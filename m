Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B4C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C4D60F35
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhHQNY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbhHQNYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7977C0612AF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q10so28643294wro.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dgfH8FHC7lRtH5aYzMRWtNR/tzYMsPRc7peitaicWXk=;
        b=CiuygpsjeFiEr1T2F6uKjJnFZ1Gx0zfcGgdRRq2xxg4/AVh5kxbUaev7TmDI2Z2Ind
         jUW3Bv09LoaoKMHEhWN/XMAmHFxKr/1yL3uaG3h48USJreSN19cAkroaYxr/ltDOPTho
         LOomfzq9ozfZMcmFKIHaNSzEc1AjlaFHPg/oF6PNAi2oURmmTScIai16R9vxSwqV9xBL
         Tc+eKrGjeMxTYO2tPiyU+h/K+PeEK8rWZhmpRYO2qCVBM05GacsQmoBSMxf1Y3s3EWKU
         vjpQYoejLDR0W7EvyJQbw+j0CGUDqbypzEmIvniXbWyqvxWu5oVZOOkHG7kk4yBVdtQa
         kUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dgfH8FHC7lRtH5aYzMRWtNR/tzYMsPRc7peitaicWXk=;
        b=VsHrWg0m1sTd1KLJnAWqCCa4436jaiNXfeilF5v+l7VSlXjNC+QKx70oNtAf50k44x
         sdXnyaNBPNzk9iQXLxtWHKwLa96ccErtaoG9Tn9PppZYc24zQBlPte+jVwhR0zrNkaM/
         gneIDbJtwQ4QnKcCpYWQDIdfziXHXLE+oQUDtbjxe7S3rzEL8nfEErsPTpztv8oCLxDA
         wJ/1GmKZJAwusIlZoxCg79iV8XI6QWTtLBr/apsHDyrDXgLaJdXuqzisLyJo7PZZEknR
         gRyHGWzuDkoGZVj4Uqq5uBJe0H3Ik+ANDIAzbEyYfDXPA2JfdqU8I0TchBIL9N8kiMre
         iWgw==
X-Gm-Message-State: AOAM533/0+hyzK01q75j1EVWpOl0Jj8sPzekv9ItKxdsIdybU01eHEc1
        nMi7kcPjVuxLahnosolgV4b50uEJ0L0=
X-Google-Smtp-Source: ABdhPJwtuMTCiUPSLbesZ8ww/luIg+JGA/+yelhkUjzbwyTFCcqFhLd7yiNCl75ntg5T+w1ypritxw==
X-Received: by 2002:a5d:574d:: with SMTP id q13mr4149550wrw.425.1629206611275;
        Tue, 17 Aug 2021 06:23:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q75sm2322685wme.40.2021.08.17.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:30 -0700 (PDT)
Message-Id: <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:20 +0000
Subject: [PATCH v3 6/8] attr: be careful about sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 attr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/attr.c b/attr.c
index d029e681f28..a1009f78029 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -744,6 +745,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	if (!istate)
 		return NULL;
 
+	/*
+	 * In the case of cone-mode sparse-checkout, getting the
+	 * .gitattributes file from a directory is meaningless: all
+	 * contained paths will be sparse if the .gitattributes is also
+	 * sparse. In the case of a sparse index, it is critical that we
+	 * don't go looking for one as it will expand the index.
+	 */
+	init_sparse_checkout_patterns(istate);
+	if (istate->sparse_checkout_patterns &&
+	    istate->sparse_checkout_patterns->use_cone_patterns &&
+	    path_in_sparse_checkout(path, istate) == NOT_MATCHED)
+		return NULL;
+
 	buf = read_blob_data_from_index(istate, path, NULL);
 	if (!buf)
 		return NULL;
-- 
gitgitgadget

