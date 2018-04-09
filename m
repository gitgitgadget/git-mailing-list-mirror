Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958F21F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeDIWqG (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33673 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeDIWp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id s10-v6so6099001plp.0
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XaWemEru83qjlrY+6fWNVcWNPA0N9HaQ1XZdJxM8Nc=;
        b=d2G/4bOqTf0Qam3vkGhdqfTOGI1++Gejc6mQbSwoeEszX9FltacEXBnyrOvQOuUg07
         WsO/+VrJ2goBHQ1tMBBV9zWcFrlFIj/QeGZkwrhprAGLfDXhj9JHTUAQQAESzN3ZQWLD
         iWk2SR5rRDFvRPBuWfVJb66kCnlmNFJgSLz+ILtFZxKabqQ8F5/qdMU8SKkCaFtGlkmP
         x+w/qIhd3wwweJ9M0/sgxbn6GYfKnKyeZGsPWpUVATPZyVrrfW1ticjke7E0z2guhatb
         vwVaYttLzgv3yHen/QW4BP/pUOd/s/HV6rgFQvyAaTin3DEaPdMX4eVx2b9BBPRLm6ln
         pMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XaWemEru83qjlrY+6fWNVcWNPA0N9HaQ1XZdJxM8Nc=;
        b=pm6mW0mTUPsRDLkVdM/lvbRPRNoy/0hXpjLGQOxJAq5mm6ywWQf2WF2CMW6Ur/Ziql
         uTPLc+dXT1lhKd415iuNIn56yUEFXrThaCicRsMw0mEeUzG2u0eZ9XO6hA/1GuiSKFFo
         m8q7IOa+DLWMmfVPL3/8yMjK0yA2UD315Lu6bEPB3Wlw6x2i91GKTZEG/nl12TIOHGW8
         c8FyHlAmjdOoSSrdO3WFbswOGc0aVkTkoz+ODFABVg7ddpOxz7BP0IcYq/OskHjQ0u20
         TlSMBUP4ZgkF55gZiRLfwyyi1Mv/N771AtfX4OnUh67P5xp4rIsUy3YVdJKn/kOftqbP
         w/bA==
X-Gm-Message-State: AElRT7GfhfXpln/ZKF61buEithpccPeeRfEExBS0Axc3fQW66lyDF2jO
        QbQP6IIiBsGjPhlsPkNK0krxewwrALc=
X-Google-Smtp-Source: AIpwx49XjNAY3CPc/pxW8nm9juOKFgm4PLXOcaOJ+wc4/QUMMGXPGCvUUcHEY2UOxTydNYFDDWbA9g==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr38648462plb.140.1523313957277;
        Mon, 09 Apr 2018 15:45:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f19sm1728855pgv.39.2018.04.09.15.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 13/16] refs: allow for_each_replace_ref to handle arbitrary repositories
Date:   Mon,  9 Apr 2018 15:45:30 -0700
Message-Id: <20180409224533.17764-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 ++--
 refs.h | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index b5be754a97..bed5f88405 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,9 +1415,9 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(the_repository),
+	return do_for_each_ref(get_main_ref_store(r),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
diff --git a/refs.h b/refs.h
index f5ab68c0ed..15f3a91cc4 100644
--- a/refs.h
+++ b/refs.h
@@ -300,9 +300,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-#define for_each_replace_ref(r, fn, cb) \
-	for_each_replace_ref_##r(fn, cb)
-int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
-- 
2.17.0.484.g0c8726318c-goog

