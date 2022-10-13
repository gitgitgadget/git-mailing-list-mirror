Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04FC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJMPkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJMPjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E4EE2A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f11so3442504wrm.6
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt8Q3OeQkg9KxER4tKtwZuSvNDk5Bieuk6bkflTo4yI=;
        b=nMN05XX39QErq7cQUMZQQYACIZMa8ImShAqW9A12iT1T0g9s4LhRuFXX4h7tNjEQgc
         B4AzWF+8lBvW6Y0wRk+DOS4HVfi5ZztM/ZO2LEYe1FS+5oT7cRRyIJuySOfGyuTsr9n2
         8EmUJXD9VlJlVzaEeJLYoX0LdIF5lJcllB9A0edtoD4k/p9S74eeH9xP9akI52DIZb/8
         O+imswZyTq8RnfdSBGInD5lfd3ms6PTfn676JnxFKWDyUehXImXkTZCTkUO4YDU8fLxY
         UR4aVjmn9aEFr3yIFecmwzP6MOaG6K7jCPWoh4qybyD8zVlLEGAS+hYQsbP0G5vU2HtZ
         lwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt8Q3OeQkg9KxER4tKtwZuSvNDk5Bieuk6bkflTo4yI=;
        b=P97TbxAPK1/wKya6Me/VAv+k+UjFhsAKfF5gyhmDCP0DtBYjSRRrBxTOrUq4/BZjMz
         SGtqqsFwdGJ02vigf0TAhg5VkxDd9GLpVl43yZTmSdTDCeCRV1CWK6hmc/NM1dnX4yM6
         a/lFekKWN2bmzWYPNgh3xmlylnogxZUS9r91ninIulDwzdtm748YetH/zDtKYfbH+8sb
         vnd4mNytqTVnri4afAvOPe9LZ+1wY8yvtaine5oNOrJzCuBnwabs+DdxLaZO0hWfvFSP
         dk0qH4XjVL1y+IX/fk3BA0u8e+a3sz7gTFdsmc+9THVLorTwvnhXtelSdnH4EMfxNFJE
         36RQ==
X-Gm-Message-State: ACrzQf37sh6w12SfBfPAxAEqwRfX/HAE0OLgDt5RreFVQ1pzIxbZgqcw
        oCak+DOtzT35J4k1L1lbDN6I3Nd8gmd6PQ==
X-Google-Smtp-Source: AMsMyM4Z0a1JJgIFLrxmZtSy+EY9TuRWzTlYK/umwf/IeKsTnTwRlKkI0KaJadJ7ENUZjMaJgYyx1A==
X-Received: by 2002:a5d:588f:0:b0:231:c661:5cee with SMTP id n15-20020a5d588f000000b00231c6615ceemr440745wrf.18.1665675581334;
        Thu, 13 Oct 2022 08:39:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/34] built-ins: consistently add "\n" between "usage" and options
Date:   Thu, 13 Oct 2022 17:39:01 +0200
Message-Id: <patch-v5-07.34-c31e6eba62d-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change commands in the "diff" family and "rev-list" to separate the
usage information and option listing with an empty line.

In the case of "git diff -h" we did this already (but let's use a
consistent "\n" pattern there), for the rest these are now consistent
with how the parse_options() API would emit usage.

As we'll see in a subsequent commit this also helps to make the "git
<cmd> -h" output more easily machine-readable, as we can assume that
the usage information is separated from the options by an empty line.

Note that "COMMON_DIFF_OPTIONS_HELP" starts with a "\n", so the
seeming omission of a "\n" here is correct, the second one is provided
by the macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-files.c | 1 +
 builtin/diff-index.c | 1 +
 builtin/diff-tree.c  | 1 +
 builtin/diff.c       | 3 ++-
 builtin/rev-list.c   | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 92cf6e1e922..096ea2fedbc 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -15,6 +15,7 @@
 
 static const char diff_files_usage[] =
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
+"\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 7d158af6b6d..e667cf52e7d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -11,6 +11,7 @@
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] "
 "[<common-diff-options>] <tree-ish> [<path>...]"
+"\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 116097a404a..23f58702fa0 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -85,6 +85,7 @@ static int diff_tree_stdin(char *line)
 static const char diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
 "  --cc          show combined diff for merge commits removing uninteresting hunks\n"
diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964c..67760b67552 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -30,7 +30,8 @@ static const char builtin_diff_usage[] =
 "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>\n"
-"   or: git diff [<options>] --no-index [--] <path> <path>\n"
+"   or: git diff [<options>] --no-index [--] <path> <path>"
+"\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 static const char *blob_path(struct object_array_entry *entry)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fba6f5d51f3..f67e2b33555 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -21,6 +21,7 @@
 
 static const char rev_list_usage[] =
 "git rev-list [<options>] <commit-id>... [-- <path>...]\n"
+"\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
 "    --max-age=<epoch>\n"
-- 
2.38.0.1085.gb7e61c3016c

