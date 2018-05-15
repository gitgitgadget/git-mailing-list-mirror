Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E081F406
	for <e@80x24.org>; Tue, 15 May 2018 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeEOUAn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:00:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44613 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeEOUAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:00:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id e6-v6so655445plt.11
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PtWYvl4qmf73jdoZBLSXEIwkvkz7fm4U5YW9ujEsnHM=;
        b=ESnG+YyozVemkqd4u0pfulOEeNpkqOKtPVEvmxmjfFB6ZAPOR5kpJUgiWztBrVEyX/
         mjKQG2L2pWZV+MvYWNKnxGa9h2YNJxux2OvYav+bvYgiVU8lYE1VAbUwqHGzdz4Klzsv
         Nema/9slD283KTps5gltqkjKSDI4QmdI1iT7na9eei1Z2smzH6sf5z6dUS7kIgnKh2NQ
         PqvvaoVyUCciZRjEZ/LUs4pLFqyYSVBdafSA/xS1XDgbPTszpIXSEjHHFhvgmGqwQWk6
         0MztjumtnNlau8BsQnub3DEDhlTLUH9zjSbipV7uktxOlzFTO5MUlv6XcfLIa8qw76WK
         NE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PtWYvl4qmf73jdoZBLSXEIwkvkz7fm4U5YW9ujEsnHM=;
        b=YxKEsvV3jpWk4iwuT+KOab8rP7/bAhfOtpw0C/mjtHVFcdORw4wD58cnoIgCWXw4jW
         aPfIcAZZI5vAuhUaxMOI6PHo9bEioEp2s8HYVBCebm2ikCM3d6t/QUWfjcmiEhXBxkoP
         ESkpv6sOtkiQVHD6moglaQl+mb4171F15gKaDhHHxrl3iwv1jIAp4FVLc5FDciixDZhL
         5JfJcs77YJyYM0G7yV4TKoe3heu0Sa/UumXAuqhOvJcFDkCBd09ccKbaCerQzRBi4Wsn
         nGjxFcU5ym/OcSAkOMbVhJXm+X0ms8WK0i47+LhtN2s/NgeQVpzRrVywgFx2qLqB+soC
         KbmQ==
X-Gm-Message-State: ALKqPwePg0AYqULZ2nBcyFIjZRZ25rc3npi2nQxtD1fS3xwkNSYzColb
        fEWQX/WAqcaFHgzM/+e4sAb7f0ZQdB8=
X-Google-Smtp-Source: AB8JxZr+zzfzyw0cg2sSWYU9CNqNoGo+WlPCRymlDaksKuIm6oPS59eI0icAIhR+/Py2WAmkPFoUkQ==
X-Received: by 2002:a17:902:28a7:: with SMTP id f36-v6mr15802495plb.155.1526414438539;
        Tue, 15 May 2018 13:00:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x8-v6sm1043183pfa.173.2018.05.15.13.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:00:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, leif.middelschulte@gmail.com
Cc:     gitster@pobox.com, newren@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] grep: handle corrupt index files early
Date:   Tue, 15 May 2018 13:00:27 -0700
Message-Id: <20180515200030.88731-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any other caller of 'repo_read_index' dies upon a negative return of
it, so grep should, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Found while reviewing the series
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

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

