From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [PATCH] git-export complains about mising cat-file
Date: Mon, 02 May 2005 08:07:02 +0400
Message-ID: <E1DSSD0-00018G-2M@home2>
Cc: git@vger.kernel.org, snake@penza-gsm.ru
X-From: git-owner@vger.kernel.org Mon May 02 06:07:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSSDA-00030y-43
	for gcvg-git@gmane.org; Mon, 02 May 2005 06:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVEBENK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 00:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVEBENK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 00:13:10 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:51124
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261542AbVEBEM6
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 00:12:58 -0400
Received: (qmail 11171 invoked by uid 1000); 2 May 2005 04:12:55 -0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Fixes bits leaved during name change.

Signed-off-by: Alexey Nezhdanov <snake@penza-gsm.ru>

---

--- k/cat-file.c
+++ l/cat-file.c
@@ -13,7 +13,7 @@ int main(int argc, char **argv)
 	unsigned long size;
 
 	if (argc != 3 || get_sha1(argv[2], sha1))
-		usage("cat-file [-t | tagname] <sha1>");
+		usage("git-cat-file [-t | tagname] <sha1>");
 
 	if (!strcmp("-t", argv[1])) {
 		buf = read_sha1_file(sha1, type, &size);
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!buf)
-		die("cat-file %s: bad file", argv[2]);
+		die("git-cat-file %s: bad file", argv[2]);
 
 	while (size > 0) {
 		long ret = write(1, buf, size);
@@ -38,9 +38,9 @@ int main(int argc, char **argv)
 			/* Ignore epipe */
 			if (errno == EPIPE)
 				break;
-			die("cat-file: %s", strerror(errno));
+			die("git-cat-file: %s", strerror(errno));
 		} else if (!ret) {
-			die("cat-file: disk full?");
+			die("git-cat-file: disk full?");
 		}
 		size -= ret;
 		buf += ret;
--- k/export.c
+++ l/export.c
@@ -12,7 +12,7 @@ void show_commit(struct commit *commit)
 	strcpy(hex, sha1_to_hex(commit->object.sha1));
 	printf("Id: %s\n", hex);
 	fflush(NULL);
-	sprintf(cmdline, "cat-file commit %s", hex);
+	sprintf(cmdline, "git-cat-file commit %s", hex);
 	system(cmdline);
 	if (commit->parents) {
 		char *against = sha1_to_hex(commit->parents->item->object.sha1);


