Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFEAC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E68F238EF
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgLQORN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 09:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgLQORN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 09:17:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA79C061794
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 06:16:33 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id hk16so4187991pjb.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 06:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/Ih2nOcdmfy8riFNJiUEsh7+VvFGa9s5vbc46vu67Q=;
        b=udEkmo5vaME4EI4e2NiKvIDo7Bb3kxf4t3m4s6GcH5qC04EQm0qyIbfSnMOV4hwAQ+
         g0O4aOPPIE8rr/zGD7nYbZTdSqSuajbrKjmgvaNtOg0JHkhVnmeZIE8XP6WLqhlyJ2Ly
         hhhco5KgRyV0JwzfDS6xwPBY4c2b1H33BtTZjEpRg8/TYS38L8aEs43nPHGBVmHYx715
         vBSpdakNj9g3WNQ3Kn3tZAsKI9yMEmtLcQ2C5OMjQ2zRsPYpcZfs4Ora2yPyMPle/9rg
         DgIrwurPERTZoAPVSCSOmnvr6wGbSkEXv57kTa5/Qq32dMU3/QXJoIzuShWZXSFwiWRA
         j5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/Ih2nOcdmfy8riFNJiUEsh7+VvFGa9s5vbc46vu67Q=;
        b=Ln0SGHvBmK/ScMI1HfFF+dMG/xK1hy0lTr93xZoZSk4Oh8RhicRjxQV2UVugJ08E47
         yIkf0HH1doJKZqPWktjZdhqXS5x0pvuXx1e4b9xM4cqwG3ADEApWg+kZ1QjuI2+SOtj7
         7nsBTSP9aOR5UzdFcCmu6MkS+9jEkNNeugV5TvTfqznoBYBtGD9oy0/XOyLnD0bt+LCc
         MP+rnn/gsZJd5bdJrDOXgknITqDOFbJXOKyXTGM1USz5NPNF/x2qh9NL1c5QByEOq8jK
         OXVOvHKKaw2CLraKhGe91b/4pqJKMRYpvp0PstfTf+wPmeC+oBnZAgG8LCnAFCNGlXUk
         zc/g==
X-Gm-Message-State: AOAM532FnCgWbXn8+uUf05sgAqtMybjQ8ExU4+Xn1cIruz37gDN2nl3s
        jX816221MDTJhFD6r0YWwx4=
X-Google-Smtp-Source: ABdhPJxrEshwUQj36djtj6uXnO3YeYu+DyVvI/xXWWhb7yqA7xTMhOv1gk8aW5MgSdRjJhxGZWsIlw==
X-Received: by 2002:a17:902:ee0b:b029:dc:1aa4:1123 with SMTP id z11-20020a170902ee0bb02900dc1aa41123mr6547711plb.18.1608214592696;
        Thu, 17 Dec 2020 06:16:32 -0800 (PST)
Received: from konoha ([27.56.186.8])
        by smtp.gmail.com with ESMTPSA id q6sm5556333pfu.23.2020.12.17.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:16:32 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:46:25 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 0/3] submodule: port subcommand add from shell to C
Message-ID: <20201217141625.GA7638@konoha>
References: <20201214231939.644175-1-periperidip@gmail.com>
 <xmqqlfdy7niy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfdy7niy.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/12 01:44, Junio C Hamano wrote:
> Shourya Shukla <periperidip@gmail.com> writes:
> 
> >     3. In the following segment:
> >         /*
> >          * NEEDSWORK: In a multi-working-tree world, this needs to be
> >          * set in the per-worktree config.
> >          */
> >         if (!git_config_get_string("submodule.active", &var) && var) {
> >
> >         There was a comment: "What if this were a valueless true
> >         ("[submodule] active\n" without "= true")?  Wouldn't get_string()
> >         fail?"
> >
> >         I was under the impression that even if the above failed, it
> >         will not really affect the big picture since at the we will set
> >         'submodule.name.active" as true irrespective of the above value.
> >         Is this correct?
> 
> Let's see what kind of value the "submodule.active" variable is
> meant to be set to.  Documentation/config/submodule.txt has this:
> 
>     submodule.active::
>             A repeated field which contains a pathspec used to match against a
>             submodule's path to determine if the submodule is of interest to git
>             commands. See linkgit:gitsubmodules[7] for details.
> 
> It definitely is a string value, and making it a valueless true is
> an error in the configuration.

I think that we did not _make_ it a valueless true. It was already there
and we somehow managed to check it. If you mean that we should ensure
that we set it to "true" so that any such errors don't happen later on,
then that is a different thing.

> I wonder if we want to diagnose such
> an error, or can we just pretend we didn't see it and keep going?

I guess we could pretend we did not see it since it isn't affecting the
run of the sub-command. If you think otherwise, please suggest.

> Also the "var" (one of the values set for this multi-valued
> variable) is never used in the body of the "if" statement.  The
> other user of "submodule.active" in module_init() seems to use
> config_get_value_multi() on it.  The new code may deserve a comment
> to explain why that is OK to (1) grab just a single value out of the
> multi-valued variable, and (2) not even look at its value.

Understood. So a comment along the lines of:

	/*
	 * Since we are fetching information only about one submodule,
	 * we need not fetch a  list of submodules to check the activity
	 * status of a single submodule.
	 *
	 * In case of a valueless true, i.e, '[submodule] active\n'
	 * without '= true', we need not worry about any errors since
	 * irrespective of the above value, we will set
	 * 'submodule.<name>.active' as true.
	 */

will work? Also, could you please comment on the other two issues I
mentioned in the cover letter so I might as well start work on v4 of
this patch?

Regards,
Shourya Shukla

