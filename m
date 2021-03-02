Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B053C4332B
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5833064ED0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhCCGdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581197AbhCBSlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 13:41:16 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44178C06178B
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 10:40:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x8so13934706pfm.9
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1tYiDblC1aIwZwjBTO9qgAwJfWm+KMO0k9xKePVHEfQ=;
        b=vzdS4wn+US3u5kWaxLT6T1J8XRcmu7Ivpo9OlG1cq8LgTPRJ669Vm+vsXMRp1LLpzb
         QpNry00w4XVRiDrGRMLMNN32k5CGw06g6NCJxQ/ktKVKW9mc46eQa5X6ABdpIYjeHf+5
         3fyDYOoyu6cpojYOuEv4JdaAGzoM2kL+m30kPHxwScDAo+mz0sjkEde+bDmZGRduGAFR
         vzl6NwzOn3KuHD34kSrvUXUy2NER1qZhwnfwSfwZDHKyg2fQy4rYeTXs72fwceCbuUqp
         QVczL2CTdzPiiOeVZwWA1hAAGRvIVNBy4xEL8dMGzFo4MkVDey9cWX5kgquhNw/cJ7Gv
         8LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1tYiDblC1aIwZwjBTO9qgAwJfWm+KMO0k9xKePVHEfQ=;
        b=Ivr16vNLspJ4oXM03/o72xiUYkbvGnx0X2KstO47ShUDV4DcrN1F/aih8zXtIIVZBi
         FTEdpRZOdfVUS+oqxVYiLT4tGiP2HflWvh8O28AKl/qJ4PakAo1HQ4y02Z/0b0EOZ12m
         VXG5cxfX1cyTfnYgpU3W7Y+tTnYWFjSzGxiXGiwwT5Q2sGCAmRba8BE6EZsM43ZYa+Xk
         2jKOqqD2BacyQ7SY8H6jF8vYDxLmjWMFTLZnly9wFRTYpg+HG62pkvJM0shRJZ9L12me
         m77DO1nNp806WDTRsdbpgWadYfgOVH7Nqhb+iHFKm6UV033RL+pGMO9gUeWEoJLNatv1
         SeRw==
X-Gm-Message-State: AOAM533BfiLOTmliW2vGM2ikhglskoOWfLU9VSNifYl09PcUURoQy6A0
        zvB8OQ5e6v3qgjbt3ko5UfJJ7rtwbd1KI+WHe7q6
X-Google-Smtp-Source: ABdhPJxJW9oQ62sCNrAIEAQlGJ7LIIjDpHXjSkLqIdHYfiELeifNFSSFTosdLagVkkizn1+vsKTSoD/8RoDUmg0WhxcA
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:dd49:: with SMTP id
 g9mr19737451pgj.175.1614710435802; Tue, 02 Mar 2021 10:40:35 -0800 (PST)
Date:   Tue,  2 Mar 2021 10:40:33 -0800
In-Reply-To: <01bd6a35c6c441a30a22a4c2d17e9cf53de6b148.1614193703.git.me@ttaylorr.com>
Message-Id: <20210302184033.12305-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <01bd6a35c6c441a30a22a4c2d17e9cf53de6b148.1614193703.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 15/15] pack-revindex: write multi-pack reverse indexes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1018,6 +1080,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  
>  	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>  	free_chunkfile(cf);
> +
> +	if (flags & MIDX_WRITE_REV_INDEX)
> +		ctx.pack_order = midx_pack_order(&ctx);
> +
> +	if (flags & MIDX_WRITE_REV_INDEX)
> +		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> +	clear_midx_files_ext(the_repository, ".rev", midx_hash);
> +
>  	commit_lock_file(&lk);
>  
>  cleanup:

Any reason why we're using 2 separate "if" statements?

Other than that, this patch and patch 14 look good. Besides all my minor
comments, I think the overall patch set is in good shape and ready to be
merged. It's great that we could reuse some of the individual-pack reverse
index concepts and code too.
