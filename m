Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E84C4167B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F27E6124F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhJDAsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhJDAsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDDC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so7261266wra.4
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91+q5KqikvkmtBnUielKrquxw8mEIZoCu4H1DVjwi6Y=;
        b=ZxcCYlv5qZHqsuyDvI+PvkyuJbhKmCS56YBshmBilaxCjxvUZvqQaMayFZRWHJZeHm
         YYU79zQI3P1Wd8/YZl3fuzO6vcmkLI0AGeIAhbDKvFajk/KXMAQpt5eiLMWRFwnZkeLZ
         317e/A39RfZgGTFz2VQz1ZArd20EpNBksDKKP57l3MJyuOvhXL/d8pbfQDhfkEG2OXUW
         K4ZQ+32CmjrQbRNikFRD8M7DifjikZzxw4NasrqH/jsPwRzbgMLdhgVg0Q+kkaKz9l96
         AdcdjgGJOF0y+7B8DVNGzJnoUIfP7AeVjyjnmbRR8nd5ZqNdtoc0m9ktv8WHorki+Sfu
         tSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91+q5KqikvkmtBnUielKrquxw8mEIZoCu4H1DVjwi6Y=;
        b=Tx6bX2ktI6eeqEZXHL8zNtG9Q0hnhugpkP1zT6HJy5Qmc2IHlScqRIC7i94K0CKnMA
         NqUJGjFyOR20d+ovhXw72tG9Gi4PIFcPxgsDFl8xLhxQDAeRGSymeK3bZe+QvlhFrfhH
         szdNLkHtMjqeia8Gi07fjKgdBFxWo6SsDVo/RyRBOa4ZJoM8DvPA5S2kLq0gXY7BwLVr
         yZC+0LxBrOV6naWzPZU0wwMWqjkDI5NPz3AknMYpBJolQYSKWncYj+1Y13WxVAou+P/K
         Nfnd01q+WaTBD+3ani52Pix5RA7ieOwfwh+9hWBm7DeIeYekd9ZqmLRkvl8MVOd73WPZ
         PbUA==
X-Gm-Message-State: AOAM531VHldn+0eo914O26w3bDEzQ989YkA/6DCxEQvX7IZ63IV3R5tQ
        pj7yDVve6l36gYMtB7Y+VjP4mrRim/eEWg==
X-Google-Smtp-Source: ABdhPJycneP38yavIivdj86cslib6KqUTWj0g6bOMzQjDhr/j6ZVBpJOnARwCq/oNJIRfJv2dGtcSA==
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr10782824wrr.142.1633308378907;
        Sun, 03 Oct 2021 17:46:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] unpack-trees API: don't have clear_unpack_trees_porcelain() reset
Date:   Mon,  4 Oct 2021 02:46:05 +0200
Message-Id: <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the clear_unpack_trees_porcelain() to be like a *_release()
function, not a *_reset() (in strbuf.c terms). Let's move the only API
user that relied on the latter to doing its own
unpack_trees_options_init(). See the commit that introduced
unpack_trees_options_init() for details on the control flow involved
here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-recursive.c | 1 +
 unpack-trees.c    | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d24a4903f1d..a77f66b006c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -442,6 +442,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 {
 	discard_index(&opt->priv->orig_index);
 	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
+	unpack_trees_options_init(&opt->priv->unpack_opts);
 }
 
 static int save_files_dirs(const struct object_id *oid,
diff --git a/unpack-trees.c b/unpack-trees.c
index 94767d3f96f..e7365322e82 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -197,7 +197,6 @@ void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->msgs_to_free);
 	dir_clear(&opts->dir);
-	memset(opts->msgs, 0, sizeof(opts->msgs));
 }
 
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
-- 
2.33.0.1404.g83021034c5d

