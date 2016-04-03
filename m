From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Sun, 3 Apr 2016 03:59:46 -0400
Message-ID: <CAPig+cQp2t0y7imR5tTHdLdMO6w13ia-GxZXxq4c2NGaZTjErw@mail.gmail.com>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
	<1459638975-17705-3-git-send-email-santiago@nyu.edu>
	<20160403044054.GB1519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Santiago Torres <santiago@nyu.edu>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 10:01:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amcy1-0007e1-7F
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 10:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbcDCH7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 03:59:48 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35345 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbcDCH7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 03:59:47 -0400
Received: by mail-ig0-f194.google.com with SMTP id ya17so8066025igc.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=cleYjxKqZCIUo23Qe8oNC+CWZdY0khllYy8ne7LrGQE=;
        b=TqZlGM1Aq1bie4BqmskTz9S2D5iX6I2ktV8Bpm8pSisVe1lFQnNB/aBAlpeQgSZWLS
         xJqoxsuvB8Pv097GPu++qm7IQXRgnnAuiNmnkS4oui6Vemp0a+AtQoLOTN3vFovFFgA3
         qm36o2acl+YEajzC63BVWwbvV/RbZ0zSsazZW/Jh+gYuatlZsCUw3RIARk/zuFEf8tMx
         nWnURJP/ulMH8KhxWNP31i27KwLqVJiX3FgVyJn/T9eian9FVjXjzyyz+autYaY/Tpci
         ZRNoQE4U6ek+3gS17cSmlaiZgOYOa12iWOyR5lIll2hnCEEhJw4k5dQwi6XYsy0kqALJ
         dkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cleYjxKqZCIUo23Qe8oNC+CWZdY0khllYy8ne7LrGQE=;
        b=ii8ebvNmTf4lr65//EAaaucEVe4MUx2pkaHy5Yuknq3MWSo4aH+DWjtxHw6FymMkn5
         ZlXWR+8UynWsTnSkfRY8nfltjB2yN6o76ddmbNweynvCXyD3cgZ45LcgqRZTWbHzmmBc
         C03a5VpqRf6fQ2udTJw5MznvC7MaWqKCvmFl/k4+djy8Vhb9jRdLtlsegGGrsT98ex6f
         48v5ASS+b4zwpxu/JQrrqNiOC2Lyo9Lyun1fZ3FI2LECQ1v/8UY3BScmZ1Ij9co62VQM
         Ig6roVVob19AR+9vymT9e9yKbxD6r0SqHfJZfYRBxip9Zn8KMHK9332YhR6+EYIW3wVv
         T6dw==
X-Gm-Message-State: AD7BkJKsd+2pRNKZ7ZEjOnISb7urGX9Y1kgCueh+31tfufvAuPEVJmKndhjmmMnLPprKyY0s5DdkybP9uhUekQ==
X-Received: by 10.107.130.138 with SMTP id m10mr4500971ioi.34.1459670386725;
 Sun, 03 Apr 2016 00:59:46 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 00:59:46 -0700 (PDT)
In-Reply-To: <20160403044054.GB1519@sigill.intra.peff.net>
X-Google-Sender-Auth: JGMoWP8HdgH9BwYkmxHJn0Cce80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290633>

On Sun, Apr 3, 2016 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> In fact, I suspect you could replace the "GOODSIG" check as well by
> doing something like:
>
>   # verifying 3 tags in one invocation should be exactly like
>   # verifying the 3 separately
>   tags="fourth-signed sixth-signed seventh-signed"
>   for i in $tags; do
>           git verify-tag -v --raw $i || return 1
>   done >expect.stdout 2>expect.stderr &&
>   git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr &&
>   test_cmp expect.stdout actual.stdout &&
>   test_cmp expect.stderr actual.stderr

Hmm, does [1] suggest that using test_cmp on stderr here would be
contraindicated?

[1]: http://article.gmane.org/gmane.comp.version-control.git/289077
