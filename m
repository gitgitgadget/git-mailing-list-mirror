Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B8C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34B5613B5
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhE1UL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhE1ULz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:11:55 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D1BC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:19 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c196so5393536oib.9
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hCv/FjSrqMI+WjTMTsnoXucijauBgpZ7Q92ug0DN54=;
        b=GNK1ZCfKJcwOJgVF6fyN+c6+d5A1dWQLiCKxXAhiDuTvX4CZ7Rb2PFZ69qmLoCMgvy
         jkZQiohrzoM9gWt6nU8ihfk5zz1dZIZqdLbF4Ng1qOmOROjxosqHXQn0wt/yrlyhZLGF
         87LIi7SZpfVfzdJ3c1shjM/eQ1BQzDm6mQa5UeWaFA07ZOmtH+LHV7ZrqnjmufTxsoAA
         Ji+ugGrKqrW213lJuy+QemlweNFC8EgO9qriWi25+1BBtDgjLLNXM+46uMjkt7sUt18x
         gCZPtc4lGmNVHUr/M5n8L7yN8gODggUfnuAUAvkKF0afGPWEXhixqrbWNK7LA0nDeOfC
         /LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hCv/FjSrqMI+WjTMTsnoXucijauBgpZ7Q92ug0DN54=;
        b=jnRqKPYvApnHHrbqxZq0f899zKJVDAqfDQmEl4O0R8bGhT3AzZr5N9YjISpFis8k/3
         pcn9XBdqqk0IiaL2jwp7aEFQSxz8XneJaPbeUdkkHBcNYD9XK7XfkAPP84CuuAm4neJS
         6iEDEm+Wvn3cjHcUPjFau2EJRqW+IprDvFe3YlcEGikvbiuul2gTEXB45AhC94XvV8kQ
         vuI1y+VnrF0G4oEYZ+y0KidNdyaOWDkPWKBsf3uyDAAdoIz69lJfsbt1nZKNnD+IFmny
         Q/MeO2A1VE6/PlJ8vNTXaiuyNqGv2UN15HA9gDUOUYal6VMJ99m1V8j9lWHnzquYBsPE
         a6Ow==
X-Gm-Message-State: AOAM531/09rOV/Ls6KLXLftTDJRvPLq1uftGuNIJrQdNj9vvHjk+r3lf
        bTtqaYOhSwxH1KhfJx0Cl5RGAKEzPTVBrA==
X-Google-Smtp-Source: ABdhPJx2IeOXoEfy4hzRqanHsgRVTQ5IlZQNEgXc+IY7deF3nDRf4Kqs2tO2+DK7gf3uBbexAbdZMQ==
X-Received: by 2002:aca:1a06:: with SMTP id a6mr6875408oia.95.1622232618165;
        Fri, 28 May 2021 13:10:18 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k20sm1371182otb.15.2021.05.28.13.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/11] push: hedge code of default=simple
Date:   Fri, 28 May 2021 15:10:04 -0500
Message-Id: <20210528201014.2175179-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`simple` is the most important mode so move the relevant code to its own
function to make it easier to see what it's doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 194967ed79..7045e4ef0c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -223,6 +223,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
+static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
+{
+	if (triangular)
+		setup_push_current(remote, branch);
+	else
+		setup_push_upstream(remote, branch, triangular, 1);
+}
+
 static int is_workflow_triangular(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -242,10 +250,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (triangular)
-			setup_push_current(remote, branch);
-		else
-			setup_push_upstream(remote, branch, triangular, 1);
+		setup_push_simple(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-- 
2.32.0.rc0

