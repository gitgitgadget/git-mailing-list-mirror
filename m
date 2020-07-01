Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A6C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C35B206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy6hEayg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgGAN1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbgGAN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BDC08C5DE
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so6833279wmc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l7YIzjVqOaRQEBb3x3ZLzBTO+liCfxOYtzPTlnD3iuI=;
        b=Dy6hEaygUGL1UKtiiYObdgLTpMOSE++I1UAKaeNEGiJX3rCfBynBeMsotTzzYm9NoR
         7sdBap10nFyJiLJ+IejulW82oyPmhROX4SPcjDWhD34JWlJrUSbBkJoRXOEH2SzIYHdJ
         xa5R8d3YMYpcoPsl/BSPXCaTj/Z8merNU35pscIkbxBonbjAqe9Dwl49iTjORLrGATJG
         Rzg0NCLZq2i/hjo0Vt0cR0m4Qb8MR8hj+RXKoZqZ0SGb9gtyXnsnzmTVw7PsyRSqO7qs
         Jl9KrWPmGD7IkGw8MAeTm5khZi00B3UBOsjXgFiW2qRfvnkZxz3d7Inw6LdE9/MDmN3s
         4bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l7YIzjVqOaRQEBb3x3ZLzBTO+liCfxOYtzPTlnD3iuI=;
        b=pwXjy1J3G4QwBIFxPxEwqassitC9CPodvcXCwHNjTV3/EuvER/orPp5h+w+bvLDIst
         wLS9X/l7HtvlHdwon4pQYfrNnf3QaNKq4ZxPuMKMQV62phJGRQ1SmLHSlVtfqQFvPt8T
         oFvTIWeh/dtkrty1lsDfQrWhNa0pWq5lwl4973b1aNSvlVMtPicXwBYX5FOcwjB1aLA2
         TMdFhT/GSde+zDZ3V81TF4H+i6MwYM/mcrdjBkCoW5dWH+7/mqQpnMco2OzWpi3tkOSo
         1AMDZSSUBc8U//WKngj5lT1osQ8PGBwaHBUE4POwPkmNDkBM5O55Qr0mW/AqNvcT4ZPR
         4fhA==
X-Gm-Message-State: AOAM533BkLxOsNoTA2no0909B4aj3CEGhS08gDHxykWC/uuN1RcrzjX9
        kM4dd6EDJZHABnzaiOYSBdHA9yBG
X-Google-Smtp-Source: ABdhPJymJUWMcrNWy8wV3UPUvZU2lPozOGxCFG0WWTF7rC07JlvWNHMI3yhpPvswW9iVBtYNjIQSJQ==
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr16265844wme.61.1593610058516;
        Wed, 01 Jul 2020 06:27:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm7217002wrn.76.2020.07.01.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:38 -0700 (PDT)
Message-Id: <af750d88875903c023c97c519999ed720f27a0cc.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:28 +0000
Subject: [PATCH v4 08/10] revision.c: fix whitespace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Here, four spaces were used instead of tab characters.

Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 7339750af1..ddf09ab0aa 100644
--- a/revision.c
+++ b/revision.c
@@ -695,11 +695,11 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	/* remove single trailing slash from path, if needed */
 	if (pi->match[last_index] == '/') {
-	    path_alloc = xstrdup(pi->match);
-	    path_alloc[last_index] = '\0';
-	    path = path_alloc;
+		path_alloc = xstrdup(pi->match);
+		path_alloc[last_index] = '\0';
+		path = path_alloc;
 	} else
-	    path = pi->match;
+		path = pi->match;
 
 	len = strlen(path);
 
-- 
gitgitgadget

