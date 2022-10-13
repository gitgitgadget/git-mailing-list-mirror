Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C969C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJMPlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJMPkR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAD4AD6F
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso1737284wmq.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRpT9wL/6rAyf9PYOq40BLO+wWhJZXFWIOX0z9H7BAs=;
        b=ItEgI4IMtSc0iAQAII/ktPsFMJEcp717PucnacSSY+iiQjkugGRkzyRHJNMQKugeHR
         YxQ8xoA2eKQkJ68UMNsXZVAEpZ96Wfwg9B8xNHW7VFu4bBNnoHaT9Yj8Fwa1KtToYkzj
         EznSwD8VU7XvXiYxk8LYrPIxsc/unZpvnygJvM2C95yoB3biEEsEIl5Y3BcYMlTMzWZC
         agiykc2R7Zrj0UTNZRrFFE1jsjx9QJPjilJVRZHhqCB+p5ayXMfmpWvaUUMEbaLwJt2q
         0Vk61HxeCbjMFNgVt9SuDLB0ZIRtOsziPDtYOOUeyxIuyA1RX2+c6DLzzrwASu7GoPJh
         /AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRpT9wL/6rAyf9PYOq40BLO+wWhJZXFWIOX0z9H7BAs=;
        b=egWSV1TmRWRoUDFhC6AafUyQ6gwfjLb7J2I0/Nu2K/tohi0D3dSu1hJnAl4lYVns74
         jyTNftmgcpYrkhKxJvxQDpT5xY1msynnnfj6SQVZETFPS8FfoEihPyanQ0XxTREwm93E
         l2S8dDOVLXWfd66XS6K/AkcmeJT1JT+vVWQe7KBbtaEzc8rv/cWz/F+ICedtTRUGzjo5
         r3qOsWFnCIjUI6lQHyuUwskRbt86ijQqUyIScMs57vbon0KOOLRHLjctqDNBUxR9t/Ts
         QCEHpTZdIKo8/0lXlEjSpx0v8QySIx1ELFWgPf0uBnTLQhDPtu+jaQWbZYq3N9tTHQSA
         rLmg==
X-Gm-Message-State: ACrzQf1Ephd0m8DlYC9ZNhtTsCwGtozWngwzb3IQI1k2DcZ/ZkTfKlDe
        s7g0qF7cHI4usCy0GBF8x6he2lJvFLvLrQ==
X-Google-Smtp-Source: AMsMyM7Xii0HFeei+fg3NzumQ+YwSDP0b5nQMjRUsExKqF07cpd2rX98oC6X8AE0QONEJshahVdclQ==
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id n13-20020a05600c4f8d00b003b49f2f4311mr298295wmq.17.1665675596787;
        Thu, 13 Oct 2022 08:39:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:56 -0700 (PDT)
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
Subject: [PATCH v5 21/34] doc txt & -h consistency: make "read-tree" consistent
Date:   Thu, 13 Oct 2022 17:39:15 +0200
Message-Id: <patch-v5-21.34-2c4c48792b3-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C version was right to use "()" in place of "[]" around the option
listing, let's update the *.txt version accordingly, and furthermore
list the *.c options in the same order as the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-read-tree.txt | 2 +-
 builtin/read-tree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index b9bfdc0a319..7567955bad8 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -9,7 +9,7 @@ git-read-tree - Reads tree information into the index
 SYNOPSIS
 --------
 [verse]
-'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+'git read-tree' [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)
 		[-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index b3a389e1b1f..f4cbe460b97 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -39,7 +39,7 @@ static int list_tree(struct object_id *oid)
 
 static const char * const read_tree_usage[] = {
 	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
-	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
+	   "              [-u | -i]] [--index-output=<file>] [--no-sparse-checkout]\n"
 	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
-- 
2.38.0.1085.gb7e61c3016c

