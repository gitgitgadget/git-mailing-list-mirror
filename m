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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBBC433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD2D610E9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbhIGNiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbhIGNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E48C0613C1
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1850764wmn.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2bnCoDymTUy35GY0pnGuwLVLYsI77eGdhk8l9/1MYn0=;
        b=pstwq/kc/H06DKL2hTe2ctJSHP9PkG4suDIuxZbTWMDSrnVFPsmh5HyNp+raGBnCjl
         DKELtPIQPg8B1WTwBAe+62GNsiMrb2LSCdoegabfWFn+vtIDCBiLOEnzOUksuqQbWBur
         Y65DxOktM+XFFSIq/c+RNRE+8iOKgxUXL+3s+JIy2fyue8UqA/w3KUaH+9DCXtSCkpz9
         1+reIkk/DQ18MPFq/lJlKiZjSuz5mauQuMDWsr9W8LadK0nxgRMLJ82IQlz/zRp/lefd
         ZbQrLwYc5t2GWOmgUqgMfTKXku+mefwBhutznYHyXYqfUeU92fmgo7kEbcfX1OwQC3v5
         36Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2bnCoDymTUy35GY0pnGuwLVLYsI77eGdhk8l9/1MYn0=;
        b=nykciVH/QFjyjNvZiOMNP+59ZA4EoKU8rmtz92rdTcFHeD6Yl82AHXnD1qP7pPUg87
         WF6Tmvk0sxJW45XhX5XIcKJKRyhcez0qp4AxgvRqDZ3NnlRDNPAHJQzTkcp4Kikx+yMw
         EjfVo3S8G6XULT9nXILpxvKycXsrd22UcgocfKuksaSBmrBHXVshtF3dv0y06LxssGPG
         3w0JJAqxEaZjFj4+I6Ns74z+1DETg6W5/YBoY0Msa0n0o3H1Wfh/6Lz6IDlFsqeUxEjU
         XsoX2goo8LBu7erg21bbQ7WXPoXFHFjdHOnoCd0HRMXgdAk7v++T6GcI6ub+EpyECQyp
         srSw==
X-Gm-Message-State: AOAM530/WQ4feJBeTs/ku9J1dx2eP0LJNqkFCBewtKyYxLjsvLycms02
        eD5CxyJUstzgZ1HcCOwIV4L6xNVxzxQ=
X-Google-Smtp-Source: ABdhPJy5U9etMozfTK67fI3ufy/+W5svvyy60atKRpwSibYiJt6VCeZ7rZn72adOKMiFw1IFgKbYow==
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr3994987wmk.91.1631021811484;
        Tue, 07 Sep 2021 06:36:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm2325564wmc.25.2021.09.07.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:51 -0700 (PDT)
Message-Id: <e273963216cdaa3c08eee6032da0677b546ecd9d.1631021808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:44 +0000
Subject: [PATCH v3 3/7] test-ref-store: tweaks to for-each-reflog-ent format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Follow the reflog format more closely, so it can be used for comparing
reflogs in tests without using inspecting files under .git/logs/

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 5 ++---
 t/t1405-main-ref-store.sh | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..0fcad9b3812 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
 	return 0;
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a600bedf2cd..76b15458409 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep recreate-main &&
 	tail -n1 actual | grep one
 '
 
-- 
gitgitgadget

