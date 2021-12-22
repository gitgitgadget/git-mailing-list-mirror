Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B893C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbhLVS44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344971AbhLVS4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B14C061746
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so6814207wrd.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=kavocR3fv8eVSjDl+KDN0Mg9YMhYqjlMaOhkncK/LU4Tbl/Z8G9tYwO7w2B6vp0PHW
         XCQX68C/Pdu2sfrWXYfVm6GGWiTq2k/902TRWb3yepj9iNG5MnJ2ej0PxWgC/V5jPqy3
         x8pot8KXJDpA9o5cP3He3wbWeiI713d15i/C4ZKUt21+henLwRLTJAmNyWvKPV3s9lbR
         9uFsHsdpoCeUrQ3LuEseiKyB9XYGLzl6NPaGRhGj/RUqXx8GQ5BpQGsTJKGLhCqg/8Qt
         FRAAnazp0x7c19BnOS6WfHyPYtUdtmvbRMlDw94lICS5fjjamg9L40HiVgq4kQlkOdnQ
         7cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=RyAQ+Fh4O+LT3thLi4gDAIs01OK7OyBMEvr5U3LEJsYQUXEVxt55e4E25X7SXgjk2F
         0qrt3Fh076iK8UYJzge/AQorCacYLWjUOGyIKgEuvKITnL5byv5i3nXJiYu8CQqkPSUh
         A6JutXR7HivKqEHOehaM3SccMll3CONLCw6TQjg4AZ0VSpdI+Nc28T8YLB6jGibFj4IX
         bpNuceHH4G1DTR+a1SqvQRtSVOICq8y/UU6KKQ8w/PQM8RMBQ0Ew1NzbS15n2j7M5gpy
         QoNePNYkR1mu7eTczZjstvJUd2VKOcDhLGIDmHONatAAU/ct0euHUJ5m+Ryeh+IPR8bO
         eZ0w==
X-Gm-Message-State: AOAM533K/hTq6hEHCPd4dSfsbm92+vDEbETI8LJadPct2NkakHM+EYsZ
        RYtenBYk47E5hfrxe6xabTmj53o8ZF0=
X-Google-Smtp-Source: ABdhPJw702OfRU1pjFE2qSIBy9wKpXKTSecjd8FnQ0qOV/DZ4SZUHs7IP8hOSMy5kvmFfhZP/VhIag==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr2988627wrp.512.1640199403703;
        Wed, 22 Dec 2021 10:56:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm3441780wrd.35.2021.12.22.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:43 -0800 (PST)
Message-Id: <67d858ec59e1c62d5e227e85e117b3cfcb3dda2a.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:30 +0000
Subject: [PATCH v5 10/16] reftable: handle null refnames in
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

