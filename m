Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C37C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82220207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt7f9lsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHSPPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgHSPPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:15:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9430C061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f18so1879092wmc.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yZIvkey6Uj4REB4QipV6iY4qH4NvmcwxVFGQ4lFzb+o=;
        b=Qt7f9lscPkZpwUtNgwjhrPOz5JEmMg0ic1GRL906zmZy4wNHqzpRjNxl+WdUHwlwHd
         Oodzo4+n3QngKTFh58fXRL6il3LAB/S4RZfZKQwqqJPf//9doHuzqtW8RenMb5dGWNbb
         qIoLvGnVqP/ctZdocwDuOK7pCMy5jrdyvbRwefog94khGk3Pg+8TniPd0Ok/6TLD2z6j
         mVY6dheH1JWrNjGM0lyfLjJTlM5T2DVcxcWUn+4V1ZZ8xTbcPbsAWkBdmQ+Q/+CiOEea
         RCCU8x9nY/i1h6Yx5PdVbFZ/AT6mztTIkyhAHhSz+idqghvr06wWgoW5i0iB2LSyh3uI
         wvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yZIvkey6Uj4REB4QipV6iY4qH4NvmcwxVFGQ4lFzb+o=;
        b=pEHhdyjmwldWsU+9PvWCa1/j/2FCguEHM/m/Dt3sA80CFgS3qvKOiD4HArVlS/mw6p
         2O8CYkeOKqY+kZfH30e9JrCXhrLN8Nre++wkLdNYVQstpvAA8Og1jw0UjuRaaAQKPLOn
         66ZeRwLO+NsfdNRqMxeFsQI81vxuzecUpNYefR4on50DZgui7qFEAiD80+Yvsp5AJU33
         jzL4EpAtqE9kWQ4kcAiN2tudEzL2dih9Pyh6ZHLGzhlK75Kf6ggmnpMcc1+UL5yaMaTd
         6WU8VwWLB5DDaRGt3bYw1Rgp5jYQxOdgBh8CkVjgqi23A31B03YO1gy2Fo8sH+k+dLgq
         y71Q==
X-Gm-Message-State: AOAM533QlC0xTF1UmqwomrVbYmMqsxHWqlCNxc7Tvuh4uZXHAv3b3m8G
        cenHP154W3gJ05/yvs/h62qJQbtSFvQ=
X-Google-Smtp-Source: ABdhPJxZgxl0y3OJSA/Upmb9xP/l0lu2TzvDSwsiAwOjxJ9ZdGjyhpK0gxxE6tssbmah4hF4yn3pjw==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr5223889wmf.47.1597850132199;
        Wed, 19 Aug 2020 08:15:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 33sm42670172wri.16.2020.08.19.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:15:31 -0700 (PDT)
Message-Id: <a8467a0d66d1291970a182f4dcad77dca1a0f196.1597850128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 15:15:24 +0000
Subject: [PATCH v2 1/4] refs: make refs_ref_exists public
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

This will be necessary to replace file existence checks for pseudorefs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 2 +-
 refs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cf91711968..d46080f4b6 100644
--- a/refs.c
+++ b/refs.c
@@ -313,7 +313,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 29e28124cd..04bd25019f 100644
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

