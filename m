Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EAC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 03:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96143610A1
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 03:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhIWDBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbhIWDB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 23:01:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A8C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:59:58 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b6so5152268ilv.0
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRj1r5/ezhZCgZsK8028gLLzvwoB5jdnTQZmzXcMP64=;
        b=daTcSg5eL+UxPVY6GcXzV4UbxM8MNU0U38bBThj/VPgTPbP8ya7UlFyhLD1f6U9jsD
         l3txKrdUhCHfP2vINvKfHZCMR0gM7NoXMxUjR6hQcF4eTorRQfffm5Y1u8tzNOLRWlLm
         DxI6Y1TTH17eGhvKZFdv71b/MCZW0knMIa4E6zWVdT9o9LD00tG1KFrAYIPn3oq30WnP
         1QanmAfZ+F6bqHBWm2Mj8iEomsBmKJEyWdxFzkIVguKvOXfjHPYnpbBrZGqMPTDvPP8w
         cjpHUEp2convcFoFWfmPF+eF5FowuJHfJiZE7FelgZhnKotw71ZtW6SMjTvOyFxsPSZx
         6MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRj1r5/ezhZCgZsK8028gLLzvwoB5jdnTQZmzXcMP64=;
        b=gcOtZAIj3xuZSG6BqET4V7YEHqjgnTU7hYnfgzGnnurrU0J3U6fg6/2ny9mJvyR1OK
         Dhpw1zR4j/l7wlkWl7BJmKHkGhBcBApiB56FWitT287KCHM8bzh02bOwexczNBBgdCHv
         pHyzKc9cWYveCPj0mHsC62fPzECJMvqBkJsBTl72lTMVDjVuKHUAjFRh5zWpPxQHo/l5
         Q1SQDSflgxYyLUPawHmaannSaCgK7C8eztMzTchdhluKIWM7mFOkrb9hJKSECGrpsKH7
         Lu8SJMnFsoapJ9bWnnn0Sng0YNY+4yI1KmEMOIfjY7UoAaQqylMIGtXMh6PMUc4F/dgy
         3Xqw==
X-Gm-Message-State: AOAM531WxRr5Em6+GsT0yFqbQIxHYEpicLK8zXzMw3IP9tGxLOqqsGGw
        9QKkuvLXuJw7q3vUiRC1fDHOIg==
X-Google-Smtp-Source: ABdhPJxxvaYOB887++IiFbfCqYfOlep9iAJ3OTtmB0GUgk6dS3XdQSNaq0L8Z1zf+Sdaar/xEdqjbA==
X-Received: by 2002:a92:c26a:: with SMTP id h10mr1821641ild.284.1632365998239;
        Wed, 22 Sep 2021 19:59:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r19sm1859643iot.0.2021.09.22.19.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:59:57 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:59:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 4/8] builtin/repack.c: keep track of existing packs
 unconditionally
Message-ID: <YUvtrTF67FW2UGhC@nand.local>
References: <c0d045a9de1a5e75d684b0dd2009a3137b6e5c59.1631730270.git.me@ttaylorr.com>
 <20210922225605.2608085-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922225605.2608085-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 03:56:05PM -0700, Jonathan Tan wrote:
> > @@ -98,8 +98,9 @@ static void remove_pack_on_signal(int signo)
> >   * have a corresponding .keep file. These packs are not to
> >   * be kept if we are going to pack everything into one file.
> >   */
> > -static void get_non_kept_pack_filenames(struct string_list *fname_list,
> > -					const struct string_list *extra_keep)
> > +static void collect_pack_filenames(struct string_list *fname_list,
> > +				   struct string_list *fname_kept_list,
> > +				   const struct string_list *extra_keep)
> >  {
> >  	DIR *dir;
> >  	struct dirent *e;
>
> The comment in the before-context of this hunk needs to be updated.

Thanks, updated. Now it reads like this:

  /*
   * Adds all packs hex strings to either the fname or fname_kept_list
   * list, based on whether each pack has a corresponding .keep file or
   * not. Packs without a .keep file are not to be kept if we are going
   * to pack everything into one file.
   */

> Also, I think that fname_list should be renamed to fname_nonkept_list.
> It does have the same semantics as before, but the name of the function
> has changed. And also, fname_list sounds like a superset of
> fname_kept_list, but that is not the case.

Yeah, I think that is a reasonable suggestion. I'll do it in a separate
patch, though, to keep the renaming self-contained.

Thanks,
Taylor
