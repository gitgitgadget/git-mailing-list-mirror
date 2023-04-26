Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D096C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjDZROe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjDZROb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:14:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC8194
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:14:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b60365f53so9025999b3a.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529261; x=1685121261;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln2PF5A8ZCS7jvOSD0zX3nbXU1zbEdENQmxOIXE9jH4=;
        b=SvITAv+YyRWzxbrJ6VUUc2Q3yQSm7VR2wl47eE+nArnNHGN94+RmUIsdYd+YvZOQxD
         WjQlGgDyxVxKMIPgGa31/LbBRlgpccs1wKmIp7GUquehQo5bCC8n83py50qRkQm5Zrc1
         WOfq7+0N6gNUZ2LaK5tE5HL8wDvtcw3sNgoWWmB0mgUkE1L85SboRYd0Vbd39KECCMd1
         jXoUBfZEF7SyQsv93K5Lmu6L6+59EN05TDXWrRBFxbmvc95IyBl+qSENtFy6e+1WYOs4
         3ZLo9rY7mDyr9VTpdF8dIXl/6JY67Vfh5eyDMKQ+DMUUkR13ZVwIVj6nj0Ga0jYG4RTK
         qU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529261; x=1685121261;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ln2PF5A8ZCS7jvOSD0zX3nbXU1zbEdENQmxOIXE9jH4=;
        b=U+RxJ9oZlZ8xIgkEI/3QUO+yxxdIpbL1XjasjvH8+J0R3ufFxbmbgQmZBRzzY1rKlZ
         J5dVIfV774dYeaU1SGVWDv2Tm5SK357KQ5AbRqGeAinOXXzosiN3wR+6JuaH+3cMXrGt
         2AG95h+/Qk305Y0VysxlfmfnhvV+dKPBiiOdRLxP2UGjuEZM121Eaz3zV5B2rL79m7im
         /1JLt/zqnnOK6TVr+i1ibTTE3Pz8aWffs1i2AVXK+g1N28IyakrPKzYy5GsgbXcTylnv
         v518Cl3Dx0OsUm0Tl90TzfsDB5luYd2KnYAkPpO6J+Zp2AYT0NscNVgkR/xk7wlJm5pY
         RaDw==
X-Gm-Message-State: AAQBX9cVPp16tK31FIo7L4FMi08vXpZWMMpHilaYDi5TJz1mnDh6UknP
        08ltwn/pDTG3K9EwVKvKCuM=
X-Google-Smtp-Source: AKy350ZFZ0tAPeb2puSIjsfopJTo0TSHmQlUFsuinXNlDin8L198gWglStuUx+Pn4Aelm2jMiVo1KA==
X-Received: by 2002:a05:6a21:798:b0:c6:c0c1:b1fe with SMTP id mg24-20020a056a21079800b000c6c0c1b1femr23542517pzb.57.1682529261321;
        Wed, 26 Apr 2023 10:14:21 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f23-20020a656297000000b00514256c05c2sm10116430pgv.7.2023.04.26.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:14:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com
Subject: Re: [PATCH v3 1/2] negotiator/default: avoid stack overflow
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
        <cover.1682513384.git.hanxin.hx@bytedance.com>
        <0e69d70805e6da684e6e17642a1cf0d59a03dfc0.1682513384.git.hanxin.hx@bytedance.com>
Date:   Wed, 26 Apr 2023 10:14:20 -0700
In-Reply-To: <0e69d70805e6da684e6e17642a1cf0d59a03dfc0.1682513384.git.hanxin.hx@bytedance.com>
        (Han Xin's message of "Wed, 26 Apr 2023 21:15:03 +0800")
Message-ID: <xmqqedo6tvkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:

> mark_common() in negotiator/default.c may overflow the stack due to
> recursive function calls. Avoid this by instead recursing using a
> heap-allocated data structure.
>
> This is the same case as 4654134976f (negotiator/skipping: avoid
> stack overflow, 2022-10-25)
>
> Reported-by: Xin Xing <xingxin.xx@bytedance.com>
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---
>  negotiator/default.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/negotiator/default.c b/negotiator/default.c
> index f4b78eb47d..635cdd6483 100644
> --- a/negotiator/default.c
> +++ b/negotiator/default.c
> @@ -55,30 +55,49 @@ static int clear_marks(const char *refname, const struct object_id *oid,
>  static void mark_common(struct negotiation_state *ns, struct commit *commit,
>  		int ancestors_only, int dont_parse)
>  {
> -	if (commit != NULL && !(commit->object.flags & COMMON)) {
> -		struct object *o = (struct object *)commit;
> +	struct prio_queue queue = { NULL };
> +
> +	if (!commit || (commit->object.flags & COMMON))
> +		return;

The original naive recursive marker had a large if block guarded by
the opposite condition around the whole thing, which amounts to the
same as this early return.  Good.

> +	prio_queue_put(&queue, commit);

And the code now uses on-stack priority queue here, and bootstraps
the machinery by placing the first element here.  OK.

> +	if (!ancestors_only) {
> +		commit->object.flags |= COMMON;
>  
> -		if (!ancestors_only)
> -			o->flags |= COMMON;

These two are equivalent, which is good.

> +		if ((commit->object.flags & SEEN) && !(commit->object.flags & POPPED))
> +			ns->non_common_revs--;

Hmph, this is a bit unexpected to duplicate the non_common_revs
counting logic here.  In the original, this piece of code was there
just after we decided to continue digging into the parents, and even
if this patch changes the mechanism with which "digging into the
parents" from recursion to priority queue, it is not obvious why we
can keep doing the decrementing for the current commit we are
looking at, instead of doing that for parents of the commit like
this patch does.  In other words, it is not clear why it needs to be
changed while going from recursive to iterative.

Is it because ancestors_only is not usable inside the loop in the
iterative version?  That is, if ancestors_only is not set, we do
paint the initial commit as COMMON just as the parents we discover
in the loop, but when ancestors_only is set, we need to skip painting
the initial commit as COMMON, so the patch moves that logic?

It may solve the issue of special casing the initial commit, but it
feels backwards in that the resulting loop becomes harder to
understand by making it necessary to process the initial commit
outside the loop only halfway.

It may make it easier to understand if we had another local
variable, "struct commit *skip_commit", that is NULL by default but
is set to the initial commit when ancestors_only is set, and do the
painting with COMMON and counting of non_common_revs all inside the
loop for the current commit that is being processed (instead of the
parents the loop discovered).  I dunno.  It would avoid duplicating
the logic and implements the "ancestors_only, do not paint or count
the initial commit" in a more readable and straight-forward way, no?

Thanks.

> +	}
> +	while ((commit = prio_queue_get(&queue))) {
> +		struct object *o = (struct object *)commit;
>  
>  		if (!(o->flags & SEEN))
>  			rev_list_push(ns, commit, SEEN);
>  		else {
>  			struct commit_list *parents;
>  
> -			if (!ancestors_only && !(o->flags & POPPED))
> -				ns->non_common_revs--;
>  			if (!o->parsed && !dont_parse)
>  				if (repo_parse_commit(the_repository, commit))
> -					return;
> +					continue;
>  
>  			for (parents = commit->parents;
>  					parents;
> -					parents = parents->next)
> -				mark_common(ns, parents->item, 0,
> -					    dont_parse);
> +					parents = parents->next) {
> +				struct commit *p = parents->item;
> +
> +				if (p->object.flags & COMMON)
> +					continue;
> +
> +				p->object.flags |= COMMON;
> +
> +				if ((p->object.flags & SEEN) && !(p->object.flags & POPPED))
> +					ns->non_common_revs--;
> +
> +				prio_queue_put(&queue, parents->item);
> +			}
>  		}
>  	}
> +
> +	clear_prio_queue(&queue);
>  }
>  
>  /*
