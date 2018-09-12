Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D92E1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeILXXs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 19:23:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35287 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeILXXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 19:23:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so3055370wre.2
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UJvwfxN1DCxrSv37KcI/P3dD1atwFo0FpZCDkMSJ0/Y=;
        b=bOMJafPWHeP9Sps0FeRTqKIGZqfY1v878aIxQZW6VRUTdbHU4dtkOArHeOuC462D/2
         xWkDzFR+isXWOVUB6b0lvdiSws1Cw4ANqPKRx5qGFpoQudp7dx9xGZWWZJU/yMUP3GN1
         8WAmok0+hacdM23U4X6cNCJt9lqd9TAgYoc08y4TjrZ7RQ/Sa6N6QTN9tGMac7JD3Xqt
         RhBChx4dIOK770FtIRtQlpe2qncxAaIMOyXlaukmpn8FNFf8E2o0UlaqncBYg/Vz1a8w
         oKIJXVO9iPDF38EK6YxtnXB1gYPRUz8MF+nbC3JOaiCqqNwTnxCzQa4cziKS3CGG0voF
         bxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UJvwfxN1DCxrSv37KcI/P3dD1atwFo0FpZCDkMSJ0/Y=;
        b=J1CBwYuP6Zj/ykosSFiDCkTsjDAZuCtq2SNoE/BiQOVEtLZBZR0OWGN8VtR0HgAW6T
         VCM4FrArC00TUUzKUr5k4MvANc7XPsbojZZ1hBRVfFHXuIV6LmCm89U9O+RXS9S/DDBS
         1tnlCWIjxSk8VY01lAoleK7EoOK0rTgZ4+OZkTWU6xHR25uDnJRWNB+YGx5E/KERh1JA
         XdsyDmhUXGYvKJZFqToXrpD5GVH3ZU9Z+O5Crk7OnRsXjDQQw80GyisGyIZGBc4xF91f
         QHkIPCXZ3p5mQkKLTqcarOPhDpgyuWhLk8nGCzU7IqIriff843kmrQw9QjJIvHhS7Efd
         6Neg==
X-Gm-Message-State: APzg51Dz+mJ2XynkEr+41gByYZHrMCqqju/Rbkq1ABhMlblEL2DbEPpx
        Ak60dPefXmEHVIyKS5mhVUk=
X-Google-Smtp-Source: ANB0VdYfQ9z5iAAFfmFxlR8JCTNm1I30sgnA6DcM3CYVf06Rqwp+1WKiHzgkk37JtouJzvaPWMiuDw==
X-Received: by 2002:adf:c5c5:: with SMTP id v5-v6mr2451170wrg.30.1536776283752;
        Wed, 12 Sep 2018 11:18:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z101-v6sm2719482wrb.55.2018.09.12.11.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:18:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/9] submodule.c: sort changed_submodule_names before searching it
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-5-sbeller@google.com>
Date:   Wed, 12 Sep 2018 11:18:02 -0700
In-Reply-To: <20180911234951.14129-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:46 -0700")
Message-ID: <xmqqr2hylgv9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We can string_list_insert() to maintain sorted-ness of the
> list as we find new items, or we can string_list_append() to
> build an unsorted list and sort it at the end just once.
>
> To pick which one is more appropriate, we notice the fact
> that we discover new items more or less in the already
> sorted order.  That makes "append then sort" more
> appropriate.

Sorry, but I still do not get the math you are implying in the
second paragraph.  Are you saying that append-then-sort is efficient
when items being appended is already sorted?  That depends on the
sorting algorithm used, so the logic is incomplete unless you say
"given that we use X for sorting,...", I think.

Do we really discover new items in sorted order, by the way?  In a
single diff invocation made inside collect_changed_submodules() for
one commit in the superproject's history, we will grab changed paths
in the pathname order (i.e. sorted); if the superproject's tip commit
touches the submodules at paths A and Z, we will discover these two
paths in sorted order.

But because we are walking the superproject's history to collect all
paths that have been affected in that function, and repeatedly
calling diff as we discover commit in the superproject's history, I
am not sure how well the resulting set of paths would be sorted.

The tip commit in superproject's history may have modified the
submodule at path X, the parent of that commit may have touched the
submodule at path M, and its parent may have touched the submodule
at path A.  Don't we end up grabbing these paths in that discoverd
order, i.e. X, M and A?

I still think changing it from "insert as we find an item, keeping
the list sorted" to "append all and then sort before we start
looking things up from the result" makes sense, but I do not think
the "we find things in sorted order" is either true, or it would
affect the choice between the two.  A justification to choose the
latter I can think of that makes sense is that we don't have to pay
cost to keep the list sorted while building it because we do not do
any look-up while building the list.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index d29dfa3d1f5..c6eff7699f3 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1256,7 +1256,7 @@ static int get_next_submodule(struct child_process *cp,
>  		case RECURSE_SUBMODULES_DEFAULT:
>  		case RECURSE_SUBMODULES_ON_DEMAND:
>  			if (!submodule ||
> -			    !unsorted_string_list_lookup(
> +			    !string_list_lookup(
>  					&changed_submodule_names,
>  					submodule->name))
>  				continue;
> @@ -1350,6 +1350,7 @@ int fetch_populated_submodules(struct repository *r,
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
>  	calculate_changed_submodule_paths();
> +	string_list_sort(&changed_submodule_names);
>  	run_processes_parallel(max_parallel_jobs,
>  			       get_next_submodule,
>  			       fetch_start_failure,
