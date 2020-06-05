Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BBC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A73B2077D
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppfdtuq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFESD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFESDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2BC08C5C3
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so9226800wmh.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=ppfdtuq3IHDx2Xm59i1Y2y5PaG2mbiLdkWk8r/EYsYG6KVlUXnN9uwlv52R8+xy9yy
         ZJcb1sHL4KIzX/Oo2htAihwtJ6eo64v48JdQY9bC1/+T0kVhqLNJHBHlhDUGilHjIW/+
         CNVL5hOcCJ1hQcQKrTGLwA1wLCnK1W2lCb66PlyQQgZrzMYcuMUstzR2IANuvwWY/lHF
         I5qq9+1OS45KVDauliXDZVdbKJq6HdQjzz9yxt9TlsB6GwShHcH05SN/JMYhO6r9BCP3
         h/SJbNubqsSRuxlHm7VSifMVXmrojY7FLAcL5xr6Wm8Hzw7yVTjV26Ci52/dBfFRC1Ex
         VNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=IbB+JpdGCEdSqpr4KNu7bYWhiwI2C6j7IRQnC3uVN8DL6T+7WhAJZfgaGY/kirI5uj
         T3/Vj72pJ29ch5zWJ5ZJTAm0Mcf+unwtswLMh8DfIfbaQtQVbt/yljvm5NzSKGuDglJq
         nEmsc4x8je85+S3cPxAOL7tj8DIggMhEJ/0L04hv2ywTEirxVt+WcRhCZU3TfPIGBVwM
         AcPtDhdYrCbFdlFhywprFUWeVXCdQsbGdRVjpy/wzIN4ohPXUWeufKu9AdqNlE4EFN3I
         1HXRVnGIYa3dNRUjj1XRK3UIbcayQKeo6gcg9fFMuK8Y/eJR7EW+jXiMCuziEDkplMxb
         /hkw==
X-Gm-Message-State: AOAM5316rp3oh1tCBvE9O1/7var15OPnxOngE0T3WUXz7HnS1+oUxreF
        z5n0HCNeFby1YLlrGBw+aO8gK+Eh
X-Google-Smtp-Source: ABdhPJzvwxrqfHsEknm2S/djzWTLidqVUW01rGDreDz4loiWkyuTvkiiNnCLCik+gjVW7X9A4/NC2Q==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr3634044wmc.167.1591380203900;
        Fri, 05 Jun 2020 11:03:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm12689995wrm.35.2020.06.05.11.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:23 -0700 (PDT)
Message-Id: <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:06 +0000
Subject: [PATCH v16 02/14] Make refs_ref_exists public
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 2 +-
 refs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 12908066b13..812fee47108 100644
--- a/refs.c
+++ b/refs.c
@@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 4dad8f24914..7aaa1226551 100644
--- a/refs.h
+++ b/refs.h
@@ -105,6 +105,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const struct string_list *skip,
 				  struct strbuf *err);
 
+int refs_ref_exists(struct ref_store *refs, const char *refname);
+
 int ref_exists(const char *refname);
 
 int should_autocreate_reflog(const char *refname);
-- 
gitgitgadget

