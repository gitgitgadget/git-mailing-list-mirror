From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: =?iso-8859-15?Q?[PATCH]_git-gui:_Fix_merge_conflict_display_error_when?=
 =?iso-8859-15?Q?_filename_contains_spaces?=
Date: Tue, 17 Mar 2009 21:56:15 +0100
Organization: http://freemail.web.de/
Message-ID: <983770303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 21:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjgMD-0004Rz-6R
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 21:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbZCQU4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbZCQU4U
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 16:56:20 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:51637 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974AbZCQU4T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 16:56:19 -0400
Received: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id 5DA9A5B1D22A
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 21:56:16 +0100 (CET)
Received: from [80.128.109.7] by freemailng0201.web.de with HTTP;
 Tue, 17 Mar 2009 21:56:15 +0100
X-Provags-Id: V01U2FsdGVkX1/JZS5SdRqkTrTRSNrQfq1TgPfhiXFLvEv9yuGrwPR0It5/7
 DGjZsLM4wdKETQK2vuDYUztBiNM0UOTZ8xO3y/w7PJxd+UjGSP4c3hnsJfGP
 A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113526>

=46rom f548fd124ad3790b6ce3f30989fc3ed06c58b3dd Mon Sep 17 00:00:00 200=
1
=46rom: Jens Lehmann <Jens.Lehmann@web.de>
Date: Tue, 17 Mar 2009 20:06:12 +0100
Subject: [PATCH] git-gui: Fix merge conflict display error when filenam=
e contains spaces

When a merge conflict occurs in a file with spaces in the filename, git=
-gui showed wrongly "LOCAL: deleted".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

To reproduce the error with git 1.6.2.1.136.g8e24, i used the following=
 commands:
  mkdir spaces
  cd spaces/
  git init
  echo "a" >file\ with\ spaces
  git add file\ with\ spaces=20
  git commit -m a .
  git checkout -b b
  echo "b" >file\ with\ spaces
  git commit -m b .
  git checkout master
  echo "c" >file\ with\ spaces
  git commit -m c .
  git merge b
  git gui
git gui doesn't show the conflict markers as it should, displaying "LOC=
AL: deleted" (but my old git-gui from 1.5.3.3 works fine).

Jens


 git-gui/lib/mergetool.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index eb2b4b5..3e1b42b 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -88,7 +88,7 @@ proc merge_load_stages {path cont} {
 	set merge_stages(3) {}
 	set merge_stages_buf {}
=20
-	set merge_stages_fd [eval git_read ls-files -u -z -- $path]
+	set merge_stages_fd [eval git_read ls-files -u -z -- {$path}]
=20
 	fconfigure $merge_stages_fd -blocking 0 -translation binary -encoding=
 binary
 	fileevent $merge_stages_fd readable [list read_merge_stages $merge_st=
ages_fd $cont]
--=20
1.5.3.3

____________________________________________________________________
Psssst! Schon vom neuen WEB.DE MultiMessenger geh=F6rt?=20
Der kann`s mit allen: http://www.produkte.web.de/messenger/?did=3D3123
