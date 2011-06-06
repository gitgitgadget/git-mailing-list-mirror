From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= 
	<jeremie.nikaes@ensimag.imag.fr>
Subject: Re: [PATCH] Add a remote helper to interact with mediawiki, pull &
 clone handled
Date: Mon, 6 Jun 2011 23:17:34 +0200
Message-ID: <BANLkTi=eGz-NydXngtAprNedmfG_UgvDfw@mail.gmail.com>
References: <1307355635-5580-1-git-send-email-jeremie.nikaes@ensimag.imag.fr> <7vmxhu92u5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 23:18:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QThBu-0006IQ-E5
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 23:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab1FFVR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 17:17:56 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34286 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab1FFVRz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 17:17:55 -0400
Received: by pxi2 with SMTP id 2so3110470pxi.10
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=q5eKKRlHwyYwytj+9KOFSXr6dtL/WTtvn9UDv2Zt4Z8=;
        b=kJ1FKMGUHUMpESxZpFFMEEE/KLdUSLgJQH4MUT4D47fd+3t90U1b65qMI0cyAus9t4
         v0U6QgNUUax8sPrXTda3r9f+D6STn5kXENVL3BZwQfQXXJA+3DbTUl01ADeBHPNSCpNZ
         RYMHudEgePrs/t47p/+IVJOfg2H5l7iuYuLSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=ZWdrKH1SBvItrTNevGgvxc7rpwDba5KQmpHa3ESMt3ASm/e7fDBNUXhfAkjeH80fLy
         4beRMN6cjBBCH5eIBWzqHsczYV2jeoTmFex3bn1AonrhrzQxk8jwHWD1cG/GPQVKXcBc
         quuMZe3txaPI8rXnZluUtJSnCLR1g6+ywPuJA=
Received: by 10.142.187.6 with SMTP id k6mr798957wff.300.1307395074263; Mon,
 06 Jun 2011 14:17:54 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Mon, 6 Jun 2011 14:17:34 -0700 (PDT)
In-Reply-To: <7vmxhu92u5.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: KgzezPOXAjRMZFgfgUmMUCjH_HQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175169>

> This seems to have grown a bit.
>
> I won't repeat issues I pointed out in the earlier round but not upda=
ted
> in this patch to save time.

Yes sorry, I actually commited a patch where the weird loop control
was not fixed yet. My mistake, will fix this asap.

About the print STDERR lines, what should we do about them ? They do
grow the patch up but if we remove them completely the script seems to
be frozen because of no text output for the user. Should we put them
in a verbose mode ?

> Two and half issues:
>
> =A0- You are writing Perl no? =A0Don't call grep/sed from it. =A0Your
> =A0 environment is much richer and more flexible ;-).

Okay it's true that we discovered Perl as we started this project so
we were more comfortable with this kind of commands. Will work on
that.
>
> =A0- You grab $commit_sha1 but never use it. Did you mean to throw it=
 at the
> =A0 "git log" above?
>
> =A0- Is there a reason you use "git log" to traverse the history all =
the way
> =A0 down to the root commit? =A0Wouldn't
>
> =A0 =A0 =A0 =A0git notes --ref=3Dmediawiki show $commit_sha1
>
> =A0 or even better yet, just doing
>
> =A0 =A0 =A0 =A0git notes --ref=3Dmediawiki show refs/mediawiki/$remot=
ename/master
>
> =A0 without the first rev-parse sufficient?
>
> =A0 Are you protecting against the case where some commits in the his=
tory
> =A0 leading to mediawiki/$remotename/master may not have the "mediawi=
ki"
> =A0 note, and falling back to the latest commit that has note? You ma=
y find
> =A0 such a commit, but that may be different from the commit at the t=
ip of
> =A0 mediawiki/$remotename/master branch. Is that a correct thing to d=
o?
> =A0 IOW, does _any_ previous version do for the purpose of this funct=
ion?
> =A0 (This paragraph is not a rhetorical question).

You are totally right. We actually were trying to find a command that
did this without having to parse the git log, git notes
--ref=3Dmediawiki show refs/mediawiki/$remotename/master does this
perfectly.
In practice, a mediawiki/$remotename/master commit should ALWAYS have
a note attached to it, so we did not try to protect against this case
here.
Should we be concerned and do something about it ?

> There are many explicit references to STDOUT like this, and also many
> unqualified "print" that spits out to the default which is STDOUT in =
the
> codepath to feed fast-import. Is that intentional, or is it just comi=
ng
> from difference in style of people who worked on different parts of t=
he
> code?
>
> If there is no reason to use two styles, please pick one and stick to
> it. If there _is_ reason, please document what are the criteria to ch=
oose
> which one in each codepath. =A0Otherwise you would waste time of your
> reviewers who have to wonder which one is correct in which codepath.

Yes you are right, that slipped too. Thanks for noticing this, fixing i=
t.

As always, thanks for the feedback, working on improving this.

--
J=E9r=E9mie Nikaes
