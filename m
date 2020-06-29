Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B2C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F01206A1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VDpdmy6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgF2Thq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgF2Thn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043BCC02A572
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 06:40:38 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j10so12784344qtq.11
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqmO7kJS85pWfJFOVUlEI7lDtRuwWJYNQCweIAdc9RI=;
        b=VDpdmy6h8DrZylU9jmGqzKpMHRYze5kn0ihjpIu3tGGJqLTTQjCkobQE9AyKVyAiu8
         VlYRrYnh3JVk/5BQZawS+mswaS7hMYlruEGVoaOz1pMd+2ECdMG6XIPZN0p4zW3YTQtZ
         r6yF0YZnJ5TG7KxHEccxxmTA7Y6skTcjSceRGswOZEpD/gN85cPUmKL653at6Dcmb2TK
         pdcIXtPRZ4Dbg0N5nPZD5ALzbzpY0A1CNO8wtNpWWtSKKnoH6237/NXgwcuZAdN58D10
         +XyYMOe9SZfKGFm8Y5aa/HpGUMx/iwnIum1SSOrIDymzaAhf1/zwTyMpO0dallKKpKIa
         pZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqmO7kJS85pWfJFOVUlEI7lDtRuwWJYNQCweIAdc9RI=;
        b=d6N1XflzH9cpqGn9CUcwrQc7/qDEwi6mD2jTdIfRMI+vQHmD6mBvoL/REXqa8OfTZV
         gY55CmnbkQBE0eKPemq4fTgsGNXw4J50/JdAeKPIDdkAcpbGgk92BmImJh8mfGQXvxfp
         SrtR45xi66NOF6CKob2IENlM0rNn7QcxWswIVVJx/bJlrV79VAHcKoKxaiMpVMVVjUqU
         Z3zQROcUJPg/a6ia903S2JqOySGfCqQpo91QHFHYT66ZxZ3aTdb+Xg98EdSYvGmwt4Y3
         QDFyFO8nZr/1yul0cX9n6Ort3zAcPgG0XFKgOMXBwWZw+iKYYUtnGslB1ZbIb19VeZAw
         DbmQ==
X-Gm-Message-State: AOAM530DbA8s3luT6TmSdujMgHbjX8FIXICVsybKCwVuUr1swQRwEqu0
        ResX8qg8p5GfjjGE8wYca19Lqg==
X-Google-Smtp-Source: ABdhPJxUvmIwnP68ng6T27NXu7nIeF4pKVNnNh1Jbi1XQ/yHia3sxLy0FQjCiBgHjaENRf1gJeQcpw==
X-Received: by 2002:ac8:fec:: with SMTP id f41mr14662281qtk.212.1593438037852;
        Mon, 29 Jun 2020 06:40:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:256b:ca14:6455:b7c1])
        by smtp.gmail.com with ESMTPSA id z19sm20139871qtz.81.2020.06.29.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:40:37 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:40:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, avarab@gmail.com,
        abhishekkumar8222@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] commit-reach: create repo_is_descendant_of()
Message-ID: <20200629134035.GA59624@syl.lan>
References: <pull.664.git.1592414670.gitgitgadget@gmail.com>
 <8f7fd8f5941426c3ed7fc28c6e4afd62bcd4bb8d.1592414670.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f7fd8f5941426c3ed7fc28c6e4afd62bcd4bb8d.1592414670.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 05:24:28PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The next change will make repo_in_merge_bases() depend on the logic in
> is_descendant_of(), but we need to make the method independent of
> the_repository first.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-reach.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 4ca7e706a18..13722430aa5 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -283,7 +283,9 @@ struct commit_list *repo_get_merge_bases(struct repository *r,
>  /*
>   * Is "commit" a descendant of one of the elements on the "with_commit" list?
>   */
> -int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
> +static int repo_is_descendant_of(struct repository *r,
> +				 struct commit *commit,
> +				 struct commit_list *with_commit)
>  {
>  	if (!with_commit)
>  		return 1;
> @@ -301,13 +303,18 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
>
>  			other = with_commit->item;
>  			with_commit = with_commit->next;
> -			if (in_merge_bases(other, commit))
> +			if (repo_in_merge_bases(r, other, commit))
>  				return 1;
>  		}
>  		return 0;
>  	}
>  }
>
> +int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
> +{
> +	return repo_is_descendant_of(the_repository, commit, with_commit);
> +}
> +

I don't think that it makes a big deal either way, but I wonder about
moving 'repo_is_descendant_of' to the header file, and making
'is_descendant_of' be 'static inline int' as you defined it here.

Since this has already graduated up to master already, I don't think
that it's worth going back just to shuffle this code around, but I was
wondering if you had any specific reason for doing it this way.

>  /*
>   * Is "commit" an ancestor of one of the "references"?
>   */
> --
> gitgitgadget
>
Thanks,
Taylor
