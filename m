Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA995C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 20:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2282067B
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 20:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLZb24nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFCUvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 16:51:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A774C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 13:51:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so1229001pll.10
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XzTK84ZEh1gROISMjZL6TBd/O/aaUY/fjz7K1QMhL1U=;
        b=FLZb24nZjgLty1vHk2qCKtrQ0LzkqulVT6x5EGgfH7xQJ3uwQku7g/yToFvl730MuN
         XZnK09j6JHUeT/Ni/X2oxwejKNKwLS9QMpQI/zVugC0KAT5WsT9Q/eFp3jFZAu4ZcLQV
         8TVirAzU6zSPS7Ab8yWH48oVxC9s00tLcXEC8HuHicpF8Jaaw4zb25LG0nzNma7P9/Kj
         awDCzJPbX0ehv7EkkvHRjwtiIK5ZupSbRWGCsylS9BuwHBinVyYg4qU2aGTdCaa8Ux4B
         p3Qii+7bJLfm92D2Z2qpEz9Y/2Su4ZjJ2jrQnjRGtmwqZw2io4LJqdMbfAnZH4sijEQa
         P6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzTK84ZEh1gROISMjZL6TBd/O/aaUY/fjz7K1QMhL1U=;
        b=jwHaWMIqmk5gvD1e1Pv4W8IATYYhwRpHuz/NlJ0YgEvXTM9+XXoEgbogCydbfWlK06
         +oA9xU2GEgRU6T+taTznKObbXGTnqN55AUL2XY46UJEARAgqRrEibbf8uYNcHih3EXDo
         I+LaO8isJwvDgsjKh9USfGeZJE/Vp82uf1Ex//4DY+84MQ09O22DXkI2aQXZ05HQXwOh
         2mBHROkqT7zyU034fsUPMlQJwJ8qv8eC3Sepfjxwhy8qfcAiLm5jQw/cL/oo7SbcqX3C
         LhQBIXNhyxCV7qDTG15hsDH8mbbwYb8z1IgIwDE74yYqzLI73PwU5NOVdyFVWvWmvmIr
         uI5w==
X-Gm-Message-State: AOAM533kvSiRwWFHahhLGe794/oycqoRk06c2VNEDXKV5xaGWihYjP6P
        765QUalrNL1jyg21hi3jBUC2Wh3P
X-Google-Smtp-Source: ABdhPJwvKjqWGQgTXmh0xIsZi3fd0vhEKqSrDL6z/GBGc/7SpnX46B2Rozzpap9O9hPDcRynk/pczQ==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr1583136pll.320.1591217514391;
        Wed, 03 Jun 2020 13:51:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z9sm3200002pjr.39.2020.06.03.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 13:51:53 -0700 (PDT)
Date:   Wed, 3 Jun 2020 13:51:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com, Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603205151.GC253041@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
 <20200603045248.GA20266@syl.local>
 <20200603051631.GA20678@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603051631.GA20678@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> Ah, this only sort of has to do with the object cache. In
> 'parse_commit_buffer()' we stop parsing parents in the case that the
> repository is shallow (this goes back to 7f3140cd23 (git repack: keep
> commits hidden by a graft, 2009-07-23)).

Ah, good analysis.  (In fact, the behavior is older: it's from
5da5c8f4cf4 (Teach parse_commit_buffer about grafting., 2005-07-30).)
So this is additional "cached" data that needs to be invalidated by
reset_repository_shallow.

So the question is, what other information falls into that category?

[...]
> --- a/shallow.c
> +++ b/shallow.c
> @@ -90,6 +90,9 @@ static void reset_repository_shallow(struct repository *r)
>  {
>  	r->parsed_objects->is_shallow = -1;
>  	stat_validity_clear(r->parsed_objects->shallow_stat);
> +

(nit: the above two lines wouldn't be needed if r->parsed_objects is
being thrown away.)

> +	parsed_object_pool_clear(r->parsed_objects);
> +	r->parsed_objects = parsed_object_pool_new();
>  }

Shallows don't affect the ref store.  They only affect object walks.
So r->parsed_objects does seem like the only place that could be
affected.

That said, with this change I'd worry about use-after-free from any
existing references to objects in the pool.

Stepping back, what I think I would like to see is to *not* have
grafts and shallow state affect the in-memory persisted parsed
objects.  Instead, act as an overlay in accessors that traverse over
them.

Lacking that, I like the idea of a "dirty bit" that gets written as
soon as we have started lying in the parsed object pool.  Something
like this.  What do you think?

diff --git i/commit-graph.c w/commit-graph.c
index 2ff042fbf4f..84b49ce903b 100644
--- i/commit-graph.c
+++ w/commit-graph.c
@@ -149,7 +149,8 @@ static int commit_graph_compatible(struct repository *r)
 	}
 
 	prepare_commit_graft(r);
-	if (r->parsed_objects && r->parsed_objects->grafts_nr)
+	if (r->parsed_objects &&
+	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))
 		return 0;
 	if (is_repository_shallow(r))
 		return 0;
diff --git i/commit.c w/commit.c
index 87686a7055b..762f09e53ae 100644
--- i/commit.c
+++ w/commit.c
@@ -423,6 +423,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	pptr = &item->parents;
 
 	graft = lookup_commit_graft(r, &item->object.oid);
+	if (graft)
+		r->parsed_objects->substituted_parent = 1;
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -447,6 +449,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (graft) {
 		int i;
 		struct commit *new_parent;
+
 		for (i = 0; i < graft->nr_parent; i++) {
 			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
diff --git i/object.h w/object.h
index b22328b8383..db02fdcd6b2 100644
--- i/object.h
+++ w/object.h
@@ -26,6 +26,7 @@ struct parsed_object_pool {
 	char *alternate_shallow_file;
 
 	int commit_graft_prepared;
+	int substituted_parent;
 
 	struct buffer_slab *buffer_slab;
 };

Thanks,
Jonathan
