Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8BE1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfIEPrz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46888 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732780AbfIEPry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so1994107pfg.13
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoigFa3xh3b2LJpKuG2gOgN5PRmPmmG13IXeZgzLIAU=;
        b=aInlpw+gqOF7o1/QP5PtNgAogKedg6WMGbXNbL1h2hNNsIAKQSfrR3rNXDCXJxq49g
         Aepd/GAnaeadZ+NBv1e8ov9mBQiz8cjTGkNkODkqss+HKuJo6peL6zK3lTMWWeKzPQxc
         EkqmAhm8puv5/73imbPkEQaxoe0Lz/CVDg+NoQd4A+KAPSimkO9k6cUxRe94tCM2FNhK
         +uIXUZAwqhH8A9/nE+bLjQGwhXZkBETWv+HNJ0U9L1jfv+V5BLN4qF5BXGB67GcpME4K
         D+6aTi02wizXUF9ndsSQDz14dhn70KP2q7TawA4K6t48KWNvRZK5dfFqoDnyN1RcTgiJ
         v3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoigFa3xh3b2LJpKuG2gOgN5PRmPmmG13IXeZgzLIAU=;
        b=FYiy6mdRq1ZnYpM1Eynw98x+yi8sh5/126F3wjMbmZOTjw8CaYW21XNyDo6We7Bisz
         zEj5GTaab0xcgX4hgXVkhxc8G48pRw3g6ASWgKlwynea2Gp2+mVnyObSH4qxQ67gG3GZ
         mKdTkH1VUH0gOwBGjaaIdSIWjvxhPCWfSGs3LHQWy/ds/JNqRMiYrv+dsT1QNp+LpN3d
         06MEeHxJfBgDxXy9CPUg+s881jebM56LeFINwM/fH1ivlG229EryaMVK3KEycoNqDFc7
         MRAuwljffvZs2Xtaix2Y73XsdngJ4fVIZdUbpqc9srZdNYCXnHs0gN9SAxEmvaAEPs/L
         K+4w==
X-Gm-Message-State: APjAAAU3ROFaMSBX949hG9USeGooKswnLrSIRvgUhyf+5/hSgj/kRM1k
        CV0H0oOVyAoaUNFKWKjcAhkK3KrQ
X-Google-Smtp-Source: APXvYqwXwEzW1EIj5/fA5jdDNTkK4GHppO/rqlxoFNfebU/9dyJ9uR/NBYrtgpodc/1L6wmRnNhvFQ==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr3722346pgl.270.1567698472753;
        Thu, 05 Sep 2019 08:47:52 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 12/12] clean: fix theoretical path corruption
Date:   Thu,  5 Sep 2019 08:47:35 -0700
Message-Id: <20190905154735.29784-13-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
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
to remove it since I am not certain.  Instead, just fix it to avoid path
corruption in case it is possible to reach this continue statement.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 6030842f3a..ccb6e23f0b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1028,8 +1028,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		 * recursive directory removal, so lstat() here could
 		 * fail with ENOENT.
 		 */
-		if (lstat(abs_path.buf, &st))
+		if (lstat(abs_path.buf, &st)) {
+			strbuf_reset(&abs_path);
 			continue;
+		}
 
 		if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
-- 
2.22.1.11.g45a39ee867

