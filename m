Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88271C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbhLVS5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbhLVS4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A3C061763
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i22so6694931wrb.13
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/nZw9BRwEFnwFiUj7FGIopgD7BwEORebn06+Gh7xpA=;
        b=LRfUE58qDZRHb7M3e/0i999hTI7HM7IAkJMIj6TRyPD6VEsuq1yJI4MH/Gxbp01YYI
         OI332+qF0+B55ZuTfdp2yRMKXJEdTdNH77oJol7gjQu98OK627ldpSjBC+3XL/2gNnQb
         Aa0N+GEz+88TZAohjiPTn68lTrqt24JMWR3CHilPgeXqB1HzXEv7JoTqgBfWL9MkXE4y
         K7cDOqd/HK+BAsXJiid87QT4sAFyzAbze6G0iT7+GQtDxvrXFBHp+zDNsR6sVSh6kK2N
         SWqweMRWDSoqoSEBUHGgnH/GxKuTsraVRMrJM7DOVQqdMjVRtLJyc4POpKmpQukWnhrt
         O+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L/nZw9BRwEFnwFiUj7FGIopgD7BwEORebn06+Gh7xpA=;
        b=lQMj5TdsJJIq0UyXnMVmijE0POlSOa7AkPA1mwL5G3842qsG78w0Fx5qGtzb2xVhkN
         4JUDfcMzPz4+1HUp9EV6VD+ItDR4AsM5PRhPg8EkudoH9r7okgwi/KAucLFE48KKH6b8
         9NAI3fu/XN9RrYOgj9poC+OT/XcPfDAHX6gmLT7LvSkwY/O5xITfGo3VwcZg8ySJHzsX
         +1R056R522WArCxZthzBrSvfJkE3MOTmJry6POtHUf8K8lZqsm295lOTFE2mCfbjn0ov
         kkJ+0spjtF+pHGYYVzh0gZihgWx/zPNL8Ho4YG2Wa6VvnKh95nXD73i0xpiI4WwcMOAH
         7SqQ==
X-Gm-Message-State: AOAM530dNeLSyw/1na8Z2unT9GFcMPuZjFsrA6qo2gl/HD3SNnPXNkSJ
        BQsc7cCmKtShVk5ORPnO8TOi8sJkHUs=
X-Google-Smtp-Source: ABdhPJzSXqhVC4g1j3rWY1Lx2KTSIaK8baGM6UzSiXtr+vD1YorHXjK8DifXvoWR/WyETE7Gt5KicQ==
X-Received: by 2002:adf:906d:: with SMTP id h100mr2866800wrh.259.1640199407681;
        Wed, 22 Dec 2021 10:56:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10sm3203861wri.57.2021.12.22.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:47 -0800 (PST)
Message-Id: <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:36 +0000
Subject: [PATCH v5 16/16] reftable: be more paranoid about 0-length memcpy
 calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index fbaa1fbef56..423e687b220 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -126,7 +126,8 @@ static int encode_string(char *str, struct string_view s)
 	string_view_consume(&s, n);
 	if (s.len < l)
 		return -1;
-	memcpy(s.buf, str, l);
+	if (l)
+		memcpy(s.buf, str, l);
 	string_view_consume(&s, l);
 
 	return start.len - s.len;
@@ -153,7 +154,9 @@ int reftable_encode_key(int *restart, struct string_view dest,
 
 	if (dest.len < suffix_len)
 		return -1;
-	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
+
+	if (suffix_len)
+		memcpy(dest.buf, key.buf + prefix_len, suffix_len);
 	string_view_consume(&dest, suffix_len);
 
 	return start.len - dest.len;
@@ -569,7 +572,8 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
 	uint64_t last;
 	int j;
 	r->hash_prefix = reftable_malloc(key.len);
-	memcpy(r->hash_prefix, key.buf, key.len);
+	if (key.len)
+		memcpy(r->hash_prefix, key.buf, key.len);
 	r->hash_prefix_len = key.len;
 
 	if (val_type == 0) {
-- 
gitgitgadget
