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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD1C48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0756861164
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFVDX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhFVDXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E3C061760
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a13so54776wrf.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=udcMUMlDoDQJHOyTiRHXFf/XsDBWAIUFRRNRk2Rl/Xk=;
        b=biwKx5RH4/IXT7QCGaSmo0ixzywc6BV1laDGQDRmy4IVRDuOHnJOfPy7n+pqPo3b9U
         Uw+WZ/UzcTgfnQJDxAT8ffQdoLdLpHGFKgoVylxFw8lOKcLtZaegRPmm+eAV/6bwASIb
         nWgPnI+c9AJylqs36fLw8Lw3KiefZZonO4iRX6lFg+QyLhDkUl7L+QPTUoXUo8BiC40M
         m9Xb7Hbg4LpUJDCKeA6lyiMOLBwwAxxG4iC6xMEFrwk1N91w8GjmUvZM1k2e6LZV6Mc4
         Nb3XrfuYJGt6Bv9uVp/Nkv1kuvB1E5hJiCrcjO+uLXO22MlGCC3tV6wYVjUZeeHAMuoq
         yV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=udcMUMlDoDQJHOyTiRHXFf/XsDBWAIUFRRNRk2Rl/Xk=;
        b=GtsvKVuRLtBQhANoDrV37XltLC0PdH9OD3Xv9cNbkW6UyE9y5kga51Fjb8Zznmgoyo
         JDEq9bzhyljfHNNi1agKss/rgOKw2rY+jlkr+cD/pYEEZSob5z2OVzpmLMZoeGKs2SN0
         L6GHAyoq4ZfgLmVrh/nV7d5C5iSRQpwNme3ts15G/Nt9a7KMVMtSx64bB8XKd1z2EEbG
         pM80ZkH/VAarVBFuGtLKgg1bpKY0PuwD9lRgdvjQfmjoxmVxarLFr4hB30BFFAeRjFvq
         EXgfqQu0NXVKAyR/m458bFgDk9uK26Z9jjNcH6ksBdAFFhfBEuaqDAFzLhcWqI9SVEsY
         Z8Kg==
X-Gm-Message-State: AOAM533BNP3K1X58jW95cUxtymz1JxJCch2r/8hp6eNnpDJW3AJZxXYa
        E7Pu6MpSz/laVNA1slG8ecYxZtZ6cT4=
X-Google-Smtp-Source: ABdhPJw73eLSy5104pqU+6WBcRfK/vBVhxiRbjE1gg+ke58y8o7E/GSe8/GDnraQn0mdfoBAbWNtWw==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr1889507wru.9.1624332060249;
        Mon, 21 Jun 2021 20:21:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm757644wmq.43.2021.06.21.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:20:59 -0700 (PDT)
Message-Id: <06db6cd6f1f93ddd3be2e8ae3efdebeb82a2ca00.1624332055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:47 +0000
Subject: [PATCH v4 07/14] [GSOC] ref-filter: introduce
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
index c15dee8d6b95..44e6dc05ac2f 100644
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

