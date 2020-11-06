Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A6C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176F92065D
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQDDiis0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgKFWF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgKFWF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:05:26 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72536C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 14:05:26 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i15so1882015qti.7
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=veKVCf4CPWLtkuUYASTFx4cFj/XzhmS8jmqHzusBAxI=;
        b=nQDDiis0EjY71lAoP6J5fVdSFvxMEpgZxE6Ck4xXBn7EVYGxj2dnh8+qdu+ubBAxnP
         cdKU/IxNKpUrdGGOGViiFbi12q0LDT+4ibNpt76/TNig6ksPZvPJgZ8j6WrOWqRepvt+
         bVc4HGPbnx4HfYVuIOFNZ/+myR1yK5QgrZQIQejbiwaUv6bbErqH3ATV/XUzIw6l2eKs
         RHfQ2E6uMmgJx+c90HzEqSWT5z566XxR4Y1UdTpW7HMdLzXJqUbYVtd12eXw5slD02xm
         CN+4p3AMss5UmsXboibk0WIsCPqNOMoQ2rrjpW/yMzr/XPwqyWA1eN1Ttnba/GXNsuqD
         XhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=veKVCf4CPWLtkuUYASTFx4cFj/XzhmS8jmqHzusBAxI=;
        b=rFmk/TOf/zAtNUu7f6sjH9iBAktpoWUodP2wep6+fKmjqbfv9z3UVl0i38DHE/7iXe
         IfdWpRvbedetvde+XufZLIOfBknoagmgmz675wobs1y7wGt+doD3992zsVmH9zvD1qIG
         PQTuu8MG0Nca1y9dw7FcWud6x71yt+5VR9rrXCfcf3oj8IlwLdzET7bi1uR31kePVQ/6
         Gwl0zSQ7Tlyqs6Cs9cyUvnXX8tHdy/SuEY7x2LQKkvo7qE02L70m8W2b6qke0mEK+qam
         VrVsgTIGNy9SqHckjcxo//e+E04clnmzwYMxQM3bO+SGTtM++UMwo/Y+oPzNpvon2XK7
         zgzA==
X-Gm-Message-State: AOAM531ko0vhFURyju/UFytLedK4wlxlRl7eGhd1maTd9qQ3p9A7fC6A
        NZY4T5bYqO6j/T+pTLfrYc8aGFXGYxs7/Ga07tMb
X-Google-Smtp-Source: ABdhPJxhsmvJz/dQwjRWhrsgbJcmYSgh68BAXWUvCFCSJEbp6ZKQ7NMUjkabYIknNYjQKzOzDbeHu04Hb72paDHPKQWI
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:16c5:: with SMTP id
 d5mr3493729qvz.42.1604700325535; Fri, 06 Nov 2020 14:05:25 -0800 (PST)
Date:   Fri,  6 Nov 2020 14:05:21 -0800
In-Reply-To: <20201102204344.342633-2-newren@gmail.com>
Message-Id: <20201106220521.757698-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-2-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: Re: [PATCH v2 01/20] merge-ort: setup basic internal data structures
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not very familiar with the merge machinery, but I'll attempt a
review of at least the first 10 patches.

> merged_info contains all relevant information for a non-conflicted
> entry.  conflict_info contains a merged_info, plus any additional
> information about a conflict such as the higher orders stages involved
> and the names of the paths those came from (handy once renames get
> involved).  If an entry remains conflicted, the merged_info portion of a
> conflict_info will later be filled with whatever version of the file
> should be placed in the working directory (e.g. an as-merged-as-possible
> variation that contains conflict markers).

I think that this information should be in the .c file.

> diff --git a/merge-ort.c b/merge-ort.c
> index b487901d3e..9d5ea0930d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -17,6 +17,46 @@
>  #include "cache.h"
>  #include "merge-ort.h"
>  
> +#include "strmap.h"
> +
> +struct merge_options_internal {
> +	struct strmap paths;    /* maps path -> (merged|conflict)_info */
> +	struct strmap unmerged; /* maps path -> conflict_info */
> +	const char *current_dir_name;
> +	int call_depth;
> +};

Maybe document if the path is from the root of the directory or just the
filename as it appears in a tree object?

I would have expected "unmerged" to be a "strset", but I guess it's more
convenient for it to be a map itself. Maybe just document it as "all
mappings in paths wherein the value is a struct conflict_info".

There seems to be 2 ways of referring to something that we couldn't
merge - "conflicted" (or "having a conflict") and "unmerged". Should we
stick to one of them?

Also, looking ahead, I see that current_dir_name is used as a temporary
variable in the recursive calls to collect_merge_info_callback(). I
would prefer if current_dir_name went in the cbdata to that function
instead, but if that's not possible, maybe document here that
current_dir_name is only used in collect_merge_info_callback(), and
temporarily at that.

> +struct version_info {
> +	struct object_id oid;
> +	unsigned short mode;
> +};

OK.

> +struct merged_info {
> +	struct version_info result;
> +	unsigned is_null:1;
> +	unsigned clean:1;
> +	size_t basename_offset;
> +	 /*
> +	  * Containing directory name.  Note that we assume directory_name is
> +	  * constructed such that
> +	  *    strcmp(dir1_name, dir2_name) == 0 iff dir1_name == dir2_name,
> +	  * i.e. string equality is equivalent to pointer equality.  For this
> +	  * to hold, we have to be careful setting directory_name.
> +	  */
> +	const char *directory_name;
> +};

I'm not sure how most of the fields in this struct are to be used, but
perhaps that will be clearer once I read the subsequent code.

> +struct conflict_info {
> +	struct merged_info merged;
> +	struct version_info stages[3];
> +	const char *pathnames[3];

Why would these be different across stages? (Rename detection?)

> +	unsigned df_conflict:1;

OK.

> +	unsigned path_conflict:1;

This doesn't seem to be assigned anywhere in this patch set?

> +	unsigned filemask:3;
> +	unsigned dirmask:3;

I wonder if this needs to be documented that the least significant bit
corresponds to stages[0], and so forth.

> +	unsigned match_mask:3;

I think this can be derived by just looking at the stages array? Maybe
document as:

  Optimization to track which stages match. Either 0 or at least 2 bits
  are set; if at least 2 bits are set, their corresponding stages match.

> +};
