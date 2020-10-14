Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA699C43467
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B62822257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRbRl7fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgJOByj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbgJOByi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1718C08EADC
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j10so1076987ybl.19
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mPZ8/pi8roeYvnwy+1w9sLzVw0EqTF0+xPC/CHpKOKg=;
        b=fRbRl7fvql3CRqGhF/diS+vdwhJM/4G3qjf6CUF6EYOIMEqe7sTJOkrFUcH1Ia9K7R
         n1gjktG3q4D6hGhOKDW9oaQfnJTQQsOjW+MzmD+PMxPDQLM+kV1AfAtot+yToXdssQk3
         Xtn/fqEUEi7Iwga/cN8ja/pAQB/cylik85dumR1iAbyv1xMiBb4r/XYXU0M1O9Hd3vYl
         gBb36art7uyUHAf+hatYM08h1y+8wLSTzgAdofkJmbmR2k8DHhyLRaZWUTTmwwtqOK4Z
         XqcyDmfy2jVK6NRTdGEa+g31k/W1DBZcCd6pf7sJ/h8gBYoe1zR/DqbaRZJKqTCZxr04
         jAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mPZ8/pi8roeYvnwy+1w9sLzVw0EqTF0+xPC/CHpKOKg=;
        b=fiI7LLBlHW5VcTRLmq/FArtztYfCAH8a+U2HYUoAfMH6n0w261P9CTN+wxHHZ4kuNC
         dBcMEIMG010NPo/oVvQZRUMSiOdMz+6WdgO0bN/gnDlVMOBA5Fz+CgKCfR54ZwX00qvs
         zQlDcWlyTFcD90+WImrhGu+7E+JGniG7kZn3czwbAkDbyC+UgrRW/NPiOVxs9dKMEj+z
         Xtz4AyKxbuMBoFry/fW2MBbDoPneUMlJ7BwMcFdYb7Ur9S43iDMTj10MzJZVxaHbJQav
         kRLEFpmV90ZpsGbuA2Kc0fAXyRlNvzNx99+q86ZlncZMtbpLX9XmCE2k1U4Y8RDocFCZ
         ikgQ==
X-Gm-Message-State: AOAM533MSIPNjedq6O6uEEtx2fuUXz5ROfOpVE8OND9qir9+ltimXkx/
        S0ndbhUju3RpXfXxejVbnmLUYRaEV18qle3n+2koCArkt1PiV2EbhpQwff88ZwhsJlnSxBej6in
        kE+lUtag3Q/NT0pOvd3DkAIOOUXjwNPZf2cqcB4APUAQpsZJoCHeqIHdCGS6an+E1ascimG3Lww
        ==
X-Google-Smtp-Source: ABdhPJy5/FGixbnVNqBlbMf/fTz6a/5MofHfH8VjCSdgfKqNPKKoHG3DtHmGXZMcbeMwvNaqm/7bKy3OAXWCygEhUwE=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c001:: with SMTP id
 c1mr1493200ybf.27.1602717910843; Wed, 14 Oct 2020 16:25:10 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:24:47 -0700
In-Reply-To: <20201014232447.3050579-1-emilyshaffer@google.com>
Message-Id: <20201014232447.3050579-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201014232447.3050579-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v5 8/8] hook: replace find_hook() with hook_exists()
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper to easily determine whether any hooks exist for a given
hook event.

Many callers want to check whether some state could be modified by a
hook; that check should include the config-based hooks as well. Optimize
by checking the config directly. Since commands which execute hooks
might want to take args to replace 'hook.runHookDir', let
'hook_exists()' mirror the behavior of 'hook.runHookDir'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v4, a little more nuance when deciding whether a hookdir hook can happen.

 hook.c | 14 ++++++++++++++
 hook.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/hook.c b/hook.c
index 1494a32c1a..e3d289d0e9 100644
--- a/hook.c
+++ b/hook.c
@@ -218,6 +218,20 @@ struct list_head* hook_list(const struct strbuf* hookname)
 	return hook_head;
 }
 
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
+{
+	const char *value = NULL; /* throwaway */
+	struct strbuf hook_key = STRBUF_INIT;
+
+	int could_run_hookdir = (should_run_hookdir == hookdir_interactive ||
+				should_run_hookdir == hookdir_warn ||
+				should_run_hookdir == hookdir_yes)
+				&& !!find_hook(hookname);
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdir;
+}
 
 int run_hooks(const char *const *env, const char *hookname,
 	      const struct strvec *args, enum hookdir_opt run_hookdir)
diff --git a/hook.h b/hook.h
index 6eb1dc99c4..bf8ea3ee11 100644
--- a/hook.h
+++ b/hook.h
@@ -36,6 +36,15 @@ enum hookdir_opt
  * command line arguments.
  */
 enum hookdir_opt configured_hookdir_opt(void);
+
+/*
+ * Returns 1 if any hooks are specified in the config or if a hook exists in the
+ * hookdir. Typically, invoke hook_exsts() like:
+ *   hook_exists(hookname, configured_hookdir_opt());
+ * Like with run_hooks, if you take a --run-hookdir flag, reflect that
+ * user-specified behavior here instead.
+ */
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
  * passed 'env' and 'args'.
-- 
2.28.0.rc0.142.g3c755180ce-goog

