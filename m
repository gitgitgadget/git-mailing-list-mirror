Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3627DC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 18:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7B461222
	for <git@archiver.kernel.org>; Thu, 27 May 2021 18:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhE0SZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhE0SZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 14:25:48 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B5C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 11:24:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v10-20020a17090a7c0ab029015f673a4c30so970597pjf.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JHUBcSjlO5Kf/8PTKVHSQVW3p1FugKqzrjDeDyC0STg=;
        b=jyumkPjM157Q7uiORJT8C08joVh73lvz0BYKNyniAfs21qJXYawk9uGyeZ577s/aA1
         ZX2JJdamKGx4zAgjiaJ4q+E4bXalcc0JxLOLpT0cxtsYAXsu6GrdIAD6mTXbVz6nXl+d
         T7Q6jzzq12dcB2VH6YdHKPNFdW1cb9PLN+GwSd9yBiwhWfhEuXhhmvByQsrsVjcGsJ/F
         d7zgbtW26MBZPlNYu0YzsOMY8LHupy8N5lGfKVqXcolpZNmgO9LkkaJ84ZW2AzZ1kqDJ
         mXBYZDVoEVlGUzAOiaC2+ISnK13LJJvWWO8pIJyfPNhRIUGulGRdl23Kb5E5u8nChiR0
         cpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JHUBcSjlO5Kf/8PTKVHSQVW3p1FugKqzrjDeDyC0STg=;
        b=ZdOUKzvlUG+Cd7ZSVv3aUR9GAI9aEOqKjv36Sjl+dE6NECCdzmSFbHeSSeU8ANb5gq
         /YpmcUHBIB2zBFwQT4CJ5SI3YHrwjJHJp1mxgndBDq+80hYwj9EoyxHYtYZJ7XVpavvH
         tPtUFmgXPglZ0yP/a8ShI8dVw77ZTWUKPFy/Kc3GGwccsOJKGAPbNucumIbg1X4kMsQL
         nOYHcrYiFtsabRBF9FZaA6zzo2SEQbclnrWQnFi16tlaVpVR8i0t2GmywTx1YSv9pZzY
         T4UExWLzllRvyrN50XkvbwLei+7O3K4WUKX+VQshSS/S/3Yuf215PoeSm2dKbdbijEWG
         TJdw==
X-Gm-Message-State: AOAM531TktlKb+qu8XK4srI2eOTHdvdUJDo4U+nS0VZCSWPPrnuKcI3q
        Kg5cyhii08J3p2KH8whEQPeQ7J0DCVG9P0GVgHrJ
X-Google-Smtp-Source: ABdhPJxPR9M6rxU7/KYp3Rxcv9gr9PWK/b5slMXjHug3dGC0ZeMF5cZSWa6kHUbKd9KaltHyJ//13pilcZBIkwKGfVP0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e388:: with SMTP id
 b8mr10971827pjz.128.1622139853944; Thu, 27 May 2021 11:24:13 -0700 (PDT)
Date:   Thu, 27 May 2021 11:24:12 -0700
In-Reply-To: <patch-16.17-328f05c51b-20210520T111610Z-avarab@gmail.com>
Message-Id: <20210527182412.2681093-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-16.17-328f05c51b-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v3 16/17] fsck: report invalid types recorded in objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        j6t@kdbg.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/object-store.h b/object-store.h
> index 698a701d70..ba6e5d76c0 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -376,6 +376,7 @@ int oid_object_info_extended(struct repository *r,
>  
>  /*
>   * Open the loose object at path, check its hash, and return the contents,
> + * use the "oi" argument to assert things about the object, or e.g. populate its
>   * type, and size. If the object is a blob, then "contents" may return NULL,
>   * to allow streaming of large blobs.
>   *
> @@ -383,9 +384,8 @@ int oid_object_info_extended(struct repository *r,
>   */
>  int read_loose_object(const char *path,
>  		      const struct object_id *expected_oid,
> -		      enum object_type *type,
> -		      unsigned long *size,
>  		      void **contents,
> +		      struct object_info *oi,
>  		      unsigned int oi_flags);
>  
>  /*

What do you mean by using "oi" to assert things? As far as I know, it's
just a way to specify which information you want (by assigning pointers
to the appropriate fields).

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index e7e8decebb..bc541af2cf 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -66,6 +66,25 @@ test_expect_success 'object with hash mismatch' '
>  	)
>  '
>  
> +test_expect_success 'object with hash and type mismatch' '
> +	test_create_repo hash-type-mismatch &&
> +	(
> +		cd hash-type-mismatch &&
> +		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
> +		old=$(test_oid_to_path "$oid") &&
> +		new=$(dirname $old)/$(test_oid ff_2) &&
> +		oid="$(dirname $new)$(basename $new)" &&
> +		mv .git/objects/$old .git/objects/$new &&
> +		git update-index --add --cacheinfo 100644 $oid foo &&
> +		tree=$(git write-tree) &&
> +		cmt=$(echo bogus | git commit-tree $tree) &&
> +		git update-ref refs/heads/bogus $cmt &&
> +		test_must_fail git fsck 2>out &&
> +		grep "^error: hash mismatch for " out &&
> +		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out

I don't think we need to know the precise quote used - it's simpler to
just put "." where we need the single quote. Same for the other case
below.
