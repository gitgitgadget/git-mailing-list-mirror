From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] vcs-svn: Remove stray calls to removed functions
Date: Thu, 29 Jul 2010 11:06:18 +0530
Message-ID: <1280381780-6265-2-git-send-email-artagnon@gmail.com>
References: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 07:38:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeLp8-0006eP-8b
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 07:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0G2FiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 01:38:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61688 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0G2FiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 01:38:10 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so232148iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WigSc90qEd1XFJ+hd0/ItNXNSmzHt0g4sK5SaLOkYa8=;
        b=l2rICkkuDE1sypkHOj/URQTxwKMmw2WfVdQc8ISSeqpU2aaB5iXQVyFpoMO0Xy22Xk
         dj1txTNiRrHYUQTeh+F7n5jR1CQ9gseITJD+AJclJikCeWhbd/+ELQjdguA2sqhwKTrB
         wCbSqmZJdfuom1Mn2xGKRFHQemyLzFLSVpCGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tB619BFovX2XohcRPpEkpKUe2cMHkHi7fKk6gUhWgCgRRIbeQ6anpSfZpmHPDjbd0H
         LXU1ychg6CYU2PWmW0mGqqR1FYnZAeK/hJDZvKdf5nLioRetX9wpEgMcOoEuRSe8yk2C
         jJI3zrUDKMpfy465tHQEIvuLV9uMs64ITaZpg=
Received: by 10.231.39.134 with SMTP id g6mr13068784ibe.151.1280381890347;
        Wed, 28 Jul 2010 22:38:10 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id h8sm442940ibk.3.2010.07.28.22.38.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 22:38:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1280381780-6265-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152160>

repo_tree.c makes calls to non-existant commit_init, dir_init and
dirent_init functions, and string_pool.c makes a call to non-existant
string_init function. These functions were previously generated in
obj_pool.h before persistence in svn-fe was turned off.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/repo_tree.c   |    3 ---
 vcs-svn/string_pool.c |    1 -
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index c27d077..1ce184d 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -308,9 +308,6 @@ static void mark_init(void)
 
 void repo_init() {
 	pool_init();
-	commit_init();
-	dir_init();
-	dirent_init();
 	mark_init();
 	if (commit_pool.size == 0) {
 		/* Create empty tree for commit 0. */
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index bd5a380..616b17e 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -93,7 +93,6 @@ void pool_init(void)
 {
 	uint32_t node;
 	uint32_t string = 0;
-	string_init();
 	while (string < string_pool.size) {
 		node = node_alloc(1);
 		node_pointer(node)->offset = string;
-- 
1.7.1
