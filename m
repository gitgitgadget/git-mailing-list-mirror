Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C858C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiCBRLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiCBRLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7303BBC9
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u10so2201071wra.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqKIUZUV+OWpepECBzlHsaINd2dS3NK9oDdgtW5YWbA=;
        b=irI/b9vzDe5eXRH83CkHVrJUYZPEjtWw44GBAxOmYKhn9VE9hA2l4pHwAgIhHYwAR5
         xYmvRSJwiWLaNAnPquPL6JO0U6drrOTibQMQXK4qAVAAyJo3cnq/qznw8QHtvqRodg1X
         7Os4u8EIAawKzROiTzrSco87tam52SIsdMHnQGbKbRHFhkxH1JDQUHn/W7JExsj/oOpi
         VO1dW1ObwzqZBXc7iVs0btUODWMShXCz84Z/yjoXfMDKmsEM0Oo/EsqofXC/fZh2tNwM
         LkIXgr2MT9EvxuwlJ2CVb0Az/j2zUE12ij4pX6uaXRCSrj5lbAJL/cFUB7e+JWNNwVdc
         qgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqKIUZUV+OWpepECBzlHsaINd2dS3NK9oDdgtW5YWbA=;
        b=Dx5bN6GOzw/O1pXoejqJ2HczhjC3iNsK3T7CUd9D1ywiW9Xffwq352R0VBrHLuf1dG
         jok41KCx/UXM2bCT3hu7jhwcTsJ3vbgV2APMCmQsT1U3PhckTTNnxQqNBvc7ir1SQO04
         gyd6SYqwX8pvuomDQj4e4RRwECbpPYCRYCKnigJav1bGBFsepvpk1sVSfv9jkBtSUM89
         4BLTnyNW9VgFdpVI8sWQz7grvbX4pxSsqhGmBtA9TPAzf9IBwJJY7YIo9l318d4zXZ0p
         qoZXRDdRyFMjdMFCvKUbgoGQ1GTbLSmNcqV4Jib4nqu/S9Kl7JbqkbIo8NYpg2yqE+pC
         kURA==
X-Gm-Message-State: AOAM531bo4iH5fW/0WBfSDo+JzslNOetQEfnw5yYYinXj6Tz8feXzHvn
        UW1sVAOw4XzUtxh3nxhS9gFhos3qk7wVYw==
X-Google-Smtp-Source: ABdhPJw+o12FA6Wue5rJDeS8nrklBfUny9rKlhSGG/eQXmjr/8UYDAHhRVx1ZRTyaCfDVAjo+PBW3Q==
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id v3-20020adfedc3000000b001ec5f115415mr21881381wro.317.1646241026876;
        Wed, 02 Mar 2022 09:10:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/14] diff.c: free "buf" in diff_words_flush()
Date:   Wed,  2 Mar 2022 18:10:09 +0100
Message-Id: <patch-03.14-5d2793039ad-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the freeing logic added in e6e045f8031 (diff.c: buffer all
output if asked to, 2017-06-29) to free the containing "buf" in
addition to its members.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index c4ccb6b1a34..c5bc9bc5128 100644
--- a/diff.c
+++ b/diff.c
@@ -2150,6 +2150,7 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 
 		for (i = 0; i < wol->nr; i++)
 			free((void *)wol->buf[i].line);
+		free(wol->buf);
 
 		wol->nr = 0;
 	}
-- 
2.35.1.1228.g56895c6ee86

