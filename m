From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH 1/1] Improve error messages from 'git stash show'
Date: Mon, 15 Mar 2010 23:19:50 +0100
Message-ID: <1268691590-27100-1-git-send-email-hendeby@isy.liu.se>
Cc: gitster@pobox.com, Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 23:31:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIoS-0005gY-6F
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936980Ab0COWay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 18:30:54 -0400
Received: from mailgw1.uni-kl.de ([131.246.120.220]:39380 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936949Ab0COWau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 18:30:50 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 18:30:49 EDT
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2FMKeVg007533;
	Mon, 15 Mar 2010 23:20:40 +0100
Received: from serv-2100.kl.dfki.de (serv-2100.kl.dfki.de [192.168.21.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id o2FMKdhH012545;
	Mon, 15 Mar 2010 23:20:40 +0100 (CET)
Received: from pc-2163.kl.dfki.de (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-2100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id o2FMKcCV009023;
	Mon, 15 Mar 2010 23:20:39 +0100 (CET)
Received: (from hendeby@localhost)
	by pc-2163.kl.dfki.de (8.14.3/8.14.3/Submit) id o2FMKP8F027152;
	Mon, 15 Mar 2010 23:20:25 +0100
X-Mailer: git-send-email 1.7.0.2.274.gc376e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142266>

The previous error message "fatal: Needed a single revision" is not
very informative.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 git-stash.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index aa47e54..cf221c6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -210,14 +210,18 @@ list_stash () {
 }
 
 show_stash () {
+	have_stash || die 'No stash found'
+
 	flags=$(git rev-parse --no-revs --flags "$@")
 	if test -z "$flags"
 	then
 		flags=--stat
 	fi
 
-	w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
-	b_commit=$(git rev-parse --verify "$w_commit^") &&
+	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
+	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
+		die 'Stash not found'
+
 	git diff $flags $b_commit $w_commit
 }
 
-- 
1.7.0.2.274.gc376e.dirty
