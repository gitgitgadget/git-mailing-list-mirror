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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDAC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A91C61090
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhDSLic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259FC061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k26so17234116wrc.8
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4SiXyNpOjEtT6sBNsSol0EteBZINGMXJ2tIBM05TJ3U=;
        b=L7NzbF+rJQUKB1WMiTcpWdthv5raACD6CFtozWXslEuQGE3s5Nj0frg8Eqx3upVzT6
         o3/hIp8tKfIkks/29Eeag76u/C+Xdx5a4Cv+SpWvysL4cxoG0xIyG2O1T6vhUeLgbaIv
         tgoYl/1+XcLCrvB1F486EUx/RTjp6EsqPReyA0dUx9JSBlCWW9lMT7T+kqsAFz/XoR3+
         3g979/hnR4wTYIfwlseFvTVrkMjLZGBfjuQv9bSxJDbPS0oFJLIpFr8t1ULsBPl5uLGv
         dlwUWfH8UNoa4pOeQD8loMKBhMYTzSs53/exOfYKZjdZv5XSFlJjfqOo0dT6nPhC23aq
         crTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4SiXyNpOjEtT6sBNsSol0EteBZINGMXJ2tIBM05TJ3U=;
        b=m2n0tLTnVB22Cp/lpuHg9MbJjSnjQLOAZ8vagwkK8i15TR0sozzIFxPrC/GD4ND/0T
         5YguovmLbDbh9FgA77NrBkDcoAjLYZ+s8O4XhQ09cLUCR3tntqfb56BFNZnGdsO0FedX
         DgcDKJhY7ZwndEfTrOCy1A2FJ9B7T2411KksQQZf9MjfDKrOe1RYlpgZduj8GEuE9o8U
         pZQBSARzK31oMxwW7C9f09EVACwResjLBL9lHHJbmjwIrFmaHMvtei55xGIdyMJd5n3q
         el9KiPSVVIDbIevOwjntm3O03uhcb7nxuB8Jpc1pEUo2ms6IZbdtb99DJQoIABTLub9D
         L6wA==
X-Gm-Message-State: AOAM532Icn1vRSP22UTusxU+utc5YLyJBfLl0r7nXxTFcLm67cDyu8v5
        6qlUIw65qg+Wpt0ghXAz98FZs0lDtr8=
X-Google-Smtp-Source: ABdhPJwshINs0Ctg1hzHhy5B0yhuW5+aBFKzGQXtyyCG6u077V545ciJqrO0cGuIpP8/+3LjNoohiA==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr13461438wrn.178.1618832279984;
        Mon, 19 Apr 2021 04:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm2983351wrg.80.2021.04.19.04.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:37:59 -0700 (PDT)
Message-Id: <8103a80394aefdd4e8b5061dfbb6a6199fe5fcae.1618832276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:29 +0000
Subject: [PATCH v7 01/28] refs: ref_iterator_peel returns boolean, rather than
 peel_status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Before, the cached ref_iterator would return peel_object() output directly. This
led to spurious differences in the GIT_TRACE_REFS output, depending on the ref
storage backend active.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c               | 2 +-
 refs/ref-cache.c     | 2 +-
 refs/refs-internal.h | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 261fd82beb98..8873854a44fb 100644
--- a/refs.c
+++ b/refs.c
@@ -2010,7 +2010,7 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	     oideq(current_ref_iter->oid, base)))
 		return ref_iterator_peel(current_ref_iter, peeled);
 
-	return peel_object(base, peeled);
+	return !!peel_object(base, peeled);
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 46f1e5428433..703a12959e1f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -491,7 +491,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	return peel_object(ref_iterator->oid, peeled);
+	return !!peel_object(ref_iterator->oid, peeled);
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..546a6b965dcc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -453,6 +453,9 @@ void base_ref_iterator_free(struct ref_iterator *iter);
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
+/*
+ * Peels the current ref, returning 0 for success.
+ */
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
 				 struct object_id *peeled);
 
-- 
gitgitgadget

