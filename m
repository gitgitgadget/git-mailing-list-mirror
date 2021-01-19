Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160EDC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E5C22DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbhASX2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbhASXZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:46 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BDC061796
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:36 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s6so10051212qvn.6
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8wKdeIxSk5T2Awn8mJpxz5DDNLf+qFk7FPESZodhFg=;
        b=gAXM4caj4Vac76HYMwU52IaDJ8+6tEwe2Mcz908Im5ILVA0LUfvwzEhT7zReDBU017
         YRpTzEPglK6f9cG6qJdUePVzwxvw7lyubkncbXyM6nCZNSp4R1nOrX4hfsWpnAtyfkPp
         OPZO9Cq8pEvgUItq6nWo92rJK1qzsfuktfZURUFh9EtNtH0f/Ol999GcHVE1KOfxru6R
         k0q4avOTuYJUiP2tgZsMRdWIOdL8+/JfEtUiIQGg53HAq+urp8SyZlXsyr+7+HoLfVeP
         t7s47yyEG9xyrZIJ33FCL7WmmlCwc7B+m1XAL7A3eI4BuikLQ7ZWxQ6Peuyqu8gWyfp9
         63eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8wKdeIxSk5T2Awn8mJpxz5DDNLf+qFk7FPESZodhFg=;
        b=GfB5tZlyehvb7p4N0WY12kChI2wxcAS9zX3eUJvFoY/0JlDa1wQS//8Ajq8z+PU2hW
         I7C3CRBGf5C1hthGeHChGhFTcL6KyvNris9a1n0DZ/joeSDXsllrxxvXMvdmIJeAhmXp
         bxywdiUYOdRP8llTBu5LzC+ePnCVPH/Pz+dE7EQ3JHfaSJzIgPKPdcNLEycuFNlkuQqW
         48OJgkj4tu3c/extaP7Ge459yZ5n/DAY752H5ngAWHyayJ+Cev9OK44Ltbk1hjrklbeL
         0vl+QAUz46AIVMsU15aRE4iKjqnFSE8JHofrc8uQSETirLz5UtsrsVwTcs73jknWxnEq
         9AlA==
X-Gm-Message-State: AOAM533CvhUR6wtBn9zBHWDnreExIF9HKDpDBpD7sBYGx45/6ZX/iMfJ
        inqTCs2yOVKXq9fxnB3bjLJ+4DdRnaPGUw==
X-Google-Smtp-Source: ABdhPJxE/HFa1DSar3spMqAqcpSFzpqewcSks5QaOfDAY/Yh7QuQPhqZy9EKDxXqtLf65aZxIXg5Iw==
X-Received: by 2002:ad4:4a70:: with SMTP id cn16mr6997976qvb.38.1611098675948;
        Tue, 19 Jan 2021 15:24:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id i17sm90959qtg.77.2021.01.19.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:35 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 09/10] builtin/repack.c: extract loose object handling
Message-ID: <a808fbdf31afc9ad9ba0ab27ce889e5a2d1a01ae.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git repack -g' will have to learn about unreachable loose objects that
need to be removed in a separate path from the existing checks.

Extract that check into a function so it can be called from multiple
places.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 279be11a16..664863111b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -298,6 +298,27 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
+static void handle_loose_and_reachable(struct child_process *cmd,
+				       const char *unpack_unreachable,
+				       int pack_everything,
+				       int keep_unreachable)
+{
+	if (unpack_unreachable) {
+		strvec_pushf(&cmd->args,
+			     "--unpack-unreachable=%s",
+			     unpack_unreachable);
+		strvec_push(&cmd->env_array, "GIT_REF_PARANOIA=1");
+	} else if (pack_everything & LOOSEN_UNREACHABLE) {
+		strvec_push(&cmd->args,
+			    "--unpack-unreachable");
+	} else if (keep_unreachable) {
+		strvec_push(&cmd->args, "--keep-unreachable");
+		strvec_push(&cmd->args, "--pack-loose-unreachable");
+	} else {
+		strvec_push(&cmd->env_array, "GIT_REF_PARANOIA=1");
+	}
+}
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -414,22 +435,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing_packs.nr && delete_redundant) {
-			if (unpack_unreachable) {
-				strvec_pushf(&cmd.args,
-					     "--unpack-unreachable=%s",
-					     unpack_unreachable);
-				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
-			} else if (pack_everything & LOOSEN_UNREACHABLE) {
-				strvec_push(&cmd.args,
-					    "--unpack-unreachable");
-			} else if (keep_unreachable) {
-				strvec_push(&cmd.args, "--keep-unreachable");
-				strvec_push(&cmd.args, "--pack-loose-unreachable");
-			} else {
-				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
-			}
-		}
+		if (existing_packs.nr && delete_redundant)
+			handle_loose_and_reachable(&cmd, unpack_unreachable,
+						   pack_everything,
+						   keep_unreachable);
 	} else {
 		strvec_push(&cmd.args, "--unpacked");
 		strvec_push(&cmd.args, "--incremental");
-- 
2.30.0.138.g6d7191ea01

