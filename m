From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: [PATCH] defaults for where to merge from (take 2)
Date: Thu, 01 Mar 2007 08:52:40 +0100
Message-ID: <45E68648.6090407@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com> <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk> <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E5B7B4.9080605@lu.unisi.ch> <Pine.LNX.4.63.0702281903470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010901030009050405090305"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 08:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMg6C-0003qQ-NZ
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 08:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbXCAHxL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 02:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbXCAHxL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 02:53:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:36263 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbXCAHxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 02:53:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so814763nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:52:46 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:from;
        b=BUOIFz+WU4C4Q1nPY4+ZY+7/eoyVK/nmQxdG9ts1swZBlDoNMn18vnCif/0pt3bHHfXvqIHARYFeVvjZ7JRHIJXsbuHZn15WkdsNiMME8bPZs761uPBfxkVW2srxK5sgEmbXGDJnpqO8dFuppajMomu6dqu8x1x3ExablgcvX0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:from;
        b=KxciwkMeXYWDmjAABT5MqlhpuBGi4slwYyJghumFPoL2s+e4zFqLN0xRIHIwEeNperiOSsdpZq589y4xLhLRhBfQSjnLr8/syNXS/MMX1wbYWgMwU9LSThXm/HqyEcVZp6kF0NMZs1r76qwJInr0/wnUyXEqXTSoKzJHE9fH8wU=
Received: by 10.48.14.4 with SMTP id 4mr5207586nfn.1172735566360;
        Wed, 28 Feb 2007 23:52:46 -0800 (PST)
Received: from ?192.168.76.141? ( [195.176.176.226])
        by mx.google.com with ESMTP id y2sm6084464mug.2007.02.28.23.52.43;
        Wed, 28 Feb 2007 23:52:44 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0702281903470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41043>

This is a multi-part message in MIME format.
--------------010901030009050405090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> I'd rather remove the complete section (However, that means that you have 
> to introduce a function to do that in config.c)

No problem.

> Also, the second part of your patch would be clearer (methinks) if you 
> replaced the call to get_sha1() with dwim_ref(). You'd get the real 
> refname for free...

Not only that, my previous version did not work if somebody specified
remotes/remote/upstreambranch instead of remote/upstreambranch.

Updated version attached.

Paolo



--------------010901030009050405090305
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="git-builtin-branch-config-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-builtin-branch-config-2.patch"

* git-branch: register where to merge from, when branching off a remote branch.

A rather standard (in 1.5) procedure for branching off a remote archive is:

  git checkout -b branchname remote/upstreambranch
  git config --add branch.branchname.remote remote
  git config --add branch.branchname.merge refs/heads/upstreambranch

In this case, we can save the user some effort if "git branch" (and
"git checkout -b") automatically do the two "git-config --add"s when the
source branch is remote.  There is a good chance that some user wants
to merge something different, but in that case they have to specify what
to merge _anyway_.

Dually, we remove the branch.branchname section when the user does
"git branch -d".


diff --git a/builtin-branch.c b/builtin-branch.c
index d0179b0..c1563cf 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -147,8 +147,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			error("Error deleting %sbranch '%s'", remote,
 			       argv[i]);
 			ret = 1;
-		} else
+		} else {
+			/* Remove git-config keys.  */
+			if (kinds == REF_LOCAL_BRANCH) {
+				char *config_key = xmalloc(strlen(argv[i]) + 8);
+				sprintf(config_key, "branch.%s", argv[i]);
+				git_config_remove_section(config_key);
+			}
+
 			printf("Deleted %sbranch %s.\n", remote, argv[i]);
+		}
 
 	}
 
@@ -308,6 +316,27 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	free_ref_list(&ref_list);
 }
 
+static void register_branch_pull (const char *name, const char *remote_name)
+{
+	char *slash = strchr(remote_name, '/');
+
+	char *config_key = xmalloc(strlen(name) + 15);
+	char *merge_value = xmalloc(strlen(remote_name) + 10);
+
+	char *remote_value = xstrdup(remote_name);
+	remote_value[slash - remote_name] = 0;
+	sprintf(config_key, "branch.%s.remote", name);
+	git_config_set(config_key, remote_value);
+
+	sprintf(merge_value, "refs/heads/%s", slash + 1);
+	sprintf(config_key, "branch.%s.merge", name);
+	git_config_set(config_key, merge_value);
+
+	free (config_key);
+	free (remote_value);
+	free (merge_value);
+}
+
 static void create_branch(const char *name, const char *start_name,
 			  unsigned char *start_sha1,
 			  int force, int reflog)
@@ -315,8 +344,8 @@ static void create_branch(const char *name, const char *start_name,
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char ref[PATH_MAX], msg[PATH_MAX + 20];
-	int forcing = 0;
+	char *real_ref = NULL, ref[PATH_MAX], msg[PATH_MAX + 20];
+	int forcing = 0, remote = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
@@ -333,7 +362,9 @@ static void create_branch(const char *name, const char *start_name,
 	if (start_sha1)
 		/* detached HEAD */
 		hashcpy(sha1, start_sha1);
-	else if (get_sha1(start_name, sha1))
+	else if (dwim_ref(start_name, strlen (start_name), sha1, &real_ref))
+		remote = !prefixcmp(real_ref, "refs/remotes/");
+	else
 		die("Not a valid object name: '%s'.", start_name);
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
@@ -354,8 +385,16 @@ static void create_branch(const char *name, const char *start_name,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	/* When branching off a remote branch, set up so that git-pull
+	   automatically merges from there.  */
+	if (remote)
+		register_branch_pull (name, real_ref + 13);
+
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
+
+	if (real_ref)
+		free (real_ref);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
diff --git a/cache.h b/cache.h
index 8bbc142..797483b 100644
--- a/cache.h
+++ b/cache.h
@@ -438,6 +438,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
+extern int git_config_remove_section(const char *);
 extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index 0ff413b..acd83aa 100644
--- a/config.c
+++ b/config.c
@@ -854,6 +854,33 @@ write_err_out:
 
 }
 
+static int section_name_match (const char *buf, const char *name)
+{
+	int i = 0, j = 0, dot = 0;
+	for (; buf[i] && buf[i] != ']'; i++) {
+		if (!dot && isspace(buf[i])) {
+			dot = 1;
+			if (name[j++] != '.')
+				break;
+			for (i++; isspace(buf[i]); i++)
+				; /* do nothing */
+			if (buf[i] != '"')
+				break;
+			continue;
+		}
+		if (buf[i] == '\\' && dot)
+			i++;
+		else if (buf[i] == '"' && dot) {
+			for (i++; isspace(buf[i]); i++)
+				; /* do_nothing */
+			break;
+		}
+		if (buf[i] != name[j++])
+			break;
+	}
+	return (buf[i] == ']' && name[j] == 0);
+}
+
 int git_config_rename_section(const char *old_name, const char *new_name)
 {
 	int ret = 0;
@@ -885,40 +912,15 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 		int length;
 		for (i = 0; buf[i] && isspace(buf[i]); i++)
 			; /* do nothing */
-		if (buf[i] == '[') {
+		if (buf[i] == '[' && section_name_match (&buf[i+1], old_name)) {
 			/* it's a section */
-			int j = 0, dot = 0;
-			for (i++; buf[i] && buf[i] != ']'; i++) {
-				if (!dot && isspace(buf[i])) {
-					dot = 1;
-					if (old_name[j++] != '.')
-						break;
-					for (i++; isspace(buf[i]); i++)
-						; /* do nothing */
-					if (buf[i] != '"')
-						break;
-					continue;
-				}
-				if (buf[i] == '\\' && dot)
-					i++;
-				else if (buf[i] == '"' && dot) {
-					for (i++; isspace(buf[i]); i++)
-						; /* do_nothing */
-					break;
-				}
-				if (buf[i] != old_name[j++])
-					break;
-			}
-			if (buf[i] == ']' && old_name[j] == 0) {
-				/* old_name matches */
-				ret++;
-				store.baselen = strlen(new_name);
-				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error();
-					goto out;
-				}
-				continue;
+			ret++;
+			store.baselen = strlen(new_name);
+			if (!store_write_section(out_fd, new_name)) {
+				ret = write_error();
+				goto out;
 			}
+			continue;
 		}
 		length = strlen(buf);
 		if (write_in_full(out_fd, buf, length) != length) {
@@ -934,3 +936,58 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 	return ret;
 }
 
+int git_config_remove_section(const char *name)
+{
+	int ret = 0;
+	char *config_filename;
+	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
+	int out_fd;
+	int removing = 0;
+	char buf[1024];
+
+	config_filename = getenv(CONFIG_ENVIRONMENT);
+	if (!config_filename) {
+		config_filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
+		if (!config_filename)
+			config_filename  = git_path("config");
+	}
+	config_filename = xstrdup(config_filename);
+	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
+	if (out_fd < 0) {
+		ret = error("Could not lock config file!");
+		goto out;
+	}
+
+	if (!(config_file = fopen(config_filename, "rb"))) {
+		ret = error("Could not open config file!");
+		goto out;
+	}
+
+	while (fgets(buf, sizeof(buf), config_file)) {
+		int i;
+		int length;
+		for (i = 0; buf[i] && isspace(buf[i]); i++)
+			; /* do nothing */
+		if (buf[i] == '[') {
+			if (section_name_match (&buf[i + 1], name)) {
+				/* name matches */
+				ret++;
+				removing = 1;
+			} else
+				removing = 0;
+		}
+		if (removing)
+			continue;
+		length = strlen(buf);
+		if (write_in_full(out_fd, buf, length) != length) {
+			ret = write_error();
+			goto out;
+		}
+	}
+	fclose(config_file);
+	if (close(out_fd) || commit_lock_file(lock) < 0)
+			ret = error("Cannot commit config file!");
+ out:
+	free(config_filename);
+	return ret;
+}



--------------010901030009050405090305--
