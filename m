Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CAC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4590721973
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HwCXkwKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIIAuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbgIIAuF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:50:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE6C061757
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:50:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z22so553641pjr.8
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VF7oE5YMw0/GxqChNnx/6uPxfpcAkfxdnUX1Fq0B3aE=;
        b=HwCXkwKk1LA0vjcwJEVa1FqIrxlEmpPUQ72elMT5MVFx5YZoY/d/q9Z+QLEr6g0/UZ
         RbJgvS/nk/3Vh5fhx19QE8etns0HUFEgQEvt1Lns3bBYXxTbvIC/2mst9XV1u92wQFE4
         W2pE6wYBxncaZ7rpzrHiYBWzZnRIf1Q4H3CoivLMbdDc2E+MGXsXiDg8YZkwse3emDWy
         pncD2gYmXF8/fX8RIz7/zyie6WOzNqXtNpscwyE6/6weXjI2JcpcQPdIZQSkWUEaFHDC
         50wVKLyJS6OtHaHATQ6NIxLx+LgrhkuDN68eClHEWUMpyPGFkNn1vIY6k/PIGj2cKXjI
         E3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VF7oE5YMw0/GxqChNnx/6uPxfpcAkfxdnUX1Fq0B3aE=;
        b=kt09wpLjjCNwQ4wPEIPLpZiInNxVMnauOSfco4bE/Bk3hpOLad46YhjgZUEh0F6Nvn
         CFxGD7R8L+AsrFmWBHiGJR1eqYVJ4trrFjXiPFccOdycqD76mrdps20QnwFFKTbMfYs3
         lDeYHz60i9McegrOiiliPziID1S6ZrPK6ZwvA04QUHMRj8zjHI4qcn4FFQiGnn7Lcx1v
         8XTevroYbAs+Uxra/SYXO2gaW3sKBZtL5lXJYXGzk1dxCSm0t+HIOXFPzwxDVpOuA8UJ
         ny4NEZDU5E+KoD6eQPY3vQ+1cjj/FjuD8wdNLHHI/J4yCz6F6zixErXwDvEUtECla7GS
         BsQw==
X-Gm-Message-State: AOAM5335TmCtCXVwtcJ3k9r3bUgzFZG6a9EbzIVDvAp/DztuezEAtmxB
        JyA8NjZCeQ63SP1ME7nnN8R9VuzK0RN1SOwOSAVjUuTTmBe/1du7FaxWxU/4Q6XiTuvnFLvFPqm
        Vob504qo9EDavWKK472IyH7gg4c/AdWfuC4X7S1ToRhqw4cMtfAom5rkFL9wEEkoOQ4RLplm6aQ
        ==
X-Google-Smtp-Source: ABdhPJxdhwxQ8DmT2IIKYIvwSDpZ4Oup9fu36A0Vm1bHKRCJgIcAk54DAckIJgHXh5M++atW14FxANyV1TjDENYpVj8=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90b:941:: with SMTP id
 dw1mr145986pjb.1.1599612602109; Tue, 08 Sep 2020 17:50:02 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:37 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 7/9] hook: replace run-command.h:find_hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper to easily determine whether any hooks exist for a given
hook event.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c | 9 +++++++++
 hook.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hook.c b/hook.c
index 0dab981681..7c7b922369 100644
--- a/hook.c
+++ b/hook.c
@@ -111,6 +111,15 @@ struct list_head* hook_list(const struct strbuf* hookname)
 	return &hook_head;
 }
 
+int hook_exists(const char *hookname)
+{
+	const char *value = NULL;
+	struct strbuf hook_key = STRBUF_INIT;
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	return (!git_config_get_value(hook_key.buf, &value)) || !!find_hook(hookname);
+}
+
 int run_hooks(const char *const *env, const struct strbuf *hookname,
 	      const struct strvec *args)
 {
diff --git a/hook.h b/hook.h
index d020788a6b..d94511b609 100644
--- a/hook.h
+++ b/hook.h
@@ -11,6 +11,7 @@ struct hook
 };
 
 struct list_head* hook_list(const struct strbuf *hookname);
+int hook_exists(const char *hookname);
 int run_hooks(const char *const *env, const struct strbuf *hookname,
 	      const struct strvec *args);
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

