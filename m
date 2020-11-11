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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB2C56202
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5AF207BB
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oipXyuQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKKM2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgKKM2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:30 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84917C0617A7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 19so2115930wmf.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AzgWnmI3Bhq6k5C1tKCzYRk5JHhlQy9Xx+1Yk/wajuk=;
        b=oipXyuQi9SYPa5C+l2M8qSRca9H5rLdJjkaVrjs33ZX+ZXVdPK0EoMoMo6RP7xycdN
         OjGBvBPEZE06pWLNV1PbM3Wm7KvE9asRxmQySRt11xPr2kOMaMFjdje92NW6CNo+XW/U
         UMdMu153WHMhkc/WzpFaGA8lzIJWAIfP6ja54n0SeOX6mHuB14DfmXGzhWa73afx4pQi
         pJLwLaQpuERIZ9mTEpK1CL6w3Q+eNcUqofrlYHBM+vNrtQA3f9egtggJaGetCIHX2u2L
         K3SZPp4NLVES+3HRSfWO1zuU2SMc+Qb7GIglaBlMXEd3lsWH3icXRY6g7aGnTpbUxuzU
         ZTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AzgWnmI3Bhq6k5C1tKCzYRk5JHhlQy9Xx+1Yk/wajuk=;
        b=LrGyTfKPS1FCmSvTuPoHPACEzl1H0uHox1Uu7dL9wCwDy9ZvETdyIFSLsrF51jLGnu
         2t06eQ5ItJA+Ep0T4QV6yw4ivn8owFKpYOu3ofXaYKngn9riMto3Y+W2JeHp14C9LU78
         uN5jHft/tpAwBG1x7mrMfakbg/RfiN3fX3LfUWYq054l6NPu2z+MxLOGVECDvOk2nx0A
         8JkmYxKpaY1JV7W2CXS/NADpjQ2c7aUggEALgKv6y+Civ3YCzDbSiY5F40n6MUuVcntC
         6v8ik84WmRIXbPS/vpphdX7DB/yXHwLxRBUtV31pOFz218GeGQlEtwVLDnSZ0VHXLpKe
         YRTg==
X-Gm-Message-State: AOAM530qH2lWKQh3BZJl57YkfmeOpYLwq/4GZcJdNcMQ4Aej0K5SzqSc
        obtbNXVNbKIk3w9jQ2cou90K2O8OCoE=
X-Google-Smtp-Source: ABdhPJzKyVhKBIG+hGI7FlakOT5N4/oxyQJpJTMAJ4QAPqsh1lZYINcZf05kr6KW6RLyj+VUvAnyOw==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr3782038wmc.36.1605097708904;
        Wed, 11 Nov 2020 04:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j71sm2613344wmj.10.2020.11.11.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:28 -0800 (PST)
Message-Id: <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:17 +0000
Subject: [PATCH v2 04/11] add -i: use `reset_color` consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
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

