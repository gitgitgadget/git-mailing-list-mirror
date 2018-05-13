Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B19F1F42D
	for <e@80x24.org>; Sun, 13 May 2018 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEMJ7D (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 05:59:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33190 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMJ7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 05:59:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12-v6so8049179wmc.0
        for <git@vger.kernel.org>; Sun, 13 May 2018 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SwZYwTjDHHre2H8BdteSEHLYpVT8Bvr7u0b+ffWP1Q=;
        b=MA5Sev4O+2uhNeoWRrJ2wAgi+03W6l0X1VT3NcmdL2pvopkKCRTY+71tOImxc24oqC
         qMoBhyKOa/pCC/Yv7frjV5VKz2wL5Xscx44nsIC2PdZTtP1Wa1LyDmFDp3wXM0XVQYE7
         D0CMLhHsxCbvgIFgsKZfoD4i+n1fnvex1kbe15q1kUtV9BCbTJezGsTHziXOx87/lmuT
         d2gcOX3V6eMz68+bsSE9FAOWJCIdEdCmZbhmD5FRYrc9o+DRsJed5bZ5kstU6c04hyRw
         J9T42LlcN99IrkrViNO2Th86q3Z+4yuZwfWOtBmA/8XXnjpB96bRXrvD9USU6kHNcEIx
         55kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SwZYwTjDHHre2H8BdteSEHLYpVT8Bvr7u0b+ffWP1Q=;
        b=RuFVMc5dUqDf7qm0W+GKFGJOzdDrHnWqGXtCjWYvLQcembyjyEumyMoK0NFtN2I4U/
         jHo6kold8qHhk/017Vxmfx8MCnqXMUEdJdbJlssHrsM9/rxxqr1/nsMqKSngASgSnFKg
         2sEhgQR0DSTCHtgKMItLRS+NEEOCphkvK8o2WJc7b6W31Puc+2PPKnP5Pb2tOrjk0Kwy
         WHSFbdMAr+MMypvlF7oj8o9C1cQoYKTWqcMd5y2Mu6VgeGqGdPkJcX99yNZA36OMd3SS
         O/UFsEROIrDuHGZZPR6/HfR+mM9WJ2VzMX6bhP8qFfKXKGfOk7xaKHL1TvG3c58GL7Ud
         zWBA==
X-Gm-Message-State: ALKqPwf/jFi881D5qcSMKIjmeoBKAXqqdEG4AAiKxMso6OPaVdQNgVly
        DGmXe2d2/LsmjdwzbFCJlpA=
X-Google-Smtp-Source: AB8JxZqkaYxGg04s7aoz9s3n/0qZBkV/CcnhBAVh8fGE8xo/PkgiK4fbupZtOrHNpSdem0smr2I9Ow==
X-Received: by 2002:a1c:340f:: with SMTP id b15-v6mr2519104wma.129.1526205541437;
        Sun, 13 May 2018 02:59:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id k28-v6sm9986872wrk.46.2018.05.13.02.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 May 2018 02:59:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/1] config: let `config_store_data_clear()` handle `value_regex`
Date:   Sun, 13 May 2018 11:58:37 +0200
Message-Id: <3f64a4e24a83a9041c79c8b302207af7687dbb21.1526204440.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
In-Reply-To: <cover.1526204440.git.martin.agren@gmail.com>
References: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com> <cover.1526204440.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of carefully clearing up `value_regex` in each code path, let
`config_store_data_clear()` handle that.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I *think* that it should be ok to `regfree()` after `regcomp()` failed,
but I'll need to look into that some more (and say something about it in
the commit message).

 config.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 83d7d0851a..2e3c6c94e9 100644
--- a/config.c
+++ b/config.c
@@ -2335,6 +2335,11 @@ struct config_store_data {
 
 void config_store_data_clear(struct config_store_data *store)
 {
+	if (store->value_regex != NULL &&
+	    store->value_regex != CONFIG_REGEX_NONE) {
+		regfree(store->value_regex);
+		free(store->value_regex);
+	}
 	free(store->parsed);
 	free(store->seen);
 	memset(store, 0, sizeof(*store));
@@ -2722,7 +2727,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
 				error("invalid pattern: %s", value_regex);
-				free(store.value_regex);
 				ret = CONFIG_INVALID_PATTERN;
 				goto out_free;
 			}
@@ -2748,21 +2752,11 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 						      &store, &opts)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
-			if (store.value_regex != NULL &&
-			    store.value_regex != CONFIG_REGEX_NONE) {
-				regfree(store.value_regex);
-				free(store.value_regex);
-			}
 			ret = CONFIG_INVALID_FILE;
 			goto out_free;
 		}
 
 		free(store.key);
-		if (store.value_regex != NULL &&
-		    store.value_regex != CONFIG_REGEX_NONE) {
-			regfree(store.value_regex);
-			free(store.value_regex);
-		}
 
 		/* if nothing to unset, or too many matches, error out */
 		if ((store.seen_nr == 0 && value == NULL) ||
-- 
2.17.0.583.g9a75a153ac

