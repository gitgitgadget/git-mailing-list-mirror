Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3554FC4CECC
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18692206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/loM6NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD0UUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D6C09B054
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so290720wmk.5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=P/loM6NALN5ATfNP0NHFqYGjOTnwV+Jj5t0dhkQ0X06wSJ00fX9OFbwsV6QRSwLJLh
         D7Md4K1d/8F9cXRm2WHExf8ORqKQRW8GK1Dqpr6kemdxM5vBxzRO34uyXJ8QbhBEmFlQ
         ZMXQyCT2IZWUVfh2OxlKoFENxnA2M1UVSLYsKabSTRQ1OfDEzNZNPs6XK9OlLRuT6JaZ
         I9WQtLzc+9VHA7PX/e1reKBpVFVqq+okq76AHmUkPli8wwpux9vWHzVZb78onJ19f2nq
         o4qc5u2i1zhfQT5oWa8cS6P4yX0uHJ/Ew1vRayPpEMVlGwRHTfW76q4wLgbInC8CQ8Sg
         Jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=JClFgHrw2hkdpfvZsFFozFH7YfrBfrmDToAbpFVKv/ZaBNAQ2svJ84AwAXZfyk+ARb
         Z4OTRdt0dGiqLNVl1zsMlWgN0OuSQeQlztLTWYwOOCoSwyZfO0aA76AyB61u1qMonRep
         NTgfvgpvm6UhHSNfjGYinpLVEN3yYCM+h3aJ6l8fCtVY9TxfsWpFkbnsEuL53SlJoHc+
         kaJA2s3zbfTa3NRn/+rckwMbCoJtJnFfiaeHKmp22udQSn+aKDzLB0xo3hiqgvaWJo8G
         vXkG7ZeFTMwan2KVE9L8RrRsMVfqARw8dzez5tXTCW3AWVniatHyZGFGMJFSDMPzSFeP
         fB5Q==
X-Gm-Message-State: AGi0PuZdGjEbiuagQ8UT40VY6/QDx4IDj33ZJ6vM4/OryelRHiAdUpSa
        wuc0ZOW5H3FPxQfcjGMLVxIncZLK
X-Google-Smtp-Source: APiQypJROcJ9Y2M5dmF4/JcNXAeljpmxHGKOcJYPfLecrnUMcgu8QJrIUdSoRCOZ/D6EVMwcjeMD9w==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr424583wma.91.1588018427246;
        Mon, 27 Apr 2020 13:13:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm21775253wro.2.2020.04.27.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:46 -0700 (PDT)
Message-Id: <95aae041613c7f6ac683c749ea3863a7fd1e46ef.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:34 +0000
Subject: [PATCH v10 08/12] reftable: clarify how empty tables should be
 written
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

The format allows for some ambiguity, as a lone footer also starts
with a valid file header. However, the current JGit code will barf on
this. This commit codifies this behavior into the standard.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index ee3f36ea851..df5cb5f11b8 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -731,6 +731,13 @@ version)
 
 Once verified, the other fields of the footer can be accessed.
 
+Empty tables
+++++++++++++
+
+A reftable may be empty. In this case, the file starts with a header
+and is immediately followed by a footer.
+
+
 Varint encoding
 ^^^^^^^^^^^^^^^
 
-- 
gitgitgadget

