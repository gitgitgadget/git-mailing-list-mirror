Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AAC1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeIFWkL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:40:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55944 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeIFWkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:40:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so12267326wmc.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kaTrEgglDUjVSKKqEX4MeBVkq06t1HH9rL0i4nTb6q0=;
        b=OB+B4h26qdxxNFKrvsVd1kIvjqSPVB8qBKCLL2R+pngj0sxObB1Q42RJ3885UbyaPF
         Pb35ip/B2+28wNoTsdK9xOFIUzgpjSUFVMbpc5BnZghRAUl9oSIKF7qWOLQTQS11LLJC
         8FVqu16K1yoNBASREcCC+NIlZ/Zec4+cWf02Z1viMi1nNqF6OAKSy6a18G7P4MHzmr84
         ManvpX713ckdN/bWeMG+SOTkLL4vNj9qvB9AAgKFkA6B/0jsSUn20Vj9PhKauwUAQwVx
         d9FfSyksNnXxAcSh1P0B/VTqO8h4J3bh4ul50kzb5KdBx3EaQ3+Yds3tQ6GFhumB3/6/
         mhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kaTrEgglDUjVSKKqEX4MeBVkq06t1HH9rL0i4nTb6q0=;
        b=MHb7nZHjl4YXEGwX/m0WIBRNc0E3Rr4DI6IDVkvx8e0/WkkYMCfLWWsHd0BY06UM3C
         zaBGliXaQSx9/YTcYgjQWf+0PyW/X6L0jfvWL+jBMprxj5yVJDDSgK52cKxGhlawSdHx
         tcUInL9zVaXoQEp4BMFtIPjqNN7r18UHJBoIlIIxw0b5NqLUaG7fQq95ICXjFsWrcBM2
         YvBzJ/vWCjnwtAFC7yhMF+8k3jUzSIZuxuuRX7tBq3vdt8drflYs4cZv5uSAE/dz7G+u
         ZM4YxGBmUGzqgT3ibIl1rPaKAPvEdwwK2KQvtXejnrAgM5QuijspX1xAhoa0uP+nXKVU
         SeJQ==
X-Gm-Message-State: APzg51CRyT8hD8c6Hc42KlCnlb5efaP4J9uMOa3y6Athi0s/Eqb4s9O+
        gMjud/ME/mivdJPgE/P72QM=
X-Google-Smtp-Source: ANB0VdarDdqj3Tx3xnB1UETpKLNkSCrymqJQlpY6wvCPlb2Bkw6wyBqu0a9V/5zPixWPvdZuo7aYjw==
X-Received: by 2002:a1c:eb03:: with SMTP id j3-v6mr2906978wmh.150.1536257011525;
        Thu, 06 Sep 2018 11:03:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s24-v6sm3648257wmc.7.2018.09.06.11.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:03:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/11] submodule.c: sort changed_submodule_names before searching it
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-7-sbeller@google.com>
Date:   Thu, 06 Sep 2018 11:03:30 -0700
In-Reply-To: <20180904230149.180332-7-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:44 -0700")
Message-ID: <xmqqbm9a1p1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Instead of sorting it after we created an unsorted list, we could insert
> correctly into the list.

It is unclear what problem you are solving, especially with
subjunctive "could" there.  We are creating an unsorted list and
then sorting it and you see it as a problem because it is just as
easy and efficient to do the insertion sort while building up the
list?  (don't react and answer without reading all the way to the
end; I think I know what is going on).

> As the unsorted append is in order of cache entry
> names, this is already sorted if names were equal to paths for submodules.

That may be a statement of a fact, but it is unclear how that fact
relates to what the code is doing before this patch, or what the
code updated by this patch is doing.

> As submodule names are often the same as their path, the input is sorted
> pretty well already, so let's just do the sort afterwards.

It is unclear what (performance?) trade-off this senttence is trying
to make.  It sounds as if it is claiming this:

	We can string_list_insert() to maintain sorted-ness of the
	list as we find new items, or we can string_list_append() to
	build an unsorted list and sort it at the end just once.

	To pick which one is more appropriate, we notice the fact
	that we discover new items more or less in the already
	sorted order.  That makes "append then sort" more
	appropriate.

But is that reasoning sensible?  

I'd imagine that append-then-sort would always be more efficient
than insert-at-the-right-place-as-we-go, and the reason why we
sometimes would need to do the latter is when we need to look up
elements in the middle of building the list (e.g. we may want to
de-dup, which requires us to look up a name from the ones we
collected so far).

And in this application, calculate_changed_submodule_paths()
discover paths by calling collect_changed_submodules() which finds a
mapping <submodule name, oid of commits> into a list sorted by
submodule name, and then goes through that list and builds a list of
submodules paths (which could be different from submodule names) by
appending.  Only after this list is fully built, get_next_submodule()
gets called, so making the latter use string_list_lookup() that assumes
a sorted list is safe if we built the list by append-then-sort (iow,
sortedness while building the list does not matter).

Having analysed all that, I find it somewhat iffy that _append() is
used there in the calculate_changed_submodule_paths() function.  It
would cause the resulting changed_submodule_names list to hold the
same name twice (or more), but I do not know if that would pose a
problem to the consumer of the list.  Using "accumulate then sort
before calling look-up" would not change it as string_list_sort()
would not dedup, so I do not think this patch would introduce a new
problem, though.



> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 8345d423fda..8bee455137a 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1255,7 +1255,7 @@ static int get_next_submodule(struct child_process *cp,
>  		default:
>  		case RECURSE_SUBMODULES_DEFAULT:
>  		case RECURSE_SUBMODULES_ON_DEMAND:
> -			if (!submodule || !unsorted_string_list_lookup(
> +			if (!submodule || !string_list_lookup(
>  					&changed_submodule_names,
>  					submodule->name))
>  				continue;
> @@ -1349,6 +1349,7 @@ int fetch_populated_submodules(struct repository *r,
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
>  	calculate_changed_submodule_paths();
> +	string_list_sort(&changed_submodule_names);
>  	run_processes_parallel(max_parallel_jobs,
>  			       get_next_submodule,
>  			       fetch_start_failure,
