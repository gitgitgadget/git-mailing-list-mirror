Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F672047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdHCJTp (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36464 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdHCJTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id d40so1420918wma.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F4vUuRPdxMjG3ruz3Rt2OUBeOaq5D4YiIqIfNVRaJSQ=;
        b=NVNzgk8NU6K16am8dBw3itS/Tkc37rvfKkruTZduwaOqiZVrcDavgHej5gBVXZGDiO
         UMIWbfl0PzPf5cCHA32Mico+Q1wBipP2+nisYgIIvEW7IO3R//2/8MlRN21y9E2oTko5
         e3n8Q1GA+cBaJKJ9vmuM09jR/gB8xN0KwRM0N+iIAiw89RlRm1/GHVS2FfO7vGZr4xlD
         iOVshwvVjK3k+5mKLZXytTyYwdUZWagc1HRTFLYocuQtKJWI0Cph+L/ofmKCYPI/o7k9
         sUqLMXegnRJvWiGmECKZLXne4D9DZVBICmqNbG+joxWySWtQq+uK0P4syGQb6wkHXDaV
         BK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F4vUuRPdxMjG3ruz3Rt2OUBeOaq5D4YiIqIfNVRaJSQ=;
        b=g9XCah8C8ZXWmA86ywqLaKPbgD2tJOpFCU9aq07H1eADWfPEWZkPDhvuf1YdOfMyFH
         MJvlrOcW6TOlzmEN6XGhyeh9XTKjFs7OgiEbNKfeH5NOWmvx1LeT1Rwz/Bpphon/z0ad
         AQsU+0EgSHoa8ljGpTz1bFoEArv5KVSXRZOWSCBMCNo/2RWQz1f+cezAksaXUn+vf57O
         1I28UvS4W7B+y2+kv2sjAZKPw+NfwolyKzFsdVu4EayoOYm7sZD8z8B0I7xoYnFdHIhg
         zfy/6XBzbN6Ttm/cotQYQCJ7Ae+HFhHUGyLmeDbbuVNif7w1pfr2h4U4v9g4rF8IxT3M
         UKYQ==
X-Gm-Message-State: AIVw112Io+et9tQw53bDt2PSWb/3Pz8qOi9BBXBpHlBiVmUipNB/eNFa
        XP7vj6cGPJjXg/Jb
X-Received: by 10.28.238.85 with SMTP id m82mr714535wmh.107.1501751978916;
        Thu, 03 Aug 2017 02:19:38 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:38 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 01/40] builtin/clone: get rid of 'value' strbuf
Date:   Thu,  3 Aug 2017 11:18:47 +0200
Message-Id: <20170803091926.1755-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code simpler by removing a few lines, and getting
rid of one variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 08b5cc433c..4b5340c55f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -871,7 +871,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -1036,7 +1036,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -1050,10 +1049,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
+	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
+	free((char *)fetch_pattern);
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1192,7 +1190,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	free(refspec);
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

