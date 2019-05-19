Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4E01F461
	for <e@80x24.org>; Sun, 19 May 2019 18:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfESSRw (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 14:17:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35847 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfESSRv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 14:17:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so6092072pfa.3
        for <git@vger.kernel.org>; Sun, 19 May 2019 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IumjM1x2qvOt2HByNovxy9FPzTW0HVZ1EzYQN3z4Ljw=;
        b=cXZiDWqoWBGx673bb2WrtduCNYwmVlcaNkUCF4OtJGLN78sxtc4Hmq3vCkyx92dxUB
         DHrv/ZWMIGjmwYtPiHu0r4ok4jnxiGfj9wdsr3rB5TtmeTqtmOYpKGgmbm1P/VeZjajE
         KQfkblttjgepwIIIPBerJy44Sje77K2ps8UGAKGJNsIG7Ip1IPLBv0LiGBv6dmGm+b5Y
         xsSw/2ub0zc8KLKJCbPjCqKvkn7VU+CZb8ct7HJ15nLGi1+k8FqTfYCcslSpXJCXpeas
         f/aFqFANpXnVHw9ztWXbZ/97F4/8Q5gnYI7FD7639SexCH1oSpFrM1oTET/9SMOZV9p8
         Lw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IumjM1x2qvOt2HByNovxy9FPzTW0HVZ1EzYQN3z4Ljw=;
        b=JygpTapl7Gce9zgblxYC3QcHKTk9jFi0uVfa4UYGcPHpozzoumRwkrPH+/qMh+Fz/6
         eobYJfnzvZhVFBFL8MzYp+yyrlzP4fJ/FiUE4z0luJR/SZeRe0Lh3i5vK8dl9GnTrnCA
         9ow4+LwfbdXYx9R/WvMK+hB6VcAud8PHXEAmtjIuXFtbNbOQCdm4b5tI5w0n7FQ8G2sI
         0afVFbO1RzswD6ILNKoGS446lnuAp4Zv/u4IEwFrQZhh8YlE9HifMbpO7XTM9JLKZJht
         Ftpuw4NVZUsTrtiokO5MxavxPYp0xwJCBwuvCH6n/8xWi6rz9D8m0Oe3lZX7oQyJzI/c
         o0QA==
X-Gm-Message-State: APjAAAVcbxmUALJhYP/vX81vmgIitoR3Kw5mj8RdkjxFN7LYyc7SKla3
        Fitp+u+QUrI667qm/GYUga/QKLjC
X-Google-Smtp-Source: APXvYqw8qjHQaSOSF99mmArBBAYR2o4GhZ+3SQuW5iNhiiI1zBTCqeLZsb/Rf5cV38TVrduZcyayMA==
X-Received: by 2002:a63:da14:: with SMTP id c20mr6223344pgh.191.1558234619039;
        Sat, 18 May 2019 19:56:59 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id 194sm22413457pfb.125.2019.05.18.19.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 19:56:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 19 May 2019 09:56:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     gitster@pobox.com
Cc:     ao2@ao2.it, e@80x24.org, git@vger.kernel.org, pclouds@gmail.com,
        peff@peff.net
Subject: [PATCH] repository.c: always allocate 'index' at repo init time
Date:   Sun, 19 May 2019 09:56:36 +0700
Message-Id: <20190519025636.24819-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com>
References: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two ways a 'struct repository' could be initialized before
using: via initialize_the_repository() and repo_init().

The first way always initializes 'index' field because that's how it is
before the introduction of 'struct repository'. Back then 'the_index' is
always available (even if not loaded). The second way however leaves
'index' NULL and relies on repo_read_index() to allocate it on demand.

The problem with the second way is that, the majority of our code base
was written with 'the_index' (i.e. the first way) in mind, where
dereferencing 'the_index' (or the 'index' field now) is always
safe.

The second way breaks this assumption. The 'index' field can be NULL
until loading from disk, which could lead to segfaults like
581d2fd9f2 (get_oid: handle NULL repo->index, 2019-05-14).

We have two options to handle this: either we audit the entire code
base, adding 'is index NULL' when needed, or we make sure 'index' is
never NULL to begin with.

This patch goes with the second option, making sure that 'index' is
always allocated after initialization. It's less effort than the first
one, and also safer because you could still miss things during the code
audit. The extra allocation cost is not a real concern.

The 'index' field is still freed and reset to NULL in repo_clear(). But
after that call, a lot more is missing in 'repo' and it can never be
used again without going through reinitialization phase. So it should be
fine.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 3 ++-
 repository.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 682c239fe3..ca58692504 100644
--- a/repository.c
+++ b/repository.c
@@ -160,6 +160,7 @@ int repo_init(struct repository *repo,
 	struct repository_format format = REPOSITORY_FORMAT_INIT;
 	memset(repo, 0, sizeof(*repo));
 
+	repo->index = xcalloc(1, sizeof(*repo->index));
 	repo->objects = raw_object_store_new();
 	repo->parsed_objects = parsed_object_pool_new();
 
@@ -262,7 +263,7 @@ void repo_clear(struct repository *repo)
 int repo_read_index(struct repository *repo)
 {
 	if (!repo->index)
-		repo->index = xcalloc(1, sizeof(*repo->index));
+		BUG("the repo hasn't been setup");
 
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
diff --git a/repository.h b/repository.h
index 4fb6a5885f..75c4f68b22 100644
--- a/repository.h
+++ b/repository.h
@@ -85,6 +85,7 @@ struct repository {
 
 	/*
 	 * Repository's in-memory index.
+	 * Cannot be NULL after initialization.
 	 * 'repo_read_index()' can be used to populate 'index'.
 	 */
 	struct index_state *index;
@@ -132,6 +133,9 @@ struct submodule;
 int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
 			const struct submodule *sub);
+/*
+ * Release all resources in 'repo'. 'repo' cannot be used again.
+ */
 void repo_clear(struct repository *repo);
 
 /*
-- 
2.22.0.rc0.322.g2b0371e29a

