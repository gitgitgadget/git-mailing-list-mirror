Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55FAC43381
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779AA6509B
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCEXAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhCEW76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 17:59:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBDEC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 14:59:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y5so2407569pju.5
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 14:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SQp+cx6yLGLn9FeojVyBOmlmVSndRT0otl9D7rmuI4M=;
        b=JU38aqDeU7L9bn7tq8qn+a6Ps/1Dlh9GzmZFWaCnZrCRWy7CNwjL/johe4QV2kEAjV
         p8D3A1c+2LNxsiccJhXJ8+ES/2TaGX08o/Sdzuzb+41VslvAB8MEhNVo5FS/AYBR3q8j
         YZOhiViRvLU0sFHDbHZNk+L2paRHMj0RX+TIICF9uTFvfEcMK97kwqjFT04rqa1yCdR6
         iIahnsTmJ5mFhkL426MstyZSr24Jcrcxhf9bb2gwvGmJda8eoUMFTvMEoOFgrTKLAV93
         b/kuGFM+tNipwaTkTUNgIqTh2fHwiS4KGErvr7rXqRWZTCW93kwuWatuO9oVYY2ehc0G
         VKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SQp+cx6yLGLn9FeojVyBOmlmVSndRT0otl9D7rmuI4M=;
        b=IwH2xFI6VeH4cp40DRynILCYJ3zQikekuMIpNHRD0aWREJzGwbLSq78m8AkqDM1ZgU
         1gQQl7n6aMxLRrQ+dceeXt6jAy3gVkCjOm5RwschVaFsyx6R6ZRG8KQguxNafgTUJGUC
         3XareymIgOD1sbihENcl2KekI96vUC2VTH/q1kEaY3cC8dD/2uNth1yuK1Wbo98PX54W
         ZkdwhNLECJtiyQPSLG+lWKu+eHms/hwa8qld/7+tYcA64hjIUPVMnSDOcUD1QO0BFnBV
         W0Hb8d6WVBtCbOOIL+p3Wm9ySSuSglzk+FWJJ2SNGDUD9FJ35c384F7sST51wKdq0OgN
         +0OA==
X-Gm-Message-State: AOAM533jfGp6gFX6VdeA3QnomOq2HVOZ1AvZTOQhBBaxpU8Tjxn5AcVD
        oo9MIhM1v1l6ISf2XNb49SwJlJZUPUcz4hthuDe7
X-Google-Smtp-Source: ABdhPJxWwge+N0mHj9CArs/CKOUz/dhIxCiFAZEg+CX8+oCqg4OIOdJncFwU3G+a2ufh39H81M//vgdEb62+Ni93NPH+
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr1837680pjo.0.1614985197086; Fri, 05 Mar 2021 14:59:57 -0800 (PST)
Date:   Fri,  5 Mar 2021 14:59:53 -0800
In-Reply-To: <xmqqzgzha0z5.fsf@gitster.c.googlers.com>
Message-Id: <20210305225953.739816-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzgzha0z5.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When fetching (as opposed to cloning) from a repository with packfile
> > URIs enabled, an error like this may occur:
> >
> >  fatal: pack has bad object at offset 12: unknown object type 5
> >  fatal: finish_http_pack_request gave result -1
> >  fatal: fetch-pack: expected keep then TAB at start of http-fetch output
> >
> > This bug was introduced in b664e9ffa1 ("fetch-pack: with packfile URIs,
> > use index-pack arg", 2021-02-22), when the index-pack args used when
> > processing the inline packfile of a fetch response and when processing
> > packfile URIs were unified.
> 
> > This bug happens because fetch, by default, partially reads (and
> > consumes) the header of the inline packfile to determine if it should
> > store the downloaded objects as a packfile or loose objects, and thus
> > passes --pack_header=<...> to index-pack to inform it that some bytes
> > are missing. 
> 
> ... and what the values in them are.

Ah, that's true.

> > However, when it subsequently fetches the additional
> > packfiles linked by URIs, it reuses the same index-pack arguments, thus
> > wrongly passing --index-pack-arg=--pack_header=<...> when no bytes are
> > missing.
> >
> > This does not happen when cloning because "git clone" always passes
> > do_keep, which instructs the fetch mechanism to always retain the
> > packfile, eliminating the need to read the header.
> >
> > There are a few ways to fix this, including filtering out pack_header
> > arguments when downloading the additional packfiles, but ...
> 
> Avoiding the condition that exhibits the breakage is possible, and I
> think it is what is done here, but I actually think that the only
> right fix is to pass correct argument to commands we invoke in the
> first place.  Why are we reusing the same argument array to begin
> with?
> 
>     ... goes back and reads the offending commit ...
> 
> commit b664e9ffa153189dae9b88f32d1c5fedcf85056a
> Author: Jonathan Tan <jonathantanmy@google.com>
> Date:   Mon Feb 22 11:20:08 2021 -0800
> 
>     fetch-pack: with packfile URIs, use index-pack arg
>     
>     Unify the index-pack arguments used when processing the inline pack and
>     when downloading packfiles referenced by URIs. This is done by teaching
>     get_pack() to also store the index-pack arguments whenever at least one
>     packfile URI is given, and then when processing the packfile URI(s),
>     using the stored arguments.
> 
> THis makes it sound like the entire idea of this offending commit
> was wrong, and before it, the codepath that processed the packfile
> fetched from the packfile URI were using the index-pack correctly
> by using index-pack arguments that are independent from the one that
> is used to process the packfile given in-stream.  Why isn't the fix
> just a straight revert of the commit???

I should probably have written more in the commit message to justify the
unification, but it is also part of a bug fix (in particular,
--fsck-objects wasn't being passed to the index-pack that indexed the
packfiles linked by URI) and for code health purposes (to prevent future
bugs by eliminating the divergence). So reverting that commit would
reintroduce another bug.

> > @@ -885,7 +885,7 @@ static int get_pack(struct fetch_pack_args *args,
> >  			strvec_push(&cmd.args, "-v");
> >  		if (args->use_thin_pack)
> >  			strvec_push(&cmd.args, "--fix-thin");
> > -		if (do_keep && (args->lock_pack || unpack_limit)) {
> > +		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
> >  			char hostname[HOST_NAME_MAX + 1];
> >  			if (xgethostname(hostname, sizeof(hostname)))
> >  				xsnprintf(hostname, sizeof(hostname), "localhost");
> 
> I do not quite get what this hunk is doing.  Care to explain?

The "do_keep" part was unnecessarily restrictive and I used a band-aid
solution to loosen it. I think this started from 88e2f9ed8e ("introduce
fetch-object: fetch one promisor object", 2017-12-05) where I might have
misunderstood what do_keep was meant to do, and taught fetch-pack to use
"index-pack" if do_keep is true or args->from_promisor is true. What I
should have done is to set do_keep to true if args->from_promisor is
true. Future commits continued to do that with fsck_objects and
index_pack_args.

Maybe what I can do is to refactor get_pack() so that do_keep retains
its original meaning of whether to use "index-pack" or "unpack-objects",
and then we wouldn't need this line. What do you think (code-wise and
whether this fits in with the release schedule, if we want to get this
in before release)?
