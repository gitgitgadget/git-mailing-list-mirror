Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3031C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900022071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7gbQNFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgKBUoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgKBUoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:17 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BCC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:16 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id z16so8739488otq.6
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2dMW9aAW7YlJ0Fi5Y6EY+FlpKwA9bNCoxkmnmeWy5s=;
        b=j7gbQNFFph/3eGH3j4M+CNZZsxGwR8+k+8s45STQjOqODq3uJrC2f9BxTr8+HiCfke
         Aip9qE6884QbZHBtDYzY2E9jAssoP3QNBJz8U+ZuonNvhCrohA/zzbrNIqX+n4sDXbWu
         Udisz2NRy/kESHyzRFzLNp5c/waEppf09nSbeXnTA6ARlptrNNLL7+PaGzGHv1w7lW2p
         CKhAYEuOjCMpPVgUMetYHy5m6q1O/HRvLB4NnJH8wr0mpjTuK1W8LY8APcILjqc3rOXC
         N3Y8Nb57c2duuORZft2zYgHIFwrkCy08PYjNhl2PEnP95sP39mT/nRAh4t+7UA1Pu6NX
         NY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2dMW9aAW7YlJ0Fi5Y6EY+FlpKwA9bNCoxkmnmeWy5s=;
        b=UiSUjRvn4bt4fTpZbB6v2aUpuB5T+mmaU78l+AG+fJZIiQ8F762kZDIOJXFnz2c09j
         ly9IfwPaAJTqHqCDEuT5mt8uCerrxY0+YzW8PoJhx7QqnMuYijRUHl0yNK7QepxiOqad
         XjDdjv2LtmX6NZ/v/iDM9NDzeNyI0WOSqo/rDOIx+j//f41yy1tfNI+6T+oFXIFLgLFt
         j+Ywwju1CiC+FJzzhB4DaR0l3bPk+mHB5kLqyX//PrsYpeaflB2TZ03XHXh9JLAPudEI
         Gc09CScecUDVAe919RzhdGK3sC1T9NG47GTNOeuFSiJRFmnvfUSiHVjpRDYjpeUWmLmV
         GJCg==
X-Gm-Message-State: AOAM533CLbBE5WgjI3Xy5whIKTyJf0cHIrK/ltbQtZLI9Dh+zERn8t5x
        qlA4+hAYrtC7hq9Fx+VSwbqc23JjOaes7A==
X-Google-Smtp-Source: ABdhPJyzx1pT4sEPZrZeUalqKxrxZlS3UYcXHk+02+jyCz5BOzE2I5zex4IFjvdTCj/JRb0oe0oSfA==
X-Received: by 2002:a05:6830:1dab:: with SMTP id z11mr5455319oti.247.1604349855286;
        Mon, 02 Nov 2020 12:44:15 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:14 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 20/20] merge-ort: free data structures in merge_finalize()
Date:   Mon,  2 Nov 2020 12:43:44 -0800
Message-Id: <20201102204344.342633-21-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 19c30117b0..c6a0fc388f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -81,6 +81,16 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static void free_strmap_strings(struct strmap *map)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(map, &iter, entry) {
+		free((char*)entry->key);
+	}
+}
+
 static void setup_path_info(struct merge_options *opt,
 			    struct string_list_item *result,
 			    const char *current_dir_name,
@@ -839,7 +849,27 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	die("Not yet implemented");
+	struct merge_options_internal *opti = result->priv;
+
+	assert(opt->priv == NULL);
+
+	/*
+	 * We marked opti->paths with strdup_strings = 0, so that we
+	 * wouldn't have to make another copy of the fullpath created by
+	 * make_traverse_path from setup_path_info().  But, now that we've
+	 * used it and have no other references to these strings, it is time
+	 * to deallocate them.
+	 */
+	free_strmap_strings(&opti->paths);
+	strmap_clear(&opti->paths, 1);
+
+	/*
+	 * All strings and util fields in opti->unmerged are a subset of
+	 * those in opti->paths.  We don't want to deallocate anything
+	 * twice, so we don't free the strings we pass 0 for free_util.
+	 */
+	strmap_clear(&opti->unmerged, 0);
+	FREE_AND_NULL(opti);
 }
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
-- 
2.29.0.471.ga4f56089c0

