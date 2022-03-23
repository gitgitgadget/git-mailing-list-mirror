Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010B1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbiCWUbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiCWUbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:31:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034E86E16
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:30:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q5so3483474ljb.11
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lneROlfrTn5wAzv8sbNzmewtf/TxQ1m6/0FK4qjLa5c=;
        b=O/4/g8ANGJ58xVNfFk6KsmZFDNgY2jPru8eQtnwk7FU6figb5TMLyx7cf/Xjeq/jKx
         A5e87CEHuHrQqSUr7DdXigPFH0WxtBbOYTBJlKwL7FwcTE2EIOLggFKE0x4iB3O5cKBS
         wfxtxzfo/pxBoQ0uPp+Z16dMSwPdVLDOXRBE7NNiyFnro1cYj3jVz+G8VQyMky+mEYry
         yuvvNa5HYVEHvvCDoh+I3q2ow2yOb8s+MYV480mzVGYxaLGGkT7E0m1lwGO2P7Vrzzit
         7kZUiU4Jnb7V635kmhC+oB/nkHVbcotjgsnRZ0iGOxbcPbgrJhh7t85k73Qz1Bboigg5
         hbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lneROlfrTn5wAzv8sbNzmewtf/TxQ1m6/0FK4qjLa5c=;
        b=uFDRJR+yinu7aPFmdjDmARcfbCPhrf/WJ4KPZTgFnhwVLWCkP0+OPBCfb8327uqp+5
         i3Ex1Qm/+J2w4Cv04M4c5t00Nm2ij5XtsOpkiwDP6xeUTx/bu8UxLEoPTHB16EtGJYKG
         NzBX1ZEKcREwLiSTDeKaWtKK84ITOC1iNcQc7w6pEb1sBNj9P5LyNfbx4vlpxHaISBiB
         08uW8Iy1rMcI8PCUtP8cWkvp2ZhbFCdKk161BYcgvlwmzo0NEW6QCa5POj8lnchNdq3u
         AeorUeB6lIzlqwXRz1rKL4Rj7bkDJlb1S5n5/LkIAVEchK4bXcUFAYTjNFDF0rXSGM+6
         nyxA==
X-Gm-Message-State: AOAM530WM9+kvbCDJ0buX2v7j9Za91bmSXWhGfVufRy+0jn0j0IoewRZ
        a/ydCbgukkI1rWzYxr993IsSS5kJPQDe8vn6zkM=
X-Google-Smtp-Source: ABdhPJzUTLaQW9WMTt3TPbJYcpxlwzVByMFKlZKYamYsIhvLVlanjPyUrli3T7KlhDn1Dh/iF0rfNASCxuGnkQKoH78=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr1485057ljq.172.1648067417206; Wed, 23
 Mar 2022 13:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
 <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com> <RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z-avarab@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 23 Mar 2022 13:30:06 -0700
Message-ID: <CANQDOdffANOvbTBAZs95PxQMgCu1Leww6+a7A960hcYi+4mNDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/7] update-index: have the index fsync() flush the
 loose objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 7:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> As with unpack-objects in a preceding commit have update-index.c make
> use of the HASH_N_OBJECTS{,_{FIRST,LAST}} flags. We now have a "batch"
> mode again for "update-index".
>
> Adding the t/* directory from git.git on a Linux ramdisk is a bit
> faster than with the tmp-objdir indirection:
>
>         $ git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=3D-O=
3 && rm -rf repo && git init repo && cp -R t repo/ && git ls-files -- t >re=
po/.git/to-add.txt' -p 'rm -rf repo/.git/objects/* repo/.git/index' './git =
-c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-ind=
ex --add --stdin <repo/.git/to-add.txt' --warmup 1 -r 10Benchmark 1: ./git =
-c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-ind=
ex --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync
>           Time (mean =C2=B1 =CF=83):     281.1 ms =C2=B1   2.6 ms    [Use=
r: 186.2 ms, System: 92.3 ms]
>           Range (min =E2=80=A6 max):   278.3 ms =E2=80=A6 287.0 ms    10 =
runs
>
>         Benchmark 2: ./git -c core.fsync=3Dloose-object -c core.fsyncMeth=
od=3Dbatch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HE=
AD
>           Time (mean =C2=B1 =CF=83):     265.9 ms =C2=B1   2.6 ms    [Use=
r: 181.7 ms, System: 82.1 ms]
>           Range (min =E2=80=A6 max):   262.0 ms =E2=80=A6 270.3 ms    10 =
runs
>
>         Summary
>           './git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch=
 -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD' ran
>             1.06 =C2=B1 0.01 times faster than './git -c core.fsync=3Dloo=
se-object -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <r=
epo/.git/to-add.txt' in 'ns/batched-fsync'
>
> And as before running that with "strace --summary-only" slows things
> down a bit (probably mimicking slower I/O a bit). I then get:
>
>         Summary
>           'strace --summary-only ./git -c core.fsync=3Dloose-object -c co=
re.fsyncMethod=3Dbatch -C repo update-index --add --stdin <repo/.git/to-add=
.txt' in 'HEAD' ran
>             1.19 =C2=B1 0.03 times faster than 'strace --summary-only ./g=
it -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-=
index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync'
>
> This one has a twist though, instead of fsync()-ing on the last object
> we write we'll not do that, and instead defer the fsync() until we
> write the index itself. This is outlined in [1] (as "METHOD THREE").
>
> Because of this under FSYNC_METHOD_BATCH we'll do the N
> objects (possibly only one, because we're lazy) as HASH_N_OBJECTS, and
> we'll even now support doing this via N arguments on the command-line.
>
> Then we won't fsync() any of it, but we will rename it
> in-place (which, if we were still using the tmp-objdir, would leave it
> "staged" in the tmp-objdir).
>
> We'll then have the fsync() for the index update "flush" that out, and
> thus avoid two fsync() calls when one will do.
>
> Running this with the "git hyperfine" command mentioned in a preceding
> commit with "strace --summary-only" shows that we do 1 fsync() now
> instead of 2, and have one more sync_file_range(), as expected.
>
> We also go from ~51k syscalls to ~39k, with ~2x the number of link()
> and unlink() in ns/batched-fsync, and of course one fsync() instead of
> two()>
>
> The flow of this code isn't quite set up for re-plugging the
> tmp-objdir back in. In particular we no longer pass
> HASH_N_OBJECTS_FIRST (but doing so would be trivial)< and there's no
> HASH_N_OBJECTS_LAST.
>
> So this and other callers would need some light transaction-y API, or
> to otherwise pass down a "yes, I'd like to flush it" down to
> finalize_hashfile(), but doing so will be trivial.
>
> And since we've started structuring it this way it'll become easy to
> do any arbitrary number of things down the line that would "bulk
> fsync" before the final fsync(). Now we write some objects and fsync()
> on the index, but between those two could do any number of other
> things where we'd defer the fsync().
>
> This sort of thing might be especially interesting for "git repack"
> when it writes e.g. a *.bitmap, *.rev, *.pack and *.idx. In that case
> we could skip the fsync() on all of those, and only do it on the *.idx
> before we renamed it in-place. I *think* nothing cares about a *.pack
> without an *.idx, but even then we could fsync *.idx, rename *.pack,
> rename *.idx and still safely do only one fsync(). See "git show
> --first-parent" on 62874602032 (Merge branch
> 'tb/pack-finalize-ordering' into maint, 2021-10-12) for a good
> overview of the code involved in that.
>
> 1. https://lore.kernel.org/git/220323.86sfr9ndpr.gmgdl@evledraar.gmail.co=
m/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/update-index.c |  7 ++++---
>  cache.h                |  1 +
>  read-cache.c           | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 34aaaa16c20..6cfec6efb38 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1142,7 +1142,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
>
>                         setup_work_tree();
>                         p =3D prefix_path(prefix, prefix_length, path);
> -                       update_one(p, 0);
> +                       update_one(p, HASH_N_OBJECTS);
>                         if (set_executable_bit)
>                                 chmod_path(set_executable_bit, p);
>                         free(p);
> @@ -1187,7 +1187,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
>                                 strbuf_swap(&buf, &unquoted);
>                         }
>                         p =3D prefix_path(prefix, prefix_length, buf.buf)=
;
> -                       update_one(p, 0);
> +                       update_one(p, HASH_N_OBJECTS);
>                         if (set_executable_bit)
>                                 chmod_path(set_executable_bit, p);
>                         free(p);
> @@ -1263,7 +1263,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
>                                 exit(128);
>                         unable_to_lock_die(get_index_file(), lock_error);
>                 }
> -               if (write_locked_index(&the_index, &lock_file, COMMIT_LOC=
K))
> +               if (write_locked_index(&the_index, &lock_file,
> +                                      COMMIT_LOCK | WLI_NEED_LOOSE_FSYNC=
))
>                         die("Unable to write new index file");
>         }
>
> diff --git a/cache.h b/cache.h
> index 2f3831fa853..7542e009a34 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -751,6 +751,7 @@ void ensure_full_index(struct index_state *istate);
>  /* For use with `write_locked_index()`. */
>  #define COMMIT_LOCK            (1 << 0)
>  #define SKIP_IF_UNCHANGED      (1 << 1)
> +#define WLI_NEED_LOOSE_FSYNC   (1 << 2)
>
>  /*
>   * Write the index while holding an already-taken lock. Close the lock,
> diff --git a/read-cache.c b/read-cache.c
> index 3e0e7d41837..275f6308c32 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2860,6 +2860,33 @@ static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
>         int ieot_entries =3D 1;
>         struct index_entry_offset_table *ieot =3D NULL;
>         int nr, nr_threads;
> +       unsigned int wflags =3D FSYNC_COMPONENT_INDEX;
> +
> +
> +       /*
> +        * TODO: This is abuse of the API recently modified
> +        * finalize_hashfile() which reveals a shortcoming of its
> +        * "fsync" design.
> +        *
> +        * I.e. It expects a "enum fsync_component component" label,
> +        * but here we're passing it an OR of the two, knowing that
> +        * it'll call fsync_component_or_die() which (in
> +        * write-or-die.c) will do "(fsync_components & wflags)" (to
> +        * our "wflags" here).
> +        *
> +        * But the API really should be changed to explicitly take
> +        * such flags, because in this case we'd like to fsync() the
> +        * index if we're in the bulk mode, *even if* our
> +        * "core.fsync=3Dindex" isn't configured.
> +        *
> +        * That's because at this point we've been queuing up object
> +        * writes that we didn't fsync(), and are going to use this
> +        * fsync() to "flush" the whole thing. Doing it this way
> +        * avoids redundantly calling fsync() twice when once will do.
> +        */
> +       if (fsync_method =3D=3D FSYNC_METHOD_BATCH &&
> +           flags & WLI_NEED_LOOSE_FSYNC)
> +               wflags |=3D FSYNC_COMPONENT_LOOSE_OBJECT;
>
>         f =3D hashfd(tempfile->fd, tempfile->filename.buf);
>
> @@ -3094,7 +3121,7 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
>         if (!alternate_index_output && (flags & COMMIT_LOCK))
>                 csum_fsync_flag =3D CSUM_FSYNC;
>
> -       finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
> +       finalize_hashfile(f, istate->oid.hash, wflags,
>                           CSUM_HASH_IN_STREAM | csum_fsync_flag);
>
>         if (close_tempfile_gently(tempfile)) {
> --
> 2.35.1.1428.g1c1a0152d61
>

In the long run, we should attach the "need to fsync the index" to an
ongoing 'repo-transaction' so that we can composably sync at the best
point regardless of what the top-level git operation does.
