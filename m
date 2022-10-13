Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4239C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJMPln (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJMPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B36267160
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u10so3477738wrq.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyY+9KrfECbxHPGaY3nfHTH+LaHUwJuwbB7xXczBd6U=;
        b=FylUlpSVrKnjBGZpYKF7qoBGMN8PB7G9K3x6EYHcWzIXahHv2Y+EwFlNq92pNbGq+x
         9YCHBj19TTVVuhJLUMQHAVwAeVEwJsC6Ws8OBAEO5/oVZoHXO3IJhNHJpjg/NbsUgPra
         Nmd3MZEa+Y84YkyewBFgxSniS5gfv64v/23h37GA5OhgWZomi4DtDsS3OlSBK3FhNhYo
         NNilFCACl80Nl9JD4l0lEa/XNiXv+t/IeQUrAdMUoqGmvGn1mC5WHlK0pgNPtMqCXsFq
         W9bwXCEgPBWf6LPY7UkbhvFyVuauh6p8Gfhb2s23MKJgUaCXJiHMxtFir3VH8Uk9LUcC
         jV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyY+9KrfECbxHPGaY3nfHTH+LaHUwJuwbB7xXczBd6U=;
        b=A1WtbV7H8m2gFO2f9XqA9w0TF82vDxfhFp+b4XdqyfNWtl82w4bJRe9JSenueMjMsd
         dA6uzU+OKlgBh1auMCJ+6CTpG+ifFl2TMkH5eLkWheVYLJKFaKO+tx5vYy0os52A7r5K
         2/tokKc4HmpBb2ZSMi3yoYMZT+sZQMrSpNkHlB+trjWt8hVMUbt5MUtu5yu0pyp/j6wT
         vlBXFDG1ZZtMEuTI6eSgBszQMjwPyKa8jZ2dU0FaXTDgb27w+2fXuclB+hv2oV5REfQs
         Pb87PPHF6diyS8liSDwVdY6z6DqR3Q71P3izyzhL6x6ePLNs1Z/ucztObuOOp/6RG+Yn
         LYwg==
X-Gm-Message-State: ACrzQf1KPulj7MbbASbjzdSVK8ykPzL73WVMP6x/csMbaLTh0zNN1dzS
        45OvOe+1kFDa1irBCf8fOrhkg9Rl5CsyfA==
X-Google-Smtp-Source: AMsMyM7Q1rleS/sFcVMiKGVQl/RTkljlLLQJttkKE/2GCWKkbXd83gv10XyQb8A8tXW9iAsFCmnOXA==
X-Received: by 2002:adf:dc4b:0:b0:230:5fe6:69d2 with SMTP id m11-20020adfdc4b000000b002305fe669d2mr387759wrj.469.1665675605864;
        Thu, 13 Oct 2022 08:40:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:05 -0700 (PDT)
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
Subject: [PATCH v5 29/34] doc txt & -h consistency: make "commit" consistent
Date:   Thu, 13 Oct 2022 17:39:23 +0200
Message-Id: <patch-v5-29.34-65cd6340726-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "-h" output of "git commit" consistent with the *.txt version
by exhaustively listing the options that it takes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 21ad4ccbf87..64f420bcbf6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,14 @@
 #include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [<options>] [--] <pathspec>..."),
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
+	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
+	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
+	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
+	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
+	   "           [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.38.0.1085.gb7e61c3016c

