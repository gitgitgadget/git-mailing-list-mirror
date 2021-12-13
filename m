Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F36BC433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbhLMQCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhLMQCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC51C061201
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so27841426wrd.9
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=MLciMJczy6UlZ0Yy4h9HwQ7idvIyDo7j265snJw9f/SfYT6NyR1Ve7vo6HjjhuRxwD
         qS1MnGMWYxPExS5vKlHxHlhvnORwjLvev0H1Xe5nUGwkhpeWzM8U+D9oAOSp9tjWwBxL
         3/GXmMBKjQjg7h1aAE16vk2Vi2gh5HOrG0v0IuDacUJiHLCvxAc7CooJemKdVzOWpVN+
         a4jiKRYyJzcxTPfoBe00l26UWUR53pcz6xBZUB4Us+nKwjU0fm/qifUyqWNYIubXV5yA
         Kk8CYgH+JoSWZDSK2S43a/7eFZFnc1uwhP+X9lRTvVGeaCILOP89XREF9dUX675vE3Mi
         /Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=2O3UN8u5p/t4jQvaa/OgDb8vO52nuByAP9yZp0M8kkCAc9sZbUydNgpUzNjrZEI+s/
         FCB2Qs4r4f1Sfx33w4ckOfhLuwyd2fc21gxSn4wieA1O75HIngmA1428k9e3nf1W0XwM
         ASt5IRCu6LfTpoyLdJHVWR5yKwXIy2cxfgJOnT8AfPQGouW5CPLzmj0eggR6DFQhl33O
         14MCQulzTTrbNViFHjFfd73b1Z2Xa7KtHelOZ8FLiowXuJ7kJLBxfTEi32IanHVAKSC/
         UDTc+p13BOWsLz3ltpIkFyCWoWxZNH/pMws2/ChwPrj6R82KDPHZio754uN7swLjrcbI
         v0cw==
X-Gm-Message-State: AOAM5322i1Nx3FfEzfHwiMgrsIjg/hdgDW04xMpZ04vuRB+mIzQ1r44S
        EckN0DpxSj4P1+/9mzA+Jy2kJqcyqk0=
X-Google-Smtp-Source: ABdhPJxLNjrLzlJnYh93CR7HGu3QTl2VVGUOHHgQg/HmxVECCbUOb0o/SsiJqPDbxNb0gXwi32/xcw==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr33864804wrc.193.1639411320889;
        Mon, 13 Dec 2021 08:02:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm8216551wrs.99.2021.12.13.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:02:00 -0800 (PST)
Message-Id: <bff85cb080975cb08e95e8df85afcc27da307cc6.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:48 +0000
Subject: [PATCH v3 10/11] reftable: handle null refnames in
 reftable_ref_record_equal
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

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8536bd03aa9..8bbcbff1e69 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1154,9 +1154,11 @@ int reftable_ref_record_equal(struct reftable_ref_record *a,
 			      struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
-	if (!(0 == strcmp(a->refname, b->refname) &&
-	      a->update_index == b->update_index &&
-	      a->value_type == b->value_type))
+	if (!null_streq(a->refname, b->refname))
+		return 0;
+
+	if (a->update_index != b->update_index ||
+	    a->value_type != b->value_type)
 		return 0;
 
 	switch (a->value_type) {
-- 
gitgitgadget

