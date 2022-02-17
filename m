Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5967DC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 01:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiBQBev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:34:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBQBeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 20:34:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FB22A8D14
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:34:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so3317845ejc.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqcOFfzkVieIC1a1BpOVQ7o81OCqiHQaBwg9ycyNcRs=;
        b=nvTzEzdGvIwcfySsxDqyfK7oreKvfSlXoDik042FW+X761iUnO3AJqqgo6+WvRL6CC
         ULS4b3nHUmKeBCTzswH6zTg2XmkPyNGPXvTw8je4iYXClz0aU3Du0zhSaHKh9ZeqskBI
         m4BbTMLlllamgnFgt5B7T1qkvXvWfYBDxEGyLE30Esyqmtgd9cXa1WgNon5pAo/vOrxN
         W4I6slte8eaMYmx4SldzDLMSqm6GcSEDg6YZV3E8iKcqtoRIWwbyNMDJ61YWSkNhoFy9
         zOZqWkkcXL7DgSV07xnhXqY2MSbh5eZNp5UbD7jKRdZ9XW/+vFT2uBqreR35UmeFVbYf
         rLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqcOFfzkVieIC1a1BpOVQ7o81OCqiHQaBwg9ycyNcRs=;
        b=ZFb5C4GuX75l/Azg2QziC3xoRDhAaBizaql8yJ6yZRKM9LcJrJCwgYsUqygPrIixIr
         RfWpbkS3YyFqrqhr8vnZULZ923rkz6QNmREMCdR8JPLRFSkCloNJjAkAqoSS8v4E4/wl
         cxU/E+215IwEy33DN84WttmFRaWvHKKr4kqVcWlQnINnBxbAqresPLvh5TiwI2QZe+ST
         ZskdbvkLusmV4dsabtPbEmiVT5Rbl4O2uAtAgOIsnzyGGumstOhqeOy/GGs8piPk0i5/
         P0sCNh9VQCmRhAYVC22m0JXLPcEQSqyJIHei83H3GR+08qI9VgL/E7biY+uitLgH1jSd
         fh+w==
X-Gm-Message-State: AOAM533xwYgeUvpY8iBTUSYLPz/nKfBYpnjUI0HqOPh48z5OhsItPA2B
        0weVaiz+GK5cl88QPMzL34PMlDjEW4Sg3cXGJdHrUnNv/Vg=
X-Google-Smtp-Source: ABdhPJzmdyvXi1LDGRCSRCKpJ9qHTTntSxdQfsD8T28g9IzBrwli2fq2oi+IA7ngvoENWHEDLKrwk64+4PuR7ceWudw=
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id
 dx21-20020a170906a85500b006cdba2039c5mr572682ejb.100.1645061675843; Wed, 16
 Feb 2022 17:34:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
In-Reply-To: <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 17:34:23 -0800
Message-ID: <CABPp-BFM67LzZFL=w-iA7vButaBKokpetDR5dr8TTnbSCmBdeA@mail.gmail.com>
Subject: Re: [PATCH 5/6] fetch: make `--atomic` flag cover backfilling of tags
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 1:32 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> When fetching references from a remote we by default also fetch all tags
> which point into the history we have fetched. This is a separate step
> performed after updating local references because it requires us to walk
> over the history on the client-side to determine whether the remote has
> announced any tags which point to one of the fetched commits.
>
> This backfilling of tags isn't covered by the `--atomic` flag: right
> now, it only applies to the step where we update our local references.
> This is an oversight at the time the flag was introduced: its purpose is
> to either update all references or none, but right now we happily update
> local references even in the case where backfilling failed.
>
> Fix this by pulling up creation of the reference transaction such that
> we can pass the same transaction to both the code which updates local
> references and to the code which backfills tags. This allows us to only
> commit the transaction in case both actions succeed.
>
> Note that we also have to start passing the transaction into
> `find_non_local_tags()`: this function is responsible for finding all
> tags which we need to backfill. Right now, it will happily return tags
> which we have already been updated with our local references. But when
> we use a single transaction for both local references and backfilling
> then it may happen that we try to queue the same reference update twice
> to the transaction, which consequentially triggers a bug. We thus have
> to skip over any tags which have already been queued. Unfortunately,
> this requires us to reach into internals of the reference transaction to
> access queued updates, but there is no non-internal interface right now
> which would allow us to access this information.

I like the changes you are making here in general, but I do agree that
reaching into refs-internal feels a bit icky.  I'm not familiar with
the refs API nor the fetching code, so feel free to ignore these
ideas, but I'm just throwing them out there as possibilities to avoid
reaching into refs-internal:

  - you are trying to check for existing transactions to avoid
duplicates, but those existing transactions came from elsewhere in the
same code we control.  Could we store a strset or strmap of the items
being updated (in addition to storing them in the transaction), and
then use the strset/strmap to filter out which tags we need to
backfill?  Or would that require plumbing an extra variable through an
awful lot of callers to get the information into the right places?

  - would it make sense to add a flag to the transaction API to allow
duplicates if both updates update the ref to the same value?  (I'm
guessing you're updating to the same value, right?)

  - should we just add something to the refs API along the lines of
"transaction_includes_update_for()" or something like that?

[...]
> @@ -361,12 +362,28 @@ static void find_non_local_tags(const struct ref *refs,
>         const struct ref *ref;
>         struct refname_hash_entry *item = NULL;
>         const int quick_flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
> +       int i;
>
>         refname_hash_init(&existing_refs);
>         refname_hash_init(&remote_refs);
>         create_fetch_oidset(head, &fetch_oids);
>
>         for_each_ref(add_one_refname, &existing_refs);
> +
> +       /*
> +        * If we already have a transaction, then we need to filter out all
> +        * tags which have already been queued up.
> +        */
> +       for (i = 0; transaction && i < transaction->nr; i++) {
> +               if (!starts_with(transaction->updates[i]->refname, "refs/tags/") ||
> +                   !(transaction->updates[i]->flags & REF_HAVE_NEW))
> +                       continue;
> +               (void) refname_hash_add(&existing_refs,
> +                                       transaction->updates[i]->refname,
> +                                       &transaction->updates[i]->new_oid);

Why the typecast here?
