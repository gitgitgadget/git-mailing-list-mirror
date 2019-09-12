Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057B71F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfILWND (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:13:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41916 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfILWNB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:13:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so14182455pgg.8
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igmfjUOmRTQ0bbabiNW7zPoaRx1PSvAemn0vlQ+CkVE=;
        b=W2ptSbJqsEfPOsao9CtBuapM1+zX4cskatn+Y9uEXvrcX11OM2W+GbHXqWKdOmo7dT
         e2/tFjvJm+kzW4bY3o+ciqe/WT2HrxJu4CE27q0C/FFiY470WtyN3jSesHlTLfnlwVc0
         p8NFkXIFgmy3GkDe3WgOgeObz6kTbkGEv/m9aVgaNWnVKNi4E7hRzu5p+koSNeAlCDVO
         1UFVWCFFyn9iQhgFoPGkFGkaT+ms1hdw8sF3yaCEW3ZkSQULpDdYq7DC9u0sIWp6NkPj
         FQ8S74IQOZAVSKDREFMS3rcMgLEpBi1f917WamGL7Z3S2JCgJZ1HkVOR/s741BLzdi3i
         uU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igmfjUOmRTQ0bbabiNW7zPoaRx1PSvAemn0vlQ+CkVE=;
        b=X42AtItHv2yfYdqunJO9HWCHIrL3v4ItNKsxHq6MMMvgxXjeg+SPYhuBk96rRlvKHR
         EXKXtaizF6WnBlR1mfkAYy+kJrNi5AS8aEF1W1RVGxk6cvCR0I5/SyUXSDR5veVfHM3O
         1kebRLmzQhZDwmv6JWySg+HnepC/hOn5N0YaEhWkQLnV903xw57M8YH8jkSm9YPBfL30
         9IVWukuYyvK9Tj5HVfIUfjx9oWzcbKtQ/PLDBUfLJh33HWwnSvFlbgJWoUosfKZVQKFV
         vxx1T0CI3p/+iXZ8dtmcZwEtZqcyPCEa6HPXh3ZhMC9i8V+hCairvSJXd9+lKuBqg45L
         KFrw==
X-Gm-Message-State: APjAAAWwoZpsSFyL+XB/JxXT2vMGbTDiGtH6TD5/LV6+b/h1Zj187raS
        HiUAS+tBq2q6ug8aOtbAMcrPCMoSPlU=
X-Google-Smtp-Source: APXvYqzHMAJbwRXwKUYSc7l19/BebzYUh1u0Ru9rOVfxdQZ3/3gyC9S8D6SvMrJ+vREejz9ihCe5lg==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr39969220pgl.420.1568326378986;
        Thu, 12 Sep 2019 15:12:58 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:58 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 12/12] clean: fix theoretical path corruption
Date:   Thu, 12 Sep 2019 15:12:40 -0700
Message-Id: <20190912221240.18057-13-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_clean() had the following code structure:

    struct strbuf abs_path = STRBUF_INIT;
    for_each_string_list_item(item, &del_list) {
        strbuf_addstr(&abs_path, prefix);
        strbuf_addstr(&abs_path, item->string);
        PROCESS(&abs_path);
        strbuf_reset(&abs_path);
    }

where I've elided a bunch of unnecessary details and PROCESS(&abs_path)
represents a big chunk of code rather than an actual function call.  One
piece of PROCESS was:

    if (lstat(abs_path.buf, &st))
        continue;

which would cause the strbuf_reset() to be missed -- meaning that the
next path to be handled would have two paths concatenated.  This path
used to use die_errno() instead of continue prior to commit 396049e5fb62
("git-clean: refactor git-clean into two phases", 2013-06-25), but my
understanding of how correct_untracked_entries() works is that it will
prevent both dir/ and dir/file from being in the list to clean so this
should be dead code and the die_errno() should be safe.  But I hesitate
to remove it since I am not certain.

However, we can fix both this bug and possible similar future bugs by
simply moving the strbuf_reset(&abs_path) to the beginning of the loop.
It'll result in N calls to strbuf_reset() instead of N-1, but that's a
small price to pay to avoid sneaky bugs like this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 6030842f3a..4cf2399f59 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1018,6 +1018,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
 
+		strbuf_reset(&abs_path);
 		if (prefix)
 			strbuf_addstr(&abs_path, prefix);
 
@@ -1051,7 +1052,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
-		strbuf_reset(&abs_path);
 	}
 
 	strbuf_release(&abs_path);
-- 
2.23.0.173.gad11b3a635.dirty

