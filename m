Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A3C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3FE2076E
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExI3/jp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHSO2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgHSO2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:28:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F70C061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so2411823wme.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1rorAVKM+u4KBXRYDRlgewUD+8J1/AJMNCNaL1BonPs=;
        b=ExI3/jp42cDMNteNxgdiwjebE7lx8gPOT6AnFuIIqsyPKU77kDrhwUNqIrzZJkcQeG
         DavXUvOQ6Z5IrgDNnmotge68GEa345liJ9w+ZxIAhmSPxQE+gNUlet6j4iB2h1HEa46w
         9W2RPH5za2WbDpSVewGjXhZ3iOHHx8iMHReZAdpLD4hwHrQbC4WBpwVXB88vXky3i6nI
         k3IGO1onJMEVtU76z5BWDZipU3CMH2o4f6KV6urWUMuN19yCiUNMS1cuBkH1VhfaCGi3
         mncU+CxWEJK1pd5PODv5SbyTsG9Iu0/Zod1GupF6DhQYCZRfxuQ7k0Ww1Uv+H7+YUQ5U
         bzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1rorAVKM+u4KBXRYDRlgewUD+8J1/AJMNCNaL1BonPs=;
        b=kMDq/LkB9ISaff1eC8Fanor3YiKekeN2dCu9f4o2+Jr5TrJUklMkbwBf91PCaPn7h6
         JOqlPXetuSBYtKTgYlF/CH1XKdIZpy2j2FTJP8oos39Yox+t8hMTaeChrii2Pe375a38
         0V6rM0J18nq5wkKmWkiTPzRaxA/nYxjEOeTzRQYrL4Lf6/suzDJFCO9DjZ++JHD/vxV2
         ynhBHzG0XbFIwBuSDRVGgd8rbZ9Pe5DnWS//70ufMKniddccUw3Xw0mDr1KzrkxJqqRv
         fjJKJAWzvW4iaj/OeteyEh8fzgNZhQDRlvz/5lmDr98n59+3deEX52ept0qOSjmUzozK
         8PdQ==
X-Gm-Message-State: AOAM53142eRvn4pzy3tNyH2D3nIExBr41mONA2hvRE7zUcqYQPbvCO3j
        Mo37MZhDZiyScvfr17g4PUTQa1DmRCM=
X-Google-Smtp-Source: ABdhPJzGtdCDaTJIuilXDBN7vmXFto40uOoXYIqKyU1REjVDOanRmOM1QJpUmBknLD7sMomfGh83/g==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr5323052wml.180.1597847282173;
        Wed, 19 Aug 2020 07:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm5840974wmf.43.2020.08.19.07.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:28:01 -0700 (PDT)
Message-Id: <6da0e62e73a34e70535e3ef41b2259e18ff91c34.1597847278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
        <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 14:27:56 +0000
Subject: [PATCH v2 2/4] refs: fix comment about submodule ref_stores
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

