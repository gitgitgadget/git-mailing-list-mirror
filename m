Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D7C35DF9
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C70E21556
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oelhYgVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgBYKzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:55:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41924 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgBYKzr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 05:55:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id v4so1296602wrs.8
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=oelhYgVnjTx9B2aRgVbxmyi4tCqgtu2bB0WppD1+4gV5+ZcOfVsYzHTGIAiv7ubsnB
         RnBFOe7e054lwMmX6YtUJYqP6MYsg23+m4EKZ7pUZbso75OdsdsYmx+s7Xy5p9JVFppC
         fG37wRWvldvMVq5JF2YrZOZ+p+Mx120/sefuFqMbNg2dmt1fZUJMD8ENPQzkF7mFTNg9
         K+Q9o91ESDzGHMrmAlDLTtYn/Z4Wg1m9h9QyXlmh0j/ADr4rCTB0F4ef52Qa5O7nNh47
         gKHJKlkrBSMzDrL7JVTEBx3UOJUNmGpdq+THg3cqm6ng6HxjlAb+G4lYVFTcUW10SW87
         3P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=H+sfPuZIwID1iGmoRtqUYGSVP4IbZ1s7ly7E6L7piEcUBcjAXCwzYchPwYxzY95krk
         1SC0T2wnsSp7RAjpmw6uLVyDq5ts6cAbsXMdrD4YE2VCgJTmtOJJqunOBchmYRxplEui
         R5yYEtofjtFKsRiyVEsZ6vkBSYYS9BuIDz+woV+7BxOMTkd1+mrVjx1vmU2sH9kQCtdq
         YLXm5PUkzRjGVkl0JbK7jFkWN4zH8cQojYM6sOKOJqcK0QwGeIP/r/c7IJ+0n7psAhHQ
         BV7AFhuW406hfdV54jvpTtxLuKP8LSs3yPoN023S0S33yedgmlnD4KOLIpfbofk6gGT4
         mvzw==
X-Gm-Message-State: APjAAAUvW4LmxXmFo1Sa7PL8OzsaT2PrSBtuoloOPdIJfGxdYtITLNvg
        GQJ/jPxRrC3NqBZwAeAsxgjM2D22
X-Google-Smtp-Source: APXvYqxa6QFlJzAgxBiqQ6Z3d2sIY0GUTYhDBbg8f+bz5XK6vYNoY7LdVN/qe2PzkFSOtA0Y0Qv8Wg==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr7174651wru.338.1582628143600;
        Tue, 25 Feb 2020 02:55:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm3786682wmf.1.2020.02.25.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:55:42 -0800 (PST)
Message-Id: <f668d9b7ca04da1d8adf0a146b48a46559471501.1582628141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Feb 2020 10:55:38 +0000
Subject: [PATCH v5 1/3] advice: extract vadvise() from advise()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

In preparation for a new advice method, extract a version of advise()
that uses an explict 'va_list' parameter. Call it from advise() for a
functionally equivalent version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 249c60dcf32..fd836332dad 100644
--- a/advice.c
+++ b/advice.c
@@ -96,15 +96,12 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-void advise(const char *advice, ...)
+static void vadvise(const char *advice, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list params;
 	const char *cp, *np;
 
-	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
-	va_end(params);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -118,6 +115,14 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }
 
+void advise(const char *advice, ...)
+{
+	va_list params;
+	va_start(params, advice);
+	vadvise(advice, params);
+	va_end(params);
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-- 
gitgitgadget

