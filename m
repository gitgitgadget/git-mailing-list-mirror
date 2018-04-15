Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530F71F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeDOQpy (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:45:54 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38188 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeDOQpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id n14-v6so1146828lfe.5
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYLEg3PdTo1jeVrd7TDCkZf8nXaG4EAb3lCx3oWpuZM=;
        b=FMBI/djnkLPuDG/ldBNZDMeOnK/mwaVMC1qfZOIsUthPFayJaksAfhwZO8oZsXjfuu
         IPRFS/ObbWDfueSEwcRis2FkhhLs1raUNTUcoZpql0jJaS28EwYA6X9YBltsaranRY5l
         dew7wOIp8gV2HouubzKezV+tQeIGJHu4hKaQTJHRT4REDdM6tFP9PJJXhXkQQSP3kMlA
         6qekSkL4woHISSC5UfpmDUxuX2CM9+/O6Xrc27Tgp4LnoXKtQ11ViOlYg7GCtCvxsWL6
         fl5sTwtPmzAfzbv1zRXJvcGbUFgnNA5P8bsUH1HkvgeQADeIIIROQ3w7kXeP0LPpDG5R
         dcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYLEg3PdTo1jeVrd7TDCkZf8nXaG4EAb3lCx3oWpuZM=;
        b=k7MFbrXbjQmt4jk58yK5FQPbCN5zP8cyHSrpq+Wdt62NhGu2mxCICPpsB290jGOeej
         7qkkbc7booiarQ6CWwK7g2jFjRziP3yYMSWqRX9kCzW3DA7GlpUWjf/CHFaiMQLX6+Ov
         1rSQFQ6pYrsOTl+dlk69RzKUq9hBwOQmy8Bz6DrPqJ1ldamF46J0qf72cg36xbgnvtpA
         CrDteGLWXlVXWC0Te3uPCbO4zhxc72ao+aBidaqRpw8yvf/tAlFZacIKdQFPjhQqwZnf
         M31288MLzFjR1OkQ0FLoRjA/XQ+winBzyj0HHhBQKCuFDmlxRVb6DLa1AUMFVObSujFl
         KksQ==
X-Gm-Message-State: ALQs6tAi9d8i+2jmtcaMy7Mvw7B4I4z0AjQjxfzlQRchAgQLisH+O/cy
        KnLKJ253VAnCsVOqSV2eA0E=
X-Google-Smtp-Source: AIpwx48xPnD26H7YTldCv3NGeVI4XlUOVJeFY10jZmddDcVXhOcrUcQDNywt3thZIhObQCqzks4vRg==
X-Received: by 2002:a19:1294:: with SMTP id 20-v6mr2389526lfs.21.1523810748871;
        Sun, 15 Apr 2018 09:45:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] git.c: implement --list-cmds=porcelain
Date:   Sun, 15 Apr 2018 18:42:36 +0200
Message-Id: <20180415164238.9107-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415164238.9107-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180415164238.9107-1-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 94 ++------------------------
 git.c                                  |  2 +
 help.c                                 | 12 ++++
 help.h                                 |  1 +
 t/t9902-completion.sh                  |  4 +-
 5 files changed, 20 insertions(+), 93 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a5f13ade20..9f17703aa7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -839,14 +839,15 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git --list-cmds=all
+		git --list-cmds=$1
 	fi
 }
 
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(__git_commands)
+	local category=${1-all}
+	for i in $(__git_commands $category)
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -862,98 +863,11 @@ __git_compute_all_commands ()
 	__git_all_commands=$(__git_list_all_commands)
 }
 
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
-}
-
 __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_porcelain_commands)
+	__git_porcelain_commands=$(__git_list_all_commands porcelain)
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
index b5da7fa013..1523ca175c 100644
--- a/help.c
+++ b/help.c
@@ -272,6 +272,18 @@ void list_all_cmds(void)
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
index 1b34caa1e1..4bfd26ddf9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1208,8 +1208,6 @@ test_expect_success 'basic' '
 	grep -q "^add \$" out &&
 	# script
 	grep -q "^filter-branch \$" out &&
-	# plumbing
-	! grep -q "^ls-files \$" out &&
 
 	run_completion "git f" &&
 	! grep -q -v "^f" out
@@ -1272,7 +1270,7 @@ test_expect_success 'general options' '
 	test_completion "git --no-r" "--no-replace-objects "
 '
 
-test_expect_success 'general options plus command' '
+test_expect_failure 'general options plus command' '
 	test_completion "git --version check" "checkout " &&
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --git-dir=foo check" "checkout " &&
-- 
2.17.0.367.g5dd2e386c3

