Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625231F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeETKnm (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:43:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53290 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETKnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:43:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id a67-v6so20609702wmf.3
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXd6lbTmQ4z63XPrCEImEausf+P6rji+L3HcYIg0eBs=;
        b=dviE90+pDCR/2WHbSDvjhswmeBkqmkpxYWjkHKhzNUPPSPPCwFLhu7l0OXpPS5KYOa
         NitI5jfkcLFRnVOsKfRd8hgI+LfJdKVJDKNs+lUrRq2A9f95toJQ136wbz/6SJspwWYl
         28iQQnQPYfxz/24Og8dVtvScmJa7OMCVKUTPSxKqQDALuFUlstDiszSvjZAMAGSzswVv
         xlai9Wsb1YxEPcdWrYvGw3dtA6P/dgO/G8HbPvsx3mpW9Z1MYWbxo01D/nIUZKmbcQ4Q
         6Hmn87otQQy/KxTU/SeB8Pmljlla1USPlKixjraTOqiznUr9qtMONE8HrSnSAShn5NQV
         E5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXd6lbTmQ4z63XPrCEImEausf+P6rji+L3HcYIg0eBs=;
        b=GB9wcgK26gl0+A/2YymBlViMk9XS+gYpoPilQzHLHl75u+1sLPHPEJH9MaEEbtp7gy
         MBojE97bR/IedUpG/F6UNq6ZXXBHnrDg3SppOoBQRbFgOgpWdqr4M8Bi1z5J7n9xxVng
         W2ZV2jXb/8cKlMN/8khVyO5EXdIrfyIUXZZ4AIoDji3G6lzquBSN4NrYtqSNipPhsUi4
         FTQ/NZODaBK6WerONq85k6UtO5tARrfnTyr8JAtlIzoKaapkLm6rqNhLjEbiEuzd6kSD
         IDUP6QZKRPGBWf5V8roOtbry1N1fTbCt+2gNU1X8wUtI1G7oXBx/DIa985ZXoZrgeKAm
         uCGA==
X-Gm-Message-State: ALKqPwf9WguwZaL39GTt92CrTX4ekzXJ2SJwSogaaRjRVmu7nncMcrzM
        1egvy8RDbzULZFQyH9fUtweJlhgXjQE=
X-Google-Smtp-Source: AB8JxZoY9sfBIzAEpQ6ppMTKUSB8cgDn4/Q7uHBxmR+be5RCYhY7HDhSYp4U8BPReyD5PcM+DeSpbw==
X-Received: by 2002:a1c:2703:: with SMTP id n3-v6mr7960463wmn.109.1526813020114;
        Sun, 20 May 2018 03:43:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id c21-v6sm13595974wre.81.2018.05.20.03.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:43:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/3] config: let `config_store_data_clear()` handle `value_regex`
Date:   Sun, 20 May 2018 12:42:34 +0200
Message-Id: <ca3af1e24176e0a20c5753e4541299747056be47.1526812503.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526812503.git.martin.agren@gmail.com>
References: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com> <cover.1526812503.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of duplicating the logic for clearing up `value_regex`, let
`config_store_data_clear()` handle that.

When `regcomp()` fails, the current code does not call `regfree()`. Make
sure we do the same by immediately invalidating `value_regex`. Some
implementations are able to handle such an extra `regfree()`-call [1],
but from the example in [2], we should not do so. (The language itself
in [2] is not super-clear on this.)

[1] https://www.redhat.com/archives/libvir-list/2013-September/msg00262.html

[2] http://pubs.opengroup.org/onlinepubs/9699919799/functions/regcomp.html

Researched-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 config.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index b3282f7193..ac71f3f2e1 100644
--- a/config.c
+++ b/config.c
@@ -2335,6 +2335,11 @@ struct config_store_data {
 
 static void config_store_data_clear(struct config_store_data *store)
 {
+	if (store->value_regex != NULL &&
+	    store->value_regex != CONFIG_REGEX_NONE) {
+		regfree(store->value_regex);
+		free(store->value_regex);
+	}
 	free(store->parsed);
 	free(store->seen);
 	memset(store, 0, sizeof(*store));
@@ -2722,7 +2727,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			if (regcomp(store.value_regex, value_regex,
 					REG_EXTENDED)) {
 				error("invalid pattern: %s", value_regex);
-				free(store.value_regex);
+				FREE_AND_NULL(store.value_regex);
 				ret = CONFIG_INVALID_PATTERN;
 				goto out_free;
 			}
@@ -2748,21 +2753,11 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
2.17.0.840.g5d83f92caf

