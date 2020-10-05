Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B4EC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2420FC3
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 21:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0d2zCDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgJEV15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 17:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJEV15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 17:27:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FCC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 14:27:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s19so161236plp.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vkV5Or3s3+43yHhGYUIzA5/ndcH8zEXALRlfSsZEJd0=;
        b=m0d2zCDLTaq3oQgeI9Q3dDhzx6yfOEvL9zrNrZqVxkqinHBisFbrIYgR6iP076nlSG
         aVvymNoi5aNbgZR8v5yjHLvHdqa3OHkbUzVHoCh0zJZzvc0REnOxT4SJDVjI+6Y6EPiI
         8rQTsylgWgDxbTjgB0ceb+cofCwJiD2CrImPYHc/N3XthNHGOljHKTSwqPS0l5fuZpFh
         YBqKfIFW9T+HhlEVcIEVR1occyhEiiaSvSBoJXnniE6euqQHIhYJeWvmjyDEZYn8ry/k
         qzYNB227LjXz404C1BYsIT5VVF2a+I2cucPltNddlbEtT195OXmjemW+pzb0awn8kENj
         KoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkV5Or3s3+43yHhGYUIzA5/ndcH8zEXALRlfSsZEJd0=;
        b=KvgKTqGEn1CDMYsd3ABNE84FldvVZ2CU/IU3ZyLS1tRAYsFthNJbA1HfAytqFO5XEa
         +yhLE9PtTq6TIVskhoVFdgi/F3CEXaFOzSSRIQCSRraL12pwXtB/JhHydx/zGooSuEmb
         ORSUXY1fJSbxzoz/VSnAj3Wz2Zr4x/7Qfb4OFB8NTEu+vBW2nyi9o8eShgZUDJ8x3FMz
         lrK467JtkVlwg9/EFfKhbvCsQ91KAayiUeHBpjjM2CNQ16Q3Row+vOtZ5DaACJgj9iXD
         I8HhuPUNwXl1KwswONScQxhDtfV9R0gh7x6FHiD2RVrlGdmapCjEImnykp7PJDoIW/qv
         bDyQ==
X-Gm-Message-State: AOAM530uF4jc8kLIeSP+6yCCzs+z74ndzCkcUVzXZoyXTk2vmC1vi7Vl
        qj71iMQ7LRHH/9axu0Yi09TWZJOWhqVRBQ==
X-Google-Smtp-Source: ABdhPJzaqN8hz00tt7VG2anqm7CfAMn+tT3DsiBHjd1SumMrdTGlskJFY3GTV+HOcM3MlDGP3i+zbg==
X-Received: by 2002:a17:90a:8d09:: with SMTP id c9mr1324125pjo.76.1601933276612;
        Mon, 05 Oct 2020 14:27:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id w3sm497314pjj.37.2020.10.05.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 14:27:56 -0700 (PDT)
Date:   Mon, 5 Oct 2020 14:27:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 8/9] commit: use config-based hooks
Message-ID: <20201005212751.GH331156@google.com>
References: <20200909004939.1942347-9-emilyshaffer@google.com>
 <20200923234734.1294057-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923234734.1294057-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 04:47:34PM -0700, Jonathan Tan wrote:
> 
> > -	if (!no_verify && find_hook("pre-commit")) {
> > +	if (!no_verify && hook_exists("pre-commit")) {
> 
> A reviewer would probably need to look at all instances of "pre-commit"
> (and likewise for the other hooks) but if the plan is to convert all
> hooks, then the reviewer wouldn't need to do this since we could just
> delete the "find_hook" function.
> 
> Overall comments about the design and scope of the patch set:
> 
>  - I think that the abilities of the current patch set regarding
>    overriding order of globally-set hook commands is sufficient. We
>    should also have some way of disabling globally-set hooks, perhaps
>    by implementing the "skip" variable mentioned in patch 1 or by
>    allowing the redefinition of hookcmd sections (e.g. by redefining a
>    command to "/usr/bin/true"). To me, these provide substantial
>    user-facing value, and would be sufficient for a first version - and
>    other things like parallelization can come later.

OK. I will send 'skip' in the next reroll. Thanks for pointing it out!

> 
>  - As for the UI that should be exposed through the "git hook" command,
>    I think that "git hook list" and "git hook run" are sufficient.
>    Editing the config files are not too difficult, and "git hook add"
>    etc. can be added later.
> 
>  - As for whether (1) it is OK for none of the hooks to be converted (and
>    instead rely on the user to edit their hook scripts to call "git hook
>    run ???"), or if (2) we should require some hooks to be
>    converted, or if (3) we should require all hooks to be converted: I'd
>    rather have (2) or (3) so that we don't have dead code. I prefer (3),
>    especially since a reviewer wouldn't have to worry about leftover
>    usages of old functions like find_hook() (as I mentioned at the start
>    of this email), but I'm not fully opposed to (2) either.

I personally prefer (3) - I think the user experience with (2) in a
release (or even in 'next', which all Googlers use) is pretty bad. The
downside, of course, is that a large topic gets merged all at once and
makes some pretty nasty reviewer overhead.

Junio, I wonder if you can give any advice here? What would be really
ideal for me would be to do something like Stolee has been doing with
his maintenance series - config-based hooks pt. I containing the library
code and config-based hooks pt. II containing the conversion of
preexisting hooks. Does that make the overhead for you significantly
worse?

 - Emily
