Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43EC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7673B2068E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEV2CmKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgHYLbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbgHYLax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:30:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF9C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so6623313pgh.6
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFl0zxz/R/Z1d53jhb7yMVOit1YZcax8f1UC7bCCpmo=;
        b=GEV2CmKMt0VTeZTp5NX4yxLvPW5QrJ9284mxn3kSX9GNUHOARW775rdyJ6t/ZBQjMA
         JW+DITog3lf2QnslO8XUZGxil5sAC0iondRo8hR4AkoSXtyYPorQ4rYG8FX47vLs5wPp
         xWV2BxwESHaUqa4nU70zk1Z5q54ApVjnxmLb8yWY7Fyn87UVUq5tPILpjkaf0sWrqz6N
         I5h6KvAF5lffPIeDMg33Wj4Vx/+Mgx3FeLU9y25kYsWZMJqMzOJYBf20RBYuHmeA7V7W
         ntuX7D2bpSgTgsbCDMgoBnOqOSxlsydjtKmN+OxPkt9j7kholC5zv0eZFhmJ8x/MHo9s
         Iz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFl0zxz/R/Z1d53jhb7yMVOit1YZcax8f1UC7bCCpmo=;
        b=KRNri6anUy9TNJJUyjgUoxQRTknA18Va13uMjj9KN/6Z+PRc3jw7HDpbt0M+CxA2jk
         tb5dzV+umaebDubzQQdSaoJ0ukbX9Sqzz5In8loYEBjTjVg98NK3n2r8SFDos6cnP9d4
         dbtX0Cd7Ur49U+dM8oDbFNh6U+MV1YhCBiY3UwLArA9NLjqo43O3XGplIREkKtHEWN79
         3Sib/snJCKuVCDe3uGG9udMf7a8J8lXpuox5CxN3BczXrJ28D4p8J9UyyTCt1R3YYOPy
         kKqrfjNLy678MqCXtkjlQivIhC/jjTA2sb6WKbIV0csxC2OJOn0qqg4wI3rCm1E+4W3f
         TdcQ==
X-Gm-Message-State: AOAM530bwk/SQuOK3zdnwqBxelrMrBsKMiId0fMCHIA5bfyshm1m4/vl
        zvpKJaCa3keryIvA8SvlUNN5x7cimuDZ9Q==
X-Google-Smtp-Source: ABdhPJwSDEZ2ofMSdBkdNbhHWJ7EqV1hjObOMphQ7RuvNB0gU8aoG7Fy7oQ2cg+vHUGPKRJc665V5Q==
X-Received: by 2002:a17:902:c3d3:: with SMTP id j19mr7220429plj.15.1598355050266;
        Tue, 25 Aug 2020 04:30:50 -0700 (PDT)
Received: from localhost.localdomain ([115.97.133.243])
        by smtp.gmail.com with ESMTPSA id y3sm2821518pjg.8.2020.08.25.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:30:49 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] submodule: fix style in function definition
Date:   Tue, 25 Aug 2020 17:00:19 +0530
Message-Id: <20200825113020.71801-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The definitions of 'verify_submodule_committish()' and
'print_submodule_summary()' had wrong styling in terms of the asterisk
placement. Amend them.

Also, the warning printed in case of an unexpected file mode printed the
mode in decimal. Print it in octal for enhanced readability.

Reported-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b83f840251..93d0700891 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -959,7 +959,7 @@ enum diff_cmd {
 	DIFF_FILES
 };
 
-static char* verify_submodule_committish(const char *sm_path,
+static char *verify_submodule_committish(const char *sm_path,
 					 const char *committish)
 {
 	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
@@ -979,7 +979,7 @@ static char* verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char* errmsg,
+static void print_submodule_summary(struct summary_cb *info, char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -1056,7 +1056,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 		} else {
 			/* for a submodule removal (mode:0000000), don't warn */
 			if (p->mod_dst)
-				warning(_("unexpected mode %d\n"), p->mod_dst);
+				warning(_("unexpected mode %o\n"), p->mod_dst);
 		}
 	}
 
-- 
2.28.0

