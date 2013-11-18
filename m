From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 3/3] for-each-ref: introduce %(color:...) for color
Date: Mon, 18 Nov 2013 22:15:30 +0530
Message-ID: <CALkWK0ngKTkFbaq7NzCW7T3KyfmWxpDEv8TLj05LoThob1fpFg@mail.gmail.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
 <1384335406-16332-4-git-send-email-artagnon@gmail.com> <xmqqbo1odqb4.fsf@gitster.dls.corp.google.com>
 <xmqq38n0dpgy.fsf@gitster.dls.corp.google.com> <CALkWK0k4MudojZt4PkLjnq0uZe322n30WP-=N0ckLw2QcnbzMA@mail.gmail.com>
 <xmqq4n79d6f1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 17:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViRxn-0000zT-Np
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 17:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab3KRQqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 11:46:12 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59501 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab3KRQqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 11:46:11 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so2323133iej.14
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l/p8BB/xmpjGjyc3UXB5BlmtocrqTTThnM2QiMCJvPo=;
        b=emKw+3iU+OQN/wsHI5M/Gkdamn5yBxy9b6CJKnIwJ2289ynqLEVLyRRhsQ3tqJGkW6
         1E6zsArQ8xRWkXQTjGcghI+G8nP5bArljuNasEaGdUgi6AFLWeTN3X01KKzQGcBWYEJc
         WQ64o/fSqg/9jG0bPdJTZDTZFtBTfR63WBQoNZ/ZQ3u0d5H5ZZ6FAzTthcNhN/L0crAD
         Pgd3LoGkD9ZhG5G/EI8QMRXzFOIyhTyX+mqm911gcNzDp1Gz4SL+J3Dm7EbZavJS+ozZ
         yq02miYAW+ibJ8fiAg8jeaTftpl8za/XOrVhQ8l/6VY7NB7lNMHMXM5PYREQbxWBbdv5
         fRVQ==
X-Received: by 10.50.40.37 with SMTP id u5mr15428486igk.29.1384793170419; Mon,
 18 Nov 2013 08:46:10 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Mon, 18 Nov 2013 08:45:30 -0800 (PST)
In-Reply-To: <xmqq4n79d6f1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237989>

Junio C Hamano wrote:
> If you are saying, by after each token, that
>
>         --format='%(color:blue)%(A)literal string%(B)'
>
> should result in
>
>         <color blue> <value for A> <color reset> "literal string" <value for B>
>
> then I would disagree.

Hm, I didn't think it was a bad idea to reset after each token. The
whole point of having color is to make sure that two consecutive
tokens don't have the same color, no? Then again, my scheme would
result in extra unnecessary resets like

  %(color:blue)%(A)%(color:green)%(B)

being turned into:

  %(color:blue)%(A)%(color:reset)%(color:green)%(B)%(color:reset)

Here, the first %(color:reset) is completely unnecessary.

> I was suggesting it to instead produce
>
>         <color blue> <value for A> "literal string" <value for B> <color reset>
>
> where the <color reset> always comes when some color is used and we
> hit the end of the format string. A bonus point if we can make it so
> that we emit the final reset only when the last "%(color:some)" is
> not "%(color:reset)", but unconditional "reset if we ever used
> color" is fine.

Okay, a simple don't-leak-color. I'll submit another iteration soon.

Thanks.
