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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C52C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A783660C40
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhHKE6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhHKE6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:58:00 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650FC06179F
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:36 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bi32so2861663oib.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7iZSzhX0298EA5UulCQR1FlJGT4jgu+42RRYbjB3Lg=;
        b=UyU0Do0qRWlbCVndGN5Tyh2DUZgtSXdvESGjxd8fXypwTo5/Jk4p7iksUxe3GwcyxS
         A+JO5rACmq2c5yJ0axqeDnLEoWrQfZpKn6a6C9GemjZiRZD43ulGJTiBU9Xzm0hjilCy
         +lDEhJWw4LmreZG1xaCEOJgWOFHcB6xz1M6nr59I0eMHdqsP44HMLpOxCu5uf3R2qieN
         uMLZI21lo0g+KrEpoEJV6KetMb9gCFaO6mE0mTLvYxdeIzpVXyOTEf+5r+HJ3xgBwjGS
         dLybgV9Nl1aKFDOmroBnxuIOgrVanUXm4sgWuE+2h0yBGquh90u+maKvqOiGs1f95y83
         QUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7iZSzhX0298EA5UulCQR1FlJGT4jgu+42RRYbjB3Lg=;
        b=LW+xfukFWgxiqoqPS38V/e8pTBifLyv20R6ClP2iJXf/PbKuMnH1wdUxv+mCfnFHSO
         VhsdO2uHo8zWK25erkdVDCENqwiG7ZeBFQrD6mWPlxwFk2ilW9kqh4d+jlHiBpwb89D8
         wDEp97Dx63rfkL5GMdt4rAYzcyfNiioB1cM5NNiCk/m30Stw2nWx3/yJckdfIUUR6+qp
         qOlVCOq85VVs0MwdYeoGL/+QleMF90LVLhpktveojcmhWGS79uWLfDzf/xx7BZ9ooy+W
         xRav29oDE4MAAup06+tbUJsDOH5rYkTZeZISgC1fi8HVtUbkNLyxjS6wc2Pp2mpZK3lU
         dFrw==
X-Gm-Message-State: AOAM533hXlS0al1h4gPt6hQwTFSwhxt4xHGBn43V6Hk/ZDRcrM8tIs/+
        PKyuE/G0e/QVrU9mIhf+rX2g2D/BeXPS4g==
X-Google-Smtp-Source: ABdhPJz8fVzsBf74ERD8nPf0rDZHvBilXTSJm3n0q6sHrUfqmYUmgzNF3HiS20Rv/zrEj5jh8HdZrA==
X-Received: by 2002:a05:6808:1807:: with SMTP id bh7mr6099483oib.52.1628657855666;
        Tue, 10 Aug 2021 21:57:35 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id p2sm4456622oip.35.2021.08.10.21.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] stage: add 'remove' subcommand
Date:   Tue, 10 Aug 2021 23:57:24 -0500
Message-Id: <20210811045727.2381-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210811045727.2381-1-felipe.contreras@gmail.com>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt | 6 ++++++
 builtin/stage.c             | 7 ++++++-
 t/t3710-stage.sh            | 5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 348d7d1d92..e2f83783b2 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git stage' [options] [--] [<paths>...]
 'git stage' (-a | --add) [options] [--] [<paths>...]
+'git stage' (-r | --remove) [options] [--] [<paths>...]
 
 
 DESCRIPTION
@@ -27,10 +28,15 @@ OPTIONS
 --add::
 	Add changes to the staging area. See linkgit:git-add[1].
 
+-r::
+--remove::
+	Remove changes from the staging area. See linkgit:git-reset[1].
+
 
 SEE ALSO
 --------
 linkgit:git-add[1]
+linkgit:git-reset[1]
 
 GIT
 ---
diff --git a/builtin/stage.c b/builtin/stage.c
index 5a80bbc76c..dee8781dc5 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -9,6 +9,7 @@
 static const char *const stage_usage[] = {
 	N_("git stage [options] [--] <paths>..."),
 	N_("git stage --add [options] [--] <paths>..."),
+	N_("git stage --remove [options] [--] <paths>..."),
 	NULL
 };
 
@@ -35,15 +36,19 @@ static int rerun(int argc, const char **argv, ...)
 
 int cmd_stage(int argc, const char **argv, const char *prefix)
 {
-	int add = 0;
+	int add = 0, remove = 0;
 
 	struct option options[] = {
 		OPT_BOOL_F('a', "add", &add, N_("add changes"), PARSE_OPT_NONEG),
+		OPT_BOOL_F('r', "remove", &remove, N_("remove changes"), PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, stage_usage,
 		PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
+	if (remove)
+		return rerun(argc, argv, "reset", NULL);
+
 	return rerun(argc, argv, "add", NULL);
 }
diff --git a/t/t3710-stage.sh b/t/t3710-stage.sh
index 225c6dd739..209f2bde9a 100755
--- a/t/t3710-stage.sh
+++ b/t/t3710-stage.sh
@@ -23,4 +23,9 @@ test_expect_success 'add' '
 	in_stage bar
 '
 
+test_expect_success 'remove' '
+	git stage --remove bar &&
+	! in_stage bar
+'
+
 test_done
-- 
2.32.0.48.g096519100f

