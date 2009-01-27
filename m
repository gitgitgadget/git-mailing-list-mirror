From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] test-path-utils: Fix off by one, found by valgrind
Date: Wed, 28 Jan 2009 00:07:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280007250.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 00:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRx30-0005nF-IZ
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZA0XHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZA0XHV
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:07:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:46507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbZA0XHT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:07:19 -0500
Received: (qmail invoked by alias); 27 Jan 2009 23:07:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 28 Jan 2009 00:07:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3IWdy0/q3ZeaU9vQRgUy/Q7rCTqIpP24kBzEAwY
	5GiraCTMU00oBp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107419>

When normalizing an absolute path, we might have to add a slash _and_ a
NUL to the buffer, so the buffer was one too small.

Let's just future proof the code and alloc PATH_MAX + 1 bytes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 test-path-utils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index a0bcb0e..2c0f5a3 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -3,7 +3,7 @@
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_absolute_path")) {
-		char *buf = xmalloc(strlen(argv[2])+1);
+		char *buf = xmalloc(PATH_MAX + 1);
 		int rv = normalize_absolute_path(buf, argv[2]);
 		assert(strlen(buf) == rv);
 		puts(buf);
-- 
1.6.1.482.g7d54be
