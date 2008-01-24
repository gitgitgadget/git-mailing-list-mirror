From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/4] Let "stg show" use the unified --diff-opts handling
Date: Thu, 24 Jan 2008 09:08:04 +0100
Message-ID: <20080124080739.25525.45807.stgit@yoghurt>
References: <20080124075935.25525.24416.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHx8b-0005yO-Hk
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbYAXIIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 03:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbYAXIIK
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:08:10 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4374 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYAXIIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:08:09 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JHx80-0005Kt-00; Thu, 24 Jan 2008 08:08:04 +0000
In-Reply-To: <20080124075935.25525.24416.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71602>

This introduces a small UI change: "stg show" called that flag
--show-opts. This could of course be avoided, but I don't think it's
worth it, since git-diff and git-show accept mostly the same options.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Catalin, do you agree?

 stgit/commands/show.py |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)


diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 72d1be3..b77a9c8 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -38,9 +38,8 @@ options =3D [make_option('-b', '--branch',
                        action =3D 'store_true'),
            make_option('-u', '--unapplied',
                        help =3D 'show the unapplied patches',
-                       action =3D 'store_true'),
-           make_option('-O', '--show-opts',
-                       help =3D 'options to pass to "git show"')]
+                       action =3D 'store_true')
+           ] + make_diff_opts_option()
=20
=20
 def func(parser, options, args):
@@ -62,13 +61,9 @@ def func(parser, options, args):
             patches =3D parse_patches(args, applied + unapplied + \
                                     crt_series.get_hidden(), len(appli=
ed))
=20
-    if options.show_opts:
-        show_flags =3D options.show_opts.split()
-    else:
-        show_flags =3D []
-
     commit_ids =3D [git_id(crt_series, patch) for patch in patches]
-    commit_str =3D '\n'.join([git.pretty_commit(commit_id, flags =3D s=
how_flags)
+    commit_str =3D '\n'.join([git.pretty_commit(commit_id,
+                                              flags =3D options.diff_f=
lags)
                             for commit_id in commit_ids])
     if commit_str:
         pager(commit_str)
