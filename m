Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293CF1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeEQWwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:33 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:46271 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEQWwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:31 -0400
Received: by mail-pf0-f169.google.com with SMTP id p12-v6so2766372pff.13
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UcpXGw/JnQEqnokGSM49Yh0JWbBsG4cCiH2gCv8T7uI=;
        b=a9urp18kA3A1S+0zJdUE6kQKY5lLCss5P9RbldZuayuUMDdGJiEgz0gHpfq230yijn
         on3JCLwRpJN2BWaJNeGJ/qW29BHsWEpqiRc0YPMD0rm0i5EI4ElkrRChMMExZYibgJKn
         67nNXkv3sBUWykqdHBF1AnF5eC1Q8shI9IMlOLFypfXN2LRNr36tdS2VS6jm32MKeV9z
         qXREt/HoPQ4MQX8nR15m7hbP9AxNPV2lZRWLedHb0dXl2X3GLtHExu4SXd/E74e1MHQb
         r82PS7KtqXhIFzN4hGRhJMKVDa4IFm4jkdCZuG94NOXSirLPyv4LoW9VxHgzIy0aD0fP
         476A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UcpXGw/JnQEqnokGSM49Yh0JWbBsG4cCiH2gCv8T7uI=;
        b=Hpa4G7OimiVfmXUNcEoCOmC8akJNaiT1+E/5W/2dC8KgNrR52VoSkicXydW5y/TnwK
         WVDri8183IYMgf6w5UYsPcyCWWn8dn2ZyyDBli/ojBKuOd8AQjOTusDIHFz48LpElrG1
         qyg68mrRvs6P5Plf/rcf8pCOb+CWBTx02UTcd2xMk9+48LD3Yx4GAHIgsqjQlnC4XlUu
         y5kegOkbwJONUxnmdfGhxqpPfY5Eum34rRpMOrRRWYrVcRoTPHm2wGl8hUiOZuYUqNb/
         PFQdK8tmMzuEvoph5biRVxUG3H5UgbdpWncjDGchfoLzlxaMmIUkG5oNO+L99781AXCx
         1NlQ==
X-Gm-Message-State: ALKqPwe3CBygx0uj8RZqKVKDJnQJZUwzquwKfoU4UQaQOvHEEIfV9w1l
        ++k+jAvXWMezF1H26cusOllzvoDLADc=
X-Google-Smtp-Source: AB8JxZp50pZvcjdoh178FMQzHqPwZw4TPrTdr1x8hL0MPHMwr29Dps+pafmT15/NmFEj5xJuoCDwPg==
X-Received: by 2002:a62:859a:: with SMTP id m26-v6mr6753134pfk.247.1526597550676;
        Thu, 17 May 2018 15:52:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o88-v6sm12487266pfa.29.2018.05.17.15.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/19] commit: convert read_graft_file to handle arbitrary repositories
Date:   Thu, 17 May 2018 15:51:49 -0700
Message-Id: <20180517225154.9200-15-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 8a2ab53fc67..3fcb2fd66ce 100644
--- a/commit.c
+++ b/commit.c
@@ -177,8 +177,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	return NULL;
 }
 
-#define read_graft_file(r, f) read_graft_file_##r(f)
-static int read_graft_file_the_repository(const char *graft_file)
+static int read_graft_file(struct repository *r, const char *graft_file)
 {
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
@@ -189,7 +188,7 @@ static int read_graft_file_the_repository(const char *graft_file)
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
-		if (register_commit_graft(the_repository, graft, 1))
+		if (register_commit_graft(r, graft, 1))
 			error("duplicate graft data: %s", buf.buf);
 	}
 	fclose(fp);
-- 
2.17.0.582.gccdcbd54c44.dirty

