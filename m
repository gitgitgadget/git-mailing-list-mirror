Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689B0209BA
	for <e@80x24.org>; Tue, 12 Sep 2017 17:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbdILRci (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 13:32:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38753 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdILRch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 13:32:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id q76so6478534pfq.5
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hvq5pF7xCOosWFP0RehknvhpA+QaNvTqacVD7pCEhMQ=;
        b=fTs3ZvbOAKrtob6uG3gOHpkqyg6Wy2xQvSBQaaEh5duMiK1NLFUwfLOUkLxp9m9qpE
         8daRh8fztM6kt20SHX1q5KCa7yi1/PYaN8wTeKMxoD/J+Q2i2b7RgmGyj6ikLn+U4kMv
         XXFxvNeSZWb/erRND28dYtlRyf3T+8uzNNzd9RlKdzR4qgF/kvxCbPnwW6P7WEvfPAPt
         orXMMaMxNps5WYQToe9KTTSTJK105Vu/vEojaMHJJpx+QDqiMpB+0nN+3Zpzz6nx/fT3
         mmlLo4jrfbxK+7KEO6xxF0dgE5WYwVueN4G89M8g2IXJibx2jPW7cvbmM3dbQD50/peq
         1diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hvq5pF7xCOosWFP0RehknvhpA+QaNvTqacVD7pCEhMQ=;
        b=inGqAiGPJxWVLvPxPx5jA4B8itT0f2u2NF4gSuu0fSJLjafLi7/yvzp8L2FyJdomwB
         R5uIpPruZks+ngHW0GkwZ90D7haS29agTaU5O9DAtMsYe1NyBRI9rckWLa8bjVAOjXab
         prowfbE50d1OCx3EhZbQaPgVQQmK0Tbf+/ENg3jTVOKFNN2drx90isUjUMHOSjc8UO8P
         mXN2UAAZAihsgTiLdI8TgG3UXrdipqb241AhIX5kwNs5e6ebaqm+2FkkY1MPIswI83qI
         ZKFcAzB7fP1m8DNLAw97kYCtilVVEXeDRZJCXcOIP7WXM49lCQwWNPSZQNBH3h4z9JHy
         Ik4Q==
X-Gm-Message-State: AHPjjUiSzogF7b7y+Lno6oTSYsrNCdDTVHm4vxOhfT/4djU7VD5DPaTR
        2rfuse67+3ksj8/WABc=
X-Google-Smtp-Source: ADKCNb5izNlPNIqzkdP1llalctE+UcQTp/q/2rfdncTBBYeIkY91Y24KMTJjXpiPSzLUblfXV9tF8g==
X-Received: by 10.98.32.86 with SMTP id g83mr15615804pfg.313.1505237556802;
        Tue, 12 Sep 2017 10:32:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9def:8161:22df:85ca])
        by smtp.gmail.com with ESMTPSA id x189sm20278332pfx.188.2017.09.12.10.32.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 10:32:36 -0700 (PDT)
Date:   Tue, 12 Sep 2017 10:32:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/4] packed refs: pass .git dir instead of packed-refs path
 to init_fn
Message-ID: <20170912173234.GE144745@aiede.mtv.corp.google.com>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912172330.GA144745@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The first argument of a ref_store_init_fn is documented to represent
the $GIT_DIR, not the path to the packed-refs file. This brings the
packed-refs store more in line with the usual ref store interface.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
That's the end of the series.  Thanks for reading.

 refs/files-backend.c  | 4 ++--
 refs/packed-backend.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fccbc24ac4..3b8e13a8b7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -57,8 +57,8 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	refs->gitdir = xstrdup(gitdir);
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
-	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
-	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
+	refs->packed_ref_store =
+			packed_ref_store_create(refs->gitcommondir, flags);
 	strbuf_release(&sb);
 
 	return ref_store;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 412c85034f..2c5db15279 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -78,7 +78,7 @@ struct packed_ref_store {
 	struct tempfile tempfile;
 };
 
-struct ref_store *packed_ref_store_create(const char *path,
+struct ref_store *packed_ref_store_create(const char *common_dir,
 					  unsigned int store_flags)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
@@ -87,7 +87,7 @@ struct ref_store *packed_ref_store_create(const char *path,
 	base_ref_store_init(ref_store, &refs_be_packed);
 	refs->store_flags = store_flags;
 
-	refs->path = xstrdup(path);
+	refs->path = xstrfmt("%s/packed-refs", common_dir);
 	return ref_store;
 }
 
-- 
2.14.1.690.gbb1197296e

