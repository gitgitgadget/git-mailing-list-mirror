Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4840C5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A90A20729
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxiyaF+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgKPQIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbgKPQIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:39 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8EC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:38 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so19244111wrw.10
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AzgWnmI3Bhq6k5C1tKCzYRk5JHhlQy9Xx+1Yk/wajuk=;
        b=JxiyaF+MT1qlLD4RBZZLKCpM7RECE/A13cPVRMLLrwO7RIQbK2ruugT/isfR8cQaYy
         ynbcK5UrQocqFRmcfqIXIkc5jVg5pJxEhPbliwkFtiXKg7GzzB2ijeMdwZCCClYJqnxj
         r0J6vo0sTniYzM6q7KA4UfxexPs2V2A3AOJ41t/Xx/C1dGADm6t7emFNGKOxMz4z3cAy
         v1AmPOyYhFpNj5MKWHYX8i4vjBLU28q8FHJkuCkNjODIs4X3hacKmte6eQFI8jUm/OET
         WFLUY2ReEw1n8so7cTrlBVTF1tEKq2KsDDlfJkTTAjn2lgRWF5HCxhiI4DtJl2PSZt+o
         cuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AzgWnmI3Bhq6k5C1tKCzYRk5JHhlQy9Xx+1Yk/wajuk=;
        b=ESruqPADWY2vB0YJNGCCYUQAcR9KW6kjG4cSCfoLYhPYSDKl0ip4otmmOSwwoOYrue
         PiQGKFZiU3pkEZYPLfoCw0auB3ym3DqZiZ6ZDf+ebN7WztsKKVi0GEz+EdeUek7oZ62V
         RoG7nIRDcGQoaf7r+e2wgOW6puHxlkaLB1qiOtLpsMf41wQ90/U903NKNYogdN2MDYya
         n38PQ8OMu6hUKTFTtNCaa2nCMMnbF+2CMnTaoXkMqA/VwYLsoGIqNBu+7ajFYQiPoUbv
         K2NnVGig2/37Iw5/N4FHT9F91mJs4Q7dTj9qeXoPLYGED7C2rFQAbVMWxhwQrPq6sAsO
         Kv7A==
X-Gm-Message-State: AOAM533ylEe4NTQMbnKyRNr4BBDuThQnhVVKA3RtiX0l8/A9leoIhXwY
        FTy8AK5YxtDLnzTIly9Vo8bHMDvlS5g=
X-Google-Smtp-Source: ABdhPJzzThqnOpVde1YUomNpii1L/l2D5f866VluYqPcjFXuYu5ysiKgMm80csk/d0XXq0p2yqQXIQ==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr19886479wrr.353.1605542917528;
        Mon, 16 Nov 2020 08:08:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm23011170wrm.96.2020.11.16.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:36 -0800 (PST)
Message-Id: <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:25 +0000
Subject: [PATCH v3 04/11] add -i: use `reset_color` consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already maintain a list of colors in the `add_i_state`, therefore we
should use them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index b6d53229bb..bf89c43145 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -672,7 +672,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", GIT_COLOR_RESET);
+			strbuf_addf(out, "%s\n", s->s.reset_color);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1065,7 +1065,7 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 			      s->s.file_new_color :
 			      s->s.context_color);
 		strbuf_add(&s->colored, plain + current, eol - current);
-		strbuf_addstr(&s->colored, GIT_COLOR_RESET);
+		strbuf_addstr(&s->colored, s->s.reset_color);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
-- 
gitgitgadget

