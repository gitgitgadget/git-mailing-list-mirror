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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C0C433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2215D61108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhIPKej (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhIPKeh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1736C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u18so5794855pgf.0
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnkkddKqtqWYsXo+82ptvtqq+qtAQ70WTJ2ehwv2NG8=;
        b=dO6SdbbV78UNMNnWnGT7f1eIxm3kG2t5I65HGSmt0yDBk27MdoNmMAqE1DNns3hHUx
         k4DNmyKpanFRKYYdRzQSZNhSlodyNDdXrbPggLSB6phHRp/pWjrH3R6sPzGkL8ajoaJQ
         2lrOrvOZgawv6BfKuamGbOBRa0iKxIW1tAo5xL5Na7LD2A4A2RItJCQXMwutOs5udpBy
         tYvaOfqvQbTSejFYC12dxNA1IUj449qS5tU/Cj2O9UtQa6P9ShtJT2j/de6ed3l5OzQh
         YlRb5rEOMkIKEIiuachKqXyrUHPJNEHi3iA98kSeXhQ5UI7dN0E+aKd0QgLek2iNNbS+
         QyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnkkddKqtqWYsXo+82ptvtqq+qtAQ70WTJ2ehwv2NG8=;
        b=zmuwQEvGmmhr4P9SE6aP4v45XEqmlFnFWMApJxEpEztYCfuL1fLBTWH+AqqIn5RUm5
         kvLEDxi091iwUwYCYUo+CGU9wlCO2g6UOqnrqfWuVbpBKNnbtmwvaS81PMui2FCqz0tY
         drCXHpANN1GbC/eRYmCYrQfHriwIzWAl1SfYmBotkKHyrxeaIozv9j49DraZuCUAZDjX
         UIHBBpzRflgBU7KjBeKGfzHI1yOnYR1ATj6ussTeeUWz97J7Nt/JNDzKaqHz1UUMfyQw
         7OmK9PfDbQv/jGQOouDGlJGU3JglFeo1A+WegN8QEKDzrvBghjqIQ8vVr1nk5mXp6qFe
         Ex3g==
X-Gm-Message-State: AOAM530O0QbkQJ7A6LBl6l00k+g7FB5FGZojaIxy6qoZwz5FV8HdWhKB
        7YjpslbLRqX+4GIqgkPhthy1OBIsKhA=
X-Google-Smtp-Source: ABdhPJw7iIV2C3Qgue52FQSWnhi+hJr7G7LeZDnlmA8PIVxWJSE7fGocgYVS8bvHHcAeFd48FJu95w==
X-Received: by 2002:aa7:8893:0:b0:416:4ed7:e4c4 with SMTP id z19-20020aa78893000000b004164ed7e4c4mr4452001pfe.83.1631788397274;
        Thu, 16 Sep 2021 03:33:17 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:17 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 4/8] submodule--helper: refactor get_submodule_displaypath()
Date:   Thu, 16 Sep 2021 16:02:37 +0530
Message-Id: <20210916103241.62376-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b0336b0377..10de01a1f7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -269,11 +269,8 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *do_get_submodule_displaypath(const char *path, const char *prefix, const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -289,6 +286,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.32.0

