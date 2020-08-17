Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A82C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E633820578
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHW08f+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392169AbgHQTPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbgHQPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40834C061344
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so13607672wmi.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1rorAVKM+u4KBXRYDRlgewUD+8J1/AJMNCNaL1BonPs=;
        b=LHW08f+FpQBwNBsOH1m86D8GwSoMblGTol7TtSBmCS13dtcaDCX4LzjFaj1sVGfigl
         RO93AkPM5qxiBan4gXN1HyYsxBzfFafZyEbKmcQFBQ/Z3JcnOPN1YmeNQbrImD5P43+o
         yKAoh0otlEPCATUNdiBv53YpcpEj7Llv8nwpWW/8yZeSBTGcxjW4VaHUL9AfZfKMhrlX
         G4kmUqkQD5xlrV65CbCUxO2ldEGAEpvYK/h2Q4kJxrL2C5Vkde0BiI6WbzmbuLDD4JlB
         IaxJbKxeNGTRQTZD71JEZ6snoCWz8UbFtx1+YJ5ABTwHMFEKojtEgRFxUttHszrgfrN2
         I2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1rorAVKM+u4KBXRYDRlgewUD+8J1/AJMNCNaL1BonPs=;
        b=UmfbtKL43yMDGoFfm0Y/POUhN7N1rGOasDTnOu7+mqLX+QJfomkA6QJMqWtUFeQASp
         SCjZA15bEt9+lqIIawzHNRDriaMyVfoDDdj2EPz6wlzdVigdpdmf6vjg1Bdn6eR2IAoJ
         r6HH5mLwztMWF6B5FWFEGIvjs49ZOk2J75bD+ypBHRscCH6TcKgEFPxBaFd0k/DEEGC6
         x24Kjn8cdCGqGfOWGJdLM3XUz8szmWpqs8zoSi6fCssxeOmnhGY7RvE4BWqNVKP+vQn4
         VBnFBdwqUnXwVD5DS+7DXxwtTwUfC91nzZnV7zlvotO0nIT1UhrNV06njYlbn4hnfyW0
         4hBA==
X-Gm-Message-State: AOAM5322Lk64gqPoCo0HZCMsXWd+ZXGOAp5EElJxxkNzvrdzjj1Zjfy2
        awwu/1Dto6dzH6cQ58e8KuTjg8OPa0I=
X-Google-Smtp-Source: ABdhPJyNY0tQZ89eWOYTqd+Lf9rqN5JEDU0bukgRvcJFnTHgSIYqaOLQ/GDrc8PqHG4OmR4/Bzawww==
X-Received: by 2002:a1c:de88:: with SMTP id v130mr14559048wmg.98.1597678799900;
        Mon, 17 Aug 2020 08:39:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm32940731wrj.93.2020.08.17.08.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:39:59 -0700 (PDT)
Message-Id: <52b397ec9efa68a6509f8750534489e62f7c2fb4.1597678796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.git.1597678796.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 15:39:54 +0000
Subject: [PATCH 2/4] refs: fix comment about submodule ref_stores
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 24d79fb5c1..9188ddbec2 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -667,7 +667,7 @@ extern struct ref_storage_be refs_be_packed;
 /*
  * A representation of the reference store for the main repository or
  * a submodule. The ref_store instances for submodules are kept in a
- * linked list.
+ * hash map; see get_submodule_ref_store() for more info.
  */
 struct ref_store {
 	/* The backend describing this ref_store's storage scheme: */
-- 
gitgitgadget

