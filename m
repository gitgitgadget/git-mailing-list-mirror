From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 7/8] Make networking commands to work from a subdirectory.
Date: Sat, 26 Nov 2005 01:57:14 -0800
Message-ID: <7vk6ev4tqd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:58:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efwo3-0002X8-OD
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVKZJ5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVKZJ5Q
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:57:16 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:460 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750835AbVKZJ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:57:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095610.EZOJ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:56:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12775>

These are whole-tree operations and there is not much point
making them operable from within a subdirectory, but it is easy
to do so, and using setup_git_directory() upfront helps git://
proxy specification picked up from the correct place.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 clone-pack.c  |    2 ++
 fetch-pack.c  |    2 ++
 http-fetch.c  |    2 ++
 http-push.c   |    1 +
 local-fetch.c |    2 ++
 send-pack.c   |    1 +
 ssh-fetch.c   |    2 ++
 ssh-upload.c  |    3 +++
 8 files changed, 15 insertions(+), 0 deletions(-)

applies-to: 40288d9fe5f400d387e29cd7ec2fa4f1ee4eecca
e01beacec2b24cf1ca59bd8a0fdbe301119ab061
diff --git a/clone-pack.c b/clone-pack.c
index 9609219..a99a95c 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -271,6 +271,8 @@ int main(int argc, char **argv)
 	int fd[2];
 	pid_t pid;
 
+	setup_git_directory();
+
 	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 6565982..58ba209 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -424,6 +424,8 @@ int main(int argc, char **argv)
 	int fd[2];
 	pid_t pid;
 
+	setup_git_directory();
+
 	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
diff --git a/http-fetch.c b/http-fetch.c
index 4353173..ad59f1c 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -922,6 +922,8 @@ int main(int argc, char **argv)
 	int arg = 1;
 	int rc = 0;
 
+	setup_git_directory();
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
diff --git a/http-push.c b/http-push.c
index 76c7886..250a9b9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1239,6 +1239,7 @@ int main(int argc, char **argv)
 	int rc = 0;
 	int i;
 
+	setup_git_directory();
 	setup_ident();
 
 	remote = xmalloc(sizeof(*remote));
diff --git a/local-fetch.c b/local-fetch.c
index 0931109..fa9e697 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -207,6 +207,8 @@ int main(int argc, char **argv)
 	char *commit_id;
 	int arg = 1;
 
+	setup_git_directory();
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't')
 			get_tree = 1;
diff --git a/send-pack.c b/send-pack.c
index 3eeb18f..2a14b00 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -273,6 +273,7 @@ int main(int argc, char **argv)
 	int fd[2], ret;
 	pid_t pid;
 
+	setup_git_directory();
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
 		char *arg = *argv;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index bf01fbc..4eb9e04 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -131,6 +131,8 @@ int main(int argc, char **argv)
 	prog = getenv("GIT_SSH_PUSH");
 	if (!prog) prog = "git-ssh-upload";
 
+	setup_git_directory();
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
diff --git a/ssh-upload.c b/ssh-upload.c
index 603abcc..b675a0b 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -121,6 +121,9 @@ int main(int argc, char **argv)
 
 	prog = getenv(COUNTERPART_ENV_NAME);
 	if (!prog) prog = COUNTERPART_PROGRAM_NAME;
+
+	setup_git_directory();
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 'w')
 			arg++;
---
0.99.9.GIT
