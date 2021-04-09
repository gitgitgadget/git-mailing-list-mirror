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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00049C43462
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63B0611AB
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhDIIdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhDIIdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC609C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so5625639edc.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ekmxo8tAOvKYr5WVXTjVBvAVclMmDfF70AA09r8Uj4k=;
        b=D7dCwdE7Cn0ZuvlqOY1biVz1qKB8KDHcHag7z0fTYHGupXoZWJQhw4quvOyYcawSkj
         1by0eVsllG8bZp1LUVBN9A/qjk/Us1myHZ2+fSSix5YV3t8rsE6N+BPp//L8cFMeUCFG
         HdjgnPXacb7DRPCar+xHfMQmm3EEKxfkJYOLZMdbQDV8HVW8FLuPx861ALnWNsUGaU6/
         JVo8BeO3cgvT6YFw0Afalu5Ve0i4ogqSdH+rBnWgi6TJMNzu0tiCV6WclR4Fmaqjy/L/
         aIZo4DvCTxOvPnlTcbwTKcNq+rRcW0jq+hv2vErtZPKTrNjum5k1pjeJDn3YZ53zmdHM
         xyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ekmxo8tAOvKYr5WVXTjVBvAVclMmDfF70AA09r8Uj4k=;
        b=NQqWHmd5DvZ2jmvokGNd9qVOxxhQ/PX9K7/aOyR0r4KM6m1nFg/10tx2reYrW6GiT3
         zXQI8gS1SZhAA/DlFDCZm3EMPjmI1npVXJj8D8h/VemmCP+5UHfVmTXulBxZXIRq7Xnv
         eWUHrMtJCMr1Z9OqGVJk3EdYoLCaMPUhHWoFfJaYrW36+FSH3iiKjbfsZHybYqqHvMPz
         U9/mDUVYebx9UtAZp3yooK4hBJ5nPa1bfSS1Hd+xp2lgN8GhuDfxSjTj/jhDFqWhCf6s
         mtdsP/DcYwSMJJ8p+3tX1smzkzwoq7Jht9dP2Wt79rjrgrfOwWYu0S00qs97ZTgx3dIe
         Ednw==
X-Gm-Message-State: AOAM533G7NsTKwzTMfCIVBI+IEOT+q9Jm5vrXW6GjUuIHS0fQEBfzKDa
        XghuWdq75K+inwlStmqyHicKmpjTBix8sg==
X-Google-Smtp-Source: ABdhPJwk9CsgFkvMqVU0tS4JCkxLTW1dz92Wj6yMYyi2GXMmV5605+JKAn/gc3nEmx5rTAl0mwPEIQ==
X-Received: by 2002:a50:ee88:: with SMTP id f8mr6952748edr.69.1617957187226;
        Fri, 09 Apr 2021 01:33:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] object-name.c: make dependency on object_type order more obvious
Date:   Fri,  9 Apr 2021 10:32:53 +0200
Message-Id: <patch-5.6-94e13611f0-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an assert to make it more obvious that we were effectively
hardcoding OBJ_TAG in sort_ambiguous() as "4".

I wrote this code in 5cc044e0257 (get_short_oid: sort ambiguous
objects by type, then SHA-1, 2018-05-10), there was already a comment
about this magic, but let's make sure that someone doing a potential
reordering of "enum object_type" in the future would notice it
breaking this function (and probably a bunch of other things...).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4d7f0c66cf..b6a7328b7a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -408,6 +408,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	enum object_type a_type_sort;
 	enum object_type b_type_sort;
+	const enum object_type tag_type_offs = OBJ_TAG - OBJ_NONE;
+	assert(tag_type_offs == 4);
 
 	/*
 	 * Sorts by hash within the same object type, just as
@@ -425,8 +427,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	 * cleverly) do that with modulus, since the enum assigns 1 to
 	 * commit, so tag becomes 0.
 	 */
-	a_type_sort = a_type % 4;
-	b_type_sort = b_type % 4;
+	a_type_sort = a_type % tag_type_offs;
+	b_type_sort = b_type % tag_type_offs;
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
-- 
2.31.1.592.gdf54ba9003

