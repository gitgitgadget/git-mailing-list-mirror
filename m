Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B4BC10DAA
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82CA2166E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="K78X6TWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgIIRSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgIIP17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FDFC0619CF
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:23:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so2787799qkf.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LIRW4oc5ufASPAzIyTY4rQFIS6pi6+of9Ao6fxrspCs=;
        b=K78X6TWG2ihZUpuLFIgsQXW7PZSD/o5lQxrmGGXl7dM9I+ROz4zGVetIWeWpEwYu4u
         4vASEirh2W92NmIUsRKe+yKiKuNMjsUDwsdHQ/TZtFcuWBBzLa05qk6JF/FfIlLITr4K
         hZOZ6SIa/xDJn0LuOwyDCTFNRLzgdv4ZnzensI0HYHNDJLC3EBgZvWOKGQVTmB505UNQ
         acJhag8qX4I+WfTzj7SxMg/zyWF950MUUnk7UXMbZz6/LTj1JvLmAQNquGTyRumkvp4F
         hTnpuqi8vzm3QuORnfnnTUbW0kwskTC6bYL7L3NoDjGTTGvyYgAD7hIKLY6CgaC1VDaT
         UJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LIRW4oc5ufASPAzIyTY4rQFIS6pi6+of9Ao6fxrspCs=;
        b=gYFzncK77YlmyB6wQVswRa0GCkXCnSvSPkJ0lJpEzsqPX1luWTFxWWa0bm7N8+P0/O
         h+R6hdFD+tBwaWCPakPf5e1I+rao7dlJHAxlxV9k3bM5rc1q8mHlSD8XnOUPPbHVuKIy
         LoCRdK+ZioFIOrmK/UbYxQKZJzemdS6l0Z+JClRy4n0PzwGgNlU0VEjj7WGjdvFJkH6/
         VkhG5S1Ytfp0VrP6nq1IDhFvXNi+a68kYprRgqFIJObUqURBWaxCkHofMSBMCmwMlhHX
         WSFTvYysHM65fR5i+X9MJJGWhG4TyM+i5rfPhDrd9ZFqmLLo33aM7EtRDf6ZQ53+5jyI
         dEog==
X-Gm-Message-State: AOAM533nbqa+mG3xEFGpYPogBNQ6abQctEQK5eUTVZUvzyZHuhNrjfzZ
        3XkBhsP4lL6ZDnxU71U5YfktzibaVNQrHuZO
X-Google-Smtp-Source: ABdhPJxf8mV+fiugbBqfPXJBFJ/upNenezyVturGdn9A2UFhmjD7L7wXWdvFpOBigzHFxlGcmNOoiw==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr3671711qkk.191.1599664986715;
        Wed, 09 Sep 2020 08:23:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id z29sm3336763qtj.79.2020.09.09.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:23:06 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:23:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 04/12] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <809972ba5f261c72146efa0461c19cb34daaa513.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read-graph test-tool is used by a number of the commit-graph test to
assert various properties about a commit-graph. Previously, this program
never ran 'prepare_repo_settings()'. There was no need to do so, since
none of the commit-graph machinery is affected by the repo settings.

In the next patch, the commit-graph machinery's behavior will become
dependent on the repo settings, and so loading them before running the
rest of the test tool is critical.

As such, teach the test tool to call 'prepare_repo_settings()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..5f585a1725 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
+	prepare_repo_settings(the_repository);
+
 	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
-- 
2.28.0.462.g4ff11cec37

