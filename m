Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA65C55181
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB9620782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQzJDgns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgDTVPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTVPA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C45C061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so9175036ejx.5
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U9KKpEo7qDk6b371Ift0pED/deaO/rNdnLFaeZUe2dA=;
        b=nQzJDgnsiPpeCybBklfaa9Q5VGsAGKwVzWJ4Z5BiwqtXiBQpbvsZ/shkqQ4+O8BloT
         okjngO80L3CuvEr22UQdL3PPQiMfaenjlOiPpoRqAx2DvEvlDNw4QWO+14Z2eMQuj1md
         SmhkG/yp1D9/zE6MJWUYiplBQ3qYQ1HRYY+a2L0vaL//kFLoMzZ5WMLOaZLY2K80QQkd
         IIib791OYUYL9rpeb7y7VUvivAu/OtxorVy2qquyKkoiIopV5SOM6hKzPHSENDEOKGx1
         N5ray/y19sT10XClJNFq1Bgoyk/h38ZixmvQUZlxJxuOb/YUJR4OmHyXvPYerPUezVv6
         1+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U9KKpEo7qDk6b371Ift0pED/deaO/rNdnLFaeZUe2dA=;
        b=tOaRjwNo+zlLhRQq6RcvAav9L5O6PD+QthkBIbOGWY3tiDSLcBEjtoVAhOOH5wLhDH
         vHpwTXmVGqv/C+eDI1pn4V5wB8c9X0W7lAlNure0MJe+INHGRA/A09AOVCZfSq0BdTXx
         ATn6CgGFhtjZkf+LAM/SxbrcdVMXFrpvHFtdqVIuns5LNfwdaddsxr3agx3+0uVHdHXZ
         QhMxyzQ8TNOvqPF6PDV/K0JfqwBcsq9q53PhMZP7ZxAmpjTrBsmCjfAn1Fg4AWp7pM8a
         ohrviRWss07HHkrLyjQbQ8zJylFBgN2O1UmTnHZ7JiVYQiFNARSENWWuSpD42x9ErP7q
         KwVA==
X-Gm-Message-State: AGi0Pubj3GDqRJIedH3Mq7TTbAqmLt5EFxHmAT6WAHTOmiCJ2f7ob8D2
        5Y7VaJSFzV6NIzB6ufC35kOnvSHv
X-Google-Smtp-Source: APiQypKT4nPEvc7RAJLxMyMDmi6eIrQYCzHErGByHErXY2cO/Gix9p3xr1SgJ0hoYH8zly4e9TY63Q==
X-Received: by 2002:a17:906:2418:: with SMTP id z24mr17732701eja.42.1587417298323;
        Mon, 20 Apr 2020 14:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gg24sm45274ejb.66.2020.04.20.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:14:57 -0700 (PDT)
Message-Id: <89b68145e8f5cb7127a028ebad50d144790fc16b.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:47 +0000
Subject: [PATCH v9 02/10] Iterate over the "refs/" namespace in
 for_each_[raw]ref
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

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3d..3b9742d03cb 100644
--- a/refs.c
+++ b/refs.c
@@ -1569,7 +1569,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1629,8 +1629,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget

