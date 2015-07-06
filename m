From: Junio C Hamano <gitster@pobox.com>
Subject: Re: refspecs with '*' as part of pattern
Date: Mon, 06 Jul 2015 16:01:15 -0700
Message-ID: <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCFO7-0008EB-9c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 01:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbbGFXBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 19:01:19 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35206 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886AbbGFXBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 19:01:17 -0400
Received: by iecuq6 with SMTP id uq6so123370005iec.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=US4TMcQwJKiK62/0pg97Li2wjtTxFWroqPn4H3g2mPI=;
        b=XzBb0vNAQYwEqyPTSlfxr3ZmTxLUbcEHELpRNrkRPGsiZpNWuL7klzjfr5ZB4nF333
         1IF1XLQ4cLiyaue+Kf5h/cUcwsLN214Eno4TUZT87PJek9QT91M5Dnn8J1US0uX0FLeP
         kcwzUnsNNS4AXiGzfcXCtoC0XfMV7rKvovPTz9jUbtx5SXrBrb3gObnXuW5TVM87s3Yg
         K+GpDt/MoMY4bEo7dabTWgkaE3Gm2aIK+Te/VrBHOJgNu6MlcZvFUtBo0LWSUhQIV3dH
         GzqAxY/1zG0G2M/uq/q5F4SaPXLdUQw7XTtqbSgdP577YKliPubwC7LB9z8dqO8fyZ5l
         A1gA==
X-Received: by 10.50.20.200 with SMTP id p8mr44980209ige.28.1436223676921;
        Mon, 06 Jul 2015 16:01:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by smtp.gmail.com with ESMTPSA id fv2sm10615714igb.22.2015.07.06.16.01.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 16:01:16 -0700 (PDT)
In-Reply-To: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
	(Jacob Keller's message of "Mon, 6 Jul 2015 11:31:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273467>

Jacob Keller <jacob.keller@gmail.com> writes:

> I've been looking at the refspecs for git fetch, and noticed that
> globs are partially supported. I wanted to use something like:
>
> refs/tags/some-prefix-*:refs/tags/some-prefix-*
>
> as a refspec, so that I can fetch only tags which have a specific
> prefix. I know that I could use namespaces to separate tags, but
> unfortunately, I am unable to fix the tag format. The specific
> repository in question is also generating several tags which are not
> relevant to me, in formats that are not really useful for human
> consumption. I am also not able to fix this less than useful practice.
>
> However, I noticed that refspecs only support * as a single component.
> The match algorithm works perfectly fine, as documented in
> abd2bde78bd9 ("Support '*' in the middle of a refspec")
>
> What is the reason for not allowing slightly more arbitrary
> expressions? Obviously no more than one *...

I cannot seem to be able to find related discussions around that
patch, so this is only my guess, but I suspect that this is to
discourage people from doing something like:

	refs/tags/*:refs/tags/foo-*

which would open can of worms (e.g. imagine you fetch with that
pathspec and then push with refs/tags/*:refs/tags/* back there;
would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
tag?) we'd prefer not having to worry about.
