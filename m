From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Make git-rev-tree obsolete
Date: Tue, 9 Aug 2005 02:23:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 09 02:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2HuB-0003S4-AM
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 02:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVHIAXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 20:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVHIAXg
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 20:23:36 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13459 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932378AbVHIAXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 20:23:36 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 455AAE308B
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 02:23:35 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2A478992D4
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 02:23:35 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 0B31D99286
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 02:23:35 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id DEECAE308B
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 02:23:34 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Junio remarked that Jeff's git-changes-script still uses git-rev-tree, and 
therefore it should not be removed. This patch changes git-changes-script 
over to git-rev-list:

--- git-changes-script.orig	Tue Aug  9 02:21:36 2005
+++ git-changes-script	Tue Aug  9 02:20:53 2005
@@ -85,14 +85,14 @@
 	base=$(cat .git/HEAD) || exit 1
 fi
 
-git-rev-tree $base | sort -rn  > ${tmpfile}.base
+git-rev-list $base > ${tmpfile}.base
 if [ -n "$remote" ]; then
 	[ -d $remote/.git ] || exit 1
 	if [ -z "$tobase" ]; then
 		tobase=$(cat $remote/.git/HEAD) || exit 1
 	fi
 	pushd $remote > /dev/null
-	git-rev-tree $tobase | sort -rn > ${tmpfile}.remote
+	git-rev-list $tobase > ${tmpfile}.remote
 	diff -u ${tmpfile}.base ${tmpfile}.remote | grep "^${diffsearch}[^${diffsearch}]" | cut -c 1- > ${tmpfile}.diff
 	rm -f ${tmpfile}.base ${tmpfile}.remote
 	mv ${tmpfile}.diff ${tmpfile}.base
@@ -103,7 +103,7 @@
 
 [ -s "${tmpfile}.base" ] || exit 0
 
-cat ${tmpfile}.base | while read time commit parents; do
+cat ${tmpfile}.base | while read commit; do
 	showcommit $commit
 	echo -e "\n--------------------------"
 
