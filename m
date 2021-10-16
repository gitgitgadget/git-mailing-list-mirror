Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F8DC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB4860E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbhJPJnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbhJPJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5902C061775
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso4957010wmc.1
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZAwyZhjWAMyTZl2gWtzaL0W/VV1Xt3SBvOfCgvyAz0=;
        b=dwznuapVZK5OUtJkTQg/6umqdxpnPJ/rv9JXL711XQgYQzXYpYorI5BYwOug3u5JgY
         9XDRtuexS8+bje64sRrGmwQZPg1m9K02TzCZftPFRNAiAWxF+oZsjpFkSgHix8cuTOgM
         9msCBvaN9IIYDKfPYCfuxm1wCQbaVlTPxGyRb574dzVxhe225hYJsZOn9SRmB17jLRs1
         a7ZUS4+6Omzdwwj9X6WkGIPqhz5uDkEtujDnLKp6mHkJeag73RyCrsVi8+gIzoMU1TP1
         L1B8kSDvCGMfso+lCh/l6Ga4wMqe/jwWBCCOeuK5/nzlNfsKoLez64F3j200nx7tLUW+
         bmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZAwyZhjWAMyTZl2gWtzaL0W/VV1Xt3SBvOfCgvyAz0=;
        b=494wMdfV5Cx+y+NBVIhGdv2nVCBXhi+j0GtZXEWa81GrV7lFHQ1jNObKwGMhyVTJlI
         /jzN0R4aFbA/lNXdUC1NEzxkYOD0RfGjyXeSN6sdEpYaUytWNc5feKuH8HyRCquW1T4j
         mWkBmCm4Cy6B1eq1DA/HQ9f6hmzbFwe1BfD5+LbnDWj8G7dwSMTLvMn+sEJP7q/XPPT0
         A9IBeTgyaJcp3fmLaMxU9SSVfYNLCjkoH1urxHexzrU7o5wojROxeuSogFH5ZN5FiIsc
         bnj0jgPQd+/A1WZnbKR6Tsw1InCNL5m+1nr8j3WUBUEpqJ9yjarGNyE60CAUUq5F5EYz
         N7ag==
X-Gm-Message-State: AOAM531bn+iEuNXagkNTDpNW0n6aadhmj8VQzrUmf2u2lbhOIEwSSSkj
        DmY3BxD+6HJ0tCrqOWOyVxtThZTNXSk2NQ==
X-Google-Smtp-Source: ABdhPJwRkIaRQfbIABaNNhWFRjmemaLmPCMIqBEay0HcOAcfFmcQqo/qh0SesRhp6vIwaJn7H2+iTw==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr18398914wmg.195.1634377181295;
        Sat, 16 Oct 2021 02:39:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/21] refs API: make refs_resolve_refdup() not set errno
Date:   Sat, 16 Oct 2021 11:39:21 +0200
Message-Id: <patch-v2-15.21-152a831b8be-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move refs_resolve_refdup() from the legacy refs_resolve_ref_unsafe()
to the new refs_werrres_ref_unsafe(). I have read its callers and
determined that they don't care about errno being set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index dc6ed561492..09452b5e413 100644
--- a/refs.c
+++ b/refs.c
@@ -268,9 +268,10 @@ char *refs_resolve_refdup(struct ref_store *refs,
 			  struct object_id *oid, int *flags)
 {
 	const char *result;
+	int ignore_errno;
 
-	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 oid, flags);
+	result = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+					 oid, flags, &ignore_errno);
 	return xstrdup_or_null(result);
 }
 
-- 
2.33.1.1338.g20da966911a

