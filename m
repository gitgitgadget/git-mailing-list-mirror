Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA10C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7916501A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhCPCO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhCPCNx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA51C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso576779wmi.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcGjxvB15e4xg9sWVsTvYdaJhzJ12f6No+s5qBl1k84=;
        b=nahYGWG9znqE2TPJWcmOU+LsAS3u8mo51vGWdxcohiooDb/pAuhmVMdXMt3HWLOp7G
         gcElqeZyyJTaGYoZ2gRriANlL+yJX3T8zGyLeTxE5vvJZDX83oklSrYU7w6YX/tgQ2Bf
         mQgKgUWuSVXgmr8oDlDAE0e160CKHvYN0vpoLk4tMdwvGdtMFXycR2j2FCfBJjOGz/0d
         Cyatcq2lMMk9QjkcJCu+AEPhsCgI1eqNwJ49G/sttRbaq0k2LunSZiycA3wL4I7GC0ka
         KOQpoIWb7ojHxkfvnQVH1c6hOY0ALe+6sRCpcmnLdv4L2scggW64cf6OKPeohlpFnCvV
         gDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcGjxvB15e4xg9sWVsTvYdaJhzJ12f6No+s5qBl1k84=;
        b=XJIoOh5fpolHqM2Ek/+zIiffMxrert1og9Elqgd/JGd3UGkA6VTJvjuv3m/g4kke9/
         HhLYnzZMJVt/LQizZxV0+GLiCAMDQN9tajIQOUAWwNpJcsD+bw1dfean0TL42IRi600Z
         CLoUDK3y3WwRukU+HjLLdrA7O7XrMRJSOKnzdYj0fwwV0gP1bn/E6r+IVm7klKzBQJJX
         BnWAKrZmRCjRSF0twqoqWzKKBu6Q6xuCr2/KdPP6/cdg+I6G8FuTbywU8N/3jS8S5mE+
         TY0r+QRk7jRLPkP4zYvEBASLRPq6GwVs7OEbECNoQK0JSpkB8Ym71Mbrx54QedmavUCb
         7qnQ==
X-Gm-Message-State: AOAM530AyCR8R+6ddAfxUOxCJ8bTRPlcjjTMSUqJ8vFPGmQ87rg4FJnW
        2vihOiqZdkvJGd7euNspY7M5gKg0i/EYkQ==
X-Google-Smtp-Source: ABdhPJxqy3plP325AId73D+wqyVgpz1UOf1Cj5SOUMmcRxGARGsuRaCYSHX1vL88W8F4aQgxiKgDCw==
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr2350050wmj.28.1615860831323;
        Mon, 15 Mar 2021 19:13:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 23/29] tree-walk.h API: document and format tree_entry_extract()
Date:   Tue, 16 Mar 2021 03:13:06 +0100
Message-Id: <20210316021312.13927-24-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document and format the argument list of the tree_entry_extract()
function in preparation for adding a sister function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index f569960c6fb..f51485250fb 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -40,11 +40,17 @@ struct tree_desc {
 
 /**
  * Decode the entry currently being visited (the one pointed to by
- * `tree_desc's` `entry` member) and return the sha1 of the entry. The
- * `pathp` and `modep` arguments are set to the entry's pathname and mode
- * respectively.
+ * `tree_desc's` `entry` member) and return the OID of the entry.
+ *
+ * There are variants of this function depending on what fields in the
+ * "struct name_entry" you'd like. You always need a pointer to an
+ * appropriate variable to fill in (NULL won't do!):
+ *
+ * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
+							 const char **pathp,
+							 unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.0.rc2.211.g1d0b8788b3

