Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044CAC4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ADF208B3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggqSLrmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKLBcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgKKXaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:30:20 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD599C061A48
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:48 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id a1so2548580qvj.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=3JnLb44Hcl2AEq7btI9/QWLzUhYEnzSwZeFrrY9880s=;
        b=ggqSLrmfYrBiVW4vCgUlDC1+ksphJYNPpzPVZtbuxAbILvbvwV6KLVRh2eKFCR6S7h
         rnPdzgUAlldFyo1Z+3Q3pvm9uu0Yxl8dgsyX91XIHvsqWt2qk51Vod2UNJNe6B+oKOBl
         iSKQbVBeJPF7QFpqRwmuxoHRWaGCT9ZagOyFeVTaw8pzhckgydhOv8h5SI64wgNTkSTX
         3m0WbCoufqOj+N2vcrBhO1HymzJtg86J9uL7byQRmiWyRqmv/YtmJWM9emuLUn8WKSA+
         QrKertc6tD7BYOtYBxHuAPExEVFHO5eiQIoDWi0+GYIQGCpwmenl/hf4VJK+DvfwoApB
         5DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=3JnLb44Hcl2AEq7btI9/QWLzUhYEnzSwZeFrrY9880s=;
        b=Ph00ARi5AKN0rrZ9CkrMElbNFDWXOhjXfOkbbkYKyUGuW6G1AEBWXjvNSC2zYK2dkZ
         fV8J39FBsfcVwGoI9LNrHfS6WZgFV3JQzRIuvEDN/sLPy/33Yewe5g93Ac/NaJeZdl0a
         aJin89DaCoUv/DzJoQkgPb/LGfZ+jiSFTqpMl+SxKdzeeni1ZcW68rGdcAr1GVsO0Ynp
         YS2XOzzIzQZZXDM2NwiuRGxfbXAgnOQzhPorKo48X0I1ZH764PaTHwOM+dRJ6W0LsvyH
         R9MTZI9Gf5kdXXE2QAPLOOpwLonvgFfe7dwtsbtccykqb0OXGwG6oUVSn9oa3Sh8SEfd
         Dtgw==
X-Gm-Message-State: AOAM532RuYeCDRWN0WUpIcj6cFMPVwcaQuxbG/k31GLsaF//saX5tskV
        xSEd/CE9mIWUMbp4I4tbp0anc2qJH57tT+RGTPYTnjyuJi4gSUoKBWDa5i759quF5jDh3Bgvo7y
        Xw6LLbwfUyO17LO9nVCijtvqdqOI+TDawk7T10roOj49UUX71ATPFJK6mm2gqGlI=
X-Google-Smtp-Source: ABdhPJwLunP8i68VRX7NCF7StnDoAwuIShLzv5dyfznCWp39FG4NXZbZl/6mkyYsmbeVUSKFsrhRMJcrS0TRkg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a05:6214:1507:: with SMTP id
 e7mr26783772qvy.50.1605137387810; Wed, 11 Nov 2020 15:29:47 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:29 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <fe6731cc0908201f26cb04c5b91cd78a6c4f2602.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 06/11] serve: advertise session ID in v2 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When transfer.advertiseSID is true, advertise the server's session ID
for all protocol v2 connections via the new session-id capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 serve.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/serve.c b/serve.c
index f6341206c4..8c0bb84f37 100644
--- a/serve.c
+++ b/serve.c
@@ -8,6 +8,8 @@
 #include "serve.h"
 #include "upload-pack.h"
 
+static int advertise_sid;
+
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
 {
@@ -30,6 +32,15 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
+static int session_id_advertise(struct repository *r, struct strbuf *value)
+{
+	if (!advertise_sid)
+		return 0;
+	if (value)
+		strbuf_addstr(value, trace2_session_id());
+	return 1;
+}
+
 struct protocol_capability {
 	/*
 	 * The name of the capability.  The server uses this name when
@@ -66,6 +77,7 @@ static struct protocol_capability capabilities[] = {
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
+	{ "session-id", session_id_advertise, NULL },
 };
 
 static void advertise_capabilities(void)
@@ -261,6 +273,8 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
+	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
 		packet_write_fmt(1, "version 2\n");
-- 
2.29.2.222.g5d2a92d10f8-goog

