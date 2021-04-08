Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3CDC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4FC61157
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 00:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDHADB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDHADA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 20:03:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FC3C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 17:02:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gc21so243914pjb.9
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=25wIItDD68jQeCfbNPi/iuVmbEwwjT+yXJbNvg4lhgE=;
        b=g2AqxoYNpG3iacimyT+0oFSQbMd/q/20UXTwvSZMsviPvlZpj2j1LwQTM+TE3n9Q/2
         aP5hMWmtFiInnc7aTu+n942HuGLKgrjjZo4HVniU0N+piyYtDEW9O8YpTs4G7CqnhLG+
         cAvTFDerWWcB+SsOjn3gPEXlEUU2VPRQmVqI9NQ1Nm6hPeLpjwLcZYWetwefTo+WuO+3
         GgP3xVjJeA+pZQ2WIZ2w2zryEsWMVY9LqBaJ5shiJppAkRTSBei0fRS/DWGJu1m9XJZ2
         hCCQTTUOaKLGZrLD3JRTanEkNo3ADS+QnwpnVrdKqyUyhRmrnPZcqqU0ug1jEV6GDW+U
         ntmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=25wIItDD68jQeCfbNPi/iuVmbEwwjT+yXJbNvg4lhgE=;
        b=uMfC8PtUvnShwfnCMOGgiQcY/KAYDdkoPaGp/jUN6gmSnw5KxrWQGbehKQi957Ba0H
         arkOuDwLbLz99fLhqXdSFVjqiodEfm58WEd388FlzkHqeOzLGTxemq1wQVT36FvA2crA
         2ruREw4+J+Puv0qMvLM9zazStbUATawm3AIA5/ejOMezoX0oIwKsYsNwyLdpKx+ml2lD
         0Sb6ugTFU4Woni1+Y1NiMi64T/aseGEASBpLNR/LgaJwSCoYeg47+DSzlHhqr3xPTNHc
         AO2/v1IqlvdgQgJsSZPQ5mvd4yPP3tAmbBxiojSYMY/ii13NQJrKFbhmX69rzB2Uwuhd
         CfWg==
X-Gm-Message-State: AOAM531zVy39LTS84Y+CSu/c5EI3xG4AnOCla5QdG/Jes2w5CVnmiE7b
        /f874fk/mX28vLsYevkWl31Vd2En5EpRV8ewwbPz
X-Google-Smtp-Source: ABdhPJzNYe+gtD3u406k+iQS4CKlm8gD3Mo/GoRKmrH7aMD25b/Equgo47xPIwdHZIOzEbzZKfKf5zIuA2caDtr2EOhd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e886:b029:e7:386b:1b30 with
 SMTP id w6-20020a170902e886b02900e7386b1b30mr5329525plg.42.1617840168935;
 Wed, 07 Apr 2021 17:02:48 -0700 (PDT)
Date:   Wed,  7 Apr 2021 17:02:41 -0700
In-Reply-To: <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
Message-Id: <20210408000242.2465219-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     rafaeloliveira.cs@gmail.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Apr 05, 2021 at 03:02:33AM +0200, Rafael Silva wrote:
> 
> > When I was digging into the code and adding trace2_region_*() calls, I
> > notice most of the time spent on the `git gc` (for the reported
> > situation) was in:
> > 
> >        # In builtin/pack-objects.c
> >        static void get_object_list(int ac, const char **av)
> >        {
> >                ...
> >                if (unpack_unreachable)
> >                        loosen_unused_packed_objects();
> >                ...
> >        }
> 
> Yeah, good find.

Agreed!

> This is my first time looking at the repacking strategy for partial
> clones. It looks like we run an initial pack-objects to cover all the
> promisor objects, and then do the "real" repack for everything else,
> with "--exclude-promisor-objects".

That is correct - we need two separate packs because one of them needs
to be accompanied by a separate ".promisor" file to show that those
objects are from the promisor remote.

> The purpose of loosen_unused_packed_objects() is to catch any objects
> that will be lost when our caller deletes all of the packs. But in this
> case, those promisor objects are in a pack which won't be deleted, so
> they should not be included.

Makes sense.

> > I'm not entirely sure about this (not this late in the day), but it seems to
> > me that we should simply skip the "missing" (promisor) files when
> > operating on a partial clone.
> > 
> > Perhaps something like:
> > 
> > --- >8 ---
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 525c2d8552..fedf58323d 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
> >  {
> >         if (!unpack_unreachable_expiration)
> >                 return 0;
> > +       if (exclude_promisor_objects && is_promisor_object(oid))
> > +               return 1;
> >         if (mtime > unpack_unreachable_expiration)
> >                 return 0;
> >         if (oid_array_lookup(&recent_objects, oid) >= 0)
> > --- >8 ---

I think this will work. The only thing we might need to watch out for is
that if we repack with --exclude-promisor-objects, some might say that
every excluded object should be loosened. I don't think that's true in
this case, because (1) the object is not unreachable and the argument
talks about loosening unreachable objects, (2) promisor objects can be
re-obtained from the promisor remote anyway. So I think we're fine.

But I think Peff suggested something better below.

> In the loop in loosen_unused_packed_objects(), we skip packs that are
> marked as "keep", so we'd skip the new promisor pack entirely. But we'd
> still see all these objects in the _old_ promisor pack. However, for
> each object there, we call has_sha1_pack_kept_or_nonlocal(), so that
> would likewise realize that each object is already being kept in the
> other pack.
> 
> Something like this seems to work, but I only lightly tested it, and it
> could probably use some refactoring to make it less horrible:
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index fdee8e4578..457525953a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -574,6 +574,23 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		repack_promisor_objects(&po_args, &names);
>  
>  		if (existing_packs.nr && delete_redundant) {
> +			/*
> +			 * tell pack-objects about our new promisor pack, which
> +			 * we will also be keeping
> +			 */
> +			for_each_string_list_item(item, &names) {
> +				/*
> +				 * yuck, we seem to only have the name with the
> +				 * packdir prefixed
> +				 */
> +				const char *prefix;
> +				if (!skip_prefix(packtmp, packdir, &prefix) ||
> +				    *prefix++ != '/')
> +					BUG("confused by packtmp");
> +				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
> +					     prefix, item->string);
> +			}
> +
>  			if (unpack_unreachable) {
>  				strvec_pushf(&cmd.args,
>  					     "--unpack-unreachable=%s",
> 
> Do you want to try to work with that?

It seems to me that this would work. The only part I was confused about
is "packtmp", but that is just the pack directory plus a specific
prefix, so "pack-objects" will indeed see that packfile as being part of
the repository - no problem.

repack_promisor_objects() might be able to be refactored to provide the
names in a format that we want, but looking at it, I don't think it's
possible (it just uses "packtmp", so we have the same "packtmp"
problem).
