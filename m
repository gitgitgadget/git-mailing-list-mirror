Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17F120248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfBYXRJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so11793734wre.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1drPoKl6rhHXAdnJQebSPXtYSZpmYeHRAMxw9MqkcYY=;
        b=qFwsaHAlA+1evLFiAeSM3+2FcZAEGht6iRWiVH3nwZvNzQN7B3Yd/dMIKPy5bUS0Qt
         vInCLf89GXL9FLLFxObuoJyRVkpVvVgy44GKKAwUmhmggLfJCZL0ppgOYOMv0R0IZuph
         8nZ6/4+yvBB++pZb8M9pcu7L+DLqDrmGcF5nT7aqMzgRZCnNwHF5GzLh5peQDV5U0nvU
         yc1BPkT9frqYzcOSRA4B/V28ixH8rYT3JH4W+SxrPUgJvyDuAGgqND6p8UBASXxks/zy
         gf5btO/XJyQJPiRp7J/seTEvjD7I3RIybFzG0JPE+alEvSaD2OpSZ8079vcvlFW4T/TJ
         YSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1drPoKl6rhHXAdnJQebSPXtYSZpmYeHRAMxw9MqkcYY=;
        b=ejqiVlZ175w3/Sn4RxlB/VQNrHyrSeoFj1MIuGtiyezn0irLylsVbFf1VvloiOOLSV
         gLKO5VyAIz2BPB5ZEI2lsD1hva6uh/lScyIFyatw2m2TRXDHyrcwgVpTcVc7dfuygN5s
         lna5uuZi8/oC2lHSyqGNRIUklwDKION/tP7goYyLlWnupld26NwDqfz7+KFlHNbTg1gR
         1/4zYKaWZD4wNAfWPS72suB+omRy6k7qaakkkbM3E6dhxBiawBZJFykn2VMCizPaL0Pb
         Irz6fU4V4PZ25csWNDyc9ieK6XS6d2G/MaW1jjKSHeFlmAeDivLTupv5fBSiXLk4+lJt
         nVqg==
X-Gm-Message-State: AHQUAubsrN9M04CJXBL9VpKMhcHXZb4m4GjchvdKIZ5WQ5zy5dF0SM0L
        zX1hu1jZqnb/GpiS4oqAL5CfYxJx
X-Google-Smtp-Source: AHgI3Ib/PWcympS0LNr61tWZlDiCAGNlPLdJxHTInrebE1RPbn/LTtVrzBFuTG22KwwsqDFwP5qMqQ==
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr9536017wrx.102.1551136626260;
        Mon, 25 Feb 2019 15:17:06 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id u8sm7213541wrr.33.2019.02.25.15.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:05 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 12/27] stash: convert drop and clear to builtin
Date:   Mon, 25 Feb 2019 23:16:16 +0000
Message-Id: <20190225231631.30507-13-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add the drop and clear commands to the builtin helper. These two
are each simple, but are being added together as they are quite
related.

We have to unfortunately keep the drop and clear functions in the
shell script as functions are called with parameters internally
that are not valid when the commands are called externally. Once
pop is converted they can both be removed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 117 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 03511f466b..c515f0b358 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,7 +12,14 @@
 #include "rerere.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper clear"),
+	NULL
+};
+
+static const char * const git_stash_helper_drop_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
@@ -21,6 +28,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_clear_usage[] = {
+	N_("git stash--helper clear"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -136,6 +148,32 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	return !(ret == 0 || ret == 1);
 }
 
+static int do_clear_stash(void)
+{
+	struct object_id obj;
+	if (get_oid(ref_stash, &obj))
+		return 0;
+
+	return delete_ref(NULL, ref_stash, &obj, 0);
+}
+
+static int clear_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_clear_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc)
+		return error(_("git stash clear with parameters is "
+			       "unimplemented"));
+
+	return do_clear_stash();
+}
+
 static int reset_tree(struct object_id *i_tree, int update, int reset)
 {
 	int nr_trees = 1;
@@ -423,6 +461,81 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
+{
+	int ret;
+	struct child_process cp_reflog = CHILD_PROCESS_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/*
+	 * reflog does not provide a simple function for deleting refs. One will
+	 * need to be added to avoid implementing too much reflog code here
+	 */
+
+	cp_reflog.git_cmd = 1;
+	argv_array_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
+			 "--rewrite", NULL);
+	argv_array_push(&cp_reflog.args, info->revision.buf);
+	ret = run_command(&cp_reflog);
+	if (!ret) {
+		if (!quiet)
+			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
+				  oid_to_hex(&info->w_commit));
+	} else {
+		return error(_("%s: Could not drop stash entry"),
+			     info->revision.buf);
+	}
+
+	/*
+	 * This could easily be replaced by get_oid, but currently it will throw
+	 * a fatal error when a reflog is empty, which we can not recover from.
+	 */
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	/* do_clear_stash if we just dropped the last stash entry */
+	if (ret)
+		do_clear_stash();
+
+	return 0;
+}
+
+static void assert_stash_ref(struct stash_info *info)
+{
+	if (!info->is_stash_ref) {
+		error(_("'%s' is not a stash reference"), info->revision.buf);
+		free_stash_info(info);
+		exit(1);
+	}
+}
+
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	int quiet = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_drop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+
+	ret = do_drop_stash(prefix, &info, quiet);
+	free_stash_info(&info);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -445,6 +558,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_stash_helper_usage, options);
 	if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		return !!clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		return !!drop_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 366a082853..b8f70230f9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -670,7 +670,7 @@ apply)
 	;;
 clear)
 	shift
-	clear_stash "$@"
+	git stash--helper clear "$@"
 	;;
 create)
 	shift
@@ -682,7 +682,7 @@ store)
 	;;
 drop)
 	shift
-	drop_stash "$@"
+	git stash--helper drop "$@"
 	;;
 pop)
 	shift
-- 
2.21.0.rc2.291.g17236886c5

