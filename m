Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E2FC2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF6E22280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTvgDdW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKBWbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:24 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18956C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:24 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i39so9011255qtb.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=p4L4TRUHpEhevASEZmzr0U4+YvhUsrFw7BKWbkCN5zs=;
        b=uTvgDdW8mF9wqj8/EwDG1XydXBbCmvqBRuSkYfGYtE1nV/zdEe4QQqccPWjMenD6V+
         XhXDogG68X7T6Ktwfji5AzCdi6oyDA15AXBgjeHbWNNlYlxvaHvE56J10jqjLV05kCbW
         31tjWGRwN2cIqT+5b47fiNSogumm5dm8mhfhF4978uoEjMnX6DYBxdvtHtCVXMjDCm3h
         KccJ7k/EenMYaACF4XPEVX3cy/W8VX2u4fbypWwEB1KszZYqkCMUsIhOWL7sw4B15aVl
         J/vmHJZv6MIVzhpHuwUIyLrjd4/Nr1qlD4Wj8CGAU9xF8bd2O7FlUmpLt7p4Jmd44k5e
         3G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=p4L4TRUHpEhevASEZmzr0U4+YvhUsrFw7BKWbkCN5zs=;
        b=HBYT7UUz3R1tsXGWQ+cTzmBZAkZPmuQOz6JNND1sMbcxCBVnUgYVEtaKxUwHTSxAou
         7XYMc7l9LS4UY2tGGDWoWzaVjaLEY9ut9ARSvKp5cdmitQhpWRMkVqW6KbKtjywt2PVa
         ciC1QaqXEkA8QJM4dDhJ9uI5Ztx+TbgV2EF/VwtoJEs7L4Zb4cdMP7nezC6dG3OwqLNg
         py/UuHIFaVOizP88oshWNLXGFL5x0wWcbQH66afoZnw33u3iCrI0+jWk6tdZA+7PUIsG
         5MBQ6rVNExfUUJZI7PBS6AwIllIRWv7eOE5Kkg9OfEez/pIJ7DL8LuKDV3XI7jK7mLw4
         zT8w==
X-Gm-Message-State: AOAM530E9F6BUGnR/u30J9SeA29CjMC88y9vooPnPcRas5FM0oLmEXbb
        Nl6hkQ8fIoXwNOfCOvO1Ra5ozkSQ6Pz/ujJT98tHI+q+4sAwth7E4koWiI7XUtKEY895csRxqUj
        BoZxJXSYT+3x8xn1gUr6Mz1C5Zy6eMd6Qb3i2G6CNNfKewan0LYzflP/plGXSVc0=
X-Google-Smtp-Source: ABdhPJycZrPgNq3J7JTYgqScT5o1AovukvH75TvX3H09vGuTl7miuSh3Qo3g+mtoDPfKatiOCy+MkZAHqSEkNQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:ad4:458d:: with SMTP id
 x13mr25224947qvu.4.1604356283140; Mon, 02 Nov 2020 14:31:23 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:04 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <9573428cc02111d3141ec2481bf679b31a5139e2.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 06/11] serve: advertise trace2 SID in v2 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled and trace2.advertiseSID is true, advertise the
server's trace2 session ID for all protocol v2 connections via the new
trace2-sid capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 serve.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/serve.c b/serve.c
index f6341206c4..b40d7aad34 100644
--- a/serve.c
+++ b/serve.c
@@ -8,6 +8,8 @@
 #include "serve.h"
 #include "upload-pack.h"
 
+static int advertise_trace2_sid;
+
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
 {
@@ -30,6 +32,15 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
+static int trace2_advertise(struct repository *r, struct strbuf *value)
+{
+	if (!advertise_trace2_sid || !trace2_is_enabled())
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
+	{ "trace2-sid", trace2_advertise, NULL },
 };
 
 static void advertise_capabilities(void)
@@ -261,6 +273,8 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
+
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
 		packet_write_fmt(1, "version 2\n");
-- 
2.29.1.341.ge80a0c044ae-goog

