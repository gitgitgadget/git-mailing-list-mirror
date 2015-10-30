From: Etienne Girard <etienne.g.girard@gmail.com>
Subject: Re: [PATCH] git-p4: Handle p4 submit failure
Date: Fri, 30 Oct 2015 18:33:07 +0100
Message-ID: <CAJA=mv7ydNCm-yy9Ukk2XB-xvAJ1VkyqHEGcCTA2PEg=5y9cFQ@mail.gmail.com>
References: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>
	<xmqqeggcmhle.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:33:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsDYB-0003vb-2c
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbbJ3RdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:33:10 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35364 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030504AbbJ3RdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:33:08 -0400
Received: by igpw7 with SMTP id w7so16782933igp.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OlQvU+p+HHn2Biwsfqe0eGyBFfhOHBThXBSRow0LLvE=;
        b=W6dG3lMOCGKx9b1FbIgLajSgglRK4VxqOhO29qENLzH2ZgYEM7fCRIQ3Sr2vPOJ+aa
         ctpwVbloRdSFatYbwoBXmX4cuEaKqzIUXzrfcyK0mTYeJCQDJJXLYPMcKJqFNXLa+pE9
         JOieeRoc4SdSr8UZAQG+MJ7oepfLkbQV3E0roNr2OgvsFg4Ey72YacMUlaZyFUv1WwV6
         gW+st/rowhZ3cWKx9SwGIiN8upkEqbpIrAmnrwStiPJUEoN9GwuRsZgNkykeXPcKvbA1
         +OMBJS8p280adgqeb1Cz2eXxSDWZKKPf3YueFdkWz4UVeRA7ljX6LkFvzcspRW1AyE2w
         ry8w==
X-Received: by 10.50.61.241 with SMTP id t17mr4187169igr.86.1446226387351;
 Fri, 30 Oct 2015 10:33:07 -0700 (PDT)
Received: by 10.64.87.170 with HTTP; Fri, 30 Oct 2015 10:33:07 -0700 (PDT)
In-Reply-To: <xmqqeggcmhle.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280499>

Hello,

>         Note: this time, you do not need to resend the patch; just
>         please let me know if you want me to do the equivalent of
>         the above while applying to make your murex address and name
>         appear as the author in "git log" and "git shortlog" output.

I'd like my murex address to appear on the log please, if it is not
too much trouble. Thank you for all these tips on the submitting
process.

>> The p4 submit command may fail, for example if the changelist contains
>> a job that does not exist in the Jobs section. If this is the case,
>> p4_write_pipe will exit the script. This change makes it so that the
>> workspace is reverted before letting the script die.
>
> Some of the information contained in this paragraph deserves to be
> in the log message proper.  How about
>
>         From: GIRARD Etienne <egirard@murex.com>
>         Subject: git-p4: clean up after p4 submit failure
>
>         When "p4 submit" command fails in P4Submit.applyCommit, the
>         workspace is left with the changes.  We already have a code
>         to revert the changes to the workspace when the user decides
>         to cancel submission by aborting the editor that edits the
>         change description, and we should treat the "p4 submit"
>         failure the same way.
>
>         Clean the workspace if p4_write_pipe raised SystemExit,
>         so that the user don't have to do it themselves.
>
>         Signed-off-by: GIRARD Etienne <egirard@murex.com>
>
> or something like that?

It seems like a good description. Please let me know if I should
submit another patch with the proper log message

>
> While trying to come up with the above description, I started
> wondering if the error message wants to differentiate the two cases.
>
> When self.edit_template() returns false, we know that the user
> actively said "no I do not want to submit", and "Submission
> cancelled" is perfectly fine, but when "p4 submit" fails because it
> did not like the change description or if it found some other
> issues, it is not necessarily that the user said "I want to cancel";
> it is more like "Submission failed".

Yes, however if `p4 submit` fails the corresponding "Command failed"
error message is displayed, and the p4 error message itself is
displayed if any.
Tthe script will also terminate successfully if self.edit_template
returns false but it will exit with error code 1 if p4 submit fails.

So the user will get "Command failed: [...]" followed by "Submission
cancelled, undoing p4 changes", to let him know that the script failed
because of p4 and that nothing was submitted.
