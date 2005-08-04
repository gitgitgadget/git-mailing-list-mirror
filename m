From: Alecs King <alecsk@gmail.com>
Subject: [Patch] Fix sparse warnings
Date: Thu, 4 Aug 2005 11:35:37 +0800
Message-ID: <20050804033537.GA5584@loalhost.H.qngy.gscas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 04 05:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0WYz-0000FF-88
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 05:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVHDDh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVHDDh0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 23:37:26 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:47902 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261768AbVHDDf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 23:35:59 -0400
Received: by zproxy.gmail.com with SMTP id i11so173766nzh
        for <git@vger.kernel.org>; Wed, 03 Aug 2005 20:35:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=JdDK/90RgrEb6dr/q8dfsveFLyFSvNI7Kp4ZV5rME9qC8HZoB531ODvTG0B918OpRKwNLH9OytLX2SCX0wx6tqZ+4ObWa493CX/hSoLwsXYwRJWzpK2ZjrM2to0sAbHgEt72sJk1vP/RXhTaIOmBzvLBrYdlHDbJsvLCcEY+eTU=
Received: by 10.37.15.80 with SMTP id s80mr144865nzi;
        Wed, 03 Aug 2005 20:35:54 -0700 (PDT)
Received: from localhost ([210.77.2.151])
        by mx.gmail.com with ESMTP id 15sm1552006nzp.2005.08.03.20.35.11;
        Wed, 03 Aug 2005 20:35:13 -0700 (PDT)
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

fix one 'should it be static?' warning and
two 'mixing declarations and code' warnings.

Signed-off-by: Alecs King <alecsk@gmail.com>
---

 connect.c        |    3 ++-
 ssh-pull.c       |    2 +-
 tools/mailinfo.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -219,6 +219,7 @@ static struct ref *find_ref_by_name(stru
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all)
 {
+	int len;
 	struct refspec *rs = parse_ref_spec(nr_refspec, refspec);
 
 	if (nr_refspec)
@@ -236,7 +237,7 @@ int match_refs(struct ref *src, struct r
 			if (!all)
 				continue;
 			/* Create a new one and link it */
-			int len = strlen(src->name) + 1;
+			len = strlen(src->name) + 1;
 			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
 			memcpy(dst_peer->name, src->name, len);
 			memcpy(dst_peer->new_sha1, src->new_sha1, 20);
diff --git a/ssh-pull.c b/ssh-pull.c
--- a/ssh-pull.c
+++ b/ssh-pull.c
@@ -10,7 +10,7 @@ static int fd_out;
 static unsigned char remote_version = 0;
 static unsigned char local_version = 1;
 
-ssize_t force_write(int fd, void *buffer, size_t length)
+static ssize_t force_write(int fd, void *buffer, size_t length)
 {
 	ssize_t ret = 0;
 	while (ret < length) {
diff --git a/tools/mailinfo.c b/tools/mailinfo.c
--- a/tools/mailinfo.c
+++ b/tools/mailinfo.c
@@ -152,13 +152,13 @@ static void cleanup_space(char *buf)
 
 static void handle_rest(void)
 {
+	FILE *out = cmitmsg;
 	char *sub = cleanup_subject(subject);
 	cleanup_space(name);
 	cleanup_space(date);
 	cleanup_space(email);
 	cleanup_space(sub);
 	printf("Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n", name, email, sub, date);
-	FILE *out = cmitmsg;
 
 	do {
 		if (!memcmp("diff -", line, 6) ||
-- 
Alecs King
