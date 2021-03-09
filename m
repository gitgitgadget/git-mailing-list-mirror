Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DD3C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435016522E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 19:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCITDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 14:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCITCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 14:02:51 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D75C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 11:02:50 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id v12so13859658ott.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gz/GjxYI0usnC5s7I7AZQr2QnSa9GdipfVmvo5ZrSfM=;
        b=hEi/nAdFdAXN4/Bt5GWPR0Xk91dLsEKZQnXYRy/QTEdL+d1Xm96i7qr4lPJbm1dBCA
         UxerCNgnp+Oit3nWW22fZLuVwFUAgNgr9RN6IFUALjlah3AiSqbiYFvTkn1YQyq1mcfU
         B+GCNIjiIqaOUQz7oUL4CdEps72HAiP1sVwoQm7pzzRRuW0cxbznRwzSxJhZ/Xc4AgHf
         yHHCNce2B7BNWdLhRbwqI9qg8FYbmSaqM2RCY0ztqrvL6CdvFw0vJUOZ/iyoxv/RaTzX
         QzB0mv/oa2a/uyv3wmPVhL7gurKorJgld1I0MSULY1ItB1ydOhvAGYn7+kfU09ydaiZB
         8Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gz/GjxYI0usnC5s7I7AZQr2QnSa9GdipfVmvo5ZrSfM=;
        b=oRL1iFAbNHfQf0cfsfHw0sJV8bLJ8OCvFb57zdk6ZhJ5dRf7o90k54HvK1oUWrS5Xe
         ZHaLkEL3kvITV5YbAuO6MbO2Fh6QsQfO8S0afdi3MNcx/G7yX5Ruvk8mzSPskWdKYq29
         mO6U6AyAsPYewvzCrr35MoCWPAmiZKScUsJX/U0OEO1TBP7RAKN1t8dA0z+v+5QanhJ3
         NhCOXMiDpiP39uN4YEZxgLvViEFOoFxOJl9KoCUeiD9VBmurlSI8WEVdNPJ+EEkERmti
         dlgqq7bA68Z3YPpMG0JHdRd9aeJhT0Eovgp1+hygszEZA3ix4U9kAJmADPeA3WNEVL8c
         ebsw==
X-Gm-Message-State: AOAM530pVnJPfS3D1NybyJMEBZ3PgEVqOPN4F75aO+BDYz5uF57OAoum
        6q11zLOBsKwVDtGR5PdB7Kei0/W1J5riN7AO8XgcLFsCq18=
X-Google-Smtp-Source: ABdhPJxGYUffn4/98WJJBvaUwnX8oRywy0G4nqAYnRrTdLNk6U94texR9B1KbdQG5uoT0lL0JgJMTnpjJHrjmOHdRrU=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr6317523otf.162.1615316570263;
 Tue, 09 Mar 2021 11:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-30-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-30-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 11:02:39 -0800
Message-ID: <CABPp-BGGGrYs4HSmT4kq__90K8OxDKkF_Nb8nLAhouLONYxsEA@mail.gmail.com>
Subject: Re: [PATCH 29/30] tree.h API users: rename read_tree_fn_t's "mode" to "raw_mode"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Rename the "mode" variable passed to read_tree_fn_t callbacks to
> "raw_mode". This variable comes to us from the tree-walk.h API. By
> renaming this variable we can easily see where its downstream users
> are in a subsequent commit where we'll sprinkle some canon_mode()
> here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  archive.c          |  5 +++--
>  builtin/log.c      |  2 +-
>  builtin/ls-files.c | 11 ++++++-----
>  builtin/ls-tree.c  |  6 +++---
>  merge-recursive.c  |  2 +-
>  5 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index bc8f1c7546f..5b85aae8106 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -232,10 +232,11 @@ static int write_directory(struct archiver_context =
*c)
>
>  static int queue_or_write_archive_entry(const struct object_id *oid,
>                                         struct strbuf *base, const char *=
filename,
> -                                       enum object_type object_type, uns=
igned mode,
> +                                       enum object_type object_type, uns=
igned raw_mode,
>                                         void *context)
>  {
>         struct archiver_context *c =3D context;
> +       unsigned mode =3D raw_mode;
>
>         while (c->bottom &&
>                !(base->len >=3D c->bottom->len &&
> @@ -382,7 +383,7 @@ struct path_exists_context {
>
>  static int reject_entry(const struct object_id *oid, struct strbuf *base=
,
>                         const char *filename,
> -                       enum object_type object_type, unsigned mode,
> +                       enum object_type object_type, unsigned raw_mode,
>                         void *context)
>  {
>         int ret =3D -1;
> diff --git a/builtin/log.c b/builtin/log.c
> index 19a916221d5..c3ef1b3e22d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -599,7 +599,7 @@ static int show_tag_object(const struct object_id *oi=
d, struct rev_info *rev)
>
>  static int show_tree_object(const struct object_id *oid,
>                             struct strbuf *base, const char *pathname,
> -                           enum object_type object_type, unsigned mode,
> +                           enum object_type object_type, unsigned raw_mo=
de,

This was surprising to me and had me worried, but it looks like this
function doesn't even use mode or raw_mode.

>                             void *context)
>  {
>         FILE *file =3D context;
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index f38df439410..391e6a9f141 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -425,10 +425,11 @@ static int read_one_entry_opt(struct index_state *i=
state,
>                               const struct object_id *oid,
>                               struct strbuf *base,
>                               const char *pathname,
> -                             unsigned mode, int opt)
> +                             unsigned raw_mode, int opt)
>  {
>         int len;
>         struct cache_entry *ce;
> +       unsigned mode =3D raw_mode;

I was about to comment, but checked out the code in question and it
looks like you've modified further.  So perhaps I should wait until
the last patch in the series.

>
>         if (S_ISDIR(mode))
>                 return READ_TREE_RECURSIVE;
> @@ -447,12 +448,12 @@ static int read_one_entry_opt(struct index_state *i=
state,
>
>  static int read_one_entry(const struct object_id *oid, struct strbuf *ba=
se,
>                           const char *pathname,
> -                         enum object_type object_type, unsigned mode,
> +                         enum object_type object_type, unsigned raw_mode=
,
>                           void *context)
>  {
>         struct index_state *istate =3D context;
>         return read_one_entry_opt(istate, oid, base, pathname,
> -                                 mode,
> +                                 raw_mode,
>                                   ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCH=
ECK);
>  }
>
> @@ -462,12 +463,12 @@ static int read_one_entry(const struct object_id *o=
id, struct strbuf *base,
>   */
>  static int read_one_entry_quick(const struct object_id *oid, struct strb=
uf *base,
>                                 const char *pathname,
> -                               enum object_type object_type, unsigned mo=
de,
> +                               enum object_type object_type, unsigned ra=
w_mode,
>                                 void *context)
>  {
>         struct index_state *istate =3D context;
>         return read_one_entry_opt(istate, oid, base, pathname,
> -                                 mode,
> +                                 raw_mode,
>                                   ADD_CACHE_JUST_APPEND);
>  }
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index c6ec3ca751e..3f84603d391 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -63,7 +63,7 @@ static int show_recursive(const char *base, int baselen=
, const char *pathname)
>
>  static int show_tree(const struct object_id *oid, struct strbuf *base,
>                      const char *pathname,
> -                    enum object_type object_type, unsigned mode,
> +                    enum object_type object_type, unsigned raw_mode,
>                      void *context)
>  {
>         int retval =3D 0;
> @@ -103,11 +103,11 @@ static int show_tree(const struct object_id *oid, s=
truct strbuf *base,
>                                                   "%"PRIuMAX, (uintmax_t)=
size);
>                         } else
>                                 xsnprintf(size_text, sizeof(size_text), "=
-");
> -                       printf("%06o %s %s %7s\t", mode, type,
> +                       printf("%06o %s %s %7s\t", raw_mode, type,
>                                find_unique_abbrev(oid, abbrev),
>                                size_text);
>                 } else
> -                       printf("%06o %s %s\t", mode, type,
> +                       printf("%06o %s %s\t", raw_mode, type,
>                                find_unique_abbrev(oid, abbrev));

This looks like a behavioral change.  It might be desirable, but
shouldn't it be called out and documented with a testcase?

(Or is there no change yet because the raw_mode isn't actually yet raw?)

>         }
>         baselen =3D base->len;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b26d9d418f9..30fbe72ca06 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -453,7 +453,7 @@ static void unpack_trees_finish(struct merge_options =
*opt)
>
>  static int save_files_dirs(const struct object_id *oid,
>                            struct strbuf *base, const char *path,
> -                          enum object_type object_type, unsigned int mod=
e,
> +                          enum object_type object_type, unsigned int raw=
_mode,
>                            void *context)
>  {
>         struct path_hashmap_entry *entry;

Oh, man, merge-recursive.c gets modes from the index, from the diff
machinery, and from its own direct calls (get_tree_entry*() calls).
And might have comparisons in all kinds of places.  I'd be _very_
leery, much more so than with merge-ort.c, of having it deal with raw
modes.
