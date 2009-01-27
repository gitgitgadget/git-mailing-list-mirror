From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] get_sha1_basic(): fix invalid memory access, found by
 valgrind
Date: Wed, 28 Jan 2009 00:07:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280007400.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 00:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRx3E-0005qy-5U
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbZA0XHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZA0XH3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:07:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:38644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751666AbZA0XH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:07:28 -0500
Received: (qmail invoked by alias); 27 Jan 2009 23:07:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 28 Jan 2009 00:07:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hilAO5VmhahrAXL5VPQvQFeqAuBAsbWq1Ab05/X
	yW0F3dnL4TX/+O
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107420>

When get_sha1_basic() is passed a buffer of len 0, it should not
check if buf[len-1] is a curly bracket.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7d95bbb..5d0ac02 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -334,7 +334,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
-	if (str[len-1] == '}') {
+	if (len && str[len-1] == '}') {
 		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
 				reflog_len = (len-1) - (at+2);
-- 
1.6.1.482.g7d54be
