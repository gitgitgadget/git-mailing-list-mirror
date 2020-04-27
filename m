Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7FEC4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118CF206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky5o2e5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD0UUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbgD0UUe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411DC03C1A7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so344595wmg.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3QrGAKOTt6oEYQBjtcS3f4Tw4e704uDTLvMTO0JFXgk=;
        b=Ky5o2e5zPkhZ0IzQ6TKnbgOrRd7Sf6iZNg+3Gl4JOYkfDfkmZQr8WwstmbB+k70RdB
         0GG8v1lJMTZiJLLHmlMGNUWpkeY8YVXzl6VSb6RSLDjg6rT6H20PM8n+eXn+b60IKuzc
         B65YXDAluKZk1voqVXC6qhU15y9fpk1kP7DAVZouxGrQBfnEM+S1nqOzYTtcPp152qj/
         NgO2EzZ+TUZv9o3L8oTd9XBIhTQkgWlc+zFd2YJp+mfiAduKbzbTGKrza+tXM+dum3Mt
         1Za0hqDBNI1I05splzmZ2wn51QG28Ne8QJQP2LhGG8hKgPmx6lt03CMqNx65u4mNoEW/
         NbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3QrGAKOTt6oEYQBjtcS3f4Tw4e704uDTLvMTO0JFXgk=;
        b=sbfZMlNeAFtEMztIUVL4SwKfs16SAA51FgLAtgUdn6qCflUGTPf7W8lO2qpKdFdlIu
         hlSUW1GaxorcN/Pqd8Xha7lPU9e8fEIqgR/8GxhNTThslkOIjdiYOnUnFwFEvCfxObDu
         7JkLj3gx3grN9v7v+7b7kpz40Tb+oweXtyS2E3pNXc7N1ii28gGeprVBPl7kWBIzY8e2
         K1uDUYnyzxIObmEdyD0NasItGYf3rSaIMUJbpczoeNV638rpYOJk5aH0v5HesyMtc1tf
         tmCoMrr+Iwku/UtVcR+xwTIJsf4evHqrCTw0g927znAtp6qkqStt1CgqapvCpV+5JNVG
         H/uQ==
X-Gm-Message-State: AGi0PuZS8MNTLvomiut8cxO6HwZn1pAWihT8j2lWJ9V/bX6MovwQQouJ
        ji6iZt477vi3EIZNCkGmfJ+qnV9A
X-Google-Smtp-Source: APiQypLjIW//IdgRe+6b6KELUqFSVKRZ6Xf7PCr1vOpxSErjniLQFb9KyK57JUjHakfgSXfZxJRPNg==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr424230wma.91.1588018421575;
        Mon, 27 Apr 2020 13:13:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm22471076wrv.42.2020.04.27.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:41 -0700 (PDT)
Message-Id: <45fd65f72e097dcabba6ea15b1d54c85e7271593.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:28 +0000
Subject: [PATCH v10 02/12] Iterate over the "refs/" namespace in
 for_each_[raw]ref
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

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index b8759116cd0..05e05579408 100644
--- a/refs.c
+++ b/refs.c
@@ -1569,7 +1569,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1629,8 +1629,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget

