Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A649C4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2938324653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlZtIyL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBZItx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:49:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36062 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBZItw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 03:49:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so2805162edp.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=KlZtIyL/AdlOkvcfUSPnRLdypcpHIfKk6p+HppfXV78O6CyDBElgOu8mwv6rSny0u8
         GKnlARj5lBBoFIiPtR9igYIWTKSRnh2VLhBUwv1aqXiR4wYrA5ICR9bHpRHpdN0NZqpg
         BqBiZWOLmenpQTJo8gzlcqeNwaYYq7L1Ut/1Dnrgo+1iqwKGFubkX8mgdJsiG+MCZiJO
         RFm7cm31NClcy4r3QmLOK9BgGtZVb87IU9y/XK5K7uTTtRKzaHx+mZrHqOYanVh/Se32
         hZkpmqHvAOF5eBUDd3EhHfqmq38SZbOBevHWE017tZ0bCAilr8LRe2s0EzpgxVsDVHYU
         2PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=JSz2KbfxxRufqP2TZ2sa7nIjM7wKNfWZZqQHREPA998akE4FRx+tgd+24uFz0Cqu7J
         2EleFe6fEQYfGjGRO6Ug6NMwNRABEp1aDZBw8zV/lXzOVE6rV//sPd8VcfF+a8/Ezgm/
         EJDB8DVKWq7giVGCIdBQE8Jb2twIiG/dYkKG2Lbb+gPpv8Eo3bjM5PQLlvvIP50+4ED7
         GNVOvK2ZXfKhoQIdxvIFi7InX7Mb6ev5ZDtJ5d1mI5aBDFJacc1sOX6BIgTpUr9srQey
         hPcMiRzphSL3aOB/txhodN7c2Y9YwubA+rdMXE/cIYgQq7qbxQE2MdNW+yLf2IDApIFh
         6z8Q==
X-Gm-Message-State: APjAAAUya60SHp9w1NVJcU/zoZgYHH+yGHZ3BxKoD2LldHG0yReVW+Ih
        2U5up7Qspuap8/G6oZo2jFFPPzZP
X-Google-Smtp-Source: APXvYqx885BIwm7x80yJbqfx80DmEUqeGDQ0dJlyzXAEnxjIYbecHI0C44fbUH/XdyUsDO4J3inF1w==
X-Received: by 2002:aa7:dad2:: with SMTP id x18mr3110402eds.384.1582706990820;
        Wed, 26 Feb 2020 00:49:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm59537edq.45.2020.02.26.00.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:49:50 -0800 (PST)
Message-Id: <da538ef7421a71adfb65e7a9b916070875c6cda4.1582706986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 08:49:43 +0000
Subject: [PATCH v7 3/6] refs: document how ref_iterator_advance_fn should
 handle symrefs
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
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb7..3490aac3a40 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also
+ * dereference the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

