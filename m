Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD86C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A1465108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbhCPQoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhCPQnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264BC061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1846197wmj.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HXXyCb3008cEuxUb0eFiCeUe/gRR165/1lETbl5mS4A=;
        b=mRcmQpWdxPqI9B0Koct/0mzklvAVCv75mZk4b7QYUXP5mZyCjXM0dJOFFmZ4CiUvMr
         nhAx6CHVDAVLkNvT3EtjeJOqjoai6RRkbLdxvHurLEXputgpusscLJU3kprpiEuOc5zK
         ulSeT1+8OI2xDhlmQiQSR/4erm9k4taDzMxwJNXywKsPWzDnicLnK6/RXOiy3SkOJxov
         3eDYbVMMXsTmN2hd5vtxWwen+kGERW5fplLlFVBMF03X9qbz3c5gUWCfmQ0nnrHtt/JG
         mwV3BSc/Azrq3QEn0J7QLCV+qOurHrACoN95XR55tx8TBUfRXKQ4+tUqW7RIYGrHejc7
         t5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HXXyCb3008cEuxUb0eFiCeUe/gRR165/1lETbl5mS4A=;
        b=CebowHF+wfyklavUTsST+XMAHpjQmnk0Dbcs7imNjqPvS+f9+svC1xZv/4d2OuF6v0
         7MdOBtK31LvvG5zljhJ+cxkTkBi91rJntQwT2OdH/n9N81QjJHcefPlTPqyR7y5SQvs7
         EChkqIx1dYgWtdo3JI/PRkQ2b6hvTJ1X0DzloknXDsx8rH8+o05JGU5iH2PVg0cxT8u1
         xQ6ISGneYpqf97ijMpkBWIzULoRjUHLFZIApP1r8mwP9wmTggtGtrvUb91msJldV3H28
         iJL7FzixOAiWIiEH4526hhqlSzSl4ddCTs2CnuFAPLl7Ah1pA8qbWFH+m4mK5TbZAkEy
         rhnA==
X-Gm-Message-State: AOAM530pPS8woYeAV3bpi2r2CFMBXpW0nmnq1gps9DNDfvkw/XDIVqb1
        HqYYl8091ybmBLoGZh4pZehSrSUE/i4=
X-Google-Smtp-Source: ABdhPJzUVHnFsWJMPH0lmt+ICfGp9OjLsjW3CPWrrDTI9U4nVFi0rAwHmO3dwcEGbW67d4mRJv+ywQ==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr492230wmd.40.1615912995025;
        Tue, 16 Mar 2021 09:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm22377151wru.2.2021.03.16.09.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:14 -0700 (PDT)
Message-Id: <1a2be38b2ca71974d19f78d4391f16145d5a9ba2.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:57 +0000
Subject: [PATCH v3 14/20] sparse-index: check index conversion happens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test case that uses test_region to ensure that we are truly
expanding a sparse index to a full one, then converting back to sparse
when writing the index. As we integrate more Git commands with the
sparse index, we will convert these commands to check that we do _not_
convert the sparse index to a full index and instead stay sparse the
entire time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index cba5f89b1e96..47f983217852 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -393,4 +393,22 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+test_expect_success 'sparse-index is expanded and converted back' '
+	init_repos &&
+
+	(
+		GIT_TEST_SPARSE_INDEX=1 &&
+		export GIT_TEST_SPARSE_INDEX &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		test_region index convert_to_sparse trace2.txt &&
+		test_region index ensure_full_index trace2.txt &&
+
+		rm trace2.txt &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" status -uno &&
+		test_region index ensure_full_index trace2.txt
+	)
+'
+
 test_done
-- 
gitgitgadget

