From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] \n usage in stderr output
Date: Thu, 15 Dec 2005 08:47:30 +0100
Message-ID: <81b0412b0512142347o6e9aaef8s227ad749f3e2a475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1088_29419375.1134632850060"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 08:49:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emnpv-0006LQ-Fh
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 08:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVLOHrc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 02:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVLOHrb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 02:47:31 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:23368 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964952AbVLOHrb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 02:47:31 -0500
Received: by nproxy.gmail.com with SMTP id o25so100255nfa
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 23:47:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=altlVKN2g7YPp9DnMrwEfUXrl2jmX6nrtzfMHSGNpCGWHgJ3hutuo7asZ/n0mLEEYx9duy/NNPmsQDujqZmhgUNbKJab8WZ9fl9XTjftYtPjHJ0DXY9Ob8MofZ+e3JAALGbOVdqmz3b9LwbIvl3QxGHatGwjcBc6l5BM96ohMXw=
Received: by 10.48.162.7 with SMTP id k7mr69304nfe;
        Wed, 14 Dec 2005 23:47:30 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Wed, 14 Dec 2005 23:47:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13685>

------=_Part_1088_29419375.1134632850060
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

fprintf and die sometimes have missing/excessive "\n" in their arguments,
correct the strings where I think it would be appropriate.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

It is always stderr, so I can hope I am not breaking anyones script...

------=_Part_1088_29419375.1134632850060
Content-Type: text/plain; 
	name=0001-n-usage-in-stderr-output-fprintf-and-die-correct-where-appropriate.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-n-usage-in-stderr-output-fprintf-and-die-correct-where-appropriate.txt"

Subject: [PATCH] \n usage in stderr output (fprintf and die), correct where appropriate

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 config.c       |    2 +-
 git.c          |    2 +-
 receive-pack.c |    2 +-
 sha1_file.c    |    8 ++++----
 show-branch.c  |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

ef105f6fe8c86d9191db8c25a70abdf272fa35db
diff --git a/config.c b/config.c
index 5b5a9a2..992e988 100644
--- a/config.c
+++ b/config.c
@@ -487,7 +487,7 @@ int git_config_set_multivar(const char* 
 			store.value_regex = (regex_t*)malloc(sizeof(regex_t));
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
-				fprintf(stderr, "Invalid pattern: %s",
+				fprintf(stderr, "Invalid pattern: %s\n",
 					value_regex);
 				free(store.value_regex);
 				return 6;
diff --git a/git.c b/git.c
index c26cac6..5939edf 100644
--- a/git.c
+++ b/git.c
@@ -264,7 +264,7 @@ int main(int argc, char **argv, char **e
 	if (*exec_path != '/') {
 		if (!getcwd(git_command, sizeof(git_command))) {
 			fprintf(stderr,
-				"git: cannot determine current directory");
+				"git: cannot determine current directory\n");
 			exit(1);
 		}
 		len = strlen(git_command);
diff --git a/receive-pack.c b/receive-pack.c
index cbe37e7..92878ec 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -79,7 +79,7 @@ static int run_update_hook(const char *r
 	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
 		die("waitpid is confused");
 	case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
-		fprintf(stderr, "%s died of signal", update_hook);
+		fprintf(stderr, "%s died of signal\n", update_hook);
 		return -1;
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
 		die("%s died strangely", update_hook);
diff --git a/sha1_file.c b/sha1_file.c
index fa22e9c..8db5074 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1274,7 +1274,7 @@ int move_temp_to_file(const char *tmpfil
 	unlink(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			fprintf(stderr, "unable to write sha1 filename %s: %s", filename, strerror(ret));
+			fprintf(stderr, "unable to write sha1 filename %s: %s\n", filename, strerror(ret));
 			return -1;
 		}
 		/* FIXME!!! Collision check here ? */
@@ -1313,7 +1313,7 @@ int write_sha1_file(void *buf, unsigned 
 	}
 
 	if (errno != ENOENT) {
-		fprintf(stderr, "sha1 file %s: %s", filename, strerror(errno));
+		fprintf(stderr, "sha1 file %s: %s\n", filename, strerror(errno));
 		return -1;
 	}
 
@@ -1321,7 +1321,7 @@ int write_sha1_file(void *buf, unsigned 
 
 	fd = mkstemp(tmpfile);
 	if (fd < 0) {
-		fprintf(stderr, "unable to create temporary sha1 filename %s: %s", tmpfile, strerror(errno));
+		fprintf(stderr, "unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
 		return -1;
 	}
 
@@ -1410,7 +1410,7 @@ int write_sha1_to_fd(int fd, const unsig
 		size = write(fd, buf + posn, objsize - posn);
 		if (size <= 0) {
 			if (!size) {
-				fprintf(stderr, "write closed");
+				fprintf(stderr, "write closed\n");
 			} else {
 				perror("write ");
 			}
diff --git a/show-branch.c b/show-branch.c
index ab158eb..f3522b7 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -303,7 +303,7 @@ static int append_ref(const char *refnam
 		return 0;
 	if (MAX_REVS <= ref_name_cnt) {
 		fprintf(stderr, "warning: ignoring %s; "
-			"cannot handle more than %d refs",
+			"cannot handle more than %d refs\n",
 			refname, MAX_REVS);
 		return 0;
 	}
@@ -535,7 +535,7 @@ int main(int ac, char **av)
 		if (MAX_REVS <= num_rev)
 			die("cannot handle more than %d revs.", MAX_REVS);
 		if (get_sha1(ref_name[num_rev], revkey))
-			die("'%s' is not a valid ref.\n", ref_name[num_rev]);
+			die("'%s' is not a valid ref.", ref_name[num_rev]);
 		commit = lookup_commit_reference(revkey);
 		if (!commit)
 			die("cannot find commit %s (%s)",
-- 
0.99.9.GIT




------=_Part_1088_29419375.1134632850060--
