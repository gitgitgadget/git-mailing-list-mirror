Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376DBC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152E72245C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay32JLNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbgGaP1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgGaP11 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC1C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f7so28398717wrw.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lOv6JBMEgYBWiAO4R5yNRRwbcbC9yLGP8K51ZZZUzgw=;
        b=Ay32JLNbvYIAVhcMB/yfb/ymHx5lPjPQgFEesOHTNDcemq8PBb1UJP4R7Z7Pk9QgpP
         UdNi5BLBhTnY2wdzwD7HU9vKhnb6KuYW4J+jEBcqbGuQQGwQJ1Ixp1mxq0R6F1VE0GDo
         PiUFYUsEqZR6t/YWQqppysXPUkhMeMKX3oU2qdplowqzPo3tOBqUnbOzFU1/+oRvG2hG
         hn4v8xydAGddJwrz5jpOpe0Jj3KSSnLP2I/Uj4V4XqvKqzyPSCsUKVtjMMvrrJ54HXsI
         7VFohMm7OkM8ZIT+Cct6h0u0tQKVQ+sgLz//c+7KyB79UQXv+Y0vlnkCleEnIABOmkS4
         rbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lOv6JBMEgYBWiAO4R5yNRRwbcbC9yLGP8K51ZZZUzgw=;
        b=Cvtn3yoJv/yvab39keMoiTVUQ9KVYA5PNNLOnKzH5f53QXaPtTZ93pKz5A6hpt0Btf
         RIaIubketNvjjwwhePsYyIl01zEaLc5gNrxsipSLqZoUBCDa+Tgn8wNVhXzbAIRSvlz4
         8cmfu4mzB6iElD/el0VHt4bd/H9qD4ctBGsWh3Z9JGVEp+NIWt+hVI01vZdWgr18muAF
         GzXG1ebhY3cRUxUdZruA9v4LB8bWal/uwx2kOy0xZsVfRsaHKlOJ+RxK5OwyrZ8XUUbT
         Jts0nE629l9ACaJotDKD1iEbKDbvmLb9AlQdsgr0oUHdAcA1amTWo2Vq5KF0ll1TehMl
         9jRg==
X-Gm-Message-State: AOAM531t5QW8fsDpz50y9gtIxXt3MBwnhS5UTK9deuR9TfkQXl3BRtkD
        2cOnvk2HwHkIUa3Xxx+CrspmgmpN
X-Google-Smtp-Source: ABdhPJxP4VD/Zl/zJHOcU594WC/BnaCAs9klJlkt6hPe4JC7sZRYD0b/m+N64Ozqq8L01CyHB4ybpQ==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr3752478wrv.427.1596209245674;
        Fri, 31 Jul 2020 08:27:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm14037197wrg.96.2020.07.31.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:25 -0700 (PDT)
Message-Id: <d33ea20fbaadd86f4cb991b26a995129d7c9038d.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:02 +0000
Subject: [PATCH v20 06/21] Make refs_ref_exists public
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
index 947b51f781..5e65e79f24 100644
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
index f212f8945e..f8835f0aef 100644
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

