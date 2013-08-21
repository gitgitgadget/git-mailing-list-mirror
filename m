From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 19:25:42 +0200
Message-ID: <5214F816.3010303@googlemail.com>
References: <5213EF74.7020408@googlemail.com> <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com> <20130821082527.GC2802@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 19:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCCAD-0001MA-9y
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 19:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab3HURZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 13:25:42 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:64132 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab3HURZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 13:25:40 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so414772eek.41
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9TFxH+yC/BHGbLL0+gTM8V7/M7gFuwksWy3fyvqmY+Q=;
        b=EmXVhrx23/HCMBg+LWwHdGhoDS9KKaRMSF/nTw+zyJRTpUdIvKRRyZPz0T9iX9cWfT
         A53PhTT42UPKF6g1Vi86rpHl6GflNPUUH9z2YZDGK6Jc7ypjze5z7Zl1O/VrjfDi4etj
         Brba9U1ITllDi64oSumWGhnzjLfdx6cjM+Auqv+lNAFhuUn7F4WanDZg+24iJb4d3NMo
         oBqc8iXaiQb9sKVIUDo4Z9jPwSlNeIyxTGFVwBz8GncJVOf/zFLjPFmzXW32w/Xn1jrv
         4m9u4SJ3r0ycHkIF1lLOse4TPunigaCu7aibxAxgq0WBXpt9KXNlcp/iO0KErxRYDwj5
         IXEA==
X-Received: by 10.14.205.72 with SMTP id i48mr163767eeo.78.1377105939139;
        Wed, 21 Aug 2013 10:25:39 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bn13sm11298778eeb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 10:25:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130821082527.GC2802@elie.Belkin>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232707>

On 08/21/2013 10:25 AM, Jonathan Nieder wrote:
> Hi,
> 
> Stefan Beller wrote:
> 
>> [PATCH] repack: rewrite the shell script in C.
> 
> Thanks for your work so far.  This review will have mostly cosmetic
> notes.  Hopefully others can try it out to see if the actual behavior
> is good.

Thanks for all the reviews. I hope to have included every suggestion
so far or have send out mail discussing why not.

There have been quite a few changes since last round
because of so many reviews.

Here is a diff to the last sent patch, I'll also send
the whole patch on its one again.
Last time I forgot to label correctly with [RFC PATCHv5],
so the next patch should be v6.

Stefan

Changes since "[PATCH] repack: rewrite the shell script in C.":

--8<--
From 3cda569cdcd1312679c0035d151515cba7dacc59 Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Wed, 21 Aug 2013 12:33:13 +0200
Subject: [PATCH 2/3] Changes to last round.

 * get_pack_filenames: directly check for .keep files
 * packdir is a global variable now
 * fix help string for parsing options.
 * reenable the delta-base-offset being turned on by default
 * rewrite remove_temporary_files(void), remove_redundant_pack(fname)
   to use more strbuf instead of using mkpath(dup)
 * beautifying the code (line length, empty lines)

Still on the todo list for this patch:
 * Inspect the code for unlink, rename and see if we
   need to deal with their return codes.
 * Check for datatypes (--window-memory could use ulong?)

Later:
 * Move parts of cmd_repack to extra functions
 * check if subprocesses are needed (update-server-info,
   prune-packed)
---
 builtin/repack.c | 191
++++++++++++++++++++++++++++++-------------------------
 1 file changed, 103 insertions(+), 88 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9fbe636..fb050c0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -13,7 +13,9 @@
 #include "string-list.h"
 #include "argv-array.h"

-static int delta_base_offset = 0;
+/* enabled by default since 22c79eab (2008-06-25) */
+static int delta_base_offset = 1;
+char *packdir;

 static const char *const git_repack_usage[] = {
 	N_("git repack [options]"),
@@ -29,25 +31,39 @@ static int repack_config(const char *var, const char
*value, void *cb)
 	return git_default_config(var, value, cb);
 }

-static void remove_temporary_files() {
+/*
+ * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
+ */
+static void remove_temporary_files(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t dirlen, prefixlen;
 	DIR *dir;
 	struct dirent *e;
-	char *prefix, *path;

-	prefix = mkpathdup(".tmp-%d-pack", getpid());
-	path = mkpathdup("%s/pack", get_object_directory());
+	/* .git/objects/pack */
+	strbuf_addstr(&buf, get_object_directory());
+	strbuf_addstr(&buf, "/pack");
+	dir = opendir(buf.buf);
+	if (!dir) {
+		strbuf_release(&buf);
+		return;
+	}

-	dir = opendir(path);
-	while ((e = readdir(dir)) != NULL) {
-		if (!prefixcmp(e->d_name, prefix)) {
-			struct strbuf fname = STRBUF_INIT;
-			strbuf_addf(&fname, "%s/%s", path, e->d_name);
-			unlink(strbuf_detach(&fname, NULL));
-		}
+	/* .git/objects/pack/.tmp-$$-pack-* */
+	dirlen = buf.len + 1;
+	strbuf_addf(&buf, "/.tmp-%d-pack-", (int)getpid());
+	prefixlen = buf.len - dirlen;
+
+	while ((e = readdir(dir))) {
+		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
+			continue;
+		strbuf_setlen(&buf, dirlen);
+		strbuf_addstr(&buf, e->d_name);
+		unlink(buf.buf);
 	}
-	free(prefix);
-	free(path);
 	closedir(dir);
+	strbuf_release(&buf);
 }

 static void remove_pack_on_signal(int signo)
@@ -57,52 +73,57 @@ static void remove_pack_on_signal(int signo)
 	raise(signo);
 }

-/*
- * Fills the filename list with all the files found in the pack directory
- * ending with .pack, without that extension.
- */
-void get_pack_filenames(char *packdir, struct string_list *fname_list)
+static void get_pack_filenames(struct string_list *fname_list)
 {
 	DIR *dir;
 	struct dirent *e;
-	char *path, *suffix, *fname;
+	char *fname;

-	path = mkpath("%s/pack", get_object_directory());
-	suffix = ".pack";
+	if (!(dir = opendir(packdir)))
+		return;

-	dir = opendir(path);
 	while ((e = readdir(dir)) != NULL) {
-		if (!suffixcmp(e->d_name, suffix)) {
-			size_t len = strlen(e->d_name) - strlen(suffix);
-			fname = xmemdupz(e->d_name, len);
+		if (suffixcmp(e->d_name, ".pack"))
+			continue;
+
+		size_t len = strlen(e->d_name) - strlen(".pack");
+		fname = xmemdupz(e->d_name, len);
+
+		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
 			string_list_append_nodup(fname_list, fname);
-		}
 	}
 	closedir(dir);
 }

-void remove_pack(char *path, char* sha1)
+static void remove_redundant_pack(const char *path, const char *sha1)
 {
-	char *exts[] = {".pack", ".idx", ".keep"};
-	int ext = 0;
-	for (ext = 0; ext < 3; ext++) {
-		char *fname;
-		fname = mkpath("%s/%s%s", path, sha1, exts[ext]);
-		unlink(fname);
+	const char *exts[] = {".pack", ".idx", ".keep"};
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+	size_t plen;
+
+	strbuf_addf(&buf, "%s/%s", path, sha1);
+	plen = buf.len;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_setlen(&buf, plen);
+		strbuf_addstr(&buf, exts[i]);
+		unlink(buf.buf);
 	}
 }

-int cmd_repack(int argc, const char **argv, const char *prefix) {
-
-	char *exts[2] = {".idx", ".pack"};
-	char *packdir, *packtmp, line[1024];
+int cmd_repack(int argc, const char **argv, const char *prefix)
+{
+	const char *exts[2] = {".idx", ".pack"};
+	char *packtmp;
 	struct child_process cmd;
 	struct string_list_item *item;
 	struct argv_array cmd_args = ARGV_ARRAY_INIT;
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list rollback = STRING_LIST_INIT_DUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
-	int count_packs, ext;
+	struct strbuf line = STRBUF_INIT;
+	int count_packs, ext, ret;
 	FILE *out;

 	/* variables to be filled by option parsing */
@@ -135,7 +156,7 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 		OPT_BOOL('l', "local", &local,
 				N_("pass --local to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable,
N_("approxidate"),
-				N_("with -A, do not loosen objects older than this Packing
constraints")),
+				N_("with -A, do not loosen objects older than this")),
 		OPT_INTEGER(0, "window", &window,
 				N_("size of the window used for delta compression")),
 		OPT_INTEGER(0, "window-memory", &window_memory,
@@ -155,7 +176,7 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 	sigchain_push_common(remove_pack_on_signal);

 	packdir = mkpathdup("%s/pack", get_object_directory());
-	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
+	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());

 	argv_array_push(&cmd_args, "pack-objects");
 	argv_array_push(&cmd_args, "--keep-true-parents");
@@ -163,47 +184,33 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 	argv_array_push(&cmd_args, "--non-empty");
 	argv_array_push(&cmd_args, "--all");
 	argv_array_push(&cmd_args, "--reflog");
-
 	if (window)
 		argv_array_pushf(&cmd_args, "--window=%u", window);
-
 	if (window_memory)
 		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
-
 	if (depth)
 		argv_array_pushf(&cmd_args, "--depth=%u", depth);
-
 	if (max_pack_size)
 		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
-
 	if (no_reuse_delta)
 		argv_array_pushf(&cmd_args, "--no-reuse-delta");
-
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");

-	if (pack_everything + pack_everything_but_loose == 0) {
+	if (!pack_everything && !pack_everything_but_loose) {
 		argv_array_push(&cmd_args, "--unpacked");
 		argv_array_push(&cmd_args, "--incremental");
 	} else {
-		struct string_list fname_list = STRING_LIST_INIT_DUP;
-		get_pack_filenames(packdir, &fname_list);
-		for_each_string_list_item(item, &fname_list) {
-			char *fname;
-			fname = mkpathdup("%s/%s.keep", packdir, item->string);
-			if (file_exists(fname)) {
-				/* when the keep file is there, we're ignoring that pack */
-			} else {
-				string_list_append(&existing_packs, item->string);
-			}
-			free(fname);
-		}
+		get_pack_filenames(&existing_packs);

 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable)
-				argv_array_pushf(&cmd_args, "--unpack-unreachable=%s",
unpack_unreachable);
+				argv_array_pushf(&cmd_args,
+						"--unpack-unreachable=%s",
+						unpack_unreachable);
 			else if (pack_everything_but_loose)
-				argv_array_push(&cmd_args, "--unpack-unreachable");
+				argv_array_push(&cmd_args,
+						"--unpack-unreachable");
 		}
 	}

@@ -222,22 +229,24 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 	cmd.out = -1;
 	cmd.no_stdin = 1;

-	if (start_command(&cmd))
+	ret = start_command(&cmd);
+	if (ret)
 		return 1;

 	count_packs = 0;
 	out = xfdopen(cmd.out, "r");
-	while (fgets(line, sizeof(line), out)) {
-		/* a line consists of 40 hex chars + '\n' */
-		if (strlen(line) != 41)
+	while (strbuf_getline(&line, out, '\n') != EOF) {
+		if (line.len != 40)
 			die("repack: Expecting 40 character sha1 lines only from
pack-objects.");
-		line[40] = '\0';
-		string_list_append(&names, line);
+		strbuf_addstr(&line, "");
+		string_list_append(&names, line.buf);
 		count_packs++;
 	}
-	if (finish_command(&cmd))
-		return 1;
 	fclose(out);
+	ret = finish_command(&cmd);
+	if (ret)
+		return 1;
+	argv_array_clear(&cmd_args);

 	if (!count_packs && !quiet)
 		printf("Nothing new to pack.\n");
@@ -246,13 +255,15 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < 2; ext++) {
 			char *fname, *fname_old;
-			fname = mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
+			fname = mkpathdup("%s/%s%s", packdir,
+						item->string, exts[ext]);
 			if (!file_exists(fname)) {
 				free(fname);
 				continue;
 			}

-			fname_old = mkpath("%s/old-%s%s", packdir, item->string, exts[ext]);
+			fname_old = mkpathdup("%s/old-%s%s", packdir,
+						item->string, exts[ext]);
 			if (file_exists(fname_old))
 				unlink(fname_old);

@@ -262,6 +273,7 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 			}
 			string_list_append_nodup(&rollback, fname);
 			free(fname);
+			free(fname_old);
 		}
 		if (failed)
 			break;
@@ -286,7 +298,7 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 				"WARNING: file.  But the operation failed, and the\n"
 				"WARNING: attempt to rename them back to their\n"
 				"WARNING: original names also failed.\n"
-				"WARNING: Please rename them in $PACKDIR manually:\n");
+				"WARNING: Please rename them in %s manually:\n", packdir);
 			for (i = 0; i < rollback.nr; i++)
 				fprintf(stderr, "WARNING:   old-%s -> %s\n",
 					rollback.items[i].string,
@@ -300,28 +312,32 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 		for (ext = 0; ext < 2; ext++) {
 			char *fname, *fname_old;
 			struct stat statbuffer;
-			fname = mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext]);
-			fname_old = mkpath("%s-%s%s", packtmp, item->string, exts[ext]);
+			fname = mkpathdup("%s/pack-%s%s",
+					packdir, item->string, exts[ext]);
+			fname_old = mkpathdup("%s-%s%s",
+					packtmp, item->string, exts[ext]);
 			if (!stat(fname_old, &statbuffer)) {
-				statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
+				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 				chmod(fname_old, statbuffer.st_mode);
 			}
 			if (rename(fname_old, fname))
 				die_errno(_("renaming '%s' failed"), fname_old);
 			free(fname);
+			free(fname_old);
 		}
 	}

 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
-		char *fname;
-		fname = mkpath("%s/old-pack-%s.idx", packdir, item->string);
-		if (remove_path(fname))
-			die_errno(_("removing '%s' failed"), fname);
-
-		fname = mkpath("%s/old-pack-%s.pack", packdir, item->string);
-		if (remove_path(fname))
-			die_errno(_("removing '%s' failed"), fname);
+		for (ext = 0; ext < 2; ext++) {
+			char *fname;
+			fname = mkpath("%s/old-pack-%s%s",
+					packdir,
+					item->string,
+					exts[ext]);
+			if (remove_path(fname))
+				warning(_("removing '%s' failed"), fname);
+		}
 	}

 	/* End of pack replacement. */
@@ -335,9 +351,8 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 				continue;
 			sha1 = item->string + len - 40;
 			if (!string_list_has_string(&names, sha1))
-				remove_pack(packdir, item->string);
+				remove_redundant_pack(packdir, item->string);
 		}
-		argv_array_clear(&cmd_args);
 		argv_array_push(&cmd_args, "prune-packed");
 		if (quiet)
 			argv_array_push(&cmd_args, "--quiet");
@@ -346,16 +361,16 @@ int cmd_repack(int argc, const char **argv, const
char *prefix) {
 		cmd.argv = cmd_args.argv;
 		cmd.git_cmd = 1;
 		run_command(&cmd);
+		argv_array_clear(&cmd_args);
 	}

 	if (!no_update_server_info) {
-		argv_array_clear(&cmd_args);
 		argv_array_push(&cmd_args, "update-server-info");
-
 		memset(&cmd, 0, sizeof(cmd));
 		cmd.argv = cmd_args.argv;
 		cmd.git_cmd = 1;
 		run_command(&cmd);
+		argv_array_clear(&cmd_args);
 	}
 	return 0;
 }
-- 
1.8.4.rc3.1.gc1ebd90
