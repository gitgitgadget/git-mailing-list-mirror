From: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@virtutech.com>
Subject: [StGit PATCH] stgit new: Do not open editor if --save-template was
	specified
Date: Fri, 31 Jul 2009 11:43:21 +0200
Message-ID: <20090731094301.4336.5496.stgit@lux.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWpdt-0000u5-83
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZGaKqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 06:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbZGaKqg
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:46:36 -0400
Received: from [62.20.90.206] ([62.20.90.206]:24238 "EHLO lux.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752269AbZGaKqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 06:46:35 -0400
Received: from lux.e.vtech (lux.hq.vtech [127.0.0.1])
	by lux.e.vtech (8.14.2/8.14.2) with ESMTP id n6V9hLqE004362;
	Fri, 31 Jul 2009 11:43:21 +0200
User-Agent: StGit/0.15-rc1-31-g936b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124539>

=46ixes side-effect of e58f264a3e59a0887c7aaa1e3227cff108ac840d

I'm not sure this is the right way to fix this problem, but "stgit
new" should not open an editor if the "--save-template" flag was
specified, as it's used as part of batch processes.

Signed-off-by: Gustav H=C3=A5llberg <gustav@virtutech.com>
---
 stgit/commands/new.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 9fd51c3..158193e 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -67,7 +67,8 @@ def func(parser, options, args):
     cd =3D gitlib.CommitData(
         tree =3D stack.head.data.tree, parents =3D [stack.head], messa=
ge =3D '',
         author =3D gitlib.Person.author(), committer =3D gitlib.Person=
=2Ecommitter())
-    cd =3D common.update_commit_data(cd, options, allow_edit =3D True)
+    cd =3D common.update_commit_data(cd, options,
+                                   allow_edit =3D not options.save_tem=
plate)
=20
     if options.save_template:
         options.save_template(cd.message)
