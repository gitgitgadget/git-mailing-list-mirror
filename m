Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74982023D
	for <e@80x24.org>; Fri,  3 Mar 2017 06:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdCCG6B (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 01:58:01 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35317 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdCCG6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 01:58:00 -0500
Received: by mail-pg0-f46.google.com with SMTP id b129so40934762pgc.2
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 22:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OigmWKAocfoC/k17ilr73h2WmcCIYXfq8JhXVJFf7ho=;
        b=Lg8jFwlhjBW7e5pYy9gz3I3v+UnUHNQEfZbJzsSsBoYuHpBFtckLbmEQOqQgjZPyVX
         RW8BaAKcP80oGaCmdb5NfEcjb3gqU6VCFjI0iFaq+OjY2sivCC3VvUA26Nfk2oxd7RNL
         8JvaVb4zBXnu3G9ae26o+g+khT7XgWgp1KgBGIoIHTpJsUCHfE5+dbi3ZDzs93DawNlw
         h2nNYMQiPvQtVS/n91CNoc0/wmkhIAGdw5/kGPX257aNPeKDZUoJPCNbYZ6tHtv0zxEB
         uLgXT6MpNW+lT7j8OFJbsBC5zBxZ/vTLiZdTEndpR9VrQLGGVfTsGbEgpmiYaPOHDasu
         HJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OigmWKAocfoC/k17ilr73h2WmcCIYXfq8JhXVJFf7ho=;
        b=SrPjZjPxTedlXQpsTZTHbRuMybz4nAGkwnr26UMsTi9k8ysye0EzXamtb2GwnamMYw
         WT2bbnFV7McVhNolHpjRyVjDufAkIGQXMSmKEGeH3cMUBM+86pM1foNLYOELF6YwF5/Z
         ecXt/6Gsy4cx1IMyJ4MzJRmANZT6mWZgqYhBcA86tThnKbp1OnSDbVYHbXuQmwjYAIEG
         KUrcxbFJekB+vQ1DGO/JYV/esFnBvY8+j7XD09oTpP1YUvu2OD+v0Oz6MesrmNUlqG6j
         MykswdQsqpEQ8gIkIkQU02shnXr2A4tF4yqEPiKADiFWKmDHfG3ZgIMncBIwVfmrEfxL
         Ttow==
X-Gm-Message-State: AMke39lnlxa7yYg9yV7gPlqi/iqcFbtLxbKT+YFLCiUjA9q6/Jus3/NS2tLYoRiR/qnMOy+8
X-Received: by 10.99.117.85 with SMTP id f21mr17509880pgn.62.1488484251734;
        Thu, 02 Mar 2017 11:50:51 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id l188sm18667575pfl.28.2017.03.02.11.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 11:50:51 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH] t/perf: export variable used in other blocks
Date:   Thu,  2 Mar 2017 11:50:41 -0800
Message-Id: <20170302195041.1699-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.0.rc1.440.g5b76565f74-goog
In-Reply-To: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
References: <20170228221236.selqkf5wme3fvued@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In p0001, a variable was created in a test_expect_success block to be
used in later test_perf blocks, but was not exported. This caused the
variable to not appear in those blocks (this can be verified by writing
'test -n "$commit"' in those blocks), resulting in a slightly different
invocation than what was intended. Export that variable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Performance indeed does drop significantly with this patch. And I cannot
say "at least this is more correct", because it isn't - as Peff thinks,
it is indeed still not 100% accurate because of the resurfacing-object
issue he mentions (I've verified this by constructing a test that fails
even after this patch set).

Also, since we don't want to unify tree_ and blob_ (for the reason Peff
mentioned in another e-mail), feel free to drop this patch set.

Having said that, while looking at the perf test, I noticed an issue
with a non-exported variable, which is corrected in this patch.

 t/perf/p0001-rev-list.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
index 16359d51a..ebf172401 100755
--- a/t/perf/p0001-rev-list.sh
+++ b/t/perf/p0001-rev-list.sh
@@ -15,7 +15,8 @@ test_perf 'rev-list --all --objects' '
 '
 
 test_expect_success 'create new unreferenced commit' '
-	commit=$(git commit-tree HEAD^{tree} -p HEAD)
+	commit=$(git commit-tree HEAD^{tree} -p HEAD) &&
+	test_export commit
 '
 
 test_perf 'rev-list $commit --not --all' '
-- 
2.12.0.rc1.440.g5b76565f74-goog

