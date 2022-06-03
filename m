Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E817BC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiFCSj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiFCSjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AADB13F0C
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so4503077wmn.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JJxGL1rDDAGdKw7XWP799MeueAOlkIeCKlogo8sTk4=;
        b=TqKj3ZHTTNuBV6AHIqmG0CAlh9AYJ6T3M4mW/c1pRm4w9rmSm4cDagzjd7xUXHvj2Z
         zmuOBBZMMUqqDM+R3pWyng5c6yJJ7UTGM86Aly1nPhO5oHC22j7sdLc84uh6QKKga7lV
         hpYYWFXJaA5v+o3R5c1+8EA2fCAmF+afHorMGOQHjymfoPYjfxPmHzu5MNfjLRPl3Zmm
         eOWiDGHzECUqKL/SEd3YTaIjatIlggkwXhZj7WTJy9J0Jlc+guV+2moOLTacmtymWYfM
         6K6BkvIg1H82E6sXNNktgHwD5isp0vAVVlAgZ/9gzzW7EZjh+jR+bnK/3oe0/VjxHR/3
         QFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JJxGL1rDDAGdKw7XWP799MeueAOlkIeCKlogo8sTk4=;
        b=VKs2/r7EHHvbq/gZ+6lIFOThrYHqEtT+5pN5T4BrpzKXVtnGU1rCqVprBWOGcRmQ6+
         nAI0J9Lm9+xQpa+jY8h3RrcfysJOsJzuwIYwgaW6oh40byJeHmwPGjnxJuCfsYXKKs14
         VqcDHDUtutCgSR9WBkPzr2ymj4NuVaWXEwoCCqDX8IWsOPOpxNbT7EjrGDcyPtjMSYaj
         5b0xTynzhRtN6qhL6fSoDhA+Bcr1NKq4wr1CZ79Yzx5OATmZX7XPdQNJeFlW7UsZEGyY
         q06LWFajzjaMAtJwSRyvrQmgZiMzzsPihILSLpkRcWP/VWxZDCvxlmpmQl8cgHt27LA+
         AA+Q==
X-Gm-Message-State: AOAM530OJ8q7m5+wdWggOl0IRMtF30Ou+O7AAfl1GQlAHJIu1CrUGc/C
        oiVItpVMLR7gJxSD6ZZ8WfScGUkjyNhZqA==
X-Google-Smtp-Source: ABdhPJwlwZYCHKqbbwGk/1ALmRaZGQ4K04U5BwgnT+TaRfEGRIsvp+MTlybvJ8Ktmze84fjnINfuvA==
X-Received: by 2002:a05:600c:104a:b0:397:3385:898a with SMTP id 10-20020a05600c104a00b003973385898amr10077294wmx.7.1654281485127;
        Fri, 03 Jun 2022 11:38:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 05/15] refs/packed-backend.c: add a BUG() if iter is NULL
Date:   Fri,  3 Jun 2022 20:37:42 +0200
Message-Id: <RFC-patch-05.15-46e0c307941-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 2775d8724d7 (packed_ref_store: implement
reference transactions, 2017-09-08) to BUG() out in a case there GCC
v12's -fanalyzer flagged that the "iter->oid" seen in the context was
reachable where iter was NULL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/packed-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97b68377673..65991bbcaf5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1226,6 +1226,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 			struct object_id peeled;
 			int peel_error = ref_iterator_peel(iter, &peeled);
 
+			if (!iter)
+				BUG("must have iter if cmp < 0");
 			if (write_packed_entry(out, iter->refname,
 					       iter->oid,
 					       peel_error ? NULL : &peeled))
-- 
2.36.1.1124.g577fa9c2ebd

