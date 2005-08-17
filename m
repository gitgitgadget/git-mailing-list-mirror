From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] Make git-update-cache take relative pathnames
Date: Wed, 17 Aug 2005 13:32:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508171331540.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 22:32:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5UaQ-000705-OC
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVHQUca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVHQUca
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:32:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751232AbVHQUc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 16:32:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7HKWNjA001255
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 Aug 2005 13:32:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7HKWMjc008346;
	Wed, 17 Aug 2005 13:32:23 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This also makes "./filename" acceptable as a side effect, since the
pathname normalization handles that too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

 update-cache.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

ece92eeda777c3141f5692132ccc2ba7e4e801a2
diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -321,6 +321,7 @@ int main(int argc, char **argv)
 {
 	int i, newfd, entries, has_errors = 0;
 	int allow_options = 1;
+	const char *prefix = setup_git_directory();
 
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
@@ -381,6 +382,7 @@ int main(int argc, char **argv)
 			}
 			die("unknown option %s", path);
 		}
+		path = prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 		if (!verify_path(path)) {
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
