Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A091F406
	for <e@80x24.org>; Sat, 12 May 2018 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeELN7I (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 09:59:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34851 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeELN7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 09:59:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id i14-v6so7917811wre.2
        for <git@vger.kernel.org>; Sat, 12 May 2018 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ycE8e0JCfVaJpuzsjGknqwAWeX6eTlie24ui3LS9aHc=;
        b=MHd/krnJI4t439UtcCXsH0PceTUmKdkBtgIDvbyCa9gqBKFsYPAh5tz8WIX8e0eNrS
         dH1D36JQjIMFyhLYcA/bBNJmfkeKAOtBJrXnI/D4IsSpyu5EaYrgLXnAEF+mi4TyJPxU
         lkP4IHsCO/cmrUYjDKwMsyFt6o/iIqMPaD34HFa7WdtVeXZaujLLxUJ3M05AIA3Fonga
         pPUv8BkcrmcspwR1xSKp51nF/HdILeh/A7wfADR/SJ8HiIMzQI0qBbGE1LpmjsDoknZE
         SfHmTrk7R7Ok4/hafUGOMmoNgcHyy/EB6BNDcBlqyT1I1TqNQ+bY5+CNSb4jr3qRBnh8
         d3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ycE8e0JCfVaJpuzsjGknqwAWeX6eTlie24ui3LS9aHc=;
        b=NXBQ57alniFsnlG+cs0I1J7ZiIX8oEa48r0VTQ19X2i/wISXDJDVtaVHhjJWo5cFhS
         GUUlmrKFIJn73t6eu0//a+yuWTp/xtkabCWB8wmjLfOPs2xjR9YRy/rT/e/pdYU8E9dG
         FGhdk4SI3H6aeXrZJ+F1k6ljsBdenHI7jK5ta9yaL2Z71oezXb4g+aOr6V1BEYwtBjE4
         9CjxlEgh99AIMiPpq44KrPiHg+rTI5a3dJvco2FmuBGhBo5aCmtuZSFSf4Pm1AFYrX4g
         +DLfofhp0wequZaW48ozLk0d/m2nVG1L5LJUVLrGZkvDSSiBIWZIP4V0lE2iJXT2lFAd
         SgPw==
X-Gm-Message-State: ALKqPwem+4paww51Pjm5xk1p7Xrkh80b0OiVt40a70eJhv4PN+ICjD7J
        V8TrwyiuDuY+1oCwdtHBNAlqcqb3
X-Google-Smtp-Source: AB8JxZqwkuYCk4D8LyfY9Jqdi2nU/2npjBKLKh1vpNrwKaWoqHHZ5I3zUuksvPfgbiW9Q0OiLZNZyQ==
X-Received: by 2002:adf:88a3:: with SMTP id f32-v6mr2036075wrf.199.1526133545897;
        Sat, 12 May 2018 06:59:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y129-v6sm3745136wmg.44.2018.05.12.06.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 06:59:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/12] bisect.c: use commit-slab for commit weight instead of commit->util
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180512080028.29611-8-pclouds@gmail.com>
Date:   Sat, 12 May 2018 22:59:04 +0900
In-Reply-To: <20180512080028.29611-8-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 12 May 2018 10:00:23 +0200")
Message-ID: <xmqqtvrddlg7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> It's done so that commit->util can be removed. See more explanation in
> the commit that removes commit->util.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Yup, this one is a no-brainer.

>  bisect.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index a579b50884..6de1abd407 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -12,6 +12,7 @@
>  #include "bisect.h"
>  #include "sha1-array.h"
>  #include "argv-array.h"
> +#include "commit-slab.h"
>  
>  static struct oid_array good_revs;
>  static struct oid_array skipped_revs;
> @@ -70,16 +71,19 @@ static void clear_distance(struct commit_list *list)
>  	}
>  }
>  
> +define_commit_slab(commit_weight, int *);
> +static struct commit_weight commit_weight;
> +
>  #define DEBUG_BISECT 0
>  
>  static inline int weight(struct commit_list *elem)
>  {
> -	return *((int*)(elem->item->util));
> +	return **commit_weight_at(&commit_weight, elem->item);
>  }
>  
>  static inline void weight_set(struct commit_list *elem, int weight)
>  {
> -	*((int*)(elem->item->util)) = weight;
> +	**commit_weight_at(&commit_weight, elem->item) = weight;
>  }
>  
>  static int count_interesting_parents(struct commit *commit)
> @@ -265,7 +269,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		struct commit *commit = p->item;
>  		unsigned flags = commit->object.flags;
>  
> -		p->item->util = &weights[n++];
> +		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
>  		switch (count_interesting_parents(commit)) {
>  		case 0:
>  			if (!(flags & TREESAME)) {
> @@ -372,6 +376,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
>  	int *weights;
>  
>  	show_list("bisection 2 entry", 0, 0, *commit_list);
> +	init_commit_weight(&commit_weight);
>  
>  	/*
>  	 * Count the number of total and tree-changing items on the
> @@ -412,6 +417,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
>  	}
>  	free(weights);
>  	*commit_list = best;
> +	clear_commit_weight(&commit_weight);
>  }
>  
>  static int register_ref(const char *refname, const struct object_id *oid,
