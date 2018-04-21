Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760941F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeDUQyu (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33323 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeDUQyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id y15-v6so1096749lfj.0
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zy9hmKX+vVG5GvvNfJ89VkrsWEUiZO7furTJP7xAHsM=;
        b=sBGjgl2/N3dhnsMXRD/7cN1dk9jRXNvr49Q4ghyEMWy06r4ldqsNedEPkHaeEEoTY1
         JWwAg55qD4IihUuII58j1ipqKAzEhbhhdUQUQfnyJ28lU7Cfg3wjHTBZm0ghHGphYC+P
         Cu38gxE2USh9WQ3qBULRHc/SzGww0+4EQl6/A/H8tW5jxbvyrMzQHEh4XESRq+4S3ZwW
         sXfIY7Xlh9Mw/HEXlZWETb+LI+p89XSwlcDpUQfxz2J245BrQnIS1sLwlswboeebzD9j
         J6GybmqYO23O0nJe6FRnOnDbEySNCi6DoFQfU2jJWrpBWTsEFVrc2kst10BgwQ4mwAwF
         AJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy9hmKX+vVG5GvvNfJ89VkrsWEUiZO7furTJP7xAHsM=;
        b=mmePzUhysuulGuJAGTdB4IXIirx+ZIccbfy2E/EKrBXzXBiTfvwFDQuN7gyQnovSzS
         KjgUMq+imIHxRZ9Vist+Q3/rO+nE+oNvFqRXU5CnyT4MYSpTHoM0u6THaZhibcuU0qdh
         1+wVyxP6JAoXyGPV27HcfedY31rs2Q7b/K/F/gtA4Zz7ni3FvcdaKwrz8w6IZjp7RLKQ
         cGvkYMgdG4pRQSNjwh84+m07tr1lVPotHLLDicmF8XyAmK6yRE9hsPGPAhf3K2Z09R4r
         kjegY9dHapqa0QReVrviXkNsQM0pv5gzoBgwLJMmmWq7sV5YbwF9/5fpcdEzQ0jKQKGK
         /zUw==
X-Gm-Message-State: ALQs6tCIEIRnmVzSQgDJjL0PvNM9U2NDLJZBvY16kJE2E/Tct95c7GSE
        5T7IiKtp0kEIp/RHMmHSGr0=
X-Google-Smtp-Source: AIpwx49IdYILnLmquVX/VTVYbq+VypogmZpxd5lv4d/6C67xxGtr0i/Ig9kEQ5ANYzuCtDGm0p9qXQ==
X-Received: by 10.46.155.79 with SMTP id o15mr9657582ljj.49.1524329674196;
        Sat, 21 Apr 2018 09:54:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
Date:   Sat, 21 Apr 2018 18:54:12 +0200
Message-Id: <20180421165414.30051-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is useful for git-completion.bash because it needs this set of
commands. Right now we have to maintain a separate command category in
there.

Note that the current completion script incorrectly classifies
filter-branch as porcelain and t9902 tests this behavior. We keep it
this way in t9902 because this test does not really care which
particular command is porcelain or plubmbing, they're just names.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 106 +++----------------------
 git.c                                  |   2 +
 help.c                                 |  12 +++
 help.h                                 |   1 +
 t/t9902-completion.sh                  |   6 +-
 5 files changed, 31 insertions(+), 96 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a5f13ade20..7d17ca23f6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -835,18 +835,23 @@ __git_complete_strategy ()
 }
 
 __git_commands () {
-	if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
+	if test -n "$GIT_TESTING_COMPLETION"
 	then
-		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
+		case "$1" in
+		porcelain)
+			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST";;
+		all)
+			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST";;
+		esac
 	else
-		git --list-cmds=all
+		git --list-cmds=$1
 	fi
 }
 
-__git_list_all_commands ()
+__git_list_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(__git_commands)
+	for i in $(__git_commands $1)
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -859,101 +864,14 @@ __git_all_commands=
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=$(__git_list_all_commands)
-}
-
-__git_list_porcelain_commands ()
-{
-	local i IFS=" "$'\n'
-	__git_compute_all_commands
-	for i in $__git_all_commands
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		applymbox)        : ask gittus;;
-		applypatch)       : ask gittus;;
-		archimport)       : import;;
-		cat-file)         : plumbing;;
-		check-attr)       : plumbing;;
-		check-ignore)     : plumbing;;
-		check-mailmap)    : plumbing;;
-		check-ref-format) : plumbing;;
-		checkout-index)   : plumbing;;
-		column)           : internal helper;;
-		commit-tree)      : plumbing;;
-		count-objects)    : infrequent;;
-		credential)       : credentials;;
-		credential-*)     : credentials helper;;
-		cvsexportcommit)  : export;;
-		cvsimport)        : import;;
-		cvsserver)        : daemon;;
-		daemon)           : daemon;;
-		diff-files)       : plumbing;;
-		diff-index)       : plumbing;;
-		diff-tree)        : plumbing;;
-		fast-import)      : import;;
-		fast-export)      : export;;
-		fsck-objects)     : plumbing;;
-		fetch-pack)       : plumbing;;
-		fmt-merge-msg)    : plumbing;;
-		for-each-ref)     : plumbing;;
-		hash-object)      : plumbing;;
-		http-*)           : transport;;
-		index-pack)       : plumbing;;
-		init-db)          : deprecated;;
-		local-fetch)      : plumbing;;
-		ls-files)         : plumbing;;
-		ls-remote)        : plumbing;;
-		ls-tree)          : plumbing;;
-		mailinfo)         : plumbing;;
-		mailsplit)        : plumbing;;
-		merge-*)          : plumbing;;
-		mktree)           : plumbing;;
-		mktag)            : plumbing;;
-		pack-objects)     : plumbing;;
-		pack-redundant)   : plumbing;;
-		pack-refs)        : plumbing;;
-		parse-remote)     : plumbing;;
-		patch-id)         : plumbing;;
-		prune)            : plumbing;;
-		prune-packed)     : plumbing;;
-		quiltimport)      : import;;
-		read-tree)        : plumbing;;
-		receive-pack)     : plumbing;;
-		remote-*)         : transport;;
-		rerere)           : plumbing;;
-		rev-list)         : plumbing;;
-		rev-parse)        : plumbing;;
-		runstatus)        : plumbing;;
-		sh-setup)         : internal;;
-		shell)            : daemon;;
-		show-ref)         : plumbing;;
-		send-pack)        : plumbing;;
-		show-index)       : plumbing;;
-		ssh-*)            : transport;;
-		stripspace)       : plumbing;;
-		symbolic-ref)     : plumbing;;
-		unpack-file)      : plumbing;;
-		unpack-objects)   : plumbing;;
-		update-index)     : plumbing;;
-		update-ref)       : plumbing;;
-		update-server-info) : daemon;;
-		upload-archive)   : plumbing;;
-		upload-pack)      : plumbing;;
-		write-tree)       : plumbing;;
-		var)              : infrequent;;
-		verify-pack)      : infrequent;;
-		verify-tag)       : plumbing;;
-		*) echo $i;;
-		esac
-	done
+	__git_all_commands=$(__git_list_commands all)
 }
 
 __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_porcelain_commands)
+	__git_porcelain_commands=$(__git_list_commands porcelain)
 }
 
 # Lists all set config variables starting with the given section prefix,
diff --git a/git.c b/git.c
index 64f67e7f7f..153f56fb95 100644
--- a/git.c
+++ b/git.c
@@ -230,6 +230,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				list_builtins(NO_PARSEOPT, ' ');
 			else if (!strcmp(cmd, "all"))
 				list_all_cmds();
+			else if (!strcmp(cmd, "porcelain"))
+				list_porcelain_cmds();
 			else
 				die("unsupported command listing type '%s'", cmd);
 			exit(0);
diff --git a/help.c b/help.c
index e63006c333..6688653f99 100644
--- a/help.c
+++ b/help.c
@@ -273,6 +273,18 @@ void list_all_cmds(void)
 	clean_cmdnames(&other_cmds);
 }
 
+void list_porcelain_cmds(void)
+{
+	int i, nr = ARRAY_SIZE(command_list);
+	struct cmdname_help *cmds = command_list;
+
+	for (i = 0; i < nr; i++) {
+		if (cmds[i].category != CAT_mainporcelain)
+			continue;
+		puts(cmds[i].name);
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 0bf29f8dc5..33e2210ebd 100644
--- a/help.h
+++ b/help.h
@@ -18,6 +18,7 @@ static inline void mput_char(char c, unsigned int num)
 
 extern void list_common_cmds_help(void);
 extern void list_all_cmds(void);
+extern void list_porcelain_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1b34caa1e1..5a23a46fcf 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,7 +13,7 @@ complete ()
 	return 0
 }
 
-# Be careful when updating this list:
+# Be careful when updating these lists:
 #
 # (1) The build tree may have build artifact from different branch, or
 #     the user's $PATH may have a random executable that may begin
@@ -30,7 +30,9 @@ complete ()
 #     completion for "git <TAB>", and a plumbing is excluded.  "add",
 #     "filter-branch" and "ls-files" are listed for this.
 
-GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_COMPLETION=t
+GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr filter-branch ls-files'
+GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout filter-branch'
 
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
-- 
2.17.0.367.g5dd2e386c3

