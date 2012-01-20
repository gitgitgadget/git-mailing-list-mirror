From: David Aguilar <davvid@gmail.com>
Subject: Re: Interesting behavior in git mergetool with no BASE revision
Date: Thu, 19 Jan 2012 22:43:24 -0800
Message-ID: <CAJDDKr5mUiJkNk-urNn5fP5x+gkzaTfx2y=K1S0AJZCy7Muwdg@mail.gmail.com>
References: <CAM6z=4_+yC4EnL9SZFd6=Nxs89QeHevNCakVzVycGBe7G+nTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jason Wenger <jcwenger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 07:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8C9-0000kP-Kj
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 07:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab2ATGnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 01:43:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39475 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2ATGnZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 01:43:25 -0500
Received: by yenm6 with SMTP id m6so116726yen.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 22:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mM5Bv/WwuzArzQYe2LgOT6UPVRvwa89Fj9vA9T6ytnc=;
        b=XiXSe0yoJVgCm84aXWfvYDBCyQQtnfu0LyRyTrUrkuMPOsHAf1dO8IFmadZkRI4Spp
         bMbYKaCm/7ochaEyhTSkHTwF9DNC3Bp5zy7jXfCRR/+h3PAlACoyrptTCzjaUiAvl1vI
         DopmsmOf/0H7+pMrWFwo0EKRKUAQcpEl1jKZU=
Received: by 10.236.116.129 with SMTP id g1mr42484142yhh.107.1327041804473;
 Thu, 19 Jan 2012 22:43:24 -0800 (PST)
Received: by 10.146.151.11 with HTTP; Thu, 19 Jan 2012 22:43:24 -0800 (PST)
In-Reply-To: <CAM6z=4_+yC4EnL9SZFd6=Nxs89QeHevNCakVzVycGBe7G+nTKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188852>

On Wed, Jan 18, 2012 at 3:05 PM, Jason Wenger <jcwenger@gmail.com> wrot=
e:
> Doing a git merge on=C2=A01.7.4.3, on a case where both branches have=
 a
> file created, and the base does not. =C2=A0Per git-mergetool:
>
> "the configured command line will be invoked with $BASE set to the
> name of a temporary file containing the common base for the merge, if
> available;"
>
> So testing in this case, I set my mergetool cmd as "echo $MERGED
> $LOCAL $REMOTE $BASE", and I get the following:

I have not seen this in practice.  Maybe escape the variables?

In any case, I added a test case to cover this case.  I think we
should at least provide an empty file in place of a missing $BASE.



> cio/.cproject ./cio/.cproject.LOCAL.9029.cproject
> ./cio/.cproject.REMOTE.9029.cproject
> ./cio/.cproject.BASE.9029.cproject
>
> ls -a cio shows the following files:
>
> .cproject
> .cproject.LOCAL.9325.cproject
> .cproject.BACKUP.9325.cproject
> .cproject.REMOTE.9325.cproject
>
> So the lack of base file makes sense -- There is no base to start
> from. =C2=A0However, $BASE evaluates to=C2=A0./cio/.cproject.BASE.902=
9.cproject,
> which is a nonexistent file. =C2=A0This makes my actual mergetool ups=
et to
> no end. =C2=A0Intuitively=C2=A0from documents, I would expect $BASE t=
o=C2=A0evaluate
> to an empty string in this case.
>
> Is this intended behavior?

Not really.  I'll send a patch shortly.
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
