Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B5C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233B6206F9
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1+gmncO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgKFWTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgKFWTi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:19:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A2C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 14:19:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a12so3309340ybc.20
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sqUTRcVsRv8RcfOITrWVGfFGAqebKXt4mO6XxW0YB/E=;
        b=R1+gmncO+EzOfbn+sI7mPWvkLlqkGj9BNNmzFWqGMzobnxbwBaqbNhr/+OIK0kM+V5
         gs1dPlS5SWGjy8ljFeqRcXnpb1kCVc6OvE54ax5ORNHcNzr0mD0xXsEYbr97wite1JJV
         6ccQYbhARViq/FD+qvtKdH/NZHFjkpE9p8k1HndWWNLODw1RgbsgKirtEJRMEMvIt4c1
         +BRrt4yFpABpx7mQoQp8O4+IPMG2tnDZ6Zar2STL45Bf+X0X4AuIO5jok2UcLx3X61bW
         L8Jc5usn6QtxOXSf7NBejFql9O9gO54fqI+O99FW5cCZEMZ4Ph5ypEjMYxvG3Hjl/eDF
         Q5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sqUTRcVsRv8RcfOITrWVGfFGAqebKXt4mO6XxW0YB/E=;
        b=aTT6YbgDvk1OO+oGs56wglnINXRnTrGpCxTbnJpsp3xy7VYgDcEaGk7LgcNq0TFGT6
         u4vTUfT6O1WJRlObSQgIdNZFPwTAjQKL0I8JkB9MPfH5fXI+JqqfCu/FxiJadhbamX+O
         RJnqpBg9/FRC3j9fBL3ITNH93iI2QgzvNJx7QEBaDsntOrsIaWWwCGBC/PhTYeBepAtk
         qh1DqD8ssfGTk1Xv2WDjqXoT++01kK+JwW1tXGtdCpZb83SrccJ5ytn0hlNBq7VecN9O
         SqtOtNGAM3qomfC/4F8Kz57adKsHAGJ4c+CDZadkOcq1KSJZ+Gt1XwEK7xq9Cjdeyexp
         ftGw==
X-Gm-Message-State: AOAM5318C4l5VjKs/j524yeoqxhUzec8PQZflpokh9TMshPLiYN1AmwI
        OFAQuaBfh67fnzQmaadFR1WWmBSPTLWO75S/7yfH
X-Google-Smtp-Source: ABdhPJwR+CIJt9yaSQ7ecs21aRAWEchS4bEXGapIMK7Km46yFfSPc0Ubf30mdJw5YdLJtAJlyXjhj39JjQlaHBock28U
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e5c1:: with SMTP id
 c184mr5826668ybh.247.1604701176572; Fri, 06 Nov 2020 14:19:36 -0800 (PST)
Date:   Fri,  6 Nov 2020 14:19:34 -0800
In-Reply-To: <20201102204344.342633-7-newren@gmail.com>
Message-Id: <20201106221934.764672-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-7-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: Re: [PATCH v2 06/20] merge-ort: implement a very basic collect_merge_info()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/merge-ort.c b/merge-ort.c
> index 537da9f6df..626eb9713e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -77,13 +77,130 @@ static int err(struct merge_options *opt, const char *err, ...)
>  	return -1;
>  }
>  
> +static int collect_merge_info_callback(int n,
> +				       unsigned long mask,
> +				       unsigned long dirmask,
> +				       struct name_entry *names,
> +				       struct traverse_info *info)
> +{

[snip]

> +	unsigned mbase_null = !(mask & 1);
> +	unsigned side1_null = !(mask & 2);
> +	unsigned side2_null = !(mask & 4);

Should these be "int"?

> +	/*
> +	 * A bunch of sanity checks verifying that traverse_trees() calls
> +	 * us the way I expect.  Could just remove these at some point,
> +	 * though maybe they are helpful to future code readers.
> +	 */
> +	assert(mbase_null == is_null_oid(&names[0].oid));
> +	assert(side1_null == is_null_oid(&names[1].oid));
> +	assert(side2_null == is_null_oid(&names[2].oid));
> +	assert(!mbase_null || !side1_null || !side2_null);
> +	assert(mask > 0 && mask < 8);

These were helpful to me.

> +	/* Other invariant checks, mostly for documentation purposes. */
> +	assert(mask == (dirmask | filemask));

But not this - filemask was computed in this function, so I need not
look elsewhere to see that this is correct.

> +	/*
> +	 * TODO: record information about the path other than all zeros,
> +	 * so we can resolve later in process_entries.
> +	 */
> +	ci = xcalloc(1, sizeof(struct conflict_info));
> +	strmap_put(&opti->paths, fullpath, ci);

OK - so each entry is a full-size conflict_info to store all relevant
information. Presumably some of these will be converted later into what
is effectively a struct merged_info (so, the extra struct conflict_info
fields are unused but memory is still occupied).

I do see that in patch 10, there is an optimization that directly
allocates the smaller struct merged_info when it is known at this point
that there is no conflict.

[snip rest of function]

>  static int collect_merge_info(struct merge_options *opt,
>  			      struct tree *merge_base,
>  			      struct tree *side1,
>  			      struct tree *side2)
>  {
> -	/* TODO: Implement this using traverse_trees() */
> -	die("Not yet implemented.");
> +	int ret;
> +	struct tree_desc t[3];
> +	struct traverse_info info;
> +	char *toplevel_dir_placeholder = "";
> +
> +	opt->priv->current_dir_name = toplevel_dir_placeholder;
> +	setup_traverse_info(&info, toplevel_dir_placeholder);

I thought that this was written like this (instead of inlining the 2
double-quotes) to ensure that the string-equality-is-pointer-equality
characteristic holds, but I see that that characteristic is for
directory_name in struct merged_info, not current_dir_name in struct
merge_options_internal. Any reason for not inlining ""?

[snip rest of function]
