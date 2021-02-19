Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC02C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4565464EB8
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 20:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSUY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSUY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 15:24:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E91C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 12:23:46 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o7so5625924pgl.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+KBaEp6MOBeQ7/9NSBMSJwX0qcjhNm5Nor4dMTaN4A=;
        b=mbs+CIcC8KJNZBMPzdU7BP7CfZurOyJyKLqnLbzmcjmVAd8cJHFtwFt8rUBHCKcjNi
         7TbDN/1wMxW2nJekewJksKGDTiOV+CV4LjvwJHTbDXgPmCIQqbFsBKuC6G1zvmzBBiO8
         UWyfpjrQFj7wYKgmjDamGHXFUwftqfdmGMjqj7utXuLGLIl6K7dbIII/m691yIpGihvK
         T1nLbsEOOEsjJJdUiR9OnNjbDFiVjChvPL2BDUV9SRlT+SUK6M/hk0Sg2ZYiozVeJxCI
         8449+7CngZsVA/9XAS65CIIqwRTjYKtNezVTALX3FnHWHaOuJWyLDObxNh+XE0qLBdXC
         KT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+KBaEp6MOBeQ7/9NSBMSJwX0qcjhNm5Nor4dMTaN4A=;
        b=cLb8C1tjEH6KoYVWIObXrueN3FMOKrFKNVrSYIgKDByZV6d5UN9LPXamEnsn1J87N0
         GtJlygOhJ6k8C6WEfUkMxLLfAmTopJeU5FSVYa+ZRPNnvwwnG7X1vjOEnX8MBJP80Chc
         /wNgztzF7LZ9CFaWOMwoBl5beCPa86a0nImBRTqZ1bRQiD0RPBi8TYMsvwYHNULHTliR
         uJDoi4WiO8OeLhFc/sJY7OgiwHiMaColZ6XVsvkT4vuXQUehYkvT6GaxeHT7pw/GBAtf
         957erRKVOXdZ8j9iR+oC/0ywwgbJdeO6wQJv7ZpktLGdfl7yCY9gZpwFgU2+u6REw936
         LQjQ==
X-Gm-Message-State: AOAM5321Crr2exjgxXzxJRbL9F3LoQsx/PObgfaw3rtgE8G+dNWSShd8
        IkJiVhV2wtf4eJnMJQbwT9/Wlg==
X-Google-Smtp-Source: ABdhPJzVOyEnZzYmq6LN1mtACrJAC+WftVClhoSau67BPBFTTOnfn1OlGkIwDkqs1FadXIhzGrKjwA==
X-Received: by 2002:a63:db08:: with SMTP id e8mr10068234pgg.261.1613766225596;
        Fri, 19 Feb 2021 12:23:45 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:5fa:7ec3:7e:6710])
        by smtp.gmail.com with ESMTPSA id w83sm10362758pfc.220.2021.02.19.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 12:23:44 -0800 (PST)
Date:   Fri, 19 Feb 2021 12:23:39 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 11/17] run-command: allow stdin for
 run_processes_parallel
Message-ID: <YDAeSwOx4MkCda9H@google.com>
References: <20201222000220.1491091-12-emilyshaffer@google.com>
 <20210201053808.1309469-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201053808.1309469-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 31, 2021 at 09:38:08PM -0800, Jonathan Tan wrote:
> 
> > diff --git a/run-command.c b/run-command.c
> > index ea4d0fb4b1..80c8c97bc1 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1683,6 +1683,9 @@ static int pp_start_one(struct parallel_processes *pp)
> >  	if (i == pp->max_processes)
> >  		BUG("bookkeeping is hard");
> >  
> > +	/* disallow by default, but allow users to set up stdin if they wish */
> > +	pp->children[i].process.no_stdin = 1;
> > +
> 
> This makes sense. May be worth a more detailed comment, e.g.:
> 
>   By default, do not inherit stdin from the parent process. (If not, all
>   children would share it!) Users may overwrite this by having the
>   get_next_task function assign 0 to no_stdin and an appropriate integer
>   to in.

Thanks, took it slightly modified:

 /*
  * By default, do not inherit stdin from the parent process - otherwise,
  * all children would share stdin! Users may overwrite this to provide
  * something to the child's stdin by having their 'get_next_task'
  * callback assign 0 to .no_stdin and an appropriate integer to .in.
  */

 - Emily
