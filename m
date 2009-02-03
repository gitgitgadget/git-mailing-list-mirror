From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] delete_ref(): fix uninitialized value, found by valgrind
Date: Tue, 3 Feb 2009 19:12:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031912290.9822@pacific.mpi-cbg.de>
References: <cover.1233684745u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 19:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPmC-00052k-K3
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbZBCSML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbZBCSML
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:12:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:51663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751859AbZBCSMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:12:10 -0500
Received: (qmail invoked by alias); 03 Feb 2009 18:12:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 03 Feb 2009 19:12:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9OXZugmK9SbeD+MXqg96yT+wAr+HErLbfGIkkBQ
	ig56l32Iv2pATb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233684745u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108234>

The variable 'err' was not necessarily initialized before it was used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index b13e01b..ded7ec4 100644
--- a/refs.c
+++ b/refs.c
@@ -929,7 +929,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_lock *lock;
-	int err, i = 0, ret = 0, flag = 0;
+	int err = 0, i = 0, ret = 0, flag = 0;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", refname), &loginfo);
 
-- 
1.6.1.2.574.g140d5
