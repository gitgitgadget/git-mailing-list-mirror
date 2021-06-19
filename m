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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85814C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E26120D
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhFSHFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhFSHFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:05:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C56C061760
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so10018745wms.5
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IySzTAUUqHzeE0FAWC8KcgPWtryks8Idbi4l3BSHKpM=;
        b=kz406hlLjUKiyndCeWTXfY57IQAXA+WOP26eqm7EpVqJWuk3/xrABHMiCS7dYa8XQ6
         tJL7qNT2qinNEStS72GkvZExAEcya394t1TI1qqhE34lcmMwKobGU7xxnUdINugNSmvt
         vtqwqHn2pLjEm28QzjlTPa+RcM26VFvw3Pp9DD2WMlYerrWGYXi/CH8IPWq01x2Fcn15
         dqQ9QnyO5hX2jPe3DL53rDr6zozIr+z0HgW64EQxnHA9Vp9DBU9XHJONK9uaXS9WLUpS
         6CPWrXqBQ3uCrx0oq7AZnkZVSN+fFFgCTJvKplXWHPMPhhkNVlxZZ2icKFWYmjD1nP42
         A79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IySzTAUUqHzeE0FAWC8KcgPWtryks8Idbi4l3BSHKpM=;
        b=eQEz4BsipqwKCdr7uhxK8+V2IHJ8KbDSR9rxceGa10D7tCUUBHTAwjJF9QNXxVX4AT
         cpG9Q/DL9qXusVvXu8Y3DpxNoImnRZCJyLI7ZDK/Z3mPtvV83fcDwoy7h8ritXRSOwo2
         Y52NvoW/0cQNvOBqwB2ZaXniRFTAg/q+pE90A2jkC+eGqSCqWCvAx9qyDzLBwM+DhxJd
         QWUd3MhIHtOq2iPhfZLBStzZiMosztJGsvbks/K8xMmK5K564brcvlKbQruOiBGyqm+M
         IPZH5HGl2OiNsJ7/6mUdT5ei+ihFIiay0Yv/I1hMQo1dIFhHtGGJDU120v7d53mVrp10
         BPAQ==
X-Gm-Message-State: AOAM532Rz0ofM398MSQ+1VsLoDE6VLl2tkM+o3BUWndmoJEF+ODbCCVV
        hevNP7I3lQU/pozp8ENA8t7O4Du9qIU=
X-Google-Smtp-Source: ABdhPJw/B41mkHxSuU6x5BxmfRdcHNXHTn2cH+QbzDCL4CyvUsl7qeB9Gdamse9UT5NW+x4Ly9NVcg==
X-Received: by 2002:a05:600c:2483:: with SMTP id 3mr364090wms.117.1624086187105;
        Sat, 19 Jun 2021 00:03:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20sm12475210wms.3.2021.06.19.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 00:03:06 -0700 (PDT)
Message-Id: <8c1d683ec6e959b7511a66eb5ea1103cd49c45f9.1624086181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
        <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Jun 2021 07:02:57 +0000
Subject: [PATCH v3 07/10] [GSOC] ref-filter: introduce
 free_ref_array_item_value() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use ref_array_item which is not dynamically allocated and
want to free the space of its member "value" after the end of use,
free_array_item() does not meet our needs, because it tries to free
ref_array_item itself and its member "symref".

Introduce free_ref_array_item_value() for freeing ref_array_item value.
It will be called internally by free_array_item(), and it will help
`cat-file --batch` free ref_array_item's value memory later.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 ++++++++---
 ref-filter.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 58def6ccd33a..22315d4809dc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2291,16 +2291,21 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-/*  Free memory allocated for a ref_array_item */
-static void free_array_item(struct ref_array_item *item)
+void free_ref_array_item_value(struct ref_array_item *item)
 {
-	free((char *)item->symref);
 	if (item->value) {
 		int i;
 		for (i = 0; i < used_atom_cnt; i++)
 			free((char *)item->value[i].s);
 		free(item->value);
 	}
+}
+
+/*  Free memory allocated for a ref_array_item */
+static void free_array_item(struct ref_array_item *item)
+{
+	free((char *)item->symref);
+	free_ref_array_item_value(item);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 9dc07476a584..76f9af7b4676 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -111,6 +111,8 @@ struct ref_format {
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
+/* Free ref_array_item's value */
+void free_ref_array_item_value(struct ref_array_item *item);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
gitgitgadget

