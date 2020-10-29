Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E90C4742C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2938A20838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLSZqHmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgJ2Vcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2Vcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2AC0613D3
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l23so4094596ybl.23
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=Bg7U+or+Hq+U9HC9U1C4iUziwAjC3NWcXNQcFIlFUVI=;
        b=MLSZqHmPEhwTojwrkX+kEyFKrt65b0ZSiagETgD5revzVIa1edKE43Al2nWXkFNNLG
         3ryCd5q/1Gmu1xJLM5jbL35vdUnrAQEDN5QhPDbwkZSYCR6CeNtgscqHMDqiQDlwSd+P
         MckswqeRkmXNXWO4kE3DXz1INY9sx00WU8LPI/dFQ2AG65+eDtMqRUyR5m3oHsu64I0k
         5IyQ27Yd5E9E3izbCpyoG13zfKJQzPoMS/GeDxTvs7rY4NrjUY2zuQkCI7jTCfjCDmYV
         DKx+SRJkFl80TIg/qVIwzdx2JSsSxzeBCMwV4QpAGQV6DOVO4LHLxk/71Eu1CqukyOqX
         4XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=Bg7U+or+Hq+U9HC9U1C4iUziwAjC3NWcXNQcFIlFUVI=;
        b=Sn0NLMyWUCXL2DfuWIn3CiK4rzP9Owbz19ksnDvbskdGr1SHq57VHK5LnaO8CRa1+O
         vzIuvAaTOnnDg2cHBfis6KhHcX0SFHh85ospA+2SH2qkDEBwTv1GYkvMvEy7BGeE+UHD
         XpFLPSfyvrB79mtk98CL2ebiLIempqo3LTP3jWwCu4J/XqRFrAGX6Rgde0NNnxHTOdf4
         sKbX9DMGj8GEHznk5uUs8E8W6vmUw++X8CSg5+imyzhcIXigSU4TJ7X/sY3J+cx/pzi8
         EiZ7wJKf3/yGlyxgzwpIXCDIRVjUxBxoltZc8r+KweIZMFiJTp4oD50MZY7vGKVSm4bq
         f8VQ==
X-Gm-Message-State: AOAM532m3Pr/4wRBtUxYzO74g6478kFg+5eymGHAtELIz5q0PPJoA1kj
        gJgyDss5oa4aAKUSYulWanbnqpkpV8EnMpIDBVrADKrJUkHcz2sNFP+XngaFhcIf7oAc5LOPv04
        j2ZjPO6l4ZJOGaBGcOoAnu/7W2w+vVl/Hk40EBaLzByqYxvZBei4qjYQSL0H+fRw=
X-Google-Smtp-Source: ABdhPJyO1s5rIQnfkG7rIqAp0vqQBq9kmxgMaKWGuvX4Dmci1/mgojZZhC8mrRNI5DWgTPkO6YZfoqTsJprqZQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:c7c9:: with SMTP id
 w192mr9021721ybe.244.1604007167515; Thu, 29 Oct 2020 14:32:47 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:33 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <c07bf8aede12f2626d2bb8eb109b9fb28dea0dc2.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 03/10] upload-pack: advertise trace2 SID in v0 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled and trace2.advertiseSID is true, advertise
upload-pack's trace2 session ID via the new trace2-sid capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 upload-pack.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..862656010c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,6 +27,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "trace2/tr2_sid.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -110,6 +111,7 @@ struct upload_pack_data {
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
+	unsigned advertise_trace2_sid : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -141,6 +143,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
+	data->advertise_trace2_sid = 0;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -1178,6 +1181,11 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
+static void format_trace2_info(struct strbuf *buf, struct upload_pack_data *d) {
+	if (d->advertise_trace2_sid && trace2_is_enabled())
+		strbuf_addf(buf, " trace2-sid=%s", tr2_sid_get());
+}
+
 static int send_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cb_data)
 {
@@ -1193,9 +1201,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
+		struct strbuf trace2_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, &data->symref);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s object-format=%s agent=%s\n",
+		format_trace2_info(&trace2_info, data);
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
@@ -1205,9 +1215,11 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     data->allow_filter ? " filter" : "",
+			     trace2_info.buf,
 			     the_hash_algo->name,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
+		strbuf_release(&trace2_info);
 	} else {
 		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
@@ -1299,6 +1311,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
+	} else if (!strcmp("trace2.advertisesid", var)) {
+		data->advertise_trace2_sid = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-- 
2.29.1.341.ge80a0c044ae-goog

