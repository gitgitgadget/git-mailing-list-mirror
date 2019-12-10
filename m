Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CCC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A914520726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbVZi3oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLJCd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:33:56 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46141 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:33:56 -0500
Received: by mail-pf1-f202.google.com with SMTP id w127so10476162pfb.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7kQygg+M3WrQt4WoU3MrW8wSA25Q/mrUwb7oj8GtMEU=;
        b=sbVZi3oiR1H5bAdpjcwq2N63yrUFoXVN78SFC/bofQojzGXDkjurnFKvzsCMGlTVlh
         UrXjRaCN1uv8KKoswwAPU/zwrFPE/K/zw9Bd2JPi0eYl/N053QIOPQCdkf3ZKHiuq54t
         2//qw/OR3aPISR1TFezXrB+a1HAzG4kdBnFc6w48VIOd1cxkIfI5t1wgnjpjxK6XJkKD
         uceffh4WA1DQHpSB1zKFyo6x+oCawg29qSApukfCzoO/rH85HJY+GscNRp6zJ+MydhDp
         05WkamHx+KzzrgAw1TZamDerP7fPScrFyxu6+Isq2Xwih21f60CetR72jSrezGTg5mzE
         fgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7kQygg+M3WrQt4WoU3MrW8wSA25Q/mrUwb7oj8GtMEU=;
        b=l+cZ1o/2QOABeSM3yD/DSZ1rEF4b++hHCw0fHNqPQBsb70iwR45xm1uMFWIJyjHiRm
         hOZg7qUE9x8rDhK5lBkJiqEd6rJ8mB++xqtwEXgNZLKy1pHncZDgWZ1btMUY5YROuIme
         I2C9suqgcxG8uhm6262j7NaLvmKV+ECxqI35pP17Yq2Inez5e7jFXw7RLGsgtE5GU6ux
         8GGml2YPBaSH0Vgos8lUJuT41dHyzjX2oBDJ5Nc2bNPJL5TpVg5I62tHIcgCMqct+U1q
         O0r5OpwRFTAJK9defkczAPgUCCxOoLgYlFoPaONa2cfEFyMvsG2BNpM5VW3z9SERWmQI
         9Bvg==
X-Gm-Message-State: APjAAAV265hnlBglS9ZjipAf1PMyWBSPlSRUa2CqfioJzlnd4rf+UkR/
        +AFyeUEEU8jpoDy6hmWFtD5tM269Y2dHZttMLfUcQMcV7QSrxvq9SbzjCjDk0e7dT/p1CwlnBMv
        xcGZCYly2hEm2kRa30ndKwBkcTJWVjq9j4iGN3BfI2eSAxfaEToSNGBw4sU/ybMiCAfHKdynAcQ
        ==
X-Google-Smtp-Source: APXvYqwkW5muZg5U0uHnbx2YxAL2w1EwQKVyeEnfLwLeI9lXEuJv6riIlW4w4anLnJDBkKZ3S27vxCigpcIapwG98W0=
X-Received: by 2002:a63:447:: with SMTP id 68mr22635789pge.364.1575945235732;
 Mon, 09 Dec 2019 18:33:55 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:31 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com>
Message-Id: <20191210023335.49987-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 2/6] config: add string mapping for enum config_scope
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user is interacting with their config files primarily by the 'git
config' command, using the location flags (--global, --system, etc) then
they may be more interested to see the scope of the config file they are
editing, rather than the filepath.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 config.c | 17 +++++++++++++++++
 config.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/config.c b/config.c
index e7052b3977..a20110e016 100644
--- a/config.c
+++ b/config.c
@@ -3312,6 +3312,23 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
 }
 
+const char *config_scope_to_string(enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		return _("system");
+	case CONFIG_SCOPE_GLOBAL:
+		return _("global");
+	case CONFIG_SCOPE_REPO:
+		return _("repo");
+	case CONFIG_SCOPE_CMDLINE:
+		return _("cmdline");
+	case CONFIG_SCOPE_UNKNOWN:
+	default:
+		return _("unknown");
+	}
+}
+
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index f0ed464004..612f43acd0 100644
--- a/config.h
+++ b/config.h
@@ -139,6 +139,7 @@ enum config_scope {
 };
 
 enum config_scope current_config_scope(void);
+const char *config_scope_to_string(enum config_scope);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
 
-- 
2.24.0.393.g34dc348eaf-goog

