Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86069EC875F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 23:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjIGXJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjIGXJX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 19:09:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167D1BD3
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 16:09:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27373f0916dso1245832a91.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694128134; x=1694732934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvuGG8qvpvDOEkoLoV9dl0sw7/l4uJw8mHSfsGgNrB0=;
        b=NexDSc7jjm+E2a2sYFqVKEhKymisy7dkvL/djtAEIZujVGYjFxV3/GghC7ajdAmLdy
         TM/aN+/nUGGwuMKjgVh62IresjniWkmR3t+4ffqN8IiAwbVBppcfQWJYWKHJ6aXAelRv
         MKB2dZL9te8+ZhRvWrwHgoWcd98TI5zq5DX34tgMY+BB8Hhz51vUv4tQCUdL3JqE9Rp1
         es17xIucDUlAsigEwOxFa6MeZ9sszcsMJCQj1+3la3r84XoO4SVt58YYkM9ASZ4uuB1T
         nlFtkkNvf4VmZUWsND4yArYENjOszTzQ5wrsFdYlW3Gdmw1lcLkS2iuqKps+drUhYGqs
         94zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694128134; x=1694732934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvuGG8qvpvDOEkoLoV9dl0sw7/l4uJw8mHSfsGgNrB0=;
        b=iRYOjawzJ+0ooTPuh3Khzs77fVVw+xs9y5J3dkXRWVbnmJ0L4HZ1kTSUrlrBCbq1W/
         mQGERx67kd3avQ9cmpbjojzWF6vadrpdZA9JGHJFTZ5Pd9tgwiECktX6Pip3UwX0LoLe
         XmDGp9a7OFXcK8gPJAmt4y68VYuUZdtdRrSURKMy3j1KU1K9Q79e3suEA+ul2itAn0sw
         ZRTPd1Jh/g0lZmdg5dCvOUxoosroZrv33LoezRk293qah77fKLA1A6v8du8Uey8W4ZkO
         VZ4gBladnxpJwhTZubC/BNcBZ52/ZkXi/qgZa81r4sya9PaqtKxExDlcGTaxzxxhjhtZ
         wDhw==
X-Gm-Message-State: AOJu0Yy2QqBWQ4TY/FVt4G8/eQls5b7PJZLvL+aaEhtjHFHEgfKqG2xr
        urQl3xjDdUJ05t+fGzXmOIxbqPnSIshAIeI6Xzy0qQ==
X-Google-Smtp-Source: AGHT+IGOySzy2U/OpGBIBEdU/yHMFKh0ApqloMQhfmvKmiHgK6wQ3eg8jd854Zi8x8efDOTkH7CrWRL+lLy2aeokYpI=
X-Received: by 2002:a17:90a:72c4:b0:268:5c3b:6f28 with SMTP id
 l4-20020a17090a72c400b002685c3b6f28mr1108793pjk.19.1694128133708; Thu, 07 Sep
 2023 16:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230906203726.1526272-1-jonathantanmy@google.com>
 <20230907170119.1536694-1-sokcevic@google.com> <xmqqa5txluvz.fsf@gitster.g>
In-Reply-To: <xmqqa5txluvz.fsf@gitster.g>
From:   Josip Sokcevic <sokcevic@google.com>
Date:   Thu, 7 Sep 2023 16:08:42 -0700
Message-ID: <CAJiyOigsH=Pac1g_5ztB01uEaCBjefazUpnH5k3ARZ-COm0uLA@mail.gmail.com>
Subject: Re: [PATCH v2] diff-lib: Fix check_removed when fsmonitor is on
To:     Junio C Hamano <gitster@pobox.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2023 at 11:07=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Josip Sokcevic <sokcevic@google.com> writes:
>
> > diff --git a/diff-lib.c b/diff-lib.c
> > index d8aa777a73..664613bb1b 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -39,11 +39,22 @@
> >  static int check_removed(const struct index_state *istate, const struc=
t cache_entry *ce, struct stat *st)
> >  {
> >       assert(is_fsmonitor_refreshed(istate));
>
> Not a problem this patch introduces, but doesn't this call path
>
>   diff_cache()
>   -> unpack_trees()
>      -> oneway_diff()
>         -> do_oneway_diff()
>            -> show_new_file(), show_modified()
>                -> get_stat_data()
>                   -> check_removed()
>
> violate the assertion?  If so, perhaps we should rewrite it into a
> more explicit "if (...) BUG(...)" that is not compiled away.

True, I will update it.

>
> > -     if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) <=
 0) {
> > -             if (!is_missing_file_error(errno))
> > -                     return -1;
> > -             return 1;
> > +     if (ce->ce_flags & CE_FSMONITOR_VALID) {
> > +             /*
> > +              * Both check_removed() and its callers expect lstat() to=
 have
> > +              * happened and, in particular, the st_mode field to be s=
et.
> > +              * Simulate this with the contents of ce.
> > +              */
> > +             memset(st, 0, sizeof(*st));
>
> It is true that the original, when CE_FSMONITOR_VALID bit is set,
> bypasses lstat() altogether and leaves the contents of st completely
> uninitialized, but this is still way too insufficient, isn't it?
>
> There are three call sites of the check_removed() function.
>
>  * The first one in run_diff_files() only cares about st.st_mode and
>    other members of the structure are not looked at.  This makes
>    readers wonder if the "st" parameter to check_removed() should
>    become "mode_t *st_mode" to clarify this point, but the primary
>    thing I want to say is that this caller will not mind if we leave
>    other members of st bogus (like 0-bit filled) as long as the mode
>    is set correctly.
>
>  * The second one in run_diff_files() passes the resulting &st to
>    match_stat_with_submodule(), which in turn passes it to
>    ie_match_stat(), which cares about "struct stat" members that are
>    used for quick change detection, like owner, group, mtime.
>    Giving it a bogus st will most likely cause it to report a
>    change.
>
>  * The third one is in get_stat_data().  This also uses the &st to
>    call match_stat_with_submodule(), so it is still totally broken
>    to give it a bogus st, the same way as the second caller above.
>
> > +             st->st_mode =3D ce->ce_mode;
>
> Does this work correctly when the cache entry points at a gitlink,
> which uses 0160000 that is not a valid st_mode?  I think you'd want
> to use a reverse function of create_ce_mode().

I realized this too but after I sent the patch. I don't think we have
a good way to reverse it, so the best we can do is to guess it. But I
don't think we should do that. Instead, should we just zero the struct
and add a TODO? Alternative could be to use a double pointer for stat
and do more checks in call sites, but I'm not familiar with the
codebase to how that branching would need to look like.

Any preference?

--=20
Josip Sokcevic
