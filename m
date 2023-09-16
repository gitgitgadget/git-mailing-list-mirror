Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0BCCD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 02:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjIPCzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjIPCyt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 22:54:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824D1BD3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:54:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502fd1e1dd8so741299e87.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694832881; x=1695437681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPAUy0CrYq28cwKlrVkyMqjCJAnFKEV1iL0pC1uxrR0=;
        b=U6Btyc6qWe6MCa2PErqKbnXxAV33Oz8Uc8aLsWyJdCeayiw9OPSbq0XxVChzi7wxSY
         qNaYhd6ZbJVBQLAAlXhpfpHx8O/aMW6XUDXMRmY2NZHIzAJFUPFCPHMuwvXv+cDNJDMY
         6SF7zRSJpRtgDLe3+IqCZUwipUzsyZFULoxnwXzNGTKG8ObA8yb5LypvohXQolUdWX2T
         GAgamkH+blEJe/FOYwRBvdsv4USRxzdqf9GdN6OBgHBfUnCIaBGCPUQCjw0k8Ow1uYMB
         0mDr//1mH6ZkKuVqyJ8sJ61zDCnUhmnvT6om1B6UckUSmL8QBRDdf5AWjJRYdsy8ftqm
         fM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694832881; x=1695437681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPAUy0CrYq28cwKlrVkyMqjCJAnFKEV1iL0pC1uxrR0=;
        b=HANzJI7tuuo1Ov+djuBc2yOgbi1AwlNaq2Tt7JGoxEesN3S29fUDYV5Syz2kJCaTht
         UpGaKq9bjbzUblBRHwCHZH+vfKgXeMDJ/e8C7gpYyIi0K1tSwwwj/2qEKBckeCMuG/5f
         DauethBN8qmNWEo/WJ7IOaBLaz12/YARm+65kcCO64PNhMdB41D9CXsGJedoI1doMP3v
         75ntbMFvbQ6SZnibknCN0iTj96/nOO5yIGBTeljqyo2alswRKwCUw1bvNo2HuRIrqFKv
         uq6KMo9eDWiT6XX3tZPGr4CqkC9B1lesklbUoqdDkziqpsPvccv/Khem7TLjSchYIhvk
         l/uA==
X-Gm-Message-State: AOJu0YyK9xESHBpQ/OrNEs/sY/ZHg7E/GtBfBYtHYoCfaCtEHEhizwxO
        C3u4dXgnyftliKxb7z0c/WPCpSLalRsolqY53mYfPND7kAw=
X-Google-Smtp-Source: AGHT+IEfralokTl+lGEdRc+LmdFRlxrZsnTDt+ZmO65418GMH+uyGcjBklg+8702t30AU3E1ssq0nyDUfiGw2ZNWgWk=
X-Received: by 2002:a19:5517:0:b0:500:9704:3c9 with SMTP id
 n23-20020a195517000000b00500970403c9mr2944807lfe.26.1694832881238; Fri, 15
 Sep 2023 19:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230914093409.GA2254811@coredump.intra.peff.net> <20230914093948.GA2254894@coredump.intra.peff.net>
In-Reply-To: <20230914093948.GA2254894@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 19:54:28 -0700
Message-ID: <CABPp-BEhgZB3Q5VKTznOFwt2+Ptcf6ffyJSbXXnmoa_4_zRAVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] merge-ort: drop custom err() function
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 2:39=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> The merge-ort code has an err() function, but it's really just error()
> in disguise. It differs in two ways:
>
>   1. It takes a "struct merge_options" argument. But the function
>      completely ignores it! We can simply remove it.

Oops, when I simplified the err() function copied from
merge-recursive.c in one way, I failed to notice that it enabled
further simplifications.

>   2. It formats the error string into a strbuf, prepending "error: ",
>      and then feeds the result into error(). But this is wrong! The
>      error() function already adds the prefix, so we end up with:
>
>         error: error: Failed to execute internal merge

...and the same problem can be found in merge-recursive.c's err() function.

Not sure what current opinions on whether we should bother fixing
those up.  I do intend on nuking merge-recursive.c, but I obviously
haven't had much Git time this year.

> So let's just drop this function entirely and call error() directly, as
> the functions are otherwise identical (note that they both always return
> -1).
>
> Presumably nobody noticed the bogus messages because they are quite hard
> to trigger (they are mostly internal errors reading and writing
> objects). However, one easy trigger is a custom merge driver which dies
> by signal; we have a test already here, but we were not checking the
> contents of stderr.

Thanks for catching this.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> A few of these messages starts with capital letters, which is unlike our
> usual error message style. I didn't clean that up here. We could do so
> on top,

There are two of these.  In my defense, they were copied verbatim from
merge-recursive.c.  And I, um, never noticed the problem over there
before copying.  Or after.

> but I actually wonder if some of these ought to be using
> path_msg() and continuing instead, to give output closer to other
> conflict or error cases (e.g., conflicts caused by missing submodule
> objects). But I dunno. I guess these are all more clearly "woah,
> something is totally wrong" that we do not expect to happen, so it
> probably isn't a big deal to just abort.

Yeah, all callers of err()/error() are for things that should never
happen regardless of repository contents and should result in an
instant abort, whereas anything calling path_msg() is a conflict or
informational message that is expected for various kinds of repository
data -- these messages are accumulated and later shown.

Another distinction is that any call to path_msg() is associated to a
very specific path (or a few specific paths in special cases like
renames or add/add with conflict modes), whereas none of the calls to
err()/error() have a specific path they are about.  This serves a few
purposes:
  * We've had reports before that users get confused when there are
multiple conflict messages about a path and they do not occur
together.  The structure of the merge machinery is such that it often
has to process conflicts by type and then by path, rather than by path
and then by type.  If a merge has many conflicts, processing by type
and then by path, combined with printing as you go, naturally results
in cases where there are multiple conflict type messages for a single
path, but the messages are separated by dozens or hundreds of lines of
conflict messages about other paths.  By accumulating and printing
later, at print time we can sort based on path and provide nicer
output (though renames and such might still cause some separation of
related messages).
  * Accumulating and printing conflict & informational messages later
is also more friendly for use by other tools such as merge-tree or
rebase that may want to only conditionally print the messages or even
operate on the structured data (the specific paths and conflict types
recorded with them) in some special way.  Dscho and I talked about
that for his webby-merge-ui-for-github tool he was working on.

Anyway, long story short is that I think continuing to use error()
instead of path_msg() or something else makes sense here.  The capital
to lowercase cleanups make sense; we could even #leftoverbits for that
piece.


>  merge-ort.c           | 28 +++++-----------------------
>  t/t6406-merge-attr.sh |  3 ++-
>  2 files changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8631c99700..027ecc7f78 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -721,23 +721,6 @@ static void clear_or_reinit_internal_opts(struct mer=
ge_options_internal *opti,
>         renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
>  }
>
> -__attribute__((format (printf, 2, 3)))
> -static int err(struct merge_options *opt, const char *err, ...)
> -{
> -       va_list params;
> -       struct strbuf sb =3D STRBUF_INIT;
> -
> -       strbuf_addstr(&sb, "error: ");
> -       va_start(params, err);
> -       strbuf_vaddf(&sb, err, params);
> -       va_end(params);
> -
> -       error("%s", sb.buf);
> -       strbuf_release(&sb);
> -
> -       return -1;
> -}
> -
>  static void format_commit(struct strbuf *sb,
>                           int indent,
>                           struct repository *repo,
> @@ -2122,13 +2105,12 @@ static int handle_content_merge(struct merge_opti=
ons *opt,
>                                           &result_buf);
>
>                 if ((merge_status < 0) || !result_buf.ptr)
> -                       ret =3D err(opt, _("Failed to execute internal me=
rge"));
> +                       ret =3D error(_("Failed to execute internal merge=
"));
>
>                 if (!ret &&
>                     write_object_file(result_buf.ptr, result_buf.size,
>                                       OBJ_BLOB, &result->oid))
> -                       ret =3D err(opt, _("Unable to add %s to database"=
),
> -                                 path);
> +                       ret =3D error(_("Unable to add %s to database"), =
path);
>
>                 free(result_buf.ptr);
>                 if (ret)
> @@ -3518,10 +3500,10 @@ static int read_oid_strbuf(struct merge_options *=
opt,
>         unsigned long size;
>         buf =3D repo_read_object_file(the_repository, oid, &type, &size);
>         if (!buf)
> -               return err(opt, _("cannot read object %s"), oid_to_hex(oi=
d));
> +               return error(_("cannot read object %s"), oid_to_hex(oid))=
;
>         if (type !=3D OBJ_BLOB) {
>                 free(buf);
> -               return err(opt, _("object %s is not a blob"), oid_to_hex(=
oid));
> +               return error(_("object %s is not a blob"), oid_to_hex(oid=
));
>         }
>         strbuf_attach(dst, buf, size, size + 1);
>         return 0;
> @@ -4973,7 +4955,7 @@ static void merge_ort_nonrecursive_internal(struct =
merge_options *opt,
>                  * TRANSLATORS: The %s arguments are: 1) tree hash of a m=
erge
>                  * base, and 2-3) the trees for the two trees we're mergi=
ng.
>                  */
> -               err(opt, _("collecting merge info failed for trees %s, %s=
, %s"),
> +               error(_("collecting merge info failed for trees %s, %s, %=
s"),
>                     oid_to_hex(&merge_base->object.oid),
>                     oid_to_hex(&side1->object.oid),
>                     oid_to_hex(&side2->object.oid));
> diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> index 9677180a5b..05ad13b23e 100755
> --- a/t/t6406-merge-attr.sh
> +++ b/t/t6406-merge-attr.sh
> @@ -179,7 +179,8 @@ test_expect_success !WINDOWS 'custom merge driver tha=
t is killed with a signal'
>
>         >./please-abort &&
>         echo "* merge=3Dcustom" >.gitattributes &&
> -       test_must_fail git merge main &&
> +       test_must_fail git merge main 2>err &&
> +       grep "^error: Failed to execute internal merge" err &&
>         git ls-files -u >output &&
>         git diff --name-only HEAD >>output &&
>         test_must_be_empty output
> --
> 2.42.0.628.g8a27295885

Thanks for fixing this up.
