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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A849C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA0F64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhBCDa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhBCD3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6130C0617AB
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so22600127wrz.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HC+ZzBrGlToRVJblAhAifGzgXh5aWhNRfQs9vvFZNGw=;
        b=QhYQK31taUXcIY1it9oT0slnXvbUqRCggUc1BpjgZi/4FTk5UW1wpqMncFSbpftPx2
         6LgCuEo8PbY+dFmRLUyA2ZKCNVn85Za1+IxGpDA6aIcpaFJD9RmH6bcGO9n/de3QLIG3
         zAMxWPKjTehYghne+gd5VnRYHoATWwYDf6mhmlgte9OQM1V1nMiYeezbPqKX/uyvQQjH
         DEvqoBvQFk3yvINFiFwLeSTSTVUGnHnH7Md0ijrA33JyK7H9G8Ilh48Q8ZmrLxWvVqX3
         h6FaBpmJmFwqMHJDrjPIk68+lIi5tV4pBhh6T/m4b3cmw0L83qisiK9rGAV5ZBaBEFG+
         chfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HC+ZzBrGlToRVJblAhAifGzgXh5aWhNRfQs9vvFZNGw=;
        b=HH9IrJm16B7DwvmeTySqcIGrtIKb16S/H/9HyH4+Fw+p8WoHd7S5iOg3UgH1z+7x3R
         +FdsrTHuJJhUeTRAJjEsYmKIm6Nb1iFwQ5Cbn9VxiUK0eDuv+vO5bWnveN+L8eAd1NtA
         kavx5PVuRgbOl9O+FUo2o7+w9Pz9DFIiBbD6ZoP3fnKuBiQjrRT/sOuGpjhA29DLlkSU
         zd/fnwik1iKrrNmCYIc7gYH+8LJNhm3yaSVLx03d44PlSbYG2uKHAbizS6b76TUxDqAX
         glWn45YjFfDktZrZ2jR0dwVt4seJyn2Ok7Ai5wlwIzC2e8LbMK45zGubCAyib8q50bjB
         M3hQ==
X-Gm-Message-State: AOAM532GJqVGPewuQ4PY/HEKxCyrWsiIaKWPpqdjTMxjC0aex9UXq42m
        Fpac20KEZmDEWhhSSDxM+MPA9tx+brQphg==
X-Google-Smtp-Source: ABdhPJyxH5bTtppoUk6MRB4Ugmh5bu2BlwchZqJwwarhQsErby6QXC1nAXYp3MdWAr/uwb3Jm7GO4g==
X-Received: by 2002:adf:9226:: with SMTP id 35mr1069840wrj.408.1612322911353;
        Tue, 02 Feb 2021 19:28:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/25] pickaxe -S: remove redundant "sz" check in while-loop
Date:   Wed,  3 Feb 2021 04:28:00 +0100
Message-Id: <20210203032811.14979-15-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we walk to the end of the string we just won't match the rest of
the regex. This removes an optimization for simplicity's sake. In
subsequent commits we'll alter this code more, and not having to think
about this condition makes it easier to read.

If we look at the context of what we're doing here the last thing we
need to be worried about is one extra regex match. The real problem is
that we keep matching after it's clear that the number of contains()
for "A" and "B" is different. So we could be much smarter here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 208177bb40..8df76afb6e 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -82,12 +82,11 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		regmatch_t regmatch;
 		int flags = 0;
 
-		while (sz &&
-		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
+		while (!regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
 			sz -= regmatch.rm_eo;
-			if (sz && regmatch.rm_so == regmatch.rm_eo) {
+			if (regmatch.rm_so == regmatch.rm_eo) {
 				data++;
 				sz--;
 			}
-- 
2.30.0.284.gd98b1dd5eaa7

