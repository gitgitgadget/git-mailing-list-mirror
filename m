Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E22C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F98D2076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dhgXwc4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgD2Wjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wjp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:39:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD1C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q124so1720699pgq.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8WTa9ZPG8ytkvnScnokmDHf+KiHubFgFeKynQGhi0zk=;
        b=dhgXwc4EcAtMdVF8hJHk1wBGpoeq34xDtF0ukQ4IF49gUcl/6OWCbfhvpkm7ptTlBO
         bbqLifF+oVfTlBsBoscIMY+74pwWwUCZKLruk95cpsDhx2VU1Vds1ErtCTWjaR7h2ZoK
         XkGImn8PoeOmGyGVB8cG2ITHRAesZeeOnQWBwqW32t2c3vD24h2TNO/fVKr9BD0VwoMT
         Jvz3np2huYVZoBnEgMUrqhQfbHnOtV9ANT7MGay9qyENywIZw6nGu1Sl+zoiSAoe2AFj
         T7IhlrtNCYU2trWd5rCEEA6N+Hwz8ORy7/AURN8hH0y2UPiR7sNg8apqh1AYO1tLvx6U
         JOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8WTa9ZPG8ytkvnScnokmDHf+KiHubFgFeKynQGhi0zk=;
        b=hbz/bKhg/+EpH1ty3j/ApGWT3sPUS+vrAIINlWM12VEZhycid1ZXUlPOYc/tPnXgO9
         qot0PFFRohTtjmV9PEAh4wyuqORSLK3uXkpbzLbps1qCu778PKBEMvjst8I7fsLg4QSc
         LbHlQ5q9GEoCp4aWHsDbwoEl692PItSh90O7eUIg3L7e9YwfVPGon49N/i6UGYAYjcAM
         K1oQ4ZIqn1/0zMHYBUte/HOxkkuOBKaswN+9fS1uyqJ8wQ+VZ3c8mnsxzLuT7BV14V2c
         KWg2c46sRThAxWgecEtVL03hTJdj/KzreEQIRdFwkMj24GaSSgp8I+uS24aj8aUGCMwH
         cK+A==
X-Gm-Message-State: AGi0Pub6rU2Dy10H50Q1OQRu3F8006xmJR02AI9Pkan8mzjvI1N45V5n
        NZEdJkHO6wo1eiqRsKFt6/ZWdA1Sg+dt+w2h
X-Google-Smtp-Source: APiQypJdKEMgTUNZB4qgUN3TxquHLqYMovUlPv11mu/9kETbO1shjwu83Nqj9jUHRNdMfdWV9n/D/A==
X-Received: by 2002:a62:7c16:: with SMTP id x22mr343346pfc.267.1588199983823;
        Wed, 29 Apr 2020 15:39:43 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y25sm1767339pgc.36.2020.04.29.15.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:39:43 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:39:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH 4/5] shallow.h: document '{commit,rollback}_shallow_file'
Message-ID: <7828def924a767e54dd43b6c107e8f98c1698f55.1588199705.git.me@ttaylorr.com>
References: <cover.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'commit_shallow_file()' and 'rollback_shallow_file()' were
introduced, they did not have an documenting comment, when they could
have benefited from one.

Add a brief note about what these functions do, and make a special note
that they reset stat-validity checks.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 shallow.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/shallow.h b/shallow.h
index b50a85ed7e..08e1bc4fd0 100644
--- a/shallow.h
+++ b/shallow.h
@@ -10,6 +10,10 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
 int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
+/*
+ * {commit,rollback}_shallow_file commits or performs a rollback to the
+ * '.git/shallow' file, respectively, and resets stat-validity checks.
+ */
 int commit_shallow_file(struct repository *r, struct lock_file *lk);
 void rollback_shallow_file(struct repository *r, struct lock_file *lk);
 
-- 
2.26.0.113.ge9739cdccc

