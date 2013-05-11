From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push
 fails.
Date: Sat, 11 May 2013 17:44:47 +0400
Message-ID: <20130511174447.094cc76d@opensuse.site>
References: <20130511162936.0354e5d7@opensuse.site>
	<20130511123626.GD2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat May 11 15:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbA6m-00050m-Cq
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 15:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab3EKNou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 09:44:50 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:39965 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab3EKNot (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 09:44:49 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so4864647lab.12
        for <git@vger.kernel.org>; Sat, 11 May 2013 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=LrVs5Z/RVxgNNDwLoj57cxo+vfXCUZeCPA8+LeluJVM=;
        b=hyvWyiLqFT7ME7BGCQWXoBvAXsmgA6pGBNMKqU/16evNTAYSgrstnRKbsTao3yw3r9
         PgAWy69kM14oW26odhwdBIl35Y14s9vb7jSHuhaZt1dYyvO1xGyTU0vGIVps2zk8QZcg
         PuXgvmSSGGaCdup5CzEEmQHxboyqBWfLxhLTW4pp3IoG2kXryC1YkvYcq1aERF56t6rm
         cN5ZEnMClL+lLXZSmokrmmm2/F7ivMhIuQshuCA3aKVp2z0env/sv81OqXNXiinB3sGa
         FoRMshbsIortkkIWA00qvmQYceiVB9XABrFBfEbUTT7GjBjSdWrSDc71kfuEu9sN2LIH
         sjDg==
X-Received: by 10.112.20.3 with SMTP id j3mr9320673lbe.90.1368279888446;
        Sat, 11 May 2013 06:44:48 -0700 (PDT)
Received: from opensuse.site ([94.29.72.160])
        by mx.google.com with ESMTPSA id y3sm2369101lby.12.2013.05.11.06.44.47
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 06:44:47 -0700 (PDT)
In-Reply-To: <20130511123626.GD2299@serenity.lan>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.14; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223971>

=F7 Sat, 11 May 2013 13:36:26 +0100
John Keeping <john@keeping.me.uk> =D0=C9=DB=C5=D4:

> On Sat, May 11, 2013 at 04:29:36PM +0400, Andrey Borzenkov wrote:
> > I noticed that using git-remote-bzr, but as far as I can tell this =
is
> > generic for all transport helpers using fast-export.
> >=20
> >=20
> >=20
> > What happened was "git push" failed due to merge conflict. So far s=
o
> > good - but from now on git assumes everything is up to date.
> >=20
> > bor@opensuse:/tmp/test/git> git push origin master
> > To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
> >  ! [rejected]        master -> master (non-fast-forward)
> > error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/tm=
p/test/bzr'
> > hint: Updates were rejected because the tip of your current branch =
is behind
> > hint: its remote counterpart. Merge the remote changes (e.g. 'git p=
ull')
> > hint: before pushing again.
> > hint: See the 'Note about fast-forwards' in 'git push --help' for d=
etails.
> > bor@opensuse:/tmp/test/git> git push origin master
> > Everything up-to-date
> > bor@opensuse:/tmp/test/git>=20
> >=20
> > The problem seems to be that git fast-export updates marks
> > unconditionally, whether export actually applied or not. So next ti=
me
> > it assumes everything is already exported and does nothing.
> >=20
> > Is it expected behavior?
>=20
> What version of Git are you using?
>=20

bor@opensuse:~/src/git> rpm -q git
git-1.8.1.4-1.1.1.x86_64

> This sounds similar to the regression fixed by commit 126aac5
> (transport-helper: fix remote helper namespace regression, 2013-05-10=
)
> but that was only introduced in commit 664059f (transport-helper: upd=
ate
> remote helper namespace, 2013-04-17) which isn't in any released
> versions of Git.

Yes, it sounds similar, but likely the different issue. This can be
demonstrated without any transport-helper involved.

bor@opensuse:/tmp/test/git> cat .git/bzr/origin/marks-git=20
:4 7ee7c98504aa12cb82a18978ebef37900b3a5dfb
:2 91fc7db33a662ae294699945631239365eb12880
bor@opensuse:/tmp/test/git> git rev-list HEAD
7ee7c98504aa12cb82a18978ebef37900b3a5dfb
91fc7db33a662ae294699945631239365eb12880
bor@opensuse:/tmp/test/git> git fast-export --import-marks=3D.git/bzr/o=
rigin/marks-git HEAD
bor@opensuse:/tmp/test/git> git rev-list master...origin/master
7ee7c98504aa12cb82a18978ebef37900b3a5dfb
bor@opensuse:/tmp/test/git> git rev-list master...bzr/origin/heads/mast=
er
7ee7c98504aa12cb82a18978ebef37900b3a5dfb
bor@opensuse:/tmp/test/git> git fast-export --import-marks=3D.git/bzr/o=
rigin/marks-git HEAD...bzr/origin/heads/master
bor@opensuse:/tmp/test/git> git fast-export --import-marks=3D.git/bzr/o=
rigin/marks-git master...bzr/origin/heads/master
bor@opensuse:/tmp/test/git>=20

So in this particular case the problem is in git-fast-export. Actually
this behavior seems to documented:

           Any commits that have already been marked will not be export=
ed
           again.

May be the right thing would be to write only those marks that had
been confirmed by remote helper. But that as far as I understand
requires some interaction between remote helper and git-fast-export.=20
