Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588ECE79AA
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 18:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjISSUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjISSUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 14:20:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB890
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:19:59 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59b5484fbe6so64875777b3.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695147599; x=1695752399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UOr2Hrr3Lx0F7IvBE/I0rQdWmSdV8n1ZavYrSOB6Zeo=;
        b=gFkKRIdvGKZjg24r9W0nZ4qJVzqAmxt0Fz3N0MB3eZNrvcJ/OXVZkdXOEFXGhlm/+F
         FpumvZPFCEWuii5ofGI4zbtgkkSzW0W8jLU1Gzc1NQ7F+8tXxV6Q1fQWqrTzfViqJ+yy
         Iv/EUb7UwKGx59QbYl0QBjLUPpvcop0I5rfxLYAY15nQjZf43/KJXWfMBpL40yYFQ+4i
         EC3WREzATzSoWqP5+b6LrIcfCKPlSvo7hddxti1v/0Uv+pM3mR/y0TREWVCjGB5AX+a2
         SWLXaTK8ZcqtvkpCRpYfAQUpre+2xIBLCGVNld4XJd8dd2s3cZmkQXJpxjH1zHh+EGty
         wD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147599; x=1695752399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOr2Hrr3Lx0F7IvBE/I0rQdWmSdV8n1ZavYrSOB6Zeo=;
        b=JEIx3P0fi4GMa+62VTOs9G6UbENLGSjxjNjiq+Ti60W9RgEcsIUfyYa9azgP1JHg5Z
         EO1SpOjWKmWDGo9BWNBzNkiCRgwOTg+rSbj8KcTws/FNMaRi+HwS2/A4D3EaHL9Tj/Ss
         C2ZgSTZBVGgWXArXwWw1VAaYUlOF/zU3nB53JdfVVToFvflcjvl7HksMSjUDC1rEbji5
         kms/vDxIBlXLweukQwCV5c7ee+3IO+39ji4lc0O4w4ubxdPtqeOqDTGhBrtvZBkzvKBo
         eB/ihwC+IlLItK0tJQfTkjXwzmj//3U+GwpaWLMg7H9dO8zw8hbx4kXXeV0LOe+yMcE8
         U8qA==
X-Gm-Message-State: AOJu0YxgAF8HXLz31y7QunLQUb1pBsGp86IQMgxD5f9nsx/N/QWijpbJ
        wrjSQvAKMEI2TWeahE1qc9uzhQ==
X-Google-Smtp-Source: AGHT+IGsHTN61gkcHUbwDMkAb8MEZn6xMT+hE1OWa11YT0cLihBDsWon3BNF8ss8kJYb1lVm1R4maw==
X-Received: by 2002:a81:9297:0:b0:56d:2d82:63dc with SMTP id j145-20020a819297000000b0056d2d8263dcmr306649ywg.10.1695147598761;
        Tue, 19 Sep 2023 11:19:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t145-20020a0dea97000000b0059beb468cb4sm3327488ywe.1.2023.09.19.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:19:58 -0700 (PDT)
Date:   Tue, 19 Sep 2023 14:19:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
Message-ID: <ZQnmTXUO94/Qy8mq@nand.local>
References: <20230911223157.446269-1-jonathantanmy@google.com>
 <20230915202912.GA8705@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915202912.GA8705@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 10:29:12PM +0200, SZEDER Gábor wrote:
> On Mon, Sep 11, 2023 at 03:31:56PM -0700, Jonathan Tan wrote:
> > SZEDER Gábor suggested [2] that we change the revision walk to read
> > changed path filters also for root commits, but I don't think that's
> > possible - we have to tie reading changed path filters to when we read
> > trees, and right now, we don't seem to read trees when evaluating root
> > commits (rev_compare_tree() in revision.c is in the only code path that
> > uses changed path filters, and it itself is only called per-parent and
> > thus not called for root commits).
>
> When encountering a root commit during a pathspec-limited revision
> walk we call rev_same_tree_as_empty() instead of rev_compare_tree().
> All that's missing there is checking the Bloom filter and accounting
> for false positives.

I think that we'd want something like this, though I would definitely
appreciate a second set of eyes since I am not 100% confident in my
set of changes here:

--- 8< ---
diff --git a/revision.c b/revision.c
index 2f4c53ea20..1d36df49e2 100644
--- a/revision.c
+++ b/revision.c
@@ -837,14 +837,24 @@ static int rev_compare_tree(struct rev_info *revs,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
 	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
+	int bloom_ret = 1;

 	if (!t1)
 		return 0;

+	if (revs->bloom_keys_nr) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+		if (!bloom_ret)
+			return 1;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);

+	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+		count_bloom_filter_false_positive++;
+
 	return tree_difference == REV_TREE_SAME;
 }

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..3a45cb997b 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -162,7 +162,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '

 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":10"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
--- >8 ---

Thanks,
Taylor
