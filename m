From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] teach --summary to stg show
Date: Fri, 10 Jul 2009 11:11:05 +0100
Message-ID: <b0943d9e0907100311n26af2e86j95cae2200298ff68@mail.gmail.com>
References: <20090619050653.GD21764@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kha@treskal.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 12:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPD4a-0004aY-QQ
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 12:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbZGJKLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 06:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbZGJKLJ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 06:11:09 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:42585 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbZGJKLI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 06:11:08 -0400
Received: by bwz25 with SMTP id 25so755196bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xVa0VaiarApRh7UOf3mkvx5UyFqrTF8QJJl4KaDZg4Y=;
        b=u+Jzw1f67vqObCvdimckFzP6hyD3gB/flXHY0+ceyjwhD/AMwtNM5mHawt9dzHc1oy
         Q3VTsmmHI5i+onF9e2yFeZoECleEXo4sRkiWiKcXf3GQf57bOtuhYV/2MIugOsMhtlob
         fExLSB093/5aBW9ajpWc1hz12b7E+VPe6pLBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ra2e0m9NidmUGMEbkAh7HI0AYuJwwjMldp2fmA7wGlyL4TwlyzBuS78k8ArH8HakFR
         G8+zKBEkpTVqN6xb2bu7eTa3NEyXyGgpexlEbeDgRoJtEw2yJQX8UeuRSfOFcmBf4cNq
         LprvcZAyv6+bga4Jy7KX5tlDmxUqVkXW3i64Y=
Received: by 10.223.106.15 with SMTP id v15mr824911fao.15.1247220665297; Fri, 
	10 Jul 2009 03:11:05 -0700 (PDT)
In-Reply-To: <20090619050653.GD21764@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123046>

Hi Alex,

Sorry for the loooong delay.

2009/6/19 Alex Chiang <achiang@hp.com>:
> Add -s/--summary option to stg show, which will generate a nice
> diffstat, similar to what you get in a cover mail if you specify
> %(diffstat)s.

I would use --stat for consistency with the diff command.

> + =A0 =A0 =A0 =A0commit_str =3D gitlib.diffstat(git.diff(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev1=
 =3D git_id(crt_series, '%s^' % patches[0]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev2=
 =3D git_id(crt_series, '%s' % patches[-1])))

This works only of the shown patches are consecutive. If you specify
random patches, the diffstat isn't correct. I propose this form of the
patch:

diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index b7a8aa9..45c3a56 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -20,6 +20,7 @@ from pydoc import pager
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit import argparse, git
+from stgit.lib import git as gitlib

 help =3D 'Show the commit corresponding to a patch'
 kind =3D 'patch'
@@ -38,6 +39,8 @@ options =3D [
         short =3D 'Show the applied patches'),
     opt('-u', '--unapplied', action =3D 'store_true',
         short =3D 'Show the unapplied patches'),
+    opt('-s', '--stat', action =3D 'store_true',
+        short =3D 'Show a diffstat summary of the specified patches'),
     ] + argparse.diff_opts_option()

 directory =3D DirectoryHasRepository(log =3D False)
@@ -61,10 +64,13 @@ def func(parser, options, args):
         # individual patches or commit ids
         patches =3D args

-    options.diff_flags.extend(color_diff_flags())
+    if not options.stat:
+        options.diff_flags.extend(color_diff_flags())
     commit_ids =3D [git_id(crt_series, patch) for patch in patches]
     commit_str =3D '\n'.join([git.pretty_commit(commit_id,
                                               flags =3D options.diff_f=
lags)
                             for commit_id in commit_ids])
+    if options.stat:
+        commit_str =3D gitlib.diffstat(commit_str)
     if commit_str:
         pager(commit_str)


--=20
Catalin
