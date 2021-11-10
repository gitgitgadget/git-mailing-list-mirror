Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E389C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682E261207
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKJBqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJBqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBBAC061767
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:43:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z21so3971137edb.5
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKJDejMguoKuLBK9KEjikGOmBRA+WOPweKJVsbkw2A8=;
        b=XCgmKHQrp2yOP/GZxFYI0Yo0VGym8eIwuieiqs/BfsKKBcN8PoA63jcSVCjt48/lCH
         V6G+NiugWq0dj8k0fYMrw49gKkP/thkWWNKcRxhsKOVf3IItFOQPZXCFMHHuj5wUmf9F
         NvPBYCK64jqpg6AWVuRwoxhDYTcdAfHtIYgZJ1QAk5lXOv61B8gV43zhBQ0Jc1fyIqeo
         KiB4hbJ1KV/oWcd0hcWIR2rrzLutmJTDAgKpKH+bYDMv6kHL63+T2b9qbI/R1xSXxUIv
         FuwQkaP9FEfSKV7fKxMZURFDkzkGwfQ/CoCfUvNzPsD3ZgpYobxGZuImNEXN369rXj90
         xNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKJDejMguoKuLBK9KEjikGOmBRA+WOPweKJVsbkw2A8=;
        b=5eBMejPYoNEJ0pgZTo/RAGLK824aMenpd/rieVFme+dquNhMnwI/v5OXZhn9tzhe93
         6HpXUNmvepOd6MyQjUtehEEvkdW9IASg7y4YmmwOJTYV1RwbKsME9yjDsuyi/1hGgA/W
         7DrQnpQwChGsx+iDKjbI0nqOxZh4PAx3nOPjpyxdLXqoJJST72AK2jzsUfiUI5edqsmW
         53KzImAJrgx9Mx2VzyJgbYEg/yoyJEXrybvuOoDDSPJTKuTgzvPlEGkCqU8+bd5ZdEAy
         woypbYVzbJ8X1ivu34DhU+DWqQLYtoLDmracKeSJ9s3SmgkuakXfMATblGlx38L+7JwR
         I66g==
X-Gm-Message-State: AOAM530tYbP6PFAcTIJput11H8r89SPo58MK7ar2Vv4jxzkgfUP/e5Cp
        hrMp6n0SY79lUDVVkjyVHiHPVsrvfJRDGg==
X-Google-Smtp-Source: ABdhPJw7zton/ya+JYlGzbLvJQYqMCwKFukA8CdHSG9jgctNxsBkayRtE82g6nE//kks7zw7bV+UoQ==
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr16549595edx.43.1636508637336;
        Tue, 09 Nov 2021 17:43:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] grep docs: de-duplicate configuration sections
Date:   Wed, 10 Nov 2021 02:43:46 +0100
Message-Id: <patch-v2-4.8-efe95397d72-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the "config/grep.txt" file in "git-grep.txt", instead of
repeating an almost identical description of the "grep" configuration
variables in two places. In a subsequent commit we'll amend this
documentation, and can now do so in one place instead of two.

Let's also add a short blurb at the top indicating that this is
included documentation, so users won't think that they need to read
the two versions and compare them.

That wording is copy/pasted from the change I made in b6a8d09f6d8 (gc
docs: include the "gc.*" section from "config" in "gc", 2019-04-07),
eventually we'll want to include this via template, and indeed this
change is extracted from a WIP series that fixes all these
"CONFIGURATION" includes which does that. But doing that would require
build system changes, so let's punt on it for now.

There is no loss of information here that isn't shown in the addition
to "grep.txt". This change was made by copying the contents of
"git-grep.txt"'s version over the "grep.txt" version. Aside from the
change "grep.txt" being made here the two were identical.

This documentation started being copy/pasted around in
b22520a37c8 (grep: allow -E and -n to be turned on by default via
configuration, 2011-03-30). After that in e.g. 6453f7b3486 (grep: add
grep.fullName config variable, 2014-03-17) they started drifting
apart, with only grep.fullName being described in the command
documentation.

In 434e6e753fe (config.txt: move grep.* to a separate file,
2018-10-27) we gained the include, but didn't do this next step, let's
do it now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/grep.txt |  7 +++++--
 Documentation/git-grep.txt    | 30 +++---------------------------
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7ca..ae51f2d91c8 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -16,8 +16,11 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. If unset (or set to 0), Git will
+	use as many threads as the number of logical cores available.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..29d5ce04f5a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -334,34 +334,10 @@ performance in this case, it might be desirable to use `--threads=1`.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
+The below documentation is the same as what's found in
+linkgit:git-config[1]:
 
+include::config/grep.txt[]
 
 GIT
 ---
-- 
2.34.0.rc1.741.gab7bfd97031

