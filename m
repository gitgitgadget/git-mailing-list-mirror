From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Produce a nicer output in case of sha1_object_info
	failures in ls-tree -l
Date: Thu, 19 Mar 2009 21:30:02 +0100
Message-ID: <20090319203002.GA31014@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 21:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOu8-0001zE-RF
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbZCSUaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbZCSUaR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:30:17 -0400
Received: from mout0.freenet.de ([195.4.92.90]:36624 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbZCSUaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:30:16 -0400
Received: from [195.4.92.21] (helo=11.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #79)
	id 1LkOsU-0006dg-Ks; Thu, 19 Mar 2009 21:30:10 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:53323 helo=tigra.home)
	by 11.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1LkOsU-0005wX-Bv; Thu, 19 Mar 2009 21:30:10 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 7B6DE277D8;
	Thu, 19 Mar 2009 21:30:04 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id B177C36D27; Thu, 19 Mar 2009 21:30:03 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113824>

Initialize the size with 0. The error message is already printed
by sha1_object_info itself. Otherwise the uninitialized size is
printed, which does not make any sense at all.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 builtin-ls-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index fca4631..a8cdafb 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -60,7 +60,6 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 {
 	int retval = 0;
 	const char *type = blob_type;
-	unsigned long size;
 
 	if (S_ISGITLINK(mode)) {
 		/*
@@ -91,6 +90,7 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			if (!strcmp(type, blob_type)) {
+				unsigned long size = 0;
 				sha1_object_info(sha1, &size);
 				printf("%06o %s %s %7lu\t", mode, type,
 				       abbrev ? find_unique_abbrev(sha1, abbrev)
-- 
1.6.2.1.250.ga1458
