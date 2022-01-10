Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC4C433FE
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiAJWIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiAJWIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 17:08:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35328C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 14:08:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so29459234wra.6
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 14:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFSxZpaSwAVhcl3JM/krqjSjAcJ8+z0BS5gYRd2lTSs=;
        b=B+hm+INrTXMLTY/EJckSznaJtlbQ/H6pTr3DJsg8/pM5Cn2ZOS1q2OOf+BwYAIIeoE
         pgCzSEeLSWLedqY5nvq30wnE0VIIZftvmg4i9A66YOUNz7bvXSX6dVTDem5zPTZgi4ex
         cZ4wp57xAMaeaowMebinIUwpGr6X5JsVt3YnM9Gg6oDrHQX1Wh1d9UpoxGosa5DBNHKU
         n2aM3bvn/8yMs35agTdB9tTCvvfredg8UJlCgdPd+w6WSwrE6LaG+0b7DYj45A2F4Vcp
         hA+1/WAu2ssu0y1Zlwy5hTgj5piCQglm/5cSVSKVp5TVZ1iS4xTuOSSX7U8tsDZNPD9c
         U1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFSxZpaSwAVhcl3JM/krqjSjAcJ8+z0BS5gYRd2lTSs=;
        b=f+Eaa3vSd3QOTOtNRpVeb8chqs8y31MeMuhQjzBBTeZ+ueEDrZFq4PDuYEoFUnvf+h
         jwZMKzTn6Lgx1/aRCsEl1gq6JbT9DPJk6LmMDA5n8vE05CqZ3HzPaTgz/5RD8fkqRf7f
         Pgr+EL8psnh5DmI3js97FfGP7djLVgXwa+Smu/yIIOM3gjYOLxoVTrQxVgTrMZrmzBu8
         WYniGED8X1Q5DLpMMa30X0dTZuiXFJaW4yo5NaBY8bPvrlfXDyY/AyJprQnbeJENNddA
         0mhMr6xMRIX3oCzQLv/svmtaDjzfyhGb6A4mQgRal/NLkS9M9k8VgUDpckkQdvEuLabQ
         z6Tg==
X-Gm-Message-State: AOAM530jFHaej/d0jQXNMQAoQ/fk3DZl16+vM6UvqlU5kFulRLmqUB8W
        SG5KPoMXSPKiyhGXQMsiAjxbFvs4Qt/FZw==
X-Google-Smtp-Source: ABdhPJyPBB1ovjChW+jIjPc6Yl4ahO2H/0kKtOgBXYKDTtpmk//UPKFDTNtw9s+II7VzI1xyF+p1vg==
X-Received: by 2002:adf:e706:: with SMTP id c6mr1334320wrm.116.1641852531629;
        Mon, 10 Jan 2022 14:08:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm84432wmr.30.2022.01.10.14.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:08:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] cat-file: don't whitespace-pad "(...)" in SYNOPSIS and usage output
Date:   Mon, 10 Jan 2022 23:08:45 +0100
Message-Id: <patch-1.2-91c472ea78d-20220110T220553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1373.g062f5534af2
In-Reply-To: <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
References: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com> <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix up whitespace issues around "(... | ...)" in the SYNOPSIS and
usage. These were introduced in ab/cat-file series. See
e145efa6059 (Merge branch 'ab/cat-file' into next, 2022-01-05). In
particular 57d6a1cf96, 5a40417876 and 97fe7250753 in that series.

We'll now correctly emit this usage output:

    $ git cat-file -h
    usage: git cat-file <type> <object>
       or: git cat-file (-e | -p) <object>
       or: git cat-file (-t | -s) [--allow-unknown-type] <object>
    [...]

Before this the last line of that would be inconsistent with the
preceding "(-e | -p)":

   or: git cat-file ( -t | -s ) [--allow-unknown-type] <object>

Reported-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-cat-file.txt | 4 ++--
 builtin/cat-file.c             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 73ebbc70ee2..bef76f4dd06 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -11,11 +11,11 @@ SYNOPSIS
 [verse]
 'git cat-file' <type> <object>
 'git cat-file' (-e | -p) <object>
-'git cat-file' ( -t | -s ) [--allow-unknown-type] <object>
+'git cat-file' (-t | -s) [--allow-unknown-type] <object>
 'git cat-file' (--batch | --batch-check) [--batch-all-objects]
 	     [--buffer] [--follow-symlinks] [--unordered]
 	     [--textconv | --filters]
-'git cat-file' (--textconv | --filters )
+'git cat-file' (--textconv | --filters)
 	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 
 DESCRIPTION
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ad9b3eef4f4..e36492235ba 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -653,11 +653,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	const char * const usage[] = {
 		N_("git cat-file <type> <object>"),
 		N_("git cat-file (-e | -p) <object>"),
-		N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
+		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
 		   "             [--textconv | --filters]"),
-		N_("git cat-file (--textconv | --filters )\n"
+		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
 	};
@@ -699,7 +699,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "filters", &opt,
 			    N_("run filters on object's content"), 'w'),
 		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
-			   N_("use a <path> for (--textconv | --filters ); Not with 'batch'")),
+			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
 		OPT_END()
 	};
 
-- 
2.34.1.1373.g062f5534af2

