Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396A41F462
	for <e@80x24.org>; Wed, 22 May 2019 00:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfEVAW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:22:27 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:46130 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVAW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:22:27 -0400
Received: by mail-yb1-f202.google.com with SMTP id v15so577544ybe.13
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GdyG56vSCo0x4ulaUpduxV8qpRdNpP8CGYxlpDpGSAw=;
        b=Rtw67QFR2tXnqIV5l16mseBZhi/lTxfM6G08vJg8j2+kdOIjl46WcXVHedMPN3n6+h
         YEWWUSAmPDwswdbvI30cEUdQ0vgtgENvEzc+QU/UKR+KqtSX7hwwxyEpotP3um0Xa/Zf
         AZaY6MVhQBPhLPbp80/h2N0EMsGIOgGiZERg79r0Dv9m42g9eL1L7znYXgzhxKAqroEX
         2vtWJjfKnRKqi/HslfnuZR62s0Jp8S4QLbD0rbyKoXj6X7Ec54iHXdoQ1EM2llPMDn46
         j1q1rPviCWiL8g4j1p7AeRNltS3NxDmFz9O6/xRD0WkSaJXE+pKbm5nLnPLAANg+3z9w
         QOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GdyG56vSCo0x4ulaUpduxV8qpRdNpP8CGYxlpDpGSAw=;
        b=AbgX7Buv/apNkKaBcfj/9Yl6Z8n/NKlf4yvKPuSdS923Y6VpXvcFfyp7CEbtnII+y0
         ljcdHn6hGuaueEyegxEMfoF79UAa8ucPfJfqoT8mXHeYNlsPiVXTbdMsCaenol8ls5TF
         J/Yfc9T1jmeaQ2rmR3wuv4Do00akZR3M7MVV0P0GMpSj+gVwaOT8O5dEg2B2GrF9Xb87
         dKWUIHkYOdSd2q1xVuI7LB3GmWQsDWIZW1zBIF0j3sp/vnzdz+oTcXRYOIdmEcVQmCE9
         pU7K3H9K8I8HcmA3peuMcDW6A40mkkWu0GWs0HMAGO3csXdPociB/Da6oJ9IBUqZfZcp
         l9zQ==
X-Gm-Message-State: APjAAAXc/mSgmxX6ChX15F5bIS1iBmIMVgVYqywxfiuh1zF2t1uPKS8X
        ODQUgvG9Ej8qE/Y7If7lHwddQK/+IS8=
X-Google-Smtp-Source: APXvYqyV5JIr3v61NOdGVx3Oe8dKgkTk9zq5xSSjUzk55ZCj49QLmh3adP/t3Toa24cKZtSY96A77OV4v1Kd
X-Received: by 2002:a81:2d07:: with SMTP id t7mr29465567ywt.495.1558484546139;
 Tue, 21 May 2019 17:22:26 -0700 (PDT)
Date:   Tue, 21 May 2019 17:21:53 -0700
In-Reply-To: <cover.1558484115.git.matvore@google.com>
Message-Id: <4a8e92ad97e65f6cda65b5cb120182ae8612b436.1558484115.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1558484115.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v1 4/5] list-objects-filter-options: move error check up
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the check that filter_options->choice is set to higher in the call
stack. This can only be set when the gentle parse function is called
from one of the two call sites.

This is important because in an upcoming patch this may or may not be an
error, and whether it is an error is only known to the
parse_list_objects_filter function.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d7a1516188..647b2b220e 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -27,28 +27,22 @@ static int parse_combine_filter(
  * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
  * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
-	if (filter_options->choice) {
-		if (errbuf) {
-			strbuf_addstr(
-				errbuf,
-				_("multiple filter-specs cannot be combined"));
-		}
-		return 1;
-	}
+	if (filter_options->choice)
+		BUG("filter_options already populated");
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
@@ -239,20 +233,22 @@ cleanup:
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	if (filter_options->choice)
+		die(_("multiple filter-specs cannot be combined"));
 	filter_options->filter_spec = strdup(arg);
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
-- 
2.21.0

