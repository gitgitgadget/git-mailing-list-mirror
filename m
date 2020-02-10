Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C230C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4309A20714
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAF+XoNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgBJOO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:14:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44309 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBJOOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:14:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so7876335wrx.11
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wNGDZz1ZqCpXmCvb0HnNmy909SX9mnqHH2KZdKl4tJY=;
        b=UAF+XoNKUgq7c6AZJeZ6EsvlDON3UeGzm6RRf6v649aGXfc1QRxrpBy8OUKAmTDhF8
         pGFreEO9/xoA4+A+ByCtS0bf737VfoXzYDbTd8W2m/u5C45y3nCiLjqKgTnwpNM0YdmG
         ObNuYBPVECVGs8FzcKu3+/pUBOoEQ0JVdrlBoeG4sdelH7g1HyXoJbPu+ioVFL4phTqO
         mcG0VeWDEX1bq0Cp99do7ifSpKM+SCqJfr7lkkpVH7XgoLBltSVesF5uQjP4w9U+vHpH
         DfEFSekl6YRuJKgF56aoUh1FJqmD9aOQSaEzWsQWpSNgFHlgh+596HuGU0eHZr33A+qp
         XDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wNGDZz1ZqCpXmCvb0HnNmy909SX9mnqHH2KZdKl4tJY=;
        b=QQMD61AOHE/sf8Mr1Pxs3bwRyL9oF0Ou9EN98Xzlht6jCyd2gQhx8PHHZNmu32Z4u2
         8aPia9qO5PY+YnFZh2oYGMPDjZ+7Z5oNSNhDNuZcvBtC1ZO4wqEGsBKyYsTUrEThxDmv
         /AXiBx2YaaQ09peiUOzOUqF3wvew9M58idB9TPtngFWCyA7dgNb7bWnFpd6ozKT8yCiy
         gThsqUaxh7wlEQrLCkV0OI1u6SsavOU32b9M2F9vqpuTwbKTyPyMBfPCXMVXcSzXiSaA
         Qofc1gZUizP4r88KYZj7iEhEcSrrV68k1rnkq89f3BdRiht89IUUs3eoNVwAx1aexClQ
         Bfjw==
X-Gm-Message-State: APjAAAVf4x3HNWV04nWmQtDrLeXiY4VHXrAQuTcb3lPfk8lG40dOsPQC
        mtC8WhqOGbVxAkYO58Q8PpzVH2D1
X-Google-Smtp-Source: APXvYqxnmmcwhwZVMECkbkSjnTJgA9fsECPf/FUBK3h8/FLqVs8vTTClbhrWPl37pC/Np16tpoaKMA==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr2153819wrx.330.1581344063948;
        Mon, 10 Feb 2020 06:14:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm719805wrq.31.2020.02.10.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:14:23 -0800 (PST)
Message-Id: <fbdcdccc885bbd0e4f6607d1aa9cb31ec863bd29.1581344060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
References: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
        <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:14:18 +0000
Subject: [PATCH v5 3/5] refs: document how ref_iterator_advance_fn should
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
index ff2436c0fb..1d7a485220 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also dereference
+ * the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

