Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1560C1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeEPWVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40686 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeEPWVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id f189-v6so1043025pfa.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9Gp3uxE7t1+gT9iWS9vg/JUoc5uJRTzTLYzMRwNViE=;
        b=TE+Dbv0T5LHXJiTyUX0Fi2UhQN+iwfK6GVTzwbBhqgnK7ZV5MC+AbHRcnBMtwKR6K1
         /keH6gSs+aPMu3JHeWOUDaEv16f/+ghqswK/IH5zqBbVUm2Ryd7k5YXZuyg1bAP6m/xj
         7Tjstmf3RazcyTyeyFAWXFoI+56edwBBxE3/1aY7neMx1+q91SvzAjdB6zrz9i6oD0Xl
         abB1wrbBM6DlCT/L8Gt9Rol3xarefF7+2JahL/aETwoyLOB9Jo5nR2JxxX2fPnEYVKAT
         MOF5Xmf9DsEz+xwb6Va9WjhK2fRBl01JukiGnXMXm+vetkEIKghmEqeLRNniA/2VX4ON
         /DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9Gp3uxE7t1+gT9iWS9vg/JUoc5uJRTzTLYzMRwNViE=;
        b=sHkgZJf9OOAyrIhQ0IBDvhtvtOoKsvZIGVRw4YmgB2xC4aRwVaRLhgZx4iXMRoYMeS
         ID5bMzyhHicTwl/B+f8XOxywwJrUHtWGKW0j6kZuPbqe/rnHAr0nF8hOkj5kJ2dhM4Ul
         NGnvS/8FyH0FXoyH3QcvehLTFOrkRvNa1yU0eMUpvgDpB6YyDlWa9c2TIDdGBonT4H8I
         01hJQS8RnMHkkLm4RbouRq4t2SPr04acR1EWgOSTF1Sn3ZDjlfihU+ubyXQ/Cn77l9a8
         /vM3BRV0Zg5KwHVNRGtlhLsmf1Ki49MwhR1eOA8cYmk2e1NnvX7s276g5kBBLw9IAxzb
         35Sg==
X-Gm-Message-State: ALKqPweQ9LvYLLw1I59Gn2shOth9UcDryb2wRfAJ2b1XlK0LLnO8g+nH
        phz32RrwBKRp6/ac/++Kprwciw==
X-Google-Smtp-Source: AB8JxZoc9z4c0gJMtrXwmw+2zAkgHFVQ6FA4noQCgCuHYynAXZw3Kc0WyUazTrEo49TIFrgQDhSQLQ==
X-Received: by 2002:a62:4d02:: with SMTP id a2-v6mr2744098pfb.2.1526509293047;
        Wed, 16 May 2018 15:21:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l14-v6sm5010364pgu.1.2018.05.16.15.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 01/11] grep: handle corrupt index files early
Date:   Wed, 16 May 2018 15:21:08 -0700
Message-Id: <20180516222118.233868-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any other caller of 'repo_read_index' dies upon a negative return of
it, so grep should, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6e7bc76785a..69f0743619f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, repo->submodule_prefix);
 	}
 
-	repo_read_index(repo);
+	if (repo_read_index(repo) < 0)
+		die("index file corrupt");
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
-- 
2.17.0.582.gccdcbd54c44.dirty

