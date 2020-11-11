Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB6C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6B42087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd4uVzgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKKUYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:24:24 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BAC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:24:24 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c80so3665990oib.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HFwvzgv62htW5tx+e9WDpFoCzHP+t4JC7IF05YIIDw=;
        b=pd4uVzgfJmeIg34BpET4nHNgVl9UXoHovyjapgX78zy2Ym60vqZymwmVHU1UTEexqV
         gmNch9D/h4/wuPuno7jpweYlZFpeYkQfu7t9fPS4+wWfCuRuE+pl2aLbFq+TuXyNb9Wp
         MuYIpSP2ZKxK1XhikPoRj56no3wNvdnkcqAy3ixxKPT+Scirl//TUnOkcyshCB/cU2ck
         D6GWj+SkEOKucpmBKwmdmIFz6/k+3cCj240xqhvu/gBR7xzBvoI/Hyj51bfwagu5CiAv
         HQpx6HiWvCrs0khmhhw1ku4+ktadKP56SrUnV9vgm7N5Zcugu26bDcGCRARisDyPNWFX
         Vu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HFwvzgv62htW5tx+e9WDpFoCzHP+t4JC7IF05YIIDw=;
        b=ROseSSSjpjD0KCmdG3w1HacP496rPi+/ZLnP1sIu8BprWZLisYAjYkxs8uWIi2H92M
         X+3zyl+TTuI/6idnbv9Mxfc3huPU4MRo7zvBQas/N3zrwww2zDNjy0CLAvYgtDJx5VPh
         cccGt6dI8sJpvFksJ3gqJa7sIfrJkgr1UpVknl+alhtH7M93UpSUVIvB0MFnxhhBoI+O
         3COBgfgcKX32nRTAxoV3fMlWMv83pK8KvNIQCUSa6h0FPawdQyW0WjVSy9GT/q6PBZf+
         Rl6UCeR9DZcoqHtqJ8AFLWcPhwIqd17iwonjIB/v9eGDFGQkyIdpk2mE2swXmfSZCXQK
         GgNA==
X-Gm-Message-State: AOAM533oNs6Ao54DP5elHPVl9/ffTCENAy3BCKmtTpjv9Q/ioBmiKZlu
        6Et77aW4Awp68ehk+xP0IB9MWJWUdPXUJDlhO+2l/Iayd0E=
X-Google-Smtp-Source: ABdhPJy9YHCO2UCYfFR7l9Y8/tf9/3vGEuPCHDUjhqLkHedSwucdut4vrKy5RYvzjP9b77YbpktYL0zDwvXny4uxvxg=
X-Received: by 2002:aca:3756:: with SMTP id e83mr3317434oia.31.1605126263748;
 Wed, 11 Nov 2020 12:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-14-newren@gmail.com> <20201111200157.3118955-1-jonathantanmy@google.com>
In-Reply-To: <20201111200157.3118955-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 12:24:12 -0800
Message-ID: <CABPp-BGr4kpjyZc3Rbh+8StPbWWqo36Kg0P=dgqctwX0SCGPxw@mail.gmail.com>
Subject: Re: [PATCH v2 13/20] merge-ort: step 1 of tree writing -- record
 basenames, modes, and oids
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 12:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +struct directory_versions {
> > +     struct string_list versions;
>
> Maybe comment that this is an unordered list of basenames to <whatever
> the type of ci->merged.result is>.

There actually is an order, and it's important.  It's reverse
lexicographic order of full pathnames (the ordering comes from the
fact that process_entries() iterates paths in that order).  The
reasons for that ordering are (1) all the basenames within a directory
are adjacent so that I can write out a tree for a directory as soon as
it is done, and (2) paths within a directory are listed before the
directory itself so that I get the necessary info for subtrees before
trying to write out their parent trees.

It's not until later patches that I take advantage of this ordering
(and when I do I have a very long commit message to describe it all),
but I can add a comment that this is a list of basenames to
merge_info.

>
> > @@ -442,6 +464,7 @@ static void process_entries(struct merge_options *opt,
> >       struct strmap_entry *e;
> >       struct string_list plist = STRING_LIST_INIT_NODUP;
> >       struct string_list_item *entry;
> > +     struct directory_versions dir_metadata;
> >
> >       if (strmap_empty(&opt->priv->paths)) {
> >               oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
> > @@ -458,6 +481,9 @@ static void process_entries(struct merge_options *opt,
> >       plist.cmp = string_list_df_name_compare;
> >       string_list_sort(&plist);
> >
> > +     /* other setup */
> > +     string_list_init(&dir_metadata.versions, 0);
> > +
>
> Might be clearer to just initialize dir_metadata as {
> STRING_LIST_INIT_NODUP }.

It'll eventually grow to { STRING_LIST_INIT_NODUP,
STRING_LIST_INIT_NODUP, NULL, 0 }, which is a tad long, but if the
initializer is clearer I'm happy to switch over to it.

> The rest makes sense.
