Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E30C47253
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CF520774
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JdXqBVvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD3Tsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Tsu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:48:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8CC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so1287051pje.5
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7dkz/Jd0fjk6gIBT8np814V6zRlWTh2MCX37MDQT3EM=;
        b=JdXqBVvfyJ3HKTKjvD7OLNHZDpZ4/Ft5aH0qjhr1yswQnJE6cRk/sDlm0kDq6zv/hy
         25IxwuF2P4HM6zHwJ5/inXzsh+QDpaZn4AVakIxYx26aeSvc5LT6JGUbcbG9SVK56rlg
         pp+ZQQ4NoTWLobmO0qyKcamYjYQsBHKSWHASzeIpISfGPc8jsygyAlnQFYOlWewxJpff
         TI3wxgmOOJNDu6lo5JlEg61/2dWouOqpRvnAPq/ER6igrXSSE2Cnxi0rg4HFxxTxwx7E
         xzKSlb7V+wZhQuC+uOo71NoC8uncYA4Y2DB47lvZb2C7IvPjDCaTI/BQkkfDihgYAJKk
         FV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dkz/Jd0fjk6gIBT8np814V6zRlWTh2MCX37MDQT3EM=;
        b=MOllsYU8kKdMYYQr7+gL2NE+4m1kItmgpwFkGjRNa6OAzBVNg9oUAtvh2RJX+2KtLT
         nw7Du6Ed7MndMK2sGsU1SXcHeYvzis8iXRxXwJif3f+DfUPMkEgvc7unYlnoIoE5pEHq
         a1G9LiMqtNaCBWysFCEYq4ttu4XD7V1tOMyxNHDXqTzrd+2R99kzq1dETI6mGKisrR2k
         XDMg5r7n88P4z9aEaKgYke1j7gY2r+J2bGQye2CXWs9iZvf5ZI0AA9d8YLp2shPlRIXd
         w+17t6LSFY7XS5MVmZ+Q03UmxAti7rrFz2TjKzqXdGNHwZr/Rurw92L6/CqkYQLazaRA
         KT8Q==
X-Gm-Message-State: AGi0PuYFP2skwfu3ZPTbOKbjqhMdtoyw77v982Cqc3HvHVXnl3+Pz1y0
        brEZRBiCPi8y1Pncl5ByW85BGlyn6PT/Ow==
X-Google-Smtp-Source: APiQypLnsUxj/t/qCfpaY6qKxoqVjpxn6jrQ9IQO++8Bvu3LXGobmaSMYkyz/pMTh6IAbKww/RHXvA==
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr591280pls.69.1588276129175;
        Thu, 30 Apr 2020 12:48:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u9sm479752pfn.197.2020.04.30.12.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:48:48 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:48:47 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 1/4] commit: make 'commit_graft_pos' non-static
Message-ID: <cb8dde2ae2e78d0bcfb61382fe7769c12804336b.1588275891.git.me@ttaylorr.com>
References: <cover.1588275891.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588275891.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, some functions will be moved from 'commit.c' to have
prototypes in a new 'shallow.h' and their implementations in
'shallow.c'.

Three functions in 'commit.c' use 'commit_graft_pos()' (they are
'register_commit_graft()', 'lookup_commit_graft()', and
'unregister_shallow()'). The first two of these will stay in 'commit.c',
but the latter will move to 'shallow.c', and thus needs
'commit_graft_pos' to be non-static.

Prepare for that by making 'commit_graft_pos' non-static so that it can
be called from both 'commit.c' and 'shallow.c'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c | 2 +-
 commit.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index c7099daeac..b76f7d72be 100644
--- a/commit.c
+++ b/commit.c
@@ -110,7 +110,7 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
+int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
 	return sha1_pos(sha1, r->parsed_objects->grafts,
 			r->parsed_objects->grafts_nr,
diff --git a/commit.h b/commit.h
index ab91d21131..eb42e8b6d2 100644
--- a/commit.h
+++ b/commit.h
@@ -236,6 +236,7 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
+int commit_graft_pos(struct repository *r, const unsigned char *sha1);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
-- 
2.26.0.113.ge9739cdccc

