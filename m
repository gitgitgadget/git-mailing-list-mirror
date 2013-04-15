From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 17:18:38 +0530
Message-ID: <CALkWK0nOW5HFrnsGwmFtmtkUc_SzwiQFw9dY6Pa2y5yRJ_OrCw@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <7vfvys160z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 13:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URhuf-0003DD-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 13:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab3DOLtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 07:49:21 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:57416 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3DOLtU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 07:49:20 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so4200213iah.17
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=htYj1+Vr5YLAWyn/W87Nspi5xPlId0skWhnT/b7mHZo=;
        b=AAGhP+xEcOF32HeNiCg9LOHfTDUzVP8YXHcfcJXmDrt+ePMiTDQl6VwjMH7cNiKk0/
         o31iAPwOiLk1pPjbFptRoIq2JgmDFyehgxB0n5pfNtnbaXkhFvvos6An5Hp20CV/EXu7
         q3Lz0Mc44VJtnM4mtRzqxARJTQQZc9QrGVCkMp0ewRQa0JEUFRXkNM2k3K0R0rsuJvO6
         5PTEX/IJJjQ4ZCRn5pW4xDca6Cmv1/3fzST02xh03niHqxW8m26NY966KqU/9zbrqig5
         7ftZVctgEcuyG5v7i3xz7wVICQ6SFMXTbE7M8eLgaQvEZYyan7tFPfxnwt+0B97i7YeD
         fO/Q==
X-Received: by 10.50.50.71 with SMTP id a7mr4962260igo.14.1366026559127; Mon,
 15 Apr 2013 04:49:19 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 04:48:38 -0700 (PDT)
In-Reply-To: <7vfvys160z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221224>

Junio C Hamano wrote:
> When you add a submodule with the current system, bypassing "git
> submodule add", you can either
>
>     (1) "git clone $URL here" and then "git add here"; or
>     (2) "git init here" and then "git add here".
>
> Because you didn't say what you are aiming for in the grander
> picture, I thought you were "making the UI simpler"

In the original email, I wrote:
>  Okay, so this is part of my evil plan to make 'git add' DTRT wrt
>  submodules, and deprecate 'git submodule add' (I have some code
>  written down, but this is a prerequisite: I don't like the
>  .git/modules nonsense).

I'm not sure how you inferred "making the UI simpler" from that, or the tests.

> by making it
> unnecessary for the users to say "git clone" himself as a separate
> step before doing "git add". In such a world, "add" would internally
> run "clone". If that were the case (I now know it is not), then the
> configuration _is_ unnecessary, and it is perfectly valid to
> question why you thought it is needed.

No, I would _never_ propose something that ugly.  Neither my code,
tests, nor my commit message indicates that I was going in that
direction, so I don't know where you got the idea from.

> But if that is the direction you are aiming for, would it be
> possible that the same configuration variable can and should cover
> the use case (2) as well?  After all, between "git init here" and
> "git add here", the user may say (cd here && git pull $URL) and the
> expected end result would be the same as (1), no?

Good point.  Yes, I would definitely want that.

> If "clone" just calls init_db(), I would imagine that it might be
> trivial to cover both cases by telling init_db() to pay attention to
> the configuration, without doing much in the "clone" itself.

Right.  I'll start hacking.
