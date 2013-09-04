From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] rev-parse test: use test_cmp instead of "test"
 builtin
Date: Tue, 3 Sep 2013 21:28:26 -0700
Message-ID: <20130904042825.GA2661@elie.Belkin>
References: <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
 <20130903170715.GD29921@google.com>
 <xmqqk3ixr7xy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 06:28:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH4hr-0003SE-7o
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 06:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab3IDE2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 00:28:35 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:38156 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab3IDE2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 00:28:34 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so6899232pbc.21
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WkfnlnInJZteJPslrEX/tX6ht5KMYRmd3nHweBS47oQ=;
        b=VThebMRfG8pyzTiEA5Ed6YvUDkAHQ4YWkjhFSsu0UU5Atk7zElWC1C/M4ig5rGDhbZ
         Rml4mUtrq86F5UtXw4WCgHpx7CDx+VtSHKEzJZnv/gAdeDRfl3YcPxtndvVq4QSqcvqo
         zRpVH+Y+eECQPchuzm7S5DYrzm06wBPe6XpUt/kHyUiJbntE0okJnhnd0btVOnUDO1/k
         E8LyKcURlpaogd18UFsCu8mpnjPS8ZqjCpFEi9bALgX6IZDnK2YVzYY8UeuNrwYkp3Xt
         v0jBGJJnnndagfCGs50+BhSa7PC6FYDhNdEWU3WM+xY5Pvc7GgU8cIXqm2Bzu6fbY2Xr
         V0VQ==
X-Received: by 10.68.219.104 with SMTP id pn8mr1071067pbc.81.1378268914488;
        Tue, 03 Sep 2013 21:28:34 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id lm2sm28079715pab.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 21:28:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqk3ixr7xy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233803>

Junio C Hamano wrote:

> After applying this patch and running "git show | grep test_cmp_rev_output",
> I notice that the second is always "git rev-parse <something>".  Do
> we still need to eval these, or would it be sufficient to do
>
>         test_cmp_rev_output () {
>                 git rev-parse --verify "$1" >expect &&
>                 git rev-parse --verify "$2" >actual &&
>                 test_cmp expect actual
>         }
>
> here, and make users like so:
>
>	-	test_cmp_rev_output tags/start "git rev-parse start^0"
>	+	test_cmp_rev_output tags/start start^0
>
> Am I missing something?

I was tempted to use test_cmp_rev, which would have the same effect.
The original test checked the output of "git rev-parse start^0", while
the test as modified above checks the output of "git rev-parse
--verify start^0".

I slightly prefer the version without --verify because "git rev-parse
--verify" is well exercised elsewhere in the testsuite (but then, so
is rev-parse without --verify, so it's not a big deal).

Abbreviating as follows

	foo () {
		git rev-parse --verify "$1" >expect &&
		git rev-parse "$2" >actual &&
		test_cmp expect actual
	}

would also be fine with me.  All it would take is a good replacement
for the placeholder "foo".  The added flexibility of "compare a rev
to the output of an arbitrary command" doesn't get used.

Jonathan
