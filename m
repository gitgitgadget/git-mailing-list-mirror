Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75639C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546286103B
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhHGU3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 16:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHGU3q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 16:29:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA2FC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 13:29:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a12so9314059qtb.2
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3UtS5+LKs/cdEuPy035hZiB/lU0SsvI7a2DPRnb6qw=;
        b=bUZalzce1RkeWmGdEsRh8oqEp30QBXGNDGlHRhvJsXKDIvfXMcWfrwAoO0e+hNrzf3
         6/l35pOeG149MCHQRuIxdJvTFObGyZovIeARAQoFxCd3PIOEiJHCR+rmbuFVTZJ1y8Ei
         rDNRBMoTTb6bNKCLNLshSuHQRE0aa3r6h29QHwnHCdPYdJTY7EnAq2h9wTv9XD3WDizO
         9x3INbbotSwPNXYVxxm+OaUzVLVp4347O/A2qgDQebcOfyCk88jMsBgiSo2TCsKL2ODe
         gG6GYxF57jghXXf4WSmyVwFpWTSQJR0047zVrq4Ox6p3YE0noj3yhol5hjbsczrK35y0
         vMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3UtS5+LKs/cdEuPy035hZiB/lU0SsvI7a2DPRnb6qw=;
        b=ts19Lc7yNz1wC5EZlOaZmJcql8COEvuwfd+/9rMu4Mwy/S9zOhilb3xZIrGTl5ogDn
         uNQf4DQZOZ2F9Kql0aqkmKWwIxL0c1J/sq9iomRKWNgIEgyTAAgRR/sSaglBQRp1kqhe
         rZe5hPU70dpuwC4GugozUhvFHMpxp5mVjRUMnjdIkb5ZXpc2uJhRR9ILqQMBZJKx6LTO
         awfequVlhyunYzvLDQxIzOWEYGfFYHc+twYLBAWISVmammTERNZOTYEjRXaKclQfeCtV
         1hNYRqek+3m73iVRK2W18zT5s5UmWtjImVGdIvBgrxMv/7XHyF/0Qg/oSMDnDbqZPR57
         2lOA==
X-Gm-Message-State: AOAM5313B8Vx4vX2l0O1V3oAM6UGpEzD8J7Us0U7Adklji92wvSZYydh
        Yx5ugaHQo7fDlmsaYDZfwzfbODPLsxY=
X-Google-Smtp-Source: ABdhPJzLsdsoZN6rHWaIUIeLJLvvynPh925LcWPjqw3w15AS0QyFI09W1+sbvvp3dfWYsz4OsPcpVg==
X-Received: by 2002:ac8:4e2f:: with SMTP id d15mr1113353qtw.352.1628368167091;
        Sat, 07 Aug 2021 13:29:27 -0700 (PDT)
Received: from noah-XPS-13-9310.myfiosgateway.com (pool-173-48-203-160.bstnma.fios.verizon.net. [173.48.203.160])
        by smtp.gmail.com with ESMTPSA id i67sm6665653qkd.90.2021.08.07.13.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 13:29:26 -0700 (PDT)
From:   Noah Pendleton <noah.pendleton@gmail.com>
To:     git@vger.kernel.org
Cc:     Noah Pendleton <noah.pendleton@gmail.com>
Subject: [PATCH 1/1] blame: skip missing ignore-revs-file's
Date:   Sat,  7 Aug 2021 16:29:02 -0400
Message-Id: <20210807202902.1279624-2-noah.pendleton@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807202902.1279624-1-noah.pendleton@gmail.com>
References: <20210807202902.1279624-1-noah.pendleton@gmail.com>
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

Instead, just skip over ignore-rev files that don't exist.

Signed-off-by: Noah Pendleton <noah.pendleton@gmail.com>
---
 Documentation/blame-options.txt |  2 +-
 Documentation/config/blame.txt  |  3 ++-
 builtin/blame.c                 |  2 +-
 t/t8013-blame-ignore-revs.sh    | 10 ++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..2a8f54cc9c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -134,7 +134,7 @@ take effect.
 	`fsck.skipList`.  This option may be repeated, and these files will be
 	processed after any files specified with the `blame.ignoreRevsFile` config
 	option.  An empty file name, `""`, will clear the list of revs from
-	previously processed files.
+	previously processed files. Any files that do not exist will be skipped.
 
 -h::
 	Show help message.
diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4d047c1790..f7f49a4ac2 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -25,7 +25,8 @@ blame.ignoreRevsFile::
 	line, in linkgit:git-blame[1].  Whitespace and comments beginning with
 	`#` are ignored.  This option may be repeated multiple times.  Empty
 	file names will reset the list of ignored revisions.  This option will
-	be handled before the command line option `--ignore-revs-file`.
+	be handled before the command line option `--ignore-revs-file`. If the
+	specified file does not exist it will be skipped.
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9a..e5b45eddf4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -835,7 +835,7 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 	for_each_string_list_item(i, ignore_revs_file_list) {
 		if (!strcmp(i->string, ""))
 			oidset_clear(&sb->ignore_list);
-		else
+		else if (file_exists(i->string))
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
 						    peel_to_commit_oid, sb);
 	}
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index b18633dee1..56956adb14 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -127,18 +127,20 @@ test_expect_success override_ignore_revs_file '
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
 
+# Non-existent ignore-revs-file should be ignored.
+test_expect_success bad_file '
+	git blame file --ignore-revs-file NOFILE
+'
+
 # For ignored revs that have added 'unblamable' lines, mark those lines with a
 # '*'
 # 	A--B--X--Y
-- 
2.32.0

