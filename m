Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4430AC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDXSGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjDXSGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:06:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAC6584
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:05:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b51fd2972so3899728b3a.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359550; x=1684951550;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ogXEVU8WLNLJnxYAnCnluxCJRIGcHKDmxL+4G2gXjg=;
        b=AjBoNe1fsHJOcVWfuFHfqmE5B8lhEWLP15Ij/Huk8THnA/pCUeaJyc1ZAZDF8IAMdk
         9DEjjrf/BBtbLH0oBUudwNjigvdzSOD6nNR1X/e2eNFiAfR0+IiVpUxUhtTb/6DTpWHO
         rlXRIAFaNkAu6Pd1e6KZlZfQn3Jy4TUiuMUA9zSqF1YUWprz2zSEsdJINmbh3eGDbv1F
         F9Kj7rkSsWNWB/bmOge3i7zxfUEPPzNBFvT0peiywZ/B5e8/MBUPNIM8W652LcIzCF2F
         CCdT0mklt6XemdR67NDTvkU6l8dM7dqOqb94mqTFNpelfPBy8WctystHQ7+skUowBqet
         4ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359550; x=1684951550;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ogXEVU8WLNLJnxYAnCnluxCJRIGcHKDmxL+4G2gXjg=;
        b=V0n/cJcWTIR0IukY2rW8zif8vLA5afPy34zAPuwqKE9/6Sy3Oozt6vyB6ZOhquZvs+
         VPXYV0sr78AKjw1Yb3Yy2XEA+nRPbNah7hr4r81IJyeTz7q0V4TmikQ+2u6hM+KadebQ
         HYeyR0iolJUx7RUA1aABCuSY2OYG79rmNig9TEQmgkIj+Y2a0vpkLlJnafoc0DeWbf2C
         KW1QI3W2Op8ydJr3R84pgM/r4krUnOKuwrDEJJl29JvpBd+bIXu75+dtOHFM5exEDm3T
         AH7NwV8fo9gNFyhn95XVTwy9RlvVnlvO+X3n2A5LGIM4FYxiA7kSM5pTBo7Poz1WgFo7
         ZFRQ==
X-Gm-Message-State: AAQBX9fC1qjhUOQhOvlQZrJG+/Ycb4AJEnwtk4DAqCTKSrDZ/a08nkrR
        pOaedRe8DkmtkX1byiGsuck=
X-Google-Smtp-Source: AKy350asEDz7JtVfKwdmL99+59kwuMyJsND5G49LX1LGv9P7gVgEFnNatGGnNXs3sKVKtF70lTCvTQ==
X-Received: by 2002:a05:6a00:1147:b0:63b:6933:a328 with SMTP id b7-20020a056a00114700b0063b6933a328mr17991622pfm.28.1682359550040;
        Mon, 24 Apr 2023 11:05:50 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id m21-20020a62a215000000b0063f33e216dasm3856998pff.96.2023.04.24.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:05:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] notes: clean up confusing NULL checks in init_notes()
References: <20230422135455.GA3942740@coredump.intra.peff.net>
        <20230422135543.GA3942829@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 11:05:49 -0700
In-Reply-To: <20230422135543.GA3942829@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 09:55:43 -0400")
Message-ID: <xmqqttx5duki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Coverity complains that we check whether "notes_ref" is NULL, but it was
> already implied to be non-NULL earlier in the function. And this is
> true; since b9342b3fd63 (refs: add array of ref namespaces, 2022-08-05),
> we call xstrdup(notes_ref) unconditionally, which would segfault if it
> was NULL.
>
> But that commit is actually doing the right thing. Even if NULL is
> passed into the function, we'll use default_notes_ref() as a fallback,
> which will never return NULL (it tries a few options, but its last
> resort is a string literal). Ironically, the "!notes_ref" check was
> added by the same commit that added the fallback: 709f79b0894 (Notes
> API: init_notes(): Initialize the notes tree from the given notes ref,
> 2010-02-13). So this check never did anything.

I am impressed(?) that Coverity can complain at the "_or_null" part
in xstrdup_or_null().

It all makes sense.  Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  notes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 45fb7f22d1..cadb435056 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1019,13 +1019,13 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>  	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
>  	t->first_non_note = NULL;
>  	t->prev_non_note = NULL;
> -	t->ref = xstrdup_or_null(notes_ref);
> +	t->ref = xstrdup(notes_ref);
>  	t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
>  	t->combine_notes = combine_notes;
>  	t->initialized = 1;
>  	t->dirty = 0;
>  
> -	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
> +	if (flags & NOTES_INIT_EMPTY ||
>  	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
>  		return;
>  	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
