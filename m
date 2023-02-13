Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D5C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 08:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBMIm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMImZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 03:42:25 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F7CC0D
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 00:42:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t36-20020a056a0013a400b005a8bca6a180so983214pfg.6
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 00:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676277744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=masnQIXmXc9Ldz5/uHO+6oSJEKrXdDwTx2hHLQGF7hc=;
        b=Ob+Q+fpg941UEe+N/wcwj9JMMzznqE5S/1nPKTdb7uDpCJvp8c1oatgr9oaJ4A3+Mh
         nN/mtlh8Ka39EswX+OTVpz0FJHpkeweSmzUEZGWUyqWc1suVq66w2KLJCJz5Vsb4VpKp
         DCwba3CtJ3tvw1fiO/JmplioLa9uPNsbNNDgAe25ML+1P27gSKWVZdL6bmhwMw7tlu5r
         AmE2KG6SJyXZokhR3JiULni/J/uiW7kT4F/aj9hCyQOAkgSjYEtbx1ks+bE3jtrLM4mm
         xTuLUl/9qkAE9ROYNH1TGPBBJlYysvEShySPsQ4KozX1INbllUsBBv4DJby06T5bvu9H
         jUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676277744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=masnQIXmXc9Ldz5/uHO+6oSJEKrXdDwTx2hHLQGF7hc=;
        b=vWIZLChJ2Uxxf/aaaUg4JkEZfZOm0PpBHX408Qx/lNLz4ntQfE5ox2FjF4qo1zR/dk
         0qzeWtAqoq1o13PT/BDq9QXsCtC8e4F+1miMx5B+rDRtaKdGjoNv01OMzhNGC21vPLze
         ySqo5dki3ZnXu7z8aD1cwv0frqSYbxAaLs9rfU9WSA6UV7ZMm/IR75v56YV0+p7rG2Ty
         4b6DoNsOveWudP1jIVJhNWu5jgG9hjqWYHtZbUhf0BGqnzWXCklu6E14YqIHwtC0AH8t
         iXEQ/V1YkBS9cOcZv8SsIjdZiH/ZM6J3Y6KWbeCCiXQ3CStCKzJmZkrf7jPq7+aXuNSE
         LPow==
X-Gm-Message-State: AO0yUKWqMwPW3lBvm7kLekK9gi4M0CfLxzl6YIGSdO3SMGHrxzZMlW+q
        P51lbDYD/BG5YFmnAQR/Lwqnmh/fdEbCTg==
X-Google-Smtp-Source: AK7set9gQgQaikvRPb/X7t2Raly7InNYJ6hSS5F8J+yqL/beSFrd87eVAHJKDfsoauV3pwy04qIVmamsO+a0dA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:eb53:b0:19a:a798:51a7 with SMTP
 id i19-20020a170902eb5300b0019aa79851a7mr245945pli.22.1676277743840; Mon, 13
 Feb 2023 00:42:23 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:42:22 +0800
In-Reply-To: <20230209000212.1892457-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-6-calvinwan@google.com>
Message-ID: <kl6la61iardd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 5/6] diff-lib: refactor out diff_change logic
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Refactor out logic that sets up the diff_change call into a helper
> function for a future patch.

This seems underspecified; there are two diff_change calls in diff-lib,
and the call in show_modified() is not changed in this patch.

> +static int diff_change_helper(struct diff_options *options,
> +	      unsigned newmode, unsigned dirty_submodule,
> +	      int changed, struct index_state *istate,
> +	      struct cache_entry *ce)

The function name is very generic, and it's not clear:

- What this does besides calling "diff_change()".
- When I should call this instead of "diff_change()".
- What the return value means.

Both of these should be documented in a comment, and I also suggest
renaming the function.


> @@ -245,21 +269,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			newmode = ce_mode_from_stat(ce, st.st_mode);
>  		}
>  
> -		if (!changed && !dirty_submodule) {
> -			ce_mark_uptodate(ce);
> -			mark_fsmonitor_valid(istate, ce);
> -			if (!revs->diffopt.flags.find_copies_harder)
> -				continue;
> -		}
> -		oldmode = ce->ce_mode;
> -		old_oid = &ce->oid;
> -		new_oid = changed ? null_oid() : &ce->oid;
> -		diff_change(&revs->diffopt, oldmode, newmode,
> -			    old_oid, new_oid,
> -			    !is_null_oid(old_oid),
> -			    !is_null_oid(new_oid),
> -			    ce->name, 0, dirty_submodule);
> -
> +		if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
> +				       changed, istate, ce))
> +			continue;
>  	}

If I'm reading the indentation correctly, the "continue" comes right
before the end of the for-loop block, so it's a no-op and should be
removed.
