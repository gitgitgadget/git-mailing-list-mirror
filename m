Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D29C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5192087D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO3V+O9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgJ2Vcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgJ2Vcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10839C0613D4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o11so1599348pgj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=T/+8dSyhHsNX7jrTAMmHIeDrylgrmPZIYhwQz1plHU0=;
        b=OO3V+O9wDuTvGHWok5Waet6E/3XdaAXUhJDAsZCjSe9jHJHI/0Q+l/sDVCbe1C/swP
         Zs9T2Ki7We4ehnHJkD9GxAXcXPVjQ3O6qETHDc+7lLPuNHVrwL/fKzuGxyixp7y1sk5n
         KY/hoQgYpDgTPiLRKh3kyJCD7lDshMu4114VK3f8X2BDEq0IF21xxqvWKrT0V7QSpD3s
         Z0jsJTYrqpWXcAZR1LPaA77Vka2/1v5BgB6iHzolOmF45KEs3orVRs5GNAlwLrw3ap6B
         +G7xmE6VTaxHYLNIL7dgFtj1PAqaEhw3gb5rDIAqEKhrUFC4cFqsh7wAtNPmsyFE0DlR
         XQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=T/+8dSyhHsNX7jrTAMmHIeDrylgrmPZIYhwQz1plHU0=;
        b=H194x4h/czaEzD3zau+X2sPnrUYJL56MLsIrSoEmmHe1W+yr6SzT5Ol6YpJh80F3Yl
         3eqGpSZunABggZpe2p1vwlBgj+W4cNHXl7USMv33du+qrDMGItbbPYHvKdX+EsYBw+Yu
         nrOzpONjYxTTZd9tG56EjpX+i0HmD5SEtb06dehCVVMlIK+/ZvCpE10rk5L8oHjd/ZGg
         abQMfBBC+cUNKsZm0EMc6ivWSCnxv0Rl3eDJ9Q3WXh5jlacPT5KX2dH9eJCThf1EUDe3
         3Dd5kw7eoqsGaAxYGk8ifxtdzsmvJx0XNmreWijF4TQFCbvqLWKCUXzzM41Nn+eWJVjP
         HRLA==
X-Gm-Message-State: AOAM533qWwrTv70BD7H5CphtYbKIRowVGXW6eIGU/Hcl8Ame+fOwAVh3
        9qB4fVIWRyJdcnMaU5R2WqCxIoFbdN7XwJ/o91po+2YZiYtOrNWQPYtSuDBywVaHSc/qYwLMrvj
        V/miwla92+9+8Pb65fPo4jbNJMf92bm0QB5iAMkUldkTls0BydFUEWv1JXTmphS0=
X-Google-Smtp-Source: ABdhPJxG7iB53eQxlOxv5Q3nyWzWl1TNJMtz7n9DAqo6vzg9sHNacl2R3QrxsDJmukxPJ3a4AGa+PqfdWZDLEQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90a:c588:: with SMTP id
 l8mr1677691pjt.205.1604007169517; Thu, 29 Oct 2020 14:32:49 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:34 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <d42118ac41d74870782104d13dad59523d3dbaa3.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 04/10] receive-pack: advertise trace2 SID in v0 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled and trace2.advertiseSID is true, advertise
receive-pack's trace2 session ID via the new trace2-sid capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/receive-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..1ff83c874b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "trace2/tr2_sid.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -54,6 +55,7 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
 static int advertise_push_options;
+static int advertise_trace2_sid;
 static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
@@ -248,6 +250,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "trace2.advertisesid") == 0) {
+		advertise_trace2_sid = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -268,6 +275,8 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
+		if (advertise_trace2_sid && trace2_is_enabled())
+			strbuf_addf(&cap, " trace2-sid=%s", tr2_sid_get());
 		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
-- 
2.29.1.341.ge80a0c044ae-goog

