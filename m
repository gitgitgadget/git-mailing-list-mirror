Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F824C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369BE20760
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubf8OyF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbgHQSDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389624AbgHQSCf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:02:35 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C0C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:02:33 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p8so8713676vsm.12
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aNgxvIlfUk5w655CuWaJ9hZLUxwe9RVV88JO3TLAa4=;
        b=ubf8OyF7SeDN+sN4fmmXFAV9H6+OcFoxRs9REX3WVIJPlex1lsD2edwBrZT1w8v4FQ
         6OS3PmIpQt/8DZBqUHM6d4WrPTEsdTmARtYoL+zqrXenx87O6oSTRS85MwILVbA1MiEt
         4BLPsqRHhSFwXTkDB87XNApOEEGfzySprak0lJEbeaDlijPjBUQrN1+0VYuLxAqSKkil
         V+NWySxqT/uqcRqyJTuTCamaVcXHLoD2oJM0iX7RTyiX5ds0IF815AuLoX+FV49sBA+N
         yuPWtTWi4qxAdPrW0BcAvx4xEw2+7NdNDIPETFfBEvbrdM7xYMfJLZq/NFBb8714kwop
         U0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aNgxvIlfUk5w655CuWaJ9hZLUxwe9RVV88JO3TLAa4=;
        b=sr0qVbW0V/Y/RZPp/tjOohoYTmBFJ5BkTHFK8t2YoBldKcPxbOO404Zs0t+1Fmf42/
         eZx1Yge/leeIY8PrTcqBoLgOTkEIhiZnlvZjXN04WPI+lZGhGJJW7MtV1FJ/yLpLHgWc
         xDKDNUWsPkMQUO5XubadxKNxqGF5fPqwyH4m2BoOQyop9JjJTHin06LoW/yFAw3Xj9qT
         /qlB8h2uylasGtltZZWdXOvrl+tSYSe6ISDQHupK9HPBkaWxWyf9q/rU84BBlghq9Pcc
         Fw9wzitW6ZjWmQOQrighdglUkRjOPL5ttXi/eznsC1esALUntn3Ycfc2Yqio/HhWBXVD
         FFWA==
X-Gm-Message-State: AOAM530bL4l9poP8XXEXllNAXUYGbaPYtkTvXFjE2kYjahFXMUwvKYdc
        ZvxYd1/vbI9xG6550A1Zzn213bmxI0wEn5SZA8E=
X-Google-Smtp-Source: ABdhPJz3CtKPhqJEMo+mQ3Ro0jI4Ts4RanoErDfb6ONFJx+3/Rm3gc22FLFnVSpCAdea92MKp8U4bNrUgdj6rPRySrI=
X-Received: by 2002:a67:8807:: with SMTP id k7mr3978980vsd.153.1597687352692;
 Mon, 17 Aug 2020 11:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com> <20200815002509.2467645-3-jacob.e.keller@intel.com>
In-Reply-To: <20200815002509.2467645-3-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 17 Aug 2020 11:02:20 -0700
Message-ID: <CA+P7+xo+q+Z1OFf-DedSNkoOFMFqbgRUMA+iqPH-u26HFW0urw@mail.gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 5:25 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Both fetch and push support pattern refspecs which allow fetching or
> pushing references that match a specific pattern. Because these patterns
> are globs, they have somewhat limited ability to express more complex
> situations.
>
> For example, suppose you wish to fetch all branches from a remote except
> for a specific one. To allow this, you must setup a set of refspecs
> which match only the branches you want. Because refspecs are either
> explicit name matches, or simple globs, many patterns cannot be
> expressed.
>
> Add support for a new type of refspec, referred to as "negative"
> refspecs. These are prefixed with a '^' and mean "exclude any ref
> matching this refspec". They can only have one "side" which always
> refers to the source. During a fetch, this refers to the name of the ref
> on the remote. During a push, this refers to the name of the ref on the
> local side.
>
> With negative refspecs, users can express more complex patterns. For
> example:
>
>  git fetch origin refs/heads/*:refs/remotes/origin/* ^refs/heads/dontwant
>
> will fetch all branches on origin into remotes/origin, but will exclude
> fetching the branch named dontwant.
>
> Refspecs today are commutative, meaning that order doesn't expressly
> matter. Rather than forcing an implied order, negative refspecs will
> always be applied last. That is, in order to match, a ref must match at
> least one positive refspec, and match none of the negative refspecs.
> This is similar to how negative pathspecs work.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/fetch.c |  3 +++
>  refspec.c       | 30 ++++++++++++++++++++++++++++++
>  refspec.h       | 14 ++++++++------
>  remote.c        | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  remote.h        |  9 ++++++++-
>  5 files changed, 97 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c49f0e975203..930214626b54 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -530,6 +530,9 @@ static struct ref *get_ref_map(struct remote *remote,
>                 tail = &rm->next;
>         }
>
> +       /* apply any negative refspecs now to prune the list of refs */
> +       ref_map = apply_negative_refspecs(ref_map, rs);
> +

So there is a slight bug here: we need to determine whether to use the
remote->fetch rs or the commandline rs. This only prunes the refs
using commandline negative refspecs, but if you're using the values
configured in the remote they won't get pruned.

I am not sure the best way to handle this, since I don't really like a
check on the lines of "if (rs->nr) { /* use rs */ } else { /* use
remote->fetch */ }..


>         ref_map = ref_remove_duplicates(ref_map);
>
>         refname_hash_init(&existing_refs);
> diff --git a/refspec.c b/refspec.c
> index f10ef284cef9..feed20aca961 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -8,6 +8,7 @@ static struct refspec_item s_tag_refspec = {
>         1,
>         0,
>         0,
> +       0,
>         "refs/tags/*",
>         "refs/tags/*"
>  };
> @@ -32,10 +33,17 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>         if (*lhs == '+') {
>                 item->force = 1;
>                 lhs++;
> +       } else if (*lhs == '^') {
> +               item->negative = 1;
> +               lhs++;
>         }
>
>         rhs = strrchr(lhs, ':');
>
> +       /* negative refspecs only have one side */
> +       if (item->negative && rhs)
> +               return 0;
> +
>         /*
>          * Before going on, special case ":" (or "+:") as a refspec
>          * for pushing matching refs.
> @@ -66,6 +74,28 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>         item->src = xstrndup(lhs, llen);
>         flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
>
> +       if (item->negative) {
> +               struct object_id unused;
> +
> +               /*
> +                * Negative refspecs only have a LHS, which indicates a ref
> +                * (or pattern of refs) to exclude from other matches. This
> +                * can either be a simple ref, a glob pattern, or even an
> +                * exact sha1 match.
> +                */
> +               if (!*item->src)
> +                       return 0; /* negative refspecs must not be empty */
> +               else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> +                       item->exact_sha1 = 1; /* ok */
> +               else if (!check_refname_format(item->src, flags))
> +                       ; /* valid looking ref is ok */
> +               else
> +                       return 0;
> +
> +               /* other rules for negative refspecs don't apply */
> +               return 1;
> +       }
> +
>         if (fetch) {
>                 struct object_id unused;
>
> diff --git a/refspec.h b/refspec.h
> index 8d654e3a3ac4..e5bf6d25d0f7 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -5,12 +5,13 @@
>  extern const struct refspec_item *tag_refspec;
>
>  /**
> - * A struct refspec_item holds the parsed interpretation of a refspec.  If it will
> - * force updates (starts with a '+'), force is true.  If it is a pattern
> - * (sides end with '*') pattern is true.  src and dest are the two sides
> - * (including '*' characters if present); if there is only one side, it is src,
> - * and dst is NULL; if sides exist but are empty (i.e., the refspec either
> - * starts or ends with ':'), the corresponding side is "".
> + * A struct refspec_item holds the parsed interpretation of a refspec.  If it
> + * will force updates (starts with a '+'), force is true.  If it is a pattern
> + * (sides end with '*') pattern is true.  If it is a negative refspec, (starts
> + * with '^'), negative is true.  src and dest are the two sides (including '*'
> + * characters if present); if there is only one side, it is src, and dst is
> + * NULL; if sides exist but are empty (i.e., the refspec either starts or ends
> + * with ':'), the corresponding side is "".
>   *
>   * remote_find_tracking(), given a remote and a struct refspec_item with either src
>   * or dst filled out, will fill out the other such that the result is in the
> @@ -22,6 +23,7 @@ struct refspec_item {
>         unsigned pattern : 1;
>         unsigned matching : 1;
>         unsigned exact_sha1 : 1;
> +       unsigned negative : 1;
>
>         char *src;
>         char *dst;
> diff --git a/remote.c b/remote.c
> index c5ed74f91c63..6a41d1028221 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1058,7 +1058,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
>         const char *dst_value = rs->dst;
>         char *dst_guess;
>
> -       if (rs->pattern || rs->matching)
> +       if (rs->pattern || rs->matching || rs->negative)
>                 return 0;
>
>         matched_src = matched_dst = NULL;
> @@ -1134,6 +1134,10 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
>         int matching_refs = -1;
>         for (i = 0; i < rs->nr; i++) {
>                 const struct refspec_item *item = &rs->items[i];
> +
> +               if (item->negative)
> +                       continue;
> +
>                 if (item->matching &&
>                     (matching_refs == -1 || item->force)) {
>                         matching_refs = i;
> @@ -1441,6 +1445,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
>                 string_list_clear(&src_ref_index, 0);
>         }
>
> +       *dst = apply_negative_refspecs(*dst, rs);
> +
>         if (errs)
>                 return -1;
>         return 0;
> @@ -1810,6 +1816,9 @@ int get_fetch_map(const struct ref *remote_refs,
>  {
>         struct ref *ref_map, **rmp;
>
> +       if (refspec->negative)
> +               return 0;
> +
>         if (refspec->pattern) {
>                 ref_map = get_expanded_map(remote_refs, refspec);
>         } else {
> @@ -1853,6 +1862,44 @@ int get_fetch_map(const struct ref *remote_refs,
>         return 0;
>  }
>
> +static int refspec_match(const struct refspec_item *refspec,
> +                        const char *name)
> +{
> +       if (refspec->pattern)
> +               return match_name_with_pattern(refspec->src, name, NULL, NULL);
> +
> +       return !strcmp(refspec->src, name);
> +}
> +
> +static int omit_name_by_refspec(const char *name, struct refspec *rs)
> +{
> +       int i;
> +
> +       for (i = 0; i < rs->nr; i++) {
> +               if (rs->items[i].negative && refspec_match(&rs->items[i], name))
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
> +{
> +       struct ref **tail;
> +
> +       for (tail = &ref_map; *tail; ) {
> +               struct ref *ref = *tail;
> +
> +               if (omit_name_by_refspec(ref->name, rs)) {
> +                       *tail = ref->next;
> +                       free(ref->peer_ref);
> +                       free(ref);
> +               } else
> +                       tail = &ref->next;
> +       }
> +
> +       return ref_map;
> +}
> +
>  int resolve_remote_symref(struct ref *ref, struct ref *list)
>  {
>         if (!ref->symref)
> diff --git a/remote.h b/remote.h
> index 5e3ea5a26deb..104e75e0f74d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -193,6 +193,12 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
>   */
>  struct ref *ref_remove_duplicates(struct ref *ref_map);
>
> +/*
> + * Remove all entries in the input list which match any negative refspec in
> + * the refspec list.
> + */
> +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
> +
>  int query_refspecs(struct refspec *rs, struct refspec_item *query);
>  char *apply_refspecs(struct refspec *rs, const char *name);
>
> @@ -205,7 +211,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  /*
>   * Given a list of the remote refs and the specification of things to
>   * fetch, makes a (separate) list of the refs to fetch and the local
> - * refs to store into.
> + * refs to store into. Note that negative refspecs are ignored here, and
> + * should be handled separately.
>   *
>   * *tail is the pointer to the tail pointer of the list of results
>   * beforehand, and will be set to the tail pointer of the list of
> --
> 2.28.0.163.g6104cc2f0b60
>
