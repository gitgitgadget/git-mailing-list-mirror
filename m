Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6221F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeEQWxE (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:53:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37509 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeEQWwR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id w19-v6so3396505plq.4
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HaZtZu1s+HK3iJMPsW5RgPYPCYO4hrRzhe5uJ7/97Wc=;
        b=FhFDC91FZfaeVK5oFbrYdLMPYeyvoNEew9KtijdlYm5/b2PTWhZ/6MwCBreLa9ofdq
         /EuUSV5dt1taCAEuhgTGQh6Sd8HWf6imccsNubYhuLuDxjIfxXEn9GptEP9+5Pgz4GSi
         kJsb9e/d/BmUi75YJNdh10dAR3DtpZ462jfFcVFZILyJdyFf37vl5f8lw/ayd5UAMGd4
         U7C3aN9pMhFPkO59FwXH366Uw0Vp2k53W0n/B8Z5L1NMBpvvjKm7dNFtV9U+0TlxfXwi
         p9NS0iHrI1oN+xuT65UBevto2M+drpzfNrnLIkmlTO0KbLfi2Bx7dWffSeRjyPFYQP2Z
         7YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HaZtZu1s+HK3iJMPsW5RgPYPCYO4hrRzhe5uJ7/97Wc=;
        b=XwurV0DWs/b9uDS5m8kqL4Er09dqORebG4W/5NZg2YPj8GE0kwejKQvyNpFDTRqlJN
         Q6ifPdM6F9iW+n5Nq5CdGBjFQ7z4JyMyAh4Za3kmb80hL6N37ANAZDus5ItW+yXFvInl
         iUflJRbOsVy4XX5jgaBPlWR1pKAmhV6gyBgAo4gxLpS/CZILykyb/MhNfL2vzfNjXHhB
         FvB3yCvUfxeGWxbYdgZjQbAazLQLVfcw3Dh1CPSDvh77TAvbyLU8oRoobnczeAlEfTQA
         aTPo8LoJXvN49HT2nYar9aVdhwDdAVNdh347AsF3fO9Mw62+e6QIdS+ptW2/NqEiFvNY
         xlrg==
X-Gm-Message-State: ALKqPweLcW1lfvxh35+UPysrjJ33ibjXiBcPnvzm8iDDOkXhnRx70y2t
        ZDAAMSvX5iZ+Z/9hlBBYcKrFWgGE7TI=
X-Google-Smtp-Source: AB8JxZpV0Si5AS9gG18UG1VTezisjr2RLTgPO+mFLgc5Dx1G7DOFT5UVntc8R6SOd6YNzagUJrEmBw==
X-Received: by 2002:a17:902:3081:: with SMTP id v1-v6mr7129690plb.266.1526597536520;
        Thu, 17 May 2018 15:52:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 63-v6sm9695124pgi.4.2018.05.17.15.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/19] commit: add repository argument to read_graft_file
Date:   Thu, 17 May 2018 15:51:40 -0700
Message-Id: <20180517225154.9200-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of read_graft_file to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 4e8d3488425..b5c0aec24a0 100644
--- a/commit.c
+++ b/commit.c
@@ -177,7 +177,8 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	return NULL;
 }
 
-static int read_graft_file(const char *graft_file)
+#define read_graft_file(r, f) read_graft_file_##r(f)
+static int read_graft_file_the_repository(const char *graft_file)
 {
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
@@ -204,7 +205,7 @@ static void prepare_commit_graft(void)
 	if (commit_graft_prepared)
 		return;
 	graft_file = get_graft_file();
-	read_graft_file(graft_file);
+	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow();
 	commit_graft_prepared = 1;
-- 
2.17.0.582.gccdcbd54c44.dirty

