Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD76C43461
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6187E6113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhDTNhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhDTNhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F54C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so10629280wmq.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8nKbhyzmPQmJXxjli+FyGmf0tQZ6Cy0P+MV4eLSkbM=;
        b=HtvFkqqhvqhveBRNrdjzJ00TyDojiw8q53WxG5DGXZGeIYTgRtNodYllJa+H/Cqup1
         ierupbS8EVjOcsj8wAgdoSDzzPfuq2slWVDqoZtYhVN/VnD4E6TwZcV1E7iaMKwlKt/I
         QTPOzXem8TBsTCpNPuYouUm5gIachdz5IC9GSKELylV5Co8xV3ErmKX4WhUdRo21J5TI
         f7xg/YI5mrO+ARL2mzJFamGkmUivqkTdhXYwE2BlxvqAXRpVq8mRV2V9Rh/i/Bs8RzAa
         ycDgg7yMxLeVDyJkGZFPy2FUgrVX++ZVt2wZrw50/vLt3jhbsVqC19UW0k+d0t2dlYmo
         MmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8nKbhyzmPQmJXxjli+FyGmf0tQZ6Cy0P+MV4eLSkbM=;
        b=oFL+EZP6lPbuFPN+7GD8xnUfslHZjw6PxatGccX9RK5URfyasDuZSoRfKRdkhZxlKf
         luy5fvWpLb7AhbjxUe7JcgftMLz6lKLxwz2PWIE7CWXmwgEp7UgAAlDemI0QB/wkGbre
         YU7FBuIp1P3PrXaaSUIwsXHcU5dPljQN2CSaMzE6+Hl4MLUIsO2xJS9kuhwU4Tzp/4OC
         ZHnGv3HRiCKUF/d7hZjm6n1iwxoQpzcl5P1jvBZSbtJ+nYhnKk+W2nm0WHP7yztaq24W
         9DAMkBPjEuFPqwT141Llp/hTlx8XP/DuplfuXZREs6ZoxRoxLbo580LU6Tk5y4/CZ1WL
         ueTg==
X-Gm-Message-State: AOAM531SLg3JcWAKyjPagSCn6bZQu3nuT0TP0E2VxUOSHvPwz1G7W56D
        zNeNPDAa3RRPXlN6RT3Ed55WzCTqGmZnew==
X-Google-Smtp-Source: ABdhPJz1aTXJaxpdGERyohrJ92ch00H4ppsdXg9RyFIcXvg0fksDPtp76dbe+4P3PS4GDbAY97bnHg==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr4424105wmq.35.1618925829420;
        Tue, 20 Apr 2021 06:37:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] object.c: normalize brace style in object_as_type()
Date:   Tue, 20 Apr 2021 15:36:59 +0200
Message-Id: <patch-7.8-893b178573-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normalize the brace style in this function introduced in
8ff226a9d5e (add object_as_type helper for casting objects,
2014-07-13) to be in line with the coding style of the project.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 0f07f976fb..f694db7e87 100644
--- a/object.c
+++ b/object.c
@@ -190,16 +190,15 @@ char* oid_is_type_or_die_msg(const struct object_id *oid,
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
-	if (obj->type == type)
+	if (obj->type == type) {
 		return obj;
-	else if (obj->type == OBJ_NONE) {
+	} else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
 			init_commit_node((struct commit *) obj);
 		else
 			obj->type = type;
 		return obj;
-	}
-	else {
+	} else {
 		if (!quiet)
 			error(_(object_type_mismatch_msg),
 			      oid_to_hex(&obj->oid),
-- 
2.31.1.723.ga5d7868e4a

