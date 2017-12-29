Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6167D1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 14:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbdL2OFv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 09:05:51 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp ([133.41.12.55]:33177 "HELO
        huc12-ckmail02.hiroshima-u.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1750820AbdL2OFu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Dec 2017 09:05:50 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp (localhost [127.0.0.1])
        by dummy.hiroshima-u.ac.jp (Postfix) with ESMTP id C01DB167029;
        Fri, 29 Dec 2017 23:05:46 +0900 (JST)
Received: from huc12-smtp01.hiroshima-u.ac.jp (huc12-smtp01.hiroshima-u.ac.jp [133.41.12.52])
        by huc12-ckmail02.hiroshima-u.ac.jp (Postfix) with ESMTP id B582F4E39;
        Fri, 29 Dec 2017 23:05:46 +0900 (JST)
Received: from localhost.localdomain (flavor1.ipc.hiroshima-u.ac.jp [133.41.117.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by huc12-smtp01.hiroshima-u.ac.jp (Postfix) with ESMTPSA id AFD2AD3471;
        Fri, 29 Dec 2017 23:05:46 +0900 (JST)
From:   suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
To:     git@vger.kernel.org
Cc:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
Subject: [PATCH] git-archive: accept --owner and --group like GNU tar
Date:   Fri, 29 Dec 2017 23:05:35 +0900
Message-Id: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
X-Mailer: git-send-email 2.16.0.rc0.33.gdf0437cdd
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1808-8.1.0.1062-23560.003
X-TM-AS-Result: No--22.122-10.0-31-10
X-imss-scan-details: No--22.122-10.0-31-10
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-MatchedRID: I087BnUjGmFITndh1lLRAdTXZe7/fokgJnRXy0H5W62YjVGk//6gyZas
        fA8Y/RCFPdJRn1Yr0QUZaNNE3MpWy6lNwxG55eYijoyKzEmtrEcW40XiUkbrG+9Jtzyqge7RLPJ
        tWpbJjY2UlUO3ZIxj9QuZqDVFTFhBQjBth+g7RZLRVW03qzAHvkWlAmUgKahQKsp1/DCVT8lHa+
        bF39Yrf9SrK1urEaWiIemj4i/nhXKP3zesLHNKN+KXavbHY/C1f6/Md8Lb2l8UtdRZTmEaIQqll
        q5m/wE3eG/tRkLoURdrLg99am9Ze6cTXLvo8+916rBZUF8y6+iiegRrH8ppLLMDna8tQimp7Ouc
        US+OAMl2VnssTR/YynV8vv247QliehY/DCk+INGzLD5kmcW6ZD9v6ImUU51vAUIWPU0KgALuWKA
        ioM7PC69qwwMmKGY3VoPzBHOmELj9jxte3IFskPnCl+sgkNd7wx0jRRxcQfNh7WbOnt2TB09SWC
        +WgFO90m3wuqJzz4w2M/lmge+8b2Wi5mgMLZ4dSDkh6bW+bceimsR6hkcJAvYygSWEaXdVA3W6n
        9p25fS668FsnFiJPpoCoI4E82O+6EovbiVesMlVXhlmZsTdjPpV/0XEKBth/pLlC5Zo2C6jxYyR
        Ba/qJQpvgGr+RG7arUhrght4B0vdB/CxWTRRuyUIayx+Skid
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ownership of files created by git-archive is always
root:root. Add --owner and --group options which work
like the GNU tar equivalent to allow overriding these
defaults.

Signed-off-by: suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
---
 Documentation/git-archive.txt |  13 +++
 archive-tar.c                 |   8 +-
 archive.c                     | 224 ++++++++++++++++++++++++++++++++++++++++++
 archive.h                     |   4 +
 t/t5005-archive-uid-gid.sh    | 140 ++++++++++++++++++++++++++
 t/t5005/parse-tar-file.py     |  60 +++++++++++
 tar.h                         |   2 +
 7 files changed, 447 insertions(+), 4 deletions(-)
 create mode 100755 t/t5005-archive-uid-gid.sh
 create mode 100755 t/t5005/parse-tar-file.py

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index cfa1e4ebe..0d156f6c1 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
 	      [-o <file> | --output=<file>] [--worktree-attributes]
+	      [--owner [username[:uid]] [--group [groupname[:gid]]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [<path>...]
 
@@ -63,6 +64,18 @@ OPTIONS
 	This can be any options that the archiver backend understands.
 	See next section.
 
+--owner=<name>[:<uid>]::
+	Force <name> as owner and <uid> as uid for the files in the tar
+	archive.  If <uid> is not supplied, <name> can be either a user
+	name or numeric UID.  In this case the missing part (UID or
+	name) will be inferred from the current host's user database.
+
+--group=<name>[:<gid>]::
+	Force <name> as group and <gid> as gid for the files in the tar
+	archive.  If <gid> is not supplied, <name> can be either a group
+	name or numeric GID.  In this case the missing part (GID or
+	name) will be inferred from the current host's group database.
+
 --remote=<repo>::
 	Instead of making a tar archive from the local repository,
 	retrieve a tar archive from a remote repository. Note that the
diff --git a/archive-tar.c b/archive-tar.c
index c6ed96ee7..ca6471870 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -204,10 +204,10 @@ static void prepare_header(struct archiver_args *args,
 	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
 	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
 
-	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
-	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
-	strlcpy(header->uname, "root", sizeof(header->uname));
-	strlcpy(header->gname, "root", sizeof(header->gname));
+	xsnprintf(header->uid, sizeof(header->uid), "%07lo", args->uid);
+	xsnprintf(header->gid, sizeof(header->gid), "%07lo", args->gid);
+	strlcpy(header->uname, args->uname, sizeof(header->uname));
+	strlcpy(header->gname, args->gname, sizeof(header->gname));
 	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
 	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
 
diff --git a/archive.c b/archive.c
index 0b7b62af0..aa4b16b75 100644
--- a/archive.c
+++ b/archive.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "tar.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -417,6 +418,223 @@ static void parse_treeish_arg(const char **argv,
 	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
 
+/*
+ * GNU tar --owner, --group options reject hexdigit, signed int values.
+ * strtol(), atoi() are too permissive to simulate the behaviour.
+ */
+#define STR_IS_DIGIT_OK 0
+#define STR_IS_NOT_DIGIT -1
+#define STR_IS_DIGIT_TOO_LARGE -2
+
+static int try_as_simple_digit(const char *s, unsigned long *dst)
+{
+	unsigned long ul;
+	char *endptr;
+
+	if (strlen(s) != strspn(s, "0123456789"))
+		return STR_IS_NOT_DIGIT;
+
+	errno = 0;
+	ul = strtoul(s, &endptr, 10);
+
+	/* catch ERANGE */
+	if (errno) {
+		errno = 0;
+		return STR_IS_DIGIT_TOO_LARGE;
+	}
+
+#if ULONG_MAX > 0xFFFFFFFFUL
+	/*
+	 * --owner, --group rejects uid/gid greater than 32-bit
+	 * limits, even on 64-bit platforms.
+	 */
+	if (ul > 0xFFFFFFFFUL)
+		return STR_IS_DIGIT_TOO_LARGE;
+#endif
+
+	if (dst)
+		*dst = ul;
+	return STR_IS_DIGIT_OK;
+}
+
+static const char *skip_leading_colon(const char *s)
+{
+	const char *col_pos;
+
+	col_pos = strchr(s, ':');
+	if (!col_pos)
+		return s;
+
+	return (col_pos + 1);
+}
+
+#define STR_IS_NAME_COLON_DIGIT 0
+#define STR_HAS_NO_COLON -1
+#define STR_HAS_DIGIT_BROKEN -2
+#define STR_HAS_DIGIT_TOO_LARGE -3
+
+static int try_as_name_colon_digit(const char *s, const char **dst_s,
+		unsigned long *dst_ul)
+{
+	int r;
+	const char *s2;
+
+	s2 = skip_leading_colon(s);
+	if (s2 == s)
+		return STR_HAS_NO_COLON;
+
+	r = try_as_simple_digit(s2, dst_ul);
+	switch (r) {
+	case STR_IS_DIGIT_OK:
+		*dst_s = xstrndup(s, s2 - s - 1);
+		return STR_IS_NAME_COLON_DIGIT;
+	case STR_IS_DIGIT_TOO_LARGE:
+		return STR_HAS_DIGIT_TOO_LARGE;
+	default:
+		return STR_HAS_DIGIT_BROKEN;
+	}
+}
+
+#define NAME_ID_BOTH_GIVEN 0
+#define NAME_ID_ID_GUESSED 1
+#define NAME_ID_ID_UNTOUCHED 2
+#define NAME_ID_NAME_GUESSED 3
+#define NAME_ID_NAME_EMPTY 4
+#define NAME_ID_ERR_ID_TOO_LARGE -126
+#define NAME_ID_ERR_SYNTAX -127
+#define NAME_ID_ERR_PARAMS -128
+
+static int set_args_uname_uid(struct archiver_args *args,
+		const char *tar_owner)
+{
+	int r;
+	struct passwd *pw = NULL;
+
+	if (!args || !tar_owner)
+		return NAME_ID_ERR_PARAMS;
+
+	r = try_as_name_colon_digit(tar_owner, &(args->uname),
+				    &(args->uid));
+	switch (r) {
+	case STR_IS_NAME_COLON_DIGIT:
+		return NAME_ID_BOTH_GIVEN;
+	case STR_HAS_DIGIT_TOO_LARGE:
+		return NAME_ID_ERR_ID_TOO_LARGE;
+	case STR_HAS_DIGIT_BROKEN:
+		return NAME_ID_ERR_SYNTAX;
+	}
+
+	/* the operand is known to be single token */
+
+	r = try_as_simple_digit(tar_owner, &(args->uid));
+	switch (r) {
+	case STR_IS_DIGIT_TOO_LARGE:
+		return NAME_ID_ERR_ID_TOO_LARGE;
+	case STR_IS_DIGIT_OK:
+		pw = getpwuid(args->uid);
+		if (!pw) {
+			args->uname = xstrdup("");
+			return NAME_ID_NAME_EMPTY;
+		}
+		args->uname = xstrdup(pw->pw_name);
+		return NAME_ID_NAME_GUESSED;
+	}
+
+	/* the operand is known to be non-digit */
+
+	args->uname = xstrdup(tar_owner);
+	pw = getpwnam(tar_owner);
+	if (!pw)
+		return NAME_ID_ID_UNTOUCHED;
+	args->uid = pw->pw_uid;
+	return NAME_ID_ID_GUESSED;
+}
+
+static int set_args_gname_gid(struct archiver_args *args,
+		const char *tar_group)
+{
+	int r;
+	struct group *gr = NULL;
+
+	if (!args || !tar_group)
+		return NAME_ID_ERR_PARAMS;
+
+	r = try_as_name_colon_digit(tar_group, &(args->gname),
+				    &(args->gid));
+	switch (r) {
+	case STR_IS_NAME_COLON_DIGIT:
+		return NAME_ID_BOTH_GIVEN;
+	case STR_HAS_DIGIT_TOO_LARGE:
+		return NAME_ID_ERR_ID_TOO_LARGE;
+	case STR_HAS_DIGIT_BROKEN:
+		return NAME_ID_ERR_SYNTAX;
+	}
+
+	/* the operand is known to be single token */
+
+	r = try_as_simple_digit(tar_group, &(args->gid));
+	switch (r) {
+	case STR_IS_DIGIT_TOO_LARGE:
+		return NAME_ID_ERR_ID_TOO_LARGE;
+	case STR_IS_DIGIT_OK:
+		gr = getgrgid(args->gid);
+		if (!gr) {
+			args->gname = xstrdup("");
+			return NAME_ID_NAME_EMPTY;
+		}
+		args->gname = xstrdup(gr->gr_name);
+		return NAME_ID_NAME_GUESSED;
+	}
+
+	/* the operand is known to be non-digit */
+
+	args->gname = xstrdup(tar_group);
+	gr = getgrnam(tar_group);
+	if (!gr)
+		return NAME_ID_ID_UNTOUCHED;
+	args->gid = gr->gr_gid;
+	return NAME_ID_ID_GUESSED;
+}
+
+static void set_args_tar_owner_group(struct archiver_args *args,
+		const char *tar_owner, const char *tar_group)
+{
+	int r;
+
+	/* initialize by default values */
+	args->uname = xstrdup("root");
+	args->gname = xstrdup("root");
+	args->uid = 0;
+	args->gid = 0;
+
+	/*
+	 * GNU tar --format=ustar checks if uid is in 0..209751.
+	 * Too long digit string could not be dealt as numeric,
+	 * it is rejected as a syntax error before range check.
+	 */
+	r = set_args_uname_uid(args, tar_owner);
+	switch (r) {
+	case NAME_ID_ERR_ID_TOO_LARGE:
+	case NAME_ID_ERR_SYNTAX:
+		die("'%s': Invalid owner ID",
+		    skip_leading_colon(tar_owner));
+	}
+	if (args->uid > MAX_ID_IN_TAR_US)
+		die("value %ld out of uid_t range 0..%ld", args->uid,
+		     MAX_ID_IN_TAR_US);
+
+	r = set_args_gname_gid(args, tar_group);
+	switch (r) {
+	case NAME_ID_ERR_ID_TOO_LARGE:
+	case NAME_ID_ERR_SYNTAX:
+		die("'%s': Invalid group ID",
+		    skip_leading_colon(tar_group));
+	}
+	if (args->gid > MAX_ID_IN_TAR_US)
+		die("value %ld out of gid_t range 0..%ld", args->gid,
+		    MAX_ID_IN_TAR_US);
+}
+
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
 		const char *name_hint, int is_remote)
@@ -431,6 +649,8 @@ static int parse_archive_args(int argc, const char **argv,
 	int i;
 	int list = 0;
 	int worktree_attributes = 0;
+	const char *tar_owner = NULL;
+	const char *tar_group = NULL;
 	struct option opts[] = {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
@@ -459,6 +679,8 @@ static int parse_archive_args(int argc, const char **argv,
 			N_("retrieve the archive from remote repository <repo>")),
 		OPT_STRING(0, "exec", &exec, N_("command"),
 			N_("path to the remote git-upload-archive command")),
+		OPT_STRING(0, "owner", &tar_owner, N_("owner"), N_("<name[:uid]> in tar")),
+		OPT_STRING(0, "group", &tar_group, N_("group"), N_("<name[:gid]> in tar")),
 		OPT_END()
 	};
 
@@ -507,6 +729,8 @@ static int parse_archive_args(int argc, const char **argv,
 	args->baselen = strlen(base);
 	args->worktree_attributes = worktree_attributes;
 
+	set_args_tar_owner_group(args, tar_owner, tar_group);
+
 	return argc;
 }
 
diff --git a/archive.h b/archive.h
index 62d1d82c1..b2cfb1e4e 100644
--- a/archive.h
+++ b/archive.h
@@ -15,6 +15,10 @@ struct archiver_args {
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
+	unsigned long uid;
+	unsigned long gid;
+	const char *uname;
+	const char *gname;
 };
 
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
diff --git a/t/t5005-archive-uid-gid.sh b/t/t5005-archive-uid-gid.sh
new file mode 100755
index 000000000..c5e08d890
--- /dev/null
+++ b/t/t5005-archive-uid-gid.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+
+test_description='test --owner --group options for git-archive'
+. ./test-lib.sh
+
+test_expect_success 'create commit with a few empty files' '
+	git init . 1>/dev/null 2>/dev/null &&
+	touch uid-gid-test.001 &&
+	mkdir uid-gid-test.002 &&
+	mkdir uid-gid-test.002/uid-gid-test.003 &&
+	git add uid-gid-test.001 &&
+	git add uid-gid-test.002 &&
+	git add uid-gid-test.002/uid-gid-test.003 &&
+	git commit -m "uid-gid-test" 2>/dev/null 1>/dev/null
+'
+
+check_uid_gid_uname_gname_in_tar() {
+	# $1 tar pathname
+	# $2 uid (digit in string)
+	# $3 gid (digit in string)
+	# $4 uname (string)
+	# $5 gname (string)
+	uid=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=uid --fail-if-multi $1`
+	if test $? != 0 -o x"${uid}" != "x"$2
+	then
+		echo "(some) uid differs from the specified value"
+		return $?
+	fi
+
+	gid=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=gid --fail-if-multi $1`
+	if test $? != 0 -o x"${gid}" != "x"$3
+	then
+		echo "(some) gid differs from the specified value"
+		return $?
+	fi
+
+	uname=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=uname --fail-if-multi $1`
+	if test $? != 0 -o x"${uname}" != "x"$4
+	then
+		echo "(some) uname differs from the specified value"
+		return $?
+	fi
+
+	gname=`python "$TEST_DIRECTORY"/t5005/parse-tar-file.py --print=gname --fail-if-multi $1`
+	if test $? != 0 -o x"${gname}" != "x"$5
+	then
+		echo "(some) gname differs from the specified value"
+		return $?
+	fi
+
+	return 0
+}
+
+test_expect_success 'test a case with explicitly specified name/id, owner=nobody:1234 group=nogroup:5678' '
+	git archive --format=tar --owner nobody:1234 --group nogroup:5678 HEAD > uid-gid-test1.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test1.tar 1234 5678 nobody nogroup &&
+	return $?
+'
+
+test_expect_success 'test a case with only string is given, owner=(current my name) group=(current my group)' '
+	my_uid=`id -u` &&
+	my_gid=`id -g` &&
+	my_uname=`id -u -n` &&
+	my_gname=`id -g -n` &&
+	git archive --format=tar --owner ${my_uname} --group ${my_gname} HEAD > uid-gid-test2.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test2.tar ${my_uid} ${my_gid} ${my_uname} ${my_gname} &&
+	return $?
+'
+
+test_expect_success 'test a case with only number is given, owner=(current my uid) group=(current my gid)' '
+	my_uid=`id -u` &&
+	my_gid=`id -g` &&
+	my_uname=`id -u -n` &&
+	my_gname=`id -g -n` &&
+	git archive --format=tar --owner ${my_uid} --group ${my_gid} HEAD > uid-gid-test3.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test3.tar ${my_uid} ${my_gid} ${my_uname} ${my_gname} &&
+	return $?
+'
+
+test_expect_success 'test a case with only uid is given, owner=(current my uid)' '
+	my_uid=`id -u` &&
+	my_gid=`id -g` &&
+	my_uname=`id -u -n` &&
+	my_gname=`id -g -n` &&
+	git archive --format=tar --owner ${my_uid} HEAD > uid-gid-test4.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test4.tar ${my_uid} ${my_gid} ${my_uname} ${my_gname} &&
+	return $?
+'
+
+test_expect_success 'test a case with no owner/group are given' '
+	git archive --format=tar HEAD > uid-gid-test5.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test5.tar 0 0 root root &&
+	return $?
+'
+
+test_expect_success 'test a case with max uid for ustar' '
+	git archive --format=tar --owner nobody:209751 --group nogroup:1234 HEAD > uid-gid-test6.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test6.tar 209751 1234 nobody nogroup &&
+	return $?
+'
+
+test_expect_success 'test a case with max gid for ustar' '
+	git archive --format=tar --group nogroup:209751 --owner nobody:1234 HEAD > uid-gid-test7.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test7.tar 1234 209751 nobody nogroup &&
+	return $?
+'
+
+test_expect_success 'test a case with uid greater than 32-bit (must fail)' '
+	test_must_fail git archive --format=tar --owner 4294967296 --group 1234 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with gid greater than 32-bit (must fail)' '
+	test_must_fail git archive --format=tar --group 4294967296 --owner 1234 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with uid greater than ustar limit (must fail)' '
+	test_must_fail git archive --format=tar --owner 2097152 --group 1234 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with gid greater than ustar limit (must fail)' '
+	test_must_fail git archive --format=tar --group 2097152 --owner 1234 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with valid username plus uid greater than 32-bit (must fail)' '
+	test_must_fail git archive --format=tar --owner nobody:4294967296 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with valid groupname plus gid greater than 32-bit (must fail)' '
+	test_must_fail git archive --format=tar --group nogroup:4294967296 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with valid username plus uid greater than ustar limit (must fail)' '
+	test_must_fail git archive --format=tar --owner nobody:2097152 HEAD >/dev/null
+'
+
+test_expect_success 'test a case with valid groupname plus gid greater than ustar limit (must fail)' '
+	test_must_fail git archive --format=tar --group nogroup:2097152 HEAD >/dev/null
+'
+
+test_done
diff --git a/t/t5005/parse-tar-file.py b/t/t5005/parse-tar-file.py
new file mode 100755
index 000000000..7d03b55d4
--- /dev/null
+++ b/t/t5005/parse-tar-file.py
@@ -0,0 +1,60 @@
+#!/usr/bin/env python
+
+import sys
+import getopt
+import tarfile
+
+optlist, args = getopt.getopt( sys.argv[1:], "", [
+                               "print=", "show=",
+                               "uniq",
+                               "fail-if-multi",
+                ] )
+
+infos_to_print = []
+uniq = False
+fail_if_multi = False
+
+for opt in optlist:
+    if opt[0] == "--print":
+        infos_to_print.append(opt[1])
+    elif opt[0] == "--show":
+        infos_to_print.append(opt[1])
+    elif opt[0] == "--uniq":
+        uniq = True
+    elif opt[0] == "--fail-if-multi":
+        uniq = True
+        fail_if_multi = True
+
+if len(infos_to_print) == 0:
+    infos_to_print = ["uid", "gid", "uname", "gname", "name"]
+
+if len(args) > 0:
+    tar = tarfile.open( path=args[0], mode="r|" )
+else:
+    tar = tarfile.open( mode="r|", fileobj=sys.stdin )
+
+out_lines = []
+for tarinfo in tar:
+    infos = []
+    for info_tag in infos_to_print:
+        if info_tag == "uid":
+            infos.append( str(tarinfo.uid) )
+        elif info_tag == "gid":
+            infos.append( str(tarinfo.gid) )
+        elif info_tag == "uname" or info_tag == "owner":
+            infos.append( tarinfo.uname )
+        elif info_tag == "gname" or info_tag == "group":
+            infos.append( tarinfo.gname )
+        elif info_tag == "name" or info_tag == "pathname":
+            infos.append( tarinfo.name )
+        out_lines.append( "\t".join(infos) )
+tar.close()
+
+if uniq:
+    out_lines = list(set(out_lines))
+    if fail_if_multi and (len(out_lines) > 1):
+        sys.stderr.write("*** not unique value, " + str(len(out_lines)) + " values found\n")
+        sys.exit(len(out_lines))
+
+for line in out_lines:
+    print line
diff --git a/tar.h b/tar.h
index 3467705e9..1e6b57470 100644
--- a/tar.h
+++ b/tar.h
@@ -5,6 +5,8 @@
 #define TYPEFLAG_GLOBAL_HEADER	'g'
 #define TYPEFLAG_EXT_HEADER	'x'
 
+#define MAX_ID_IN_TAR_US	0x1FFFFFUL
+
 struct ustar_header {
 	char name[100];		/*   0 */
 	char mode[8];		/* 100 */
-- 
2.11.0


