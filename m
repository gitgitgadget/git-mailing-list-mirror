Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5DFC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B046137D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhHWKpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHWKpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:45:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085CC061760
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso13706049wmg.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpfYM0TXQN6MKQKpS7j6S1yEaN9HTLDA8mKD8mhFv9I=;
        b=EBww38yerG/006rzsCWB67qWa5RIq8ZMXwKPv2tHnoCixufXV6DM3r2BBuLv56Xlfl
         IsO09mZvTC5OlnNUpRX1XupdE5SjITdH5N12VCUjC94F5rB0srAMRJLKSasGCVUydwW+
         Z3KvI5fLUiubhxyWqtEuazn1nqif0WLA1Qds6UXIB/V7x9CTDiVc1wv6S3TJok4ZZkC5
         458d+rQAg1iRzfrSBaULY/fSRa18+JO3fJwiZxLjTQsjjzBMiNpS65SFxVEJSebzYljr
         /2jkeasCQynHL8xqHpxYLwzJXo3sNbuCdxyArkyeS7agmY+dzY7Rm5FXgdQPJIGgyavj
         Z6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpfYM0TXQN6MKQKpS7j6S1yEaN9HTLDA8mKD8mhFv9I=;
        b=o4BJL+koN+cXyYmYX515eJU0QPXVWZyclg+Cy/cm4Q+ts9lgTDTLPUbsEmLyMdGe/t
         +YldvfwJJZiq1EBQH+BWAypMhNponO30jnmMhrHZ9twVwXMH7pC+LEqHhGv92YEkrNrH
         g/ci04BSrBt87wsbLYxz/GGpvew5QkLeqJt9CFbKercrqU9vgtAPtVtByzFC5oeK6JOg
         ewIo4a4kGby39yBwTe3Phe9UQXBJGjXPkb+RgApxRdDuxhzeSAs/5sV4vZXkJ+Rrjt5M
         J8vZWAB2lMAz7eZHxdDSTf8RxagnsEhk611KVNCk7OC9IRJvNz9I8z9Yz/wwUyNvckHj
         PVmQ==
X-Gm-Message-State: AOAM530+NXsWQJjR093R94ZyU7DEnDD8Z4pmYHxlFPrkx4rXlhubSJ/D
        eQ0G73N8t3q+B65HSSN9c+faZCsySMQOxvyI
X-Google-Smtp-Source: ABdhPJxNx5Z/M5J7Gh9M+4e7wqg6/T1LaIWBprzbe/x4TnRTKxn3h6uW6ibUuKETKUJgPpvIu3wYzg==
X-Received: by 2002:a1c:d4:: with SMTP id 203mr819218wma.67.1629715455669;
        Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k12sm15351187wrd.75.2021.08.23.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] advice: remove use of global advice_add_embedded_repo
Date:   Mon, 23 Aug 2021 12:44:01 +0200
Message-Id: <patch-v4-3.4-e1018212e40-20210823T103719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
References: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The external use of this variable was added in 532139940c9 (add: warn
when adding an embedded repository, 2017-06-14). For the use-case it's
more straightforward to track whether we've shown advice in
check_embedded_repo() than setting the global variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c      | 2 --
 advice.h      | 1 -
 builtin/add.c | 7 ++++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index b18833bc807..41cfea82d06 100644
--- a/advice.c
+++ b/advice.c
@@ -4,7 +4,6 @@
 #include "help.h"
 #include "string-list.h"
 
-int advice_add_embedded_repo = 1;
 int advice_graft_file_deprecated = 1;
 
 static int advice_use_color = -1;
@@ -38,7 +37,6 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
-	{ "addEmbeddedRepo", &advice_add_embedded_repo },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 };
 
diff --git a/advice.h b/advice.h
index ed51db0f057..4b754f4c626 100644
--- a/advice.h
+++ b/advice.h
@@ -5,7 +5,6 @@
 
 struct string_list;
 
-extern int advice_add_embedded_repo;
 extern int advice_graft_file_deprecated;
 
 /*
diff --git a/builtin/add.c b/builtin/add.c
index cf29b302d44..8a5dd29f3f1 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -419,6 +419,7 @@ static const char embedded_advice[] = N_(
 static void check_embedded_repo(const char *path)
 {
 	struct strbuf name = STRBUF_INIT;
+	static int adviced_on_embedded_repo = 0;
 
 	if (!warn_on_embedded_repo)
 		return;
@@ -430,10 +431,10 @@ static void check_embedded_repo(const char *path)
 	strbuf_strip_suffix(&name, "/");
 
 	warning(_("adding embedded git repository: %s"), name.buf);
-	if (advice_add_embedded_repo) {
+	if (!adviced_on_embedded_repo &&
+	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
 		advise(embedded_advice, name.buf, name.buf);
-		/* there may be multiple entries; advise only once */
-		advice_add_embedded_repo = 0;
+		adviced_on_embedded_repo = 1;
 	}
 
 	strbuf_release(&name);
-- 
2.33.0.663.gfcc3c7013a8

