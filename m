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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258FAC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F23661474
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFONbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhFONbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE12C06121D
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so2027534wms.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1RyoUSZFJxz7y6PjMiMZAxUO69o5Pe1rFl/cPKTlma8=;
        b=au1lLZBIMlhBomodZhu3UWYBkJXffiiC9Bkm0l015AFTTpGwhZrCsy75lA60sNAFNS
         9cloG63wRPSRTSBEeg24JrI1Z8fdXU/ZAvohNtBy4qZQ0f0KjOZHEjPMDfaOMGyI2Agw
         K3tomg8TmolshaBxuPIGhXdeUdqvN9ogxKCNRRG3YRzbt1kFQKTtbdAK9DRLtJZ3EPAu
         sllai4yl/g3zRYBy3WUPh6ar35cneoRLyn0IxK0tll1Lk8zM/rEojQxqqs4nyo6dN7Rj
         M05/l83LqMZLnJ8Sq5zB5bUWf1IhLc29mMszLwV1QhcSeWN6312+dvnmBEHDCYvIcB72
         mXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1RyoUSZFJxz7y6PjMiMZAxUO69o5Pe1rFl/cPKTlma8=;
        b=lngrH4VoCHbc97aCgF4ogyMKSXof1xXTfjP5D7Ms2N+cVUytcWpu53Y8o0hY3URiv4
         LHNOBSwzuoqGThzstZlhIX9Dx/1hIIyX/Akkn+TlrLsc6C67Wr9Tl0MjLBpi/hfeamU3
         JDxQFnI2rqdXpfmxWc/mXmw2yZFh484wPOZUhx5Do45p/g/VhfqqNukxOksbq2KGa14V
         N7spwjKuI5nHX6jo/QHK25AHXmeVDl+gGiGJ83viMATU1Il03ebaTr8wjMRd4gz5kGmp
         1hyK9Ic+1lHrvPvpD25pJHcujzrhKIaHWH62IaG3ItZcpSm7LXMqO11PBF4mT0ukeER6
         NfyQ==
X-Gm-Message-State: AOAM531z1cgNEwrmSIr85RKqhdKTZdk6yvSqD80npVlTzbn+TXE01WL+
        +/G3bWqm+yI96cZ1rMuWRBezRt+SJdk=
X-Google-Smtp-Source: ABdhPJydyE5/Lp3t9vSA+0SSLSsWmkZhUJMyhcFfk+7YhlWkosQU8sXXsg4kNMxWZIT5Mdqs6vkEzg==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr5366741wmq.50.1623763752334;
        Tue, 15 Jun 2021 06:29:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm15771152wms.18.2021.06.15.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:29:12 -0700 (PDT)
Message-Id: <d2f2563eb76ac2e2c88a76edfac7353284407ad2.1623763747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 13:29:02 +0000
Subject: [PATCH v2 6/9] [GSOC] ref-filter: introduce
 free_array_item_internal() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Introduce free_array_item_internal() for freeing ref_array_item value.
It will be called internally by free_array_item(), and it will help
`cat-file --batch` free ref_array_item's memory later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 ++++++++---
 ref-filter.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 420c0bf9384f..aa2ce634106b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2282,16 +2282,21 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-/*  Free memory allocated for a ref_array_item */
-static void free_array_item(struct ref_array_item *item)
+void free_array_item_internal(struct ref_array_item *item)
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
+	free_array_item_internal(item);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 9dc07476a584..d4531fef5f91 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -111,6 +111,8 @@ struct ref_format {
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
+/* Free array item's value */
+void free_array_item_internal(struct ref_array_item *item);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
gitgitgadget

