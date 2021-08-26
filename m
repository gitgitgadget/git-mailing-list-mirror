Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7577AC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557D160E0B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbhHZOGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbhHZOGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:06:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79745C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso2323217wmr.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjNUgIYblg+sK68bz8yXT3BAS/9Dv0yaeblduHUUInw=;
        b=B6Qga7sE+EBtsoo4ljE0i5tf54VuUlquOojTkTqd8VnV4EtimAmizE19kbiQRBBshZ
         K+S/OomrcGcGBTUHsE13qRl87wf2fLDm2vNotgzWDGvuNjUPdhjMDezRgzrgzcSduO2U
         U4CSM/tU00Q6jV/0DITfttqRdr6e1aOmMpX5R6YOdiQLp6g27xLmpLcB54lDLUnCMhup
         O9iOmmlE03f1lUYcEwh9Pp6eny/CP3wuDNrjPNzSzIpXfCr19NoLZ4vo+I5RUo2/IWpO
         PHKRwxP+IcyFg2HwO6MdNCX8XCVXFvKTI8VTZ4KkROf9n1J7FaQBxTXwX4LR1drSJF7v
         7OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjNUgIYblg+sK68bz8yXT3BAS/9Dv0yaeblduHUUInw=;
        b=KGfTHv/HprBBy9WJaFyP2fKNOSLIEltIGjGqZIP9G05l2yF+k1wNdetIlCy/QjJeVo
         ursjG82vt3J0ka0vBsJtIjN0C335Lxq9u5xGnC3xLARef4RaG8OQJu8kSKW14+wo0iLD
         e8PC3DT30PgJAH3JIMKVcdGhliIfF6CswILElWSlfXVBA1cjzXeBQ5C6XgwYxGhMSvkC
         neMavjwsfKKRl59+4wPLI6V2SO/p+rDDsC5jwhQtoYI3U57XvS2xAYx14UbFI130TJO+
         1zh15oF0iqA0e2JwtuH2f4uq2Y+U42UaB2olU8nqATUR/4MEYxIiLJc9tha/39hsJcSK
         8ykQ==
X-Gm-Message-State: AOAM531hUssWa0pvKlcYaql7FUTNB8zGvUxawQMekYXjAuWTm2Zxe6ji
        E3qLO5Ur2gUT34ozzfcPjloQWM3haWPE9A==
X-Google-Smtp-Source: ABdhPJwZRAMMxWay48znTn70bOlvP3FjKobGquQetOpk6pE353ZOMuGKMxaNnOSvlPBtZBTD0f+IJg==
X-Received: by 2002:a05:600c:a41:: with SMTP id c1mr3775948wmq.109.1629986756771;
        Thu, 26 Aug 2021 07:05:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm2471987wms.33.2021.08.26.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:05:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] strvec: add a strvec_pushvec()
Date:   Thu, 26 Aug 2021 16:05:48 +0200
Message-Id: <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a strvec_pushvec() function to concatenate two "struct strvec *"
together, and modify code added in 50d89ad6542 (submodule: use
argv_array instead of hand-building arrays, 2012-09-01) to use it. In
a subsequent commit we'll gain another API user.

This could also have been named strvec_concat()[1], but I opted to
make its name consistent with the strbuf_addbuf() function instead. We
only name these sorts of functions *_concat() in one instance:
parse_options_concat().

1. http://lore.kernel.org/git/30620e13-4509-1905-7644-9962b6adf9c5@gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strvec.c    | 8 ++++++++
 strvec.h    | 7 +++++++
 submodule.c | 4 +---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/strvec.c b/strvec.c
index 61a76ce6cb9..54ed8427c13 100644
--- a/strvec.c
+++ b/strvec.c
@@ -56,6 +56,14 @@ void strvec_pushv(struct strvec *array, const char **items)
 		strvec_push(array, *items);
 }
 
+void strvec_pushvec(struct strvec *array, const struct strvec *items)
+{
+	int i;
+
+	for (i = 0; i < items->nr; i++)
+		strvec_push(array, items->v[i]);
+}
+
 void strvec_pop(struct strvec *array)
 {
 	if (!array->nr)
diff --git a/strvec.h b/strvec.h
index fdcad75b45b..9003bde2b7d 100644
--- a/strvec.h
+++ b/strvec.h
@@ -62,6 +62,13 @@ void strvec_pushl(struct strvec *, ...);
 /* Push a null-terminated array of strings onto the end of the array. */
 void strvec_pushv(struct strvec *, const char **);
 
+/**
+ * Push the contents of another "struct strvec *" onto the end of the
+ * array. Like strvec_pushv(), this is a convenience wrapper that
+ * calls strvec_push() in a loop.
+ */
+void strvec_pushvec(struct strvec *, const struct strvec *);
+
 /**
  * Remove the final element from the array. If there are no
  * elements in the array, do nothing.
diff --git a/submodule.c b/submodule.c
index 8e611fe1dbf..84b5f5dc0e0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1606,7 +1606,6 @@ int fetch_populated_submodules(struct repository *r,
 			       int default_option,
 			       int quiet, int max_parallel_jobs)
 {
-	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 
 	spf.r = r;
@@ -1622,8 +1621,7 @@ int fetch_populated_submodules(struct repository *r,
 		die(_("index file corrupt"));
 
 	strvec_push(&spf.args, "fetch");
-	for (i = 0; i < options->nr; i++)
-		strvec_push(&spf.args, options->v[i]);
+	strvec_pushvec(&spf.args, options);
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-- 
2.33.0.733.ga72a4f1c2e1

