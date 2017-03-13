Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84EA20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbdCMVoJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:09 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35676 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753491AbdCMVoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:44:00 -0400
Received: by mail-pg0-f46.google.com with SMTP id b129so70797596pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ar7oNeYjlMTavxYiAWsrMxIcLOZJe9FepKDCwQS2zPw=;
        b=sIFragFywCm1kQHDICtwAPa8anoSu7tIQXtThHdan/8lVuH1cEyHvmAjQyL8cn44d8
         OmcOXW1svAerI7q7sABvK1bqBbWMEF7Ccw6Xi7e43JIcNQMPyKn2qvVwDAvTFh6p87td
         0CUUQ9T0IjLHPUKo9bGTgcIUSCV0hBhu6q2P6fLN6qWZV/Q4soGd+a3EuiBYarbt8MgB
         GTYQiYSU7l/LtJ9zAK9IvEU1MUGHYyLsmRnLI05RTVy9WCmCabNzOzdFiOGUJTNXy2T1
         Q93VnsxYkQoBa+4NU+iCEKLMNZfHDeEvZreFc+hQRMx6SyyyJVW1QW1tG3BrvLkktYzY
         Xq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ar7oNeYjlMTavxYiAWsrMxIcLOZJe9FepKDCwQS2zPw=;
        b=PWF/80Mn6V6SjiH0NjQ6Lhwt/cUa0BXZC1jHuXingel9hkqgcj+Q5tdd7C+6BWu1PB
         Ok1b+38p7WgkxVHF/mNsHW+4+EpcoeiqF4tzeXtnhd45gPZDF7mtTa8THTm+DXBxY+at
         mxsCXYFgcKHEvDEd/gptgyzVA7suNmA7ttBw2X0NzeDm+ebQwbxWk8ZndD0/44UxTjUG
         XpRBmGCUxqh8B1nS6AJZTCdfhjQcnfXfyRXC4SNoS/+/rRTpiKbJfqWz75aIxBRhnlS2
         LQoyfCEe79yGPYQhwoYEk4AoIz6w+tMitI/2d7GbrF+//D0yM9EQy1QBVAr6mcdmEHVM
         34Jw==
X-Gm-Message-State: AMke39k8nV5vUEJX+uy3jAZa2xgEMfFQj+CkN+rmfc2K/aLrfOF6m2llQGRXlZKQaSZXKtON
X-Received: by 10.84.208.227 with SMTP id c32mr49896364plj.71.1489441438923;
        Mon, 13 Mar 2017 14:43:58 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 09/10] submodule--helper init: set submodule.<name>.active
Date:   Mon, 13 Mar 2017 14:43:40 -0700
Message-Id: <20170313214341.172676-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When initializing a submodule set the submodule.<name>.active config to
true to indicate that the submodule is active.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a3acc9e4c..b669ed031 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -361,6 +361,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
+	/* Set active flag for the submodule being initialized */
+	if (!is_submodule_initialized(path)) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "submodule.%s.active", sub->name);
+		git_config_set_gently(sb.buf, "true");
+	}
+
 	/*
 	 * Copy url setting when it is not set yet.
 	 * To look up the url in .git/config, we must not fall back to
-- 
2.12.0.246.ga2ecc84866-goog

