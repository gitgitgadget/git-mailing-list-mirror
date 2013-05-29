From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 05:51:53 -0500
Message-ID: <CAMP44s0vARKGsn2noBEAxSVHD1bkU9pR7nPCvFJwp5epwidkQw@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
	<20130528110014.GA1264@hmsreliant.think-freely.org>
	<7vobbv2fze.fsf@alter.siamese.dyndns.org>
	<51a568db9c9b8_807b33e18996fa@nysa.mail>
	<ko4jf7$e4d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed May 29 12:52:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhdz6-0000Q2-81
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 12:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965581Ab3E2Kv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 06:51:56 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:33304 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965388Ab3E2Kvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 06:51:55 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so8523582lab.1
        for <git@vger.kernel.org>; Wed, 29 May 2013 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zwH+8bTkp6X35sDrO6BruA2xvwGB3o4RxqG7XbtJWVU=;
        b=l9yMayxWtSB+kidCnuSIuBHiCKB58mLA3TS281LbiQIHawsS0Jic5m0uJ/Zp1nl04i
         6BtjCUhMzWDGiXwxLVle4SdmEKWKOl6Fud448M1cqmPT1cfMWSpoVlkvaJu1v4xwQSWg
         loEcZrKwwwO0QLfZsOunp5laFcDQiIJeqUsqVFqG07nS9SN1uLWroeZY1IKBYxC8CDkY
         68sxRQNSEC7FgdH3mzW83GG5sUtTDyJ2UGL1rEL9vb62Hh51zyiBD3Iufe0iGjenl8bg
         OPp8nOHUmrdHsneHDb7veUUQ5a7604tNjwIArsM4ueEhyxcF9h4iFrFGLFFcshUycRCp
         0V1g==
X-Received: by 10.112.167.72 with SMTP id zm8mr1353659lbb.11.1369824714112;
 Wed, 29 May 2013 03:51:54 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 03:51:53 -0700 (PDT)
In-Reply-To: <ko4jf7$e4d$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225784>

On Wed, May 29, 2013 at 4:58 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
> Felipe Contreras wrote:
>>
>> Junio C Hamano wrote:

>>> It probably is better to fold this patch into the other one when it
>>> is rerolled to correct the option name gotcha "on the tin".
>>
>>
>> Why? This patch is standalone and fixes an issue that is independent
>> of the other patch. Why squash two patches that do *two* different
>> things?
>>
>> Anyway, I'll happily drop this patch if you want this memory leak to
>> remain. But then I'll do the same in the other patch.
>>
>> This mantra of avodiing 'goto' is not helping anybody.
>
>
> adding 5 letters (to change the next "if" into an "else if") versus your
> addition of several lines and some 15 additional letters (ignoring the
> whitsspace)  is IMHO enough to see what is better?

This has nothing to do with what Junio said. Junio said it is better
to squash the two changes into one, which is not clearly better.

As for your suggestion, what happens the next time somebody needs to
add something else to this chunk of code? Another if, and then
another, and soon enough you end up with five levels of indentation,
and in some of those patches you have to change the indentation of
existing code.

If only there was much bigger and successful software project that had
hashed all these questions and came up with a code-style to last the
ages. Oh, but there is, it's called Linux, and the answer is to use
goto's.

If the code used a goto in the first place.. BAM:

--- a/sequencer.c
+++ b/sequencer.c
 <at>  <at>  -628,8 +628,10  <at>  <at>  static int
do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}

 	allow = allow_empty(opts, commit);
-	if (allow < 0)
-		return allow;
+	if (allow < 0) {
+		res = allow;
+		goto leave;
+	}
 	if (!opts->no_commit)
 		res = run_git_commit(defmsg, opts, allow);

And every time you need to add more code you just do it, and stop
worrying about increasing indentation, or re-indenting.

Problem solved.

-- 
Felipe Contreras
