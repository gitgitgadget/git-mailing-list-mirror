Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33785C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1025B206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koVOOX/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbgGaQwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbgGaQwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC5C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r4so25629086wrx.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvdArNTuNFTGPsnaWFvZ5ZJQbVEjIqkdNyGC6HTg0OE=;
        b=koVOOX/JY1F84dPviYkiVt1fVlqOcyXZTuox7VXuLVWNYhLo4WVZS8AMTmCQjlQfwQ
         HT/kvD/Tca9S9IeHKdkMMEFdJon+FXELNbEXT/9aen5odjs8tIf9iUi+OytlCnUAMoxI
         +fRp/L3XKIO+4bOOAcfzA9FRanX2Wrm71ZPbjZUMKThiMik0D1MtPJZjUkXRmV5qX9Jd
         8x7fOW/L1p8u9b4C4js0d2j6YCf4gZn0QHWR9M8tzFuSV1nRI0OGd/nWSi/Ua3pYUNwn
         3cxtTyi0rEs1rev4o/RUbGfzQMDh14PTHrboOZUNREKNDyUzNVLrljKV3yTNmHCDiyhP
         +mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvdArNTuNFTGPsnaWFvZ5ZJQbVEjIqkdNyGC6HTg0OE=;
        b=c9LWVAFdUA79f+oqi5eIAf2TZblzj9EbmoSlrLQmRWq9LESU8OydJC+Cq3Z6nkGkPG
         wCWTY1L7/FR5Fcx4OlvhUGja/rgw25K3RGJimQFvQsERu43oMiKLtz2gMHEGFPuFLh2t
         FT33GNmtQnIklBi2vAbnrMtrVqZGguTqpRrd93OPNoSSYcsjpzXs0ft4QeSo/qK01Lz+
         GRgLxuhqWcJ2G006uf408cW/hAhF3GR893hL/K01nex3PEnsJAV1w+kNkCESyT02Qt1K
         6596+CrItC6wWAH8yQ6LI/fSpdyV90gRiIR+jwitc/0X3XQ6kfZikik/02+7Yq+YLHmv
         qKVA==
X-Gm-Message-State: AOAM530tYU4ZgsHc35afoXFA6sK5OMHIF4CwbvFQqs8jeSKdY50581WW
        bmIt6xMYzj1oMc/YCQgJ9Aa4+p8X
X-Google-Smtp-Source: ABdhPJwPnX/vnD7QLAKD1xbaGp6toGyueQVcd48BRGFOxXGzeahGrj4CAr0yC4rEe1J5nN8JzruEHA==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr4189581wrq.319.1596214329016;
        Fri, 31 Jul 2020 09:52:09 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 1/6] stash: mark `i_tree' in reset_tree() const
Date:   Fri, 31 Jul 2020 18:51:35 +0200
Message-Id: <20200731165140.29197-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731165140.29197-1-alban.gruin@gmail.com>
References: <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200731165140.29197-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In reset_tree(), the value pointed by `i_tree' is not modified.  In a
latter commit, it will be provided with `the_hash_algo->empty_tree',
which is a constant.  Hence, this changes `i_tree' to be a constant.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0c52a3b849..9baa8b379e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -228,7 +228,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	return do_clear_stash();
 }
 
-static int reset_tree(struct object_id *i_tree, int update, int reset)
+static int reset_tree(const struct object_id *i_tree, int update, int reset)
 {
 	int nr_trees = 1;
 	struct unpack_trees_options opts;
-- 
2.20.1

