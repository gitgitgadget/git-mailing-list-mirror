From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Mon, 21 May 2007 20:20:52 +0200
Message-ID: <20070521182052.GB4696@ferdyx.org>
References: <20070520181447.GA10638@ferdyx.org> <7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 20:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCVF-0004uc-Uf
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381AbXEUSVB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757101AbXEUSVA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:21:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:30054 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbXEUSU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:20:58 -0400
Received: by nz-out-0506.google.com with SMTP id z3so401658nzf
        for <git@vger.kernel.org>; Mon, 21 May 2007 11:20:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=lAEIdUf/DkhjbpKS8drFNnfC8Um2tTM9Q6ZMOd0Uu4k2tQqnoI+7tXcH9ov3EtLTHriuOEtOGfGGcpod7ahnXrcOIqDbmDS/X3g0w9dVVuYnZxBVYCIY0CnJ94lnEJ3ZFQiA0wkaM4uGKUbx9dKTcJbi5xyf932uqji+nOauKSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Tu6+w02ZgoKNZ/95HW1JJ+DCqMIB/E/0yluoSiiS+zdyXesVV8m2Y3z7vQFeVcuBOpY9UnhL9N/6kTL6c4JK1MVfXzy1CDKWhicrGmVfkUMI+HrostU8qaubFD8htCrgxP6rb+g5oUzE9yBPZBJ5PRhJ6iQUEkOMxOE4PxmFruM=
Received: by 10.65.145.1 with SMTP id x1mr2548790qbn.1179771657741;
        Mon, 21 May 2007 11:20:57 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id f12sm7023646qba.2007.05.21.11.20.54;
        Mon, 21 May 2007 11:20:56 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@gentoo.org; Mon, 21 May 2007 20:20:55 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48037>

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
---
 Documentation/git-am.txt        |    8 ++-
 Documentation/git-mailsplit.txt |   13 +++-
 builtin-mailsplit.c             |  139 ++++++++++++++++++++++++++++++++-------
 builtin.h                       |    2 +-
 4 files changed, 132 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ba79773..25cf84a 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git-am' [--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
          [--3way] [--interactive] [--binary]
          [--whitespace=<option>] [-C<n>] [-p<n>]
-         <mbox>...
+         <mbox>|<Maildir>...
+
 'git-am' [--skip | --resolved]
 
 DESCRIPTION
@@ -23,9 +24,10 @@ current branch.
 
 OPTIONS
 -------
-<mbox>...::
+<mbox>|<Maildir>...::
 	The list of mailbox files to read patches from. If you do not
-	supply this argument, reads from the standard input.
+	supply this argument, reads from the standard input. If you supply
+	directories, they'll be treated as Maildirs.
 
 -s, --signoff::
 	Add `Signed-off-by:` line to the commit message, using
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index c11d6a5..abb0903 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,12 +7,15 @@ git-mailsplit - Simple UNIX mbox splitter program
 
 SYNOPSIS
 --------
-'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>...]
+'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>|<Maildir>...]
 
 DESCRIPTION
 -----------
-Splits a mbox file into a list of files: "0001" "0002" ..  in the specified
-directory so you can process them further from there.
+Splits a mbox file or a Maildir into a list of files: "0001" "0002" ..  in the
+specified directory so you can process them further from there.
+
+IMPORTANT: Maildir splitting relies upon filenames being sorted to output
+patches in the correct order.
 
 OPTIONS
 -------
@@ -20,6 +23,10 @@ OPTIONS
 	Mbox file to split.  If not given, the mbox is read from
 	the standard input.
 
+<Maildir>::
+	Root of the Maildir to split. This directory should contain the cur, tmp
+	and new subdirectories.
+
 <directory>::
 	Directory in which to place the individual messages.
 
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 3bca855..454f943 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -6,9 +6,10 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "path-list.h"
 
 static const char git_mailsplit_usage[] =
-"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>...";
+"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
 
 static int is_from_line(const char *line, int len)
 {
@@ -96,44 +97,106 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	exit(1);
 }
 
-int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip)
+static int populate_maildir_list(struct path_list *list, const char *path)
 {
-	char *name = xmalloc(strlen(dir) + 2 + 3 * sizeof(skip));
+	DIR *dir;
+	struct dirent *dent;
+
+	if ((dir = opendir(path)) == NULL) {
+		error("cannot diropen %s (%s)", path, strerror(errno));
+		return -1;
+	}
+
+	while ((dent = readdir(dir)) != NULL) {
+		if (dent->d_name[0] == '.')
+			continue;
+		path_list_insert(dent->d_name, list);
+	}
+
+	closedir(dir);
+
+	return 1;
+}
+
+static int split_maildir(const char *maildir, const char *dir,
+	int nr_prec, int skip)
+{
+	char file[PATH_MAX];
+	char curdir[PATH_MAX];
+	char name[PATH_MAX];
 	int ret = -1;
+	struct path_list list = {NULL, 0, 0, 1};
 
-	while (*mbox) {
-		const char *file = *mbox++;
-		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
-		int file_done = 0;
+	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
+	if (populate_maildir_list(&list, curdir) < 0)
+		goto out;
 
-		if ( !f ) {
-			error("cannot open mbox %s", file);
+	int i;
+	for (i = 0; i < list.nr; i++) {
+		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path);
+		FILE *f = fopen(file, "r");
+		if (!f) {
+			error("cannot open mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
 
 		if (fgets(buf, sizeof(buf), f) == NULL) {
-			if (f == stdin)
-				break; /* empty stdin is OK */
-			error("cannot read mbox %s", file);
+			error("cannot read mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
 
-		while (!file_done) {
-			sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
-			file_done = split_one(f, name, allow_bare);
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		split_one(f, name, 1);
+
+		fclose(f);
+	}
+
+	path_list_clear(&list, 1);
+
+	ret = skip;
+out:
+	return ret;
+}
+
+int split_mbox(const char *file, const char *dir, int allow_bare,
+		int nr_prec, int skip)
+{
+	char name[PATH_MAX];
+	int ret = -1;
+
+	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
+	int file_done = 0;
+
+	if (!f) {
+		error("cannot open mbox %s", file);
+		goto out;
+	}
+
+	if (fgets(buf, sizeof(buf), f) == NULL) {
+		/* empty stdin is OK */
+		if (f != stdin) {
+			error("cannot read mbox %s", file);
+			goto out;
 		}
+		file_done = 1;
+	}
 
-		if (f != stdin)
-			fclose(f);
+	while (!file_done) {
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		file_done = split_one(f, name, allow_bare);
 	}
+
+	if (f != stdin)
+		fclose(f);
+
 	ret = skip;
 out:
-	free(name);
 	return ret;
 }
+
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
-	int nr = 0, nr_prec = 4, ret;
+	int nr = 0, nr_prec = 4, num = 0;
 	int allow_bare = 0;
 	const char *dir = NULL;
 	const char **argp;
@@ -186,9 +249,39 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			argp = stdin_only;
 	}
 
-	ret = split_mbox(argp, dir, allow_bare, nr_prec, nr);
-	if (ret != -1)
-		printf("%d\n", ret);
+	while (*argp) {
+		const char *arg = *argp++;
+		struct stat argstat;
+		int ret = 0;
+
+		if (arg[0] == '-' && arg[1] == 0) {
+			ret = split_mbox(arg, dir, allow_bare, nr_prec, nr);
+			if (ret < 0) {
+				error("cannot split patches from stdin");
+				return 1;
+			}
+			num += ret;
+			continue;
+		}
+
+		if (stat(arg, &argstat) == -1) {
+			error("cannot stat %s (%s)", arg, strerror(errno));
+			return 1;
+		}
+
+		if (S_ISDIR(argstat.st_mode))
+			ret = split_maildir(arg, dir, nr_prec, nr);
+		else
+			ret = split_mbox(arg, dir, allow_bare, nr_prec, nr);
+
+		if (ret < 0) {
+			error("cannot split patches from %s", arg);
+			return 1;
+		}
+		num += ret;
+	}
+
+	printf("%d\n", num);
 
-	return ret == -1;
+	return 0;
 }
diff --git a/builtin.h b/builtin.h
index d3f3a74..39290d1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -8,7 +8,7 @@ extern const char git_usage_string[];
 
 extern void help_unknown_cmd(const char *cmd);
 extern int mailinfo(FILE *in, FILE *out, int ks, const char *encoding, const char *msg, const char *patch);
-extern int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip);
+extern int split_mbox(const char *file, const char *dir, int allow_bare, int nr_prec, int skip);
 extern void stripspace(FILE *in, FILE *out);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);
-- 
1.5.2
