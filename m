Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E486B2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdBOAf0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:26 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:36117 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:22 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so56117290itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bm7XJHfpZAD53PeyCh+mCxKWJuEFdMDYnk9K+oUC0Vw=;
        b=Nz8bMtxYjZo+O/hKC+cdRrBRAWgycVgmd+C2GQJZLktOlTAUEWZbSVZ9Jevo4MwtAh
         SMic7FbMOkgBHbH1MpGyFIUzbiwsQNOTyconP86MAaFPp+/VJ1l54li6Dmb1W+M9p2X9
         WNtre7BlionPV8chPZk2qCZTpctF7JVeJpSO/AId+ri9p5tU/9luCFzLesmegWJXfraz
         UcST76DdLglWGVM66ratXMjkHgH134vJYtd2dnL2zu82WlYHPih1WCvSUKSRLTejx6qp
         N9gPmi/rOxeHIqTQSsuxnj9VWEwgjocYmXXQFXh5pyCspSPA9UBKDxoWMF/Jwubu4WP2
         DjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bm7XJHfpZAD53PeyCh+mCxKWJuEFdMDYnk9K+oUC0Vw=;
        b=cq4SeuUxMP2MhOG7eoDhtUj3ArCLwYAAMfR+S0oUrICerkXDs55bG40e/rGArIOi5l
         oHOx2i0h7vJR+YY+q85UAutTpYcIUeCim3QuzrhNR9GGd7X0NQflTCwROOzZtYGVoU1j
         ZxR8AvexhazpK6eetZqzyW4UKHA+5Xv/nBsvl3iKCLSt5UjMWkCXboOMlSRz71DsX1El
         yHIqU0H8KOltB/jBzFhPbpOGpZcKdFFiivWJbyhkH2WOhjBxzY7EEyXXIo2QLJdwK6e6
         IfmS682wsMU+4j63pipeeZmYhZx+Zw2tPFHNNG8+GNmGmI9fxXiiHEBnaPpeK2SlT54r
         brtA==
X-Gm-Message-State: AMke39kDSIS1L8wXwSaXOVcGc4o1XCcIVlh3BPea26XF1x2aUDRymm9hHWMA1rsU00G0LLqG
X-Received: by 10.84.231.134 with SMTP id g6mr8433732plk.110.1487118916156;
        Tue, 14 Feb 2017 16:35:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id o1sm3285593pgf.63.2017.02.14.16.35.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/14] unpack-trees: pass old oid to verify_clean_submodule
Date:   Tue, 14 Feb 2017 16:34:19 -0800
Message-Id: <20170215003423.20245-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check (which uses the old oid) is yet to be implemented, but this part
is just a refactor, so it can go separately first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19fe8..616a0ae4b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(const struct cache_entry *ce,
+static int verify_clean_submodule(const char *old_sha1,
+				  const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
@@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
-	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ce->ce_mode) &&
-	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
-		/* If we are not going to update the submodule, then
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned char sha1[20];
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		/*
+		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
 			return 0;
-		return verify_clean_submodule(ce, error_type, o);
+		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+					      ce, error_type, o);
 	}
 
 	/*
-- 
2.12.0.rc0.16.gd1691994b4.dirty

