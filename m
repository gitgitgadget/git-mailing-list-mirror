Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB62AECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiIEI25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiIEI2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4319E43619
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s23so4840497wmj.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cw7vuiEZMkJBLrphMrqZgJfkne3UKJgnHqzYbBlaJJg=;
        b=jtlS7OuAQtDo7KJUQQXliaX023jsTz527llWXRp89uifi5ogKTk2DgX/uvGS2v6BuY
         7SGZWOf8Z/LBqbdI5SDxHtfN5tq9HaBzTxY8TiawORE7Kg4ntt0Tbm23/JX8cE9dJv4S
         OGSwoO27oYPIuR9rBtu4TsmcxgbRDxREIOte6ky1t5BIUTx6GynTGOA34KwHRjdv9LbF
         NPruPlt6XgiAlWHlIAmanwaV87neTjbTGK/kz2vyBuodhjRRqYhqrMYDfgGHpK/N5V7p
         tL78ZID1q97maiYVufPnwGhvjbg628/QocKcJAnOMypJWVuX8s9z66qRTtUT9XzGaVHI
         R6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cw7vuiEZMkJBLrphMrqZgJfkne3UKJgnHqzYbBlaJJg=;
        b=XKHzg6nzYzw5j2vR7ApC5ZMSfpIS20miownQLyKq2ngmKbN5TOBU8ZC2E+OBulvPhb
         Tld2CRjngDrlH2x9VIhTY7mZDlo0eHYkA2z9Yi9ekop5qAgQRSZHFPdN0XxaPWvi4icQ
         TBwbXrF3ffSK0OVPpL1ZBhs1odFNj+j0k9Kaf1CLgNcOg+VSbcycfubOLIZngzkfuzc6
         x2c+TRZndedEymWuMYy9EuPpOrr8ikyCARPitXv5Ous5l9OjQw8+aeGz7mp7B8sHvxxY
         TaFp72DopjkMMjQ+h7KlW+8aAiQGeB+R3bVIr466pqDBh9uMGtxvg0dNXa2nrdX0jySM
         m3wA==
X-Gm-Message-State: ACgBeo2LH4ZyCzWcq7xAi4nWvNyP+ooBt/8x1BtfsidE9aQucJ8Wpzej
        XqPV8pvz/XReTeV2OBt5jpL9Pv5DaDZ3Tg==
X-Google-Smtp-Source: AA6agR5dBGueemZg3j4Upp9sYfy8pBXCLNF8goujRyN6rZmFkmUPhrQ8SkE/km1AogJs9vmRT7En/g==
X-Received: by 2002:a05:600c:354a:b0:3a5:bd8f:c2a5 with SMTP id i10-20020a05600c354a00b003a5bd8fc2a5mr9546601wmq.142.1662366439004;
        Mon, 05 Sep 2022 01:27:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 28/34] doc txt & -h consistency: use "[<label>...]" for "zero or more"
Date:   Mon,  5 Sep 2022 10:26:39 +0200
Message-Id: <patch-28.34-6607ed3e343-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct uses of "<label>..." where we really meant to say
"[<label>...]", i.e. the command in question taken an optional set of
"<label>". As the CodingGuidelines notes "[o]ptional parts [should be]
enclosed in square brackets".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-clean.txt | 2 +-
 builtin/clean.c             | 2 +-
 builtin/commit.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 13e3a0844f8..6d55cd1f5e8 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/clean.c b/builtin/clean.c
index 6f039f555b2..40ff2c578de 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -26,7 +26,7 @@ static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] [<pathspec>...]"),
 	NULL
 };
 
diff --git a/builtin/commit.c b/builtin/commit.c
index fcf9c85947e..21ad4ccbf87 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -45,7 +45,7 @@ static const char * const builtin_commit_usage[] = {
 };
 
 static const char * const builtin_status_usage[] = {
-	N_("git status [<options>] [--] <pathspec>..."),
+	N_("git status [<options>] [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2

