Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293B4C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbhLVSMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344523AbhLVSL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:11:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B503C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g132so2156722wmg.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=77ZwXy3rQHnaJX6J6R2oYsiyoRUtAOTsz+aMmsE4hCE=;
        b=MoywKVuaC6+U1QrHFG1fpUCUNSjAF2EU00eQkjSKHmlQT+XvTySUvMBvqXGPJkogBS
         Wo+ngCL7hQoA8OxPGKD0MnTBOv+tf35VRIctxL7NzSMT2gOTf/KY9mgS5bfYmEoatX9Z
         by3Hh2+Q+nqhFP+gl+hTC7eByrjBf7YowDCcag6+gzISCSyAChpT+WA9fbd05xycZD2F
         1jwm3S9eujqcceXAlHtc24q8GonZ7E4d1mJRXLgsg9rRJdmcTxwSbvaSr1kzmF3sjVse
         zWWxhBX/0vksnsn2Ahj5XOvv002144sP0QsmF7EwexPQHRDxPjiQY/B+nug2yj9pd9Bg
         E4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=77ZwXy3rQHnaJX6J6R2oYsiyoRUtAOTsz+aMmsE4hCE=;
        b=Iu6nwop4NVX2tsAajyU4DwJUQELBgReZtVtOSGxxvMUXwDH7DeBFcpQmQ0SBUlkdpQ
         9sjezlDTbFTpkenS7liKltoktfjNjrdIc4lqDQ4U6pP6P/ldX+X3klweo1i/jVRNr1+D
         4fj0XjRLYVfaNagX+ym/8me4g8HCJEbVevFadVt+s6Ka5lbtDc4ts/0b9huu1CvDm+Tb
         EAl//tHQ8KoPfEB/79x9TyXaYr6qp4m0GjAyur8n1gQLJeUMwkgICUhrLju7Fkx1PqQR
         WeVCKS1G7WFm4gVLpW7RGlc8fb7JHqTv7e0UzaYDLdKrpzJ53/dGIa5x/SGXbGKjadkb
         0F4g==
X-Gm-Message-State: AOAM533rEfPPqUsaRDUYeWzduiku8wkso94seyAi2QIk9vZRqB0Tpzv6
        026e3oGdMn00LINPHiCZRcIZjcPsGIY=
X-Google-Smtp-Source: ABdhPJymwTJIUfZ1E48q2+LTBhGWZyJ2SptO2KuCreok2C1Cv6fLLPS8cKGHxyl+1gVawmQHmbXWOA==
X-Received: by 2002:a1c:f217:: with SMTP id s23mr1722360wmc.70.1640196716808;
        Wed, 22 Dec 2021 10:11:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm2573144wrd.13.2021.12.22.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:11:56 -0800 (PST)
Message-Id: <b189f8661e22a7e8d3f4a0dfd3ed32ae14b49e0b.1640196714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
        <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:11:53 +0000
Subject: [PATCH v2 2/3] refs: print error message in debug output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 791423c6a7d..8a6bb157ee6 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -47,7 +47,8 @@ static int debug_transaction_prepare(struct ref_store *refs,
 	transaction->ref_store = drefs->refs;
 	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
 						   err);
-	trace_printf_key(&trace_refs, "transaction_prepare: %d\n", res);
+	trace_printf_key(&trace_refs, "transaction_prepare: %d \"%s\"\n", res,
+			 err->buf);
 	return res;
 }
 
-- 
gitgitgadget

