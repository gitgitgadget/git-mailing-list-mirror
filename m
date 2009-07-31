From: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@virtutech.com>
Subject: [StGit PATCH] stgit new: Do not open editor if --save-template was
	specified
Date: Fri, 31 Jul 2009 11:48:29 +0200
Message-ID: <20090731094718.4516.20444.stgit@lux.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 11:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWoj7-0000pT-QD
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZGaJsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 05:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZGaJsa
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:48:30 -0400
Received: from oden.vtab.com ([62.20.90.195]:39771 "EHLO oden.vtab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZGaJs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 05:48:29 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2009 05:48:29 EDT
Received: from oden.vtab.com (oden.vtab.com [127.0.0.1])
	by oden.vtab.com (Postfix) with ESMTP id 7473926EF3A;
	Fri, 31 Jul 2009 11:48:29 +0200 (CEST)
Received: from lux.e.vtech (unknown [62.20.90.206])
	by oden.vtab.com (Postfix) with ESMTP id 5DB0526EF1C;
	Fri, 31 Jul 2009 11:48:29 +0200 (CEST)
User-Agent: StGit/0.15-rc1-31-g936b-dirty
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124519>

=46ixes side-effect of e58f264a3e59a0887c7aaa1e3227cff108ac840d

I'm not sure this is the right way to fix the problem, but an editor
should not be opened if "--save-template" was specified to "stg new",
as it is used for batch processes.

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
