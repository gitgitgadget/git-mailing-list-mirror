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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869DC43617
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456D660FE4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhCaTKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhCaTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313DC06175F
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1677645wmj.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tRuIHBiBcFDrXHJnqUdgI2cJKp7LrkE73m3TRVeOi6c=;
        b=JLk/xMMekBhfga5rCm/RQEleTqbX9L9jF8ePVBEY2kQSAelcRhxvoIz+PNU1a1fFyi
         iDjO/lHDfxxtV8giUwphGpXhPATmyeNtUSgD5BNFb7HyIoQKzeOMGmGZigKigE6gijY4
         CYxzXrawxUOYTtIqC7WCmK3n3M/vWqYrbYafSnG3ArG9EijLoni3g+6fdQ/OQNDxxieM
         Nm7x8VKAKUweM6mz+xqT5OSj9Udu3IIJfM5niO5zRXDAsGZ00e4jn5eMJGXgmObhyQ/u
         iYlVD36j4lBxsQmQqy3+8QGhlCT83K/7dp1beBHuxMGZ6yrymHdva22rGQbJxra/s7ri
         k8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRuIHBiBcFDrXHJnqUdgI2cJKp7LrkE73m3TRVeOi6c=;
        b=Tqxtq4ua2/KU0c4z3EQXfsNK487wQGTWH2MH/tU7wbrc++ffrCnNqUMYvnpNLM3LZh
         XoiprBsBGvxVhIM2viQc3lZrdC3jDYoCYsW9HRP+xITgxMRSR5oSUpe2xJ4s6OT1Uiw5
         +Uu7th87tSMT9TVnraq60A1Bv3Lch7Mm3YvaZ6Wty/GCz2bZJwGvk+rz73keirgydfV2
         MYi2T59OlprO5xd071QbeZW8Z4M4R2xl4csnGDxGJgq7Exn159GrgY7gUv0EqY0fVLl7
         rB25uIrl/r2Ol6TdRQYP/LqmD96mrxSFz24XG1KwMX+PixaRNmkcAO1qIsN8XykTu2Re
         BRwQ==
X-Gm-Message-State: AOAM530/UPsZI331EGc017RVfTBaFf4TRym8Hq9w0NkIWC58ofmHfNTM
        /qQFkRUjWqeXF+T1ePlzSiN/50cd+YIJuQ==
X-Google-Smtp-Source: ABdhPJxWXxcQJ3HDTBQ4CorFeBpcCd5plmUJsTz7Y+xbcudpGw833W44ANJBSyZ0OLPLiCjt40DThA==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr4441527wmi.28.1617217801905;
        Wed, 31 Mar 2021 12:10:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:10:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/18] tree-walk.h API doc: improve documentation of get_tree_entry()
Date:   Wed, 31 Mar 2021 21:09:42 +0200
Message-Id: <patch-14.19-44f16d74426-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a mention of sha1 to OID and change the comment to a listing of
functions discussed below, right now there's only one function, but
subsequent commits will add more.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index 09e40d9221d..cd8da84f56c 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -166,11 +166,13 @@ struct traverse_info {
 };
 
 /**
- * Find an entry in a tree given a pathname and the sha1 of a tree to
+ * Find an entry in a tree given a pathname and the OID of a tree to
  * search. Returns 0 if the entry is found and -1 otherwise.
  *
- * The third and fourth parameters are set to the entry's sha1 and
- * mode respectively.
+ * You always need a pointer to an appropriate variable to fill in
+ * (NULL won't do!). That variable is:
+ *
+ * get_tree_entry(): unsigned short mode
  */
 int get_tree_entry(struct repository *, const struct object_id *, const char *,
 		   struct object_id *,
-- 
2.31.1.474.g72d45d12706

