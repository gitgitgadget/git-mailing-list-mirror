Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87AC433E5
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E22619CB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhC3PEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhC3PDx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:03:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654AEC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:53 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z9so14428113ilb.4
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=QLuFurfbqCYnSA7Tqu+jSqnrDra4ycwDnP3aZan09hQflraA/LkgodnRMDmbtRtHd/
         YIgjg+mFSxyItkmJ8LxqHaVty7zTYNXV/yqq2vp6CqzHmtGEJgN3P0NqaMLTe5MrY3Dh
         YsUDwa1A6Hhq00TLnQQ91MTlyN3XHNfHq9IogOU1aCgoTJ4BX3DOHIDkd8acycTuepbL
         Mp3IGXG0O1K8Xx2onmgbbZCNpdOhCs8wFCb++S9ncpn/D+MJHquOWS9ug0kVObm76ajp
         SG4DIkKicH8JI5mYK3Xyu4Zufss4sK6GZre7PF6KLUV0mX6GRCBWo0+nDYeOcTsXNWet
         HEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4a9UY5s40LlGymKW7WgX8xoLwzSyTJIIO9ypByJRAw=;
        b=SEN28eZKvIfgQo+RGe34IqHyjidCmPTMhupb9evkiIRfmBnFfq94Gcj4L1uFPmwKCf
         iMQeSW/CE3qqObraIwqVvw6BWXjXS9ypBzizbzcMwJRF6H2i/009f8bYE3q4yF5Rxva9
         c9XYFGAeTXvJ3ipQqu3KmGEHqQnfyNc91iZ2IZE5A6GnN7HlG1/SP7u3/vrOOiVhaA11
         Vd+hj67yo5+YK7vv8p0ZIb7gGzoar5y+9V3QEguqKoJIgTWCX7lPrdi09zeGs7weHRtt
         VKsv6YVu8J2FNL4R/qXHFZzeJmSC2Ttovg2WcpwFkXqAgDvNNJqo4b/XbeN7wy5huin/
         csAA==
X-Gm-Message-State: AOAM533DVgRQcFLtLojVuId0+eQEjn7T3EZw/sWU6W21lyOyKsVvq430
        czjpdAjTAWaqnZRFAoAkvCVmR0+C8I0D6Q==
X-Google-Smtp-Source: ABdhPJwN7FKEUhUi+8Lj3z837zjbX1ipWs+ehOriCnEmzP6MBj7a0gaNKetofg0jngGHIczq47HmQg==
X-Received: by 2002:a92:b744:: with SMTP id c4mr21370650ilm.265.1617116632550;
        Tue, 30 Mar 2021 08:03:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id c17sm9118071ilh.32.2021.03.30.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:03:52 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:03:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 02/16] builtin/multi-pack-index.c: don't handle 'progress'
 separately
Message-ID: <130c191b805917bdd146c4122b8b8ceaae700580.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there is a shared 'flags' member in the options structure,
there is no need to keep track of whether to force progress or not,
since ultimately the decision of whether or not to show a progress meter
is controlled by a bit in the flags member.

Manipulate that bit directly, and drop the now-unnecessary 'progress'
field while we're at it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4a0ddb06c4..c70f020d8f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,7 +13,6 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	unsigned long batch_size;
-	int progress;
 	unsigned flags;
 } opts;
 
@@ -23,7 +22,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
+		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
@@ -31,15 +30,14 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	git_config(git_default_config, NULL);
 
-	opts.progress = isatty(2);
+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage, 0);
 
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
-	if (opts.progress)
-		opts.flags |= MIDX_PROGRESS;
 
 	if (argc == 0)
 		usage_with_options(builtin_multi_pack_index_usage,
-- 
2.30.0.667.g81c0cbc6fd

