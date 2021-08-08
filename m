Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083CC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D52460EE9
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhHHRtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhHHRtp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 13:49:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D48C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 10:49:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w197so14543347qkb.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+aXnQvIOEFS7N9TVKe+H4zVbhAxGQVeO9iE+sN6Y0M=;
        b=izNN6ExBKUmI3bHVu3trtXxESdtIp7ao0AB01KeXaupZO41Fed0gYxPFhYP9KHKy0P
         iyM3BI15MEhYOsSSGEv0hFmysBDiFx7naNmi25PZByg4FVMg2HMu4wrNhiXk9hHFlG9s
         k4tgZTmLGXBpwCFkcR1MQ4BQnb2AiWq93u+26ebx0DaZNhe5fcFlDlfeaWdR7LAS5q5g
         /wDqFE+y/sCXNjhjLOAnbzTg65vEIFJz1UNxI4vhAlOIxteTNtn5+PiAxnPvtLGPZWo9
         2LTD7aRQqsmuONG7HH2aq8+dIl3oc3fUss4hcHtz7w9TLayLdROFGWj7GD2x/l4DJ8tA
         sIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+aXnQvIOEFS7N9TVKe+H4zVbhAxGQVeO9iE+sN6Y0M=;
        b=aROOe/9+dVHewUkNyiJxciJHQJM7acNbN14E0LJSctfStGTMyHCxlm7nosx1793V2A
         fXISKBvmzQyAgjo8sPLxsxBHQssjCIz+hd4GgT7/G55Zfnx4mGAi+UQZOTi7I1NxLXmA
         QIzsRkWOAEDfZAcHn9oBuOYG9mJAYzp8l7lZV3TpGCCDtkiNxRBX+wvEdp/rVm/oMkG5
         NpX52h0muE6tGk9UhdbZK+DsDx9QffOqINSA0EdsS70/qchc9uWRoKT5QklgaXCjgiou
         JltKJFx816PartsC4pL1Ocjl0MQFmEecl00WNJ71Vi/htHzj3aeHFV9iydmScEtJjAgZ
         LCwg==
X-Gm-Message-State: AOAM530ds2bru4Bbw0Dl60EXJ2TJ3SYcZ1Zrq1KUpnrHIpgDgNBbfbql
        /xN8vlFa959oEDskeJrlpGXJDMDKpEI=
X-Google-Smtp-Source: ABdhPJyFh+NHmxghjAMP27MI5hicg3r5JF8wOmTm/ZB1tTKQhsYZ+H7CyB5AhNJObKiMqOIypejI1g==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr19445138qkf.129.1628444963196;
        Sun, 08 Aug 2021 10:49:23 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-203-160.bstnma.fios.verizon.net. [173.48.203.160])
        by smtp.gmail.com with ESMTPSA id h7sm5924070qtq.79.2021.08.08.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 10:49:22 -0700 (PDT)
From:   Noah Pendleton <noah.pendleton@gmail.com>
To:     git@vger.kernel.org
Cc:     Noah Pendleton <noah.pendleton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] blame: add config `blame.ignoreRevsFileIsOptional`
Date:   Sun,  8 Aug 2021 13:48:47 -0400
Message-Id: <20210808174847.16590-1-noah.pendleton@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807202752.1278672-1-noah.pendleton@gmail.com>
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting the config option `blame.ignoreRevsFile` globally to eg
`.git-blame-ignore-revs` causes `git blame` to error when the file
doesn't exist in the current repository:

```
fatal: could not open object name list: .git-blame-ignore-revs
```

Add a new config option, `blame.ignoreRevsFileIsOptional`, that when set
to true, `git blame` will silently ignore any missing ignoreRevsFile's.

Signed-off-by: Noah Pendleton <noah.pendleton@gmail.com>
---
Reworked this patch to add a new config
`blame.ignoreRevsFileIsOptional`, which controls whether missing
files specified by ignoreRevsFile cause an error or are silently
ignored.

Updated tests and docs to match.

 Documentation/blame-options.txt |  3 ++-
 Documentation/config/blame.txt  |  5 +++++
 builtin/blame.c                 |  7 ++++++-
 t/t8013-blame-ignore-revs.sh    | 14 ++++++++++----
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..199a28ab79 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -134,7 +134,8 @@ take effect.
 	`fsck.skipList`.  This option may be repeated, and these files will be
 	processed after any files specified with the `blame.ignoreRevsFile` config
 	option.  An empty file name, `""`, will clear the list of revs from
-	previously processed files.
+	previously processed files. If `blame.ignoreRevsFileIsOptional` is true,
+	missing files will be silently ignored.
 
 -h::
 	Show help message.
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4d047c1790..2aae851e4b 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -27,6 +27,11 @@ blame.ignoreRevsFile::
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
 
+blame.ignoreRevsFileIsOptional::
+	Silently skip missing files specified by ignoreRevsFile or the command line
+	option `--ignore-revs-file`. If unset, or set to false, missing files will
+	cause a nonrecoverable error.
+
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
 	attribute to another commit with a '*' in the output of
diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9a..df132b34ce 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -56,6 +56,7 @@ static int coloring_mode;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_NODUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
+static int ignorerevsfileisoptional;
 
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -715,6 +716,9 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		string_list_insert(&ignore_revs_file_list, str);
 		return 0;
 	}
+	if (!strcmp(var, "blame.ignorerevsfileisoptional")) {
+		ignorerevsfileisoptional = git_config_bool(var, value);
+	}
 	if (!strcmp(var, "blame.markunblamablelines")) {
 		mark_unblamable_lines = git_config_bool(var, value);
 		return 0;
@@ -835,7 +839,8 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 	for_each_string_list_item(i, ignore_revs_file_list) {
 		if (!strcmp(i->string, ""))
 			oidset_clear(&sb->ignore_list);
-		else
+		/* skip non-existent files if ignorerevsfileisoptional is set */
+		else if (!ignorerevsfileisoptional || file_exists(i->string))
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
 						    peel_to_commit_oid, sb);
 	}
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index b18633dee1..f789426cbf 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -127,18 +127,24 @@ test_expect_success override_ignore_revs_file '
 	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
 	test_cmp expect actual
 	'
-test_expect_success bad_files_and_revs '
+test_expect_success bad_revs '
 	test_must_fail git blame file --ignore-rev NOREV 2>err &&
 	test_i18ngrep "cannot find revision NOREV to ignore" err &&
 
-	test_must_fail git blame file --ignore-revs-file NOFILE 2>err &&
-	test_i18ngrep "could not open.*: NOFILE" err &&
-
 	echo NOREV >ignore_norev &&
 	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
 	test_i18ngrep "invalid object name: NOREV" err
 '
 
+# Non-existent ignore-revs-file should fail unless
+# blame.ignoreRevsFileIsOptional is set
+test_expect_success bad_file '
+	test_must_fail git blame file --ignore-revs-file NOFILE &&
+
+	git config --add blame.ignorerevsfileisoptional true &&
+	git blame file --ignore-revs-file NOFILE
+'
+
 # For ignored revs that have added 'unblamable' lines, mark those lines with a
 # '*'
 # 	A--B--X--Y
-- 
2.32.0

