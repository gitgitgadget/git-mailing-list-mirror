Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E0C2BB85
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5961A206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VaOOsS1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405063AbgDNEEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgDNEEH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F1C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c138so5517603pfc.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ud+kuMoXbePDAxE/+dZegJ8NGHZwbj/msbUcBnU5f6g=;
        b=VaOOsS1t1WXh2CusZ7FopSgOkRqyiEcANmD5TFvl9FyhMtBFQDT0T1k0l6bCohltLl
         y9rGOAxqNWDHxzsv/vptawfeCi1Oi64BUII1qBMoo3ZQPe9RxJHlhS900reyV39uNSyh
         skG73qHx92JU945A31Ldk636SvI5ZpGh6HLYu1gV3at8wZgkPeZj+gDxtCG/M1AbvPWz
         RbKIKrhAHKQCJ+mf/whM1vdii7zHrzWMi1x5JTHbfboRPYCRy91YGR6BekTJVNwYLD7q
         ftk5TwoHSv3RbZ8iOXgU1GV8wnZte2x+ketcL1WtLkjZWp3drscl6a8vyvysi2YdSYrS
         uNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ud+kuMoXbePDAxE/+dZegJ8NGHZwbj/msbUcBnU5f6g=;
        b=FF4R2xe9pmND5m1ySWW854sJDUMe2UMH9f4rWr2vJoYZVpObsI06dbNSejKkSTmiTs
         dkjAptVl0q6T090k2ezEEslXDGnZxjR//3EZuO4MxUIrmtfkVgluLWH96KzwADEJulG8
         wYblTl6FvKIUOJfZHodkCqG8o3os8+VUwKWbNgKhxzsIe2PEDsuqHzW9dXZsHwKOU8GO
         hDkpkuOwzHtAeiM30rSHFzkgZ3oWbrPIMGdroOFLjPFHe6pXlxPWHMJXJwl7fLXjv2YT
         uglpdQApEuEq6vypNSE/SoWT0TvWoEVSLnagy/56YhrZYwjfJpjJoMpfDVZpu7Nub9wq
         UzTQ==
X-Gm-Message-State: AGi0PuYdEHZCNKu6RQxew1LAXqfuhm+Lqj8lwLiwGhedP0vJmD8Glh9J
        EwWRKOA6Ds4iwOM65Hetzx6/L5+DV1d6rHcS
X-Google-Smtp-Source: APiQypLndCWikIIhAOMDaYnzKfExvjBoCMl7uLgJiJ/7V5P/I5Jqh3PU2ppDWiq6wsbAyQDkV7z7lw==
X-Received: by 2002:a63:6a84:: with SMTP id f126mr17748445pgc.14.1586837046211;
        Mon, 13 Apr 2020 21:04:06 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y126sm4670468pgy.91.2020.04.13.21.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:05 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:04 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 1/7] t/helper/test-read-graph.c: support commit-graph chains
Message-ID: <0eb2c610283689675450b1e4e2c66147f1500cf1.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 61df89c8e5 (commit-graph: don't early exit(1) on e.g. "git status",
2019-03-25), the former 'load_commit_graph_one' was refactored into
'open_commit_graph' and 'load_commit_graph_one_fd_st' as a means of
avoiding an early-exit from non-library code.

However, 'load_commit_graph_one' does not support commit-graph chains,
and hence the 'read-graph' test tool does not work with them.

Replace 'load_commit_graph_one' with 'read_commit_graph_one' in order to
support commit-graph chains. In the spirit of 61df89c8e5,
'read_commit_graph_one' does not ever 'die()', making it a suitable
replacement here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index f8a461767c..4846040363 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -7,26 +7,15 @@
 int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
-	char *graph_name;
-	int open_ok;
-	int fd;
-	struct stat st;
 	struct object_directory *odb;
 
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
-	graph_name = get_commit_graph_filename(odb);
-
-	open_ok = open_commit_graph(graph_name, &fd, &st);
-	if (!open_ok)
-		die_errno(_("Could not open commit-graph '%s'"), graph_name);
-
-	graph = load_commit_graph_one_fd_st(fd, &st, odb);
+	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-	FREE_AND_NULL(graph_name);
 
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
-- 
2.26.0.106.g9fadedd637

