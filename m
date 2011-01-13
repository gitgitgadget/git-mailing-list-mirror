From: JT Olds <jtolds@xnet5.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Thu, 13 Jan 2011 10:00:45 -0700
Message-ID: <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
	<20110112182150.GC31747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 13 18:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdQcQ-0005cQ-GS
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 18:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757070Ab1AMRFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jan 2011 12:05:45 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35739 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030Ab1AMRFn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 12:05:43 -0500
Received: by ewy5 with SMTP id 5so990045ewy.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=paFXdSrvc9HCWY4c13PKKvAAFcFSG64vH1UsyBK2Rdw=;
        b=skYvnE/s+TOhPCSCcu/ck2LJhM4LBFYSDa0ErfTj1Lv69HLxJxfQ4p8iY8l0WigUi6
         2sC0tScH7vnnfeqhAy7Zkq7cKVsMqRndUkopPdN/KxL/b3zqR9z2t8G1NcQW/fo3u36F
         muhrn8guBnXAQCKGhU6ItREmSSb6A1cjAT0ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VtSi59jqWKZrTLtAfFegyRICXeGhnUrG5hmCTauXP8zXaeCH7aqUFOvkSBRytUMGsJ
         lmHi0V5wOx3kZ7+AM/Aw7Mmf8h03+5k+b6yHHcC5JrG1EBxDiIXOA9Q0+7DP+2mT5PtD
         Bi17DF364xtLrsXFOzO3ILNOnovNGEz2AoeBk=
Received: by 10.216.179.207 with SMTP id h57mr2231689wem.20.1294938045728;
 Thu, 13 Jan 2011 09:00:45 -0800 (PST)
Received: by 10.216.2.194 with HTTP; Thu, 13 Jan 2011 09:00:45 -0800 (PST)
In-Reply-To: <20110112182150.GC31747@sigill.intra.peff.net>
X-Google-Sender-Auth: ZQto6cL8jKmcAmsdumpjUIKB_cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165056>

> Some things off the top of my head: Does your GIT_AUTHOR_NAME or
> GIT_AUTHOR_EMAIL contain any odd characters that might confuse a pars=
er?

Nah, from my .git/config

[user]
	name =3D JT
	email =3D jt@instructure.com

> Do you do anything special with setting up those environment variable=
s
> in your shell (e.g., in a .bashrc or .profile; those files _shouldn't=
_
> be read by a non-interactive shell, but it's something to investigate=
)?

Nope, the only place in my entire home directory where those get set
are in my filter-branch script to fix them, which I only run after the
problem manifests itself.

> For that matter, how do you set up your identity in general (by
> environment, or in ~/.gitconfig, or a local .git/config in each repo)=
,
> and what does it contain?

I have a global identity in ~/.gitconfig

[user]
    name =3D JT
    email =3D hello@jtolds.com

and then in particular topic branches in their .git/config like before.

> Can you try running this in a repo that's giving you problems:
>
> =A0. git-sh-setup
> =A0git log --format=3D%H --author=3Dyour.name |
> =A0while read rev; do
> =A0 =A0get_author_ident_from_commit $rev
> =A0 =A0git format-patch -1 --stdout $rev |
> =A0 =A0 =A0git mailinfo /dev/null /dev/null
> =A0done | less

I don't have git-sh-setup, which seems like it should be included in
the git-core package, but it's not. I have git-core
1:1.7.1-1.1ubuntu0.1 installed. Obviously this precludes
get_author_ident_from_commit from working.

> If that doesn't turn up anything, I think the next thing to try would=
 be
> making a script that reproduces the problem for you, and see if I can
> reproduce it here.

Alright, I'll see what I can do. Thanks.
