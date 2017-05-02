Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F17B207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdEBBCy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:02:54 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33858 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdEBBCu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:02:50 -0400
Received: by mail-pg0-f42.google.com with SMTP id v1so52294199pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KmW6bE69p7OKJFZM4+1L7KB+JPgOwfmmh/cOLJsPhh4=;
        b=V00BxpaVnteu8lZ/7R4ZvBzUSv2ldMuh4vGPH2L6yla476jHh01AwJEBYw+VZ+WmRF
         DpjO31yerrzak6IDzHYvNfyyipknXlDGCWUt8pOfB+4XVPgdj2brZaan0qGTlQWJ4rmW
         j4HoedTrK8iYJjKYCUyvsgrIay9zbfZ79w3fMHl/finpqqFOgk1LbA9SyPnXY97bssZU
         8RQ+7TUr5wD94lqq+bfnkxmX2YHfrYoO8o4FGs4+zLoeIsLthI5IZw4vse5YIM0FrI9E
         dv2QANDarqiknbI/2Z4gFc4811h0zSNuHNPPtOS9/5b+JEcQU6pVGGtUJXgV6XiX1Z6E
         P1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KmW6bE69p7OKJFZM4+1L7KB+JPgOwfmmh/cOLJsPhh4=;
        b=c8AvYKE8WcI+7ufNlrZf2LnYyt81uzcY+iMQ2b7O7JPtNuLygajDQGl5HnTqXaMBK4
         tr6H7LoJQT7gV6Ck4+K/NWKYMGKv6gXKL/YtskyBra10XnX2bjLYtgimnOAeMbIOe6xJ
         y4WjfLrXzOakrDlkMebasM7HD7BsWfN5MtUdJTOH09jfpc9zRSp8PYCDy4yT6ZCW90KI
         NcbfLCfU91X2DbvYv/ZZ10P13zkLrogbmQ+TAOO/KRrvWTVDLP45U1lSpuu4B3C4jOXU
         4y8H6CwOAyqAN3KR54C0up81k/3oMHc0sheMpJ1aC4mT7NM87Md5MzivMgA9G2VrpCVr
         Fetg==
X-Gm-Message-State: AN3rC/6MPmlP1mX+Nagtk3lLIQuDXMH/hTAumhVXFcvC9r9EYgC7KKTO
        1p5Y34cAOvSKYaIL
X-Received: by 10.98.153.216 with SMTP id t85mr29474314pfk.178.1493686969286;
        Mon, 01 May 2017 18:02:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 3/6] submodule: remove add_oid_to_argv
Date:   Mon,  1 May 2017 18:02:36 -0700
Message-Id: <20170502010239.179369-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170502010239.179369-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function 'add_oid_to_argv()' provides the same functionality as
'append_oid_to_argv()'.  Remove this duplicate function and instead use
'append_oid_to_argv()' where 'add_oid_to_argv()' was previously used.

Change-Id: Id0abea012707460cb7000df761e6557ba5cd88d9
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 46abd52b1..7baa28ae0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -970,12 +970,6 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static int add_oid_to_argv(const struct object_id *oid, void *data)
-{
-	argv_array_push(data, oid_to_hex(oid));
-	return 0;
-}
-
 static void calculate_changed_submodule_paths(void)
 {
 	struct rev_info rev;
@@ -989,10 +983,10 @@ static void calculate_changed_submodule_paths(void)
 	init_revisions(&rev, NULL);
 	argv_array_push(&argv, "--"); /* argv[0] program name */
 	oid_array_for_each_unique(&ref_tips_after_fetch,
-				   add_oid_to_argv, &argv);
+				   append_oid_to_argv, &argv);
 	argv_array_push(&argv, "--not");
 	oid_array_for_each_unique(&ref_tips_before_fetch,
-				   add_oid_to_argv, &argv);
+				   append_oid_to_argv, &argv);
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
-- 
2.13.0.rc1.294.g07d810a77f-goog

