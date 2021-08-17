Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A4EC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 23:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6722A60F5E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 23:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhHQXCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQXCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 19:02:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD1C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 16:02:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so7629641pjb.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NFDYYZfc1Jb+2KBJrg7HxDfkt/S8UXBuEm3iZfudpW8=;
        b=Iq1ZrbGVyg7KC0YXzf3HTMQ++P5j0dbzT8HhGxR17s5JF11THnDuESwUIvhduQEKch
         8Y8hOt9dbFbkC28vI0ctsKkcj4Ir2+yfEKxRXdS/G5MUFBibcy9x60inHzWpKTYUek7L
         2M2CaqL367sdI/QtsTrs05m207yi3bK2C79TMCSyt6HtJtEHwUNwaz6UNXDyKiIhk7Ez
         b53//TGBcixxetqhkEBwP2XJgxBegtmX58C1IL5vSPvgc2uSgMz6/LVIIOQsor3Pwgqs
         g4/FeWQjXelQLcwCKjhHBvIJO4W3dKZ9uVxD1ZITnOb1thfZD0z1eaBYhZUa7uNfo5dn
         qZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NFDYYZfc1Jb+2KBJrg7HxDfkt/S8UXBuEm3iZfudpW8=;
        b=Dts+w4xuyWOeN7GQ+F158oE17C1RSe0JPWRaXELneeqT9x1E4IsRt9FrOkBYvvQnci
         k1Y198UDVw26f3bawa8SgJLTrA2M1YT3zBMEH13IjMUXTkp9qnOt6JF6CSGDqnr2oAU3
         02L2jn4HxoYwCqaL43Nmh4Ogj6d/ScwwVYJG+d/zz1cG7kEtg+xKkJcJEtH0AEUSZ1C7
         hPD2+KvuoYBUk9F+Ow3qu6enqJPqvL/7pN6DGgHScaK1avKh+Yk6fLhums+yOd6IkCvO
         P/M3aHz/AbuGu1zZuFQgsIuZ0/rlSJQSAJP/dxoSGvnsziW0XJmbXr3pqPaPFbYE48o0
         dr9g==
X-Gm-Message-State: AOAM533duDn+xqGiWW0HvOPpPA6tRIyjRS3ZsaJPgU/B2hH4yQmmZIAq
        cDQfprv+VZ8mq9b7YAad6Yj5RA==
X-Google-Smtp-Source: ABdhPJwi1RrlOAQQAhOqvycVVC7bdIBqk8tr6BMs5LkHYUpvludCGCM/nuV77XlLVp+GuluKMlgcdw==
X-Received: by 2002:a17:90a:e641:: with SMTP id ep1mr5870682pjb.209.1629241339577;
        Tue, 17 Aug 2021 16:02:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:69dd:f5ad:cd83:910c])
        by smtp.gmail.com with ESMTPSA id ca12sm2999021pjb.45.2021.08.17.16.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 16:02:18 -0700 (PDT)
Date:   Tue, 17 Aug 2021 16:02:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mahi Kolla <mkolla2@illinois.edu>
Subject: Re: [PATCH v6] clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
Message-ID: <YRw/8tThN7djNE+E@google.com>
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
 <xmqqy293ucju.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy293ucju.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 14, 2021 at 11:05:41AM -0700, Junio C Hamano wrote:
> 
> "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 66fe66679c8..a08d9012243 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -986,6 +986,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  	struct remote *remote;
> >  	int err = 0, complete_refs_before_fetch = 1;
> >  	int submodule_progress;
> > +	int sticky_recursive_clone;
> 
> This variable does not have to be in such a wider scope, I think.
> 
> 
> >  	struct transport_ls_refs_options transport_ls_refs_options =
> >  		TRANSPORT_LS_REFS_OPTIONS_INIT;
> > @@ -1130,6 +1131,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  					   strbuf_detach(&sb, NULL));
> >  		}
> 
> Just in this scope, where "struct string_list_item *item" and
> "struct strbuf sb" are declared, is where an extra int variable,
> which receives the configuration value, needs to exist.
> 
> Also, for a variable that is used only to receive value from
> git_config_get_bool(), immediately to be used and then never used
> again, we do not need such a long and descriptive name.
> 
> > +		if (!git_config_get_bool("submodule.stickyRecursiveClone", &sticky_recursive_clone)
> > +		    && sticky_recursive_clone) {
> > +		    string_list_append(&option_config, "submodule.recurse=true");
> > +		}
> 
> We do not need {} around a single statement block.
> 
> Taken together, perhaps like the attached.
> 
> I'll queue the patch posted as-is for now.
> 
> Thanks.
> 
> diff --git c/builtin/clone.c w/builtin/clone.c
> index 66fe66679c..c4e02d2f78 100644
> --- c/builtin/clone.c
> +++ w/builtin/clone.c
> @@ -1114,6 +1114,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (option_recurse_submodules.nr > 0) {
>  		struct string_list_item *item;
>  		struct strbuf sb = STRBUF_INIT;
> +		int val;
>  
>  		/* remove duplicates */
>  		string_list_sort(&option_recurse_submodules);
> @@ -1130,6 +1131,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  					   strbuf_detach(&sb, NULL));
>  		}
>  
> +		if (!git_config_get_bool("submodule.stickyRecursiveClone", &val) &&
> +		    val)
> +		    string_list_append(&option_config, "submodule.recurse=true");
> +
>  		if (option_required_reference.nr &&
>  		    option_optional_reference.nr)
>  			die(_("clone --recursive is not compatible with "

I like the changes you propose here. It also looks to me like you wanted
to wait for Mahi to send the updates herself, which I appreciate.

Mahi's internship ended last week and I believe she told me she's
planning to be very busy this week; so if we don't hear from her by this
time next week, I'll send a reroll with these changes (unless you want
to just take them yourself without the list churn).

 - Emily
