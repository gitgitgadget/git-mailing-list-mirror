Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34AC433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B512151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVJkzojv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgIMOzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIMOyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944CDC061788
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so10433604pfd.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhqnCInFVlqf7lfNjakMPZ5Cg7FnqmcRrEbX2MCI+qM=;
        b=kVJkzojvNfWUQ2Kg8dg8EcEx4gQjTHWqVSVf1oXkQ3MTbrYRYci0U1cp+phkkhFMhx
         BusoZX1l6w1dIUWSveHZffSAkjYxhWMBMcexeVU/ynWASQuoa9zd2EmOEbWpEPX6KGjh
         XKXgT4tJ2MN7FeUswIW0a3+9f/HUdIKxyGjWT2cWETfvlxGEEpcmZ7gkAWa4iWYOqE6V
         o5D4CioRfMMm1A5RuJMLfk7+V5ocFGJnESejPxe9nvKDF7yykJMsaZKxZTI/17Vp8Tc4
         YG06GIy5c6CcJe55Wgn/L9Bh0zXBmY8QmcJKdv9j2qdLjHuXRL18MjMapZAabrPFeY0g
         Co2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhqnCInFVlqf7lfNjakMPZ5Cg7FnqmcRrEbX2MCI+qM=;
        b=tN5lis97y2W/esllNfoUw6Bv4MFc0QfIjVC7keSRSvS/XlKOqEtDRnoVBvjyZxEM1G
         aPTiWx1+x6ZMrY8dwrJahhlP1bQs/MhZiYxVRSTcXg1R0PsU4xehTDwbQuHg11UIjIXx
         2QBix5W875WiACIwmW5rrMVDvYUWXtbNsR5pXEkgcrDqJsxiWfweOn74I+/P7Vseb1ts
         qOVDyXpEhGq+jlSS3GMUyWMj0iCNrUbW9gztEtjuuVJ/aRTy3ywOHjKI4IxJ6N02FLFt
         xF4f8qjwSNnOggL7SspdA/jAssxlxQjn1jO+vLlC6s87/2raPHj8GCuyH0rHfMscu77g
         K0JA==
X-Gm-Message-State: AOAM531ildgKuLvJwafkaLKbjGR4mL6fcwR/dr1LFBq1c+I0e2gzMPzG
        qNSNKQfoxLc/0h+pn43PR0IOuPba4uENXUoxD4Y=
X-Google-Smtp-Source: ABdhPJzq4/Gt/NXTZFAcFOdTYL1SuD8GAsbZDg6DV2VA2HBiTXVxDEvLO5tDbgTAadRfd7Elfm/Xlw==
X-Received: by 2002:a65:6487:: with SMTP id e7mr44087pgv.409.1600008871977;
        Sun, 13 Sep 2020 07:54:31 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:31 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 2/7] transport: add flag for "--[no-]force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:08 +0530
Message-Id: <20200913145413.18351-3-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new flag: "TRANSPORT_PUSH_FORCE_IF_INCLUDES", which is
set if "--force-if-includes" is specified in the command line
and calls "apply_push_force_if_includes()" if set.

Update "print_one_push_status()" to catch and print the ref
status if set to "REF_STATUS_REJECT_REMOTE_UPDATED"; add a
reject reason: "REJECT_REF_NEEDS_UPDATE" to map it new ref
status.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 transport.c | 18 +++++++++++++++++-
 transport.h | 12 +++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/transport.c b/transport.c
index 43e24bf1e5..7f5020bba3 100644
--- a/transport.c
+++ b/transport.c
@@ -567,6 +567,11 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "stale info", porcelain, summary_width);
 		break;
+	case REF_STATUS_REJECT_REMOTE_UPDATED:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				 "remote ref updated since checkout",
+				 porcelain, summary_width);
+		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
@@ -659,6 +664,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			*reject_reasons |= REJECT_FETCH_FIRST;
 		} else if (ref->status == REF_STATUS_REJECT_NEEDS_FORCE) {
 			*reject_reasons |= REJECT_NEEDS_FORCE;
+		} else if (ref->status == REF_STATUS_REJECT_REMOTE_UPDATED) {
+			*reject_reasons |= REJECT_REF_NEEDS_UPDATE;
 		}
 	}
 	free(head);
@@ -1101,6 +1108,7 @@ static int run_pre_push_hook(struct transport *transport,
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
+		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
 		strbuf_reset(&buf);
@@ -1151,6 +1159,8 @@ int transport_push(struct repository *r,
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
 		struct strvec ref_prefixes = STRVEC_INIT;
+		int is_cas = 0;
+		int if_includes = flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES;
 
 		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
@@ -1178,9 +1188,15 @@ int transport_push(struct repository *r,
 
 		if (transport->smart_options &&
 		    transport->smart_options->cas &&
-		    !is_empty_cas(transport->smart_options->cas))
+		    !is_empty_cas(transport->smart_options->cas)) {
+			is_cas = 1;
 			apply_push_cas(transport->smart_options->cas,
 				       transport->remote, remote_refs);
+		}
+
+		/* When "--force-if-includes" is specified. */
+		if (if_includes)
+			apply_push_force_if_includes(remote_refs, is_cas);
 
 		set_ref_status_for_push(remote_refs,
 			flags & TRANSPORT_PUSH_MIRROR,
diff --git a/transport.h b/transport.h
index ca409ea1e4..729bb6979e 100644
--- a/transport.h
+++ b/transport.h
@@ -136,6 +136,7 @@ struct transport {
 #define TRANSPORT_PUSH_ATOMIC			(1<<13)
 #define TRANSPORT_PUSH_OPTIONS			(1<<14)
 #define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)
+#define TRANSPORT_PUSH_FORCE_IF_INCLUDES	(1<<16)
 
 int transport_summary_width(const struct ref *refs);
 
@@ -217,11 +218,12 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
-#define REJECT_NON_FF_HEAD     0x01
-#define REJECT_NON_FF_OTHER    0x02
-#define REJECT_ALREADY_EXISTS  0x04
-#define REJECT_FETCH_FIRST     0x08
-#define REJECT_NEEDS_FORCE     0x10
+#define REJECT_NON_FF_HEAD      0x01
+#define REJECT_NON_FF_OTHER     0x02
+#define REJECT_ALREADY_EXISTS   0x04
+#define REJECT_FETCH_FIRST      0x08
+#define REJECT_NEEDS_FORCE      0x10
+#define REJECT_REF_NEEDS_UPDATE 0x20
 
 int transport_push(struct repository *repo,
 		   struct transport *connection,
-- 
2.28.0

