Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE62EC4BA06
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313D2467B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4cy25Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgB0EfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:35:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45117 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgB0EfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 23:35:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id v2so1578977wrp.12
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 20:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=U4cy25Njq5bzgDYDDubgOZTvQ+3RsRXrtwQ+6ghMQvVCURhj0/zDyv7X0jrnAJUm0x
         YqPNNFKV9u+a9NKau+SodLwlY7BM1fZsEXE07Zo/1sop4uU06AwZPQRW1bAjoho1TbR/
         i9GKCcMCWI0Z7m3/2IoYebyeaJVRjPGcIGd0oDeqTD9l2IInL7yLUfjbQVbaiGS3qU0X
         x8SxCRzQdPGs+Gp8msJm1QONYFBflgAOKs+vGKtJkYQQNz4hVokrqzlofu3AtA3GwEki
         LhNXXKx3QPAOL0xA/S96NE/DdnnICrMdVsgky00dp/G7QH/XxpAOJfEMNigMLzV+rdBH
         FLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=aDwX7SYg8RKG4g9sdpj8uHC8/BNTMSXpb0vrBUIA8agEnkHJ0bbUAoeU5s4UoKoHCi
         i0HlpkJg+bWjRz3n52ITpfEYyg2yYc8zWa6Q5i/sIyx7VBs3zPzvzJvgiALGEGsIXrOg
         YFpibumHDzUakJU4MI0UcUvlosaud3x5/fAANEEeaVx/KJy7YoV6RGaYbDkRAlV+hwE+
         GI7eXGBAoUL3jIjftwvOiurwIcWLQk8Cxq6pm/yPn01FXfbEStlHw9iKbVdm2sKPr+Fm
         WE+dKUAxU+vFQOxD/s69nxhpPHEtTGRIurOQrlsJA0nnYKDorKq0/RUwNI4Hfo82Tgtw
         5ToQ==
X-Gm-Message-State: APjAAAUkOp0gusKW0JtwmH4Iw+cYtUeH6qbxEA/dC36ijcFQPSYQmTC4
        j+MtoqtlMhQWYbbsLOGTPYpSvsUp
X-Google-Smtp-Source: APXvYqx0XvGC0aLLgPEWI6seRk+hk+o51YUgpmrIUvFMgzAvN22AhAX1OoI3+1EMfeFrUxRE2vNwyQ==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr2346427wru.421.1582778114176;
        Wed, 26 Feb 2020 20:35:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm5900391wmd.20.2020.02.26.20.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 20:35:13 -0800 (PST)
Message-Id: <f668d9b7ca04da1d8adf0a146b48a46559471501.1582778112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 04:35:08 +0000
Subject: [PATCH v6 1/4] advice: extract vadvise() from advise()
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

