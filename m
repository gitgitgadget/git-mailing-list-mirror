Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA438C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE04861167
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349717AbhIIB6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhIIB6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:58:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A6C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:57:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v24so378272edi.10
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0PzBzKnHHg+woshn+t3teNABGVb6O1ESDRJLRq7G7GQ=;
        b=W2U7qpMZb741I1jLktgkhyThMUNRA7fJO1QHwrmDMNOszEaAOjps1SKztQOR01375t
         dTt9E/+VnNVr51KQby218zICphybCk7ocC6BRUhkG8M0j4laQy9JCx3mP6sLutO+T2YR
         rBudhZPmvUrcknoz0PIfIvE5zdhCYSxtGXBhUA4xzcXnOPaEYWKS5F97VcoYNDfGoT/t
         SuifFTYxZUyAPXTCj+/QkdC9/AA4CQZANOACW4Rkht+4VqGjYBk2a0dzOA19jAbCPrM1
         LyNloRd4S+Ty4a8h5UpxeUJoL8/T4PuQirwXGNkw7iB5L5tPUbSVLyEXHq4l575qZXhC
         4Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0PzBzKnHHg+woshn+t3teNABGVb6O1ESDRJLRq7G7GQ=;
        b=5Ximf6N+QaDeLtN3DrdpbrGcaDMiSYVV02ELGqxOYORwou4fORNOAbRnmhBn33zLsO
         ldP7tmV662zZu1LItoSjRUFotR4GCJ4KoHofvxdL5jJMB7UqGkI4KyLDb2sAnJTe5Kky
         7Hb96ZWEG/5gqXdEMrDqBXIz8oG9ZJQXu8tPDKvgpMWucwQtD/lxNGYXWJV5Sl4O6yZO
         NlxSfz40OKFH2Vfpc2zAwtdygG9tHJG8khkSlJ49y2fFWRk335fk76cFb/u0YUUOk2CX
         6A5nu9eAzV2griHDL6WzB4a6Ex4ivLU9083a29elFETaqvyP7QdcP3V50RMZlwocdxxF
         9iWw==
X-Gm-Message-State: AOAM532fWd1eMtgYfB/kiSHIL/isVzFRG6OzOKJoPVSJfsIQb7NFSIb8
        PMNusGm4MpNlU4BvA7HgXX0=
X-Google-Smtp-Source: ABdhPJxibzbx6+22160XQS6luriwJ7iCA+e2bGnFFUb8HPgP9nfialAhMdl0XlP4KUid9KhmPcDQoA==
X-Received: by 2002:aa7:dc50:: with SMTP id g16mr594224edu.182.1631152664386;
        Wed, 08 Sep 2021 18:57:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k6sm144380edv.77.2021.09.08.18.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:57:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Segfaults in git rebase --continue and git rerere
Date:   Thu, 09 Sep 2021 03:48:38 +0200
References: <YTlgyHnD3fFWwLu3@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTlgyHnD3fFWwLu3@camp.crustytoothpaste.net>
Message-ID: <87tuiufr3c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> I'm having a bit of a problem with segfaults using
> 2.33.0.252.g9b09ab0cd71.  I was in the process of running "git rebase
> --continue" with that version to resolve some conflicts in a project I'm
> working on.  At that point, it segfaulted, and I got this (apologies for
> the French):
>
>   error: impossible d'analyser la section en conflit dans 'scutiger-lfs/s=
rc/bin/git-lfs-transfer.rs'
>   error: impossible d'analyser la section en conflit dans 'scutiger-lfs/s=
rc/bin/git-lfs-transfer.rs'
>   Pr=C3=A9-image enregistr=C3=A9e pour 'scutiger-lfs/src/bin/git-lfs-tran=
sfer.rs'
>   [HEAD d=C3=A9tach=C3=A9e 5134185] scutiger-lfs: move BatchItem, Mode, a=
nd Oid to library
>    2 files changed, 74 insertions(+), 9 deletions(-)
>   Fusion automatique de scutiger-lfs/src/processor.rs
>   Fusion automatique de scutiger-lfs/src/bin/git-lfs-transfer.rs
>   CONFLIT (contenu) : Conflit de fusion dans scutiger-lfs/src/bin/git-lfs=
-transfer.rs
>   error: impossible d'appliquer 2cd1615... scutiger-lfs: move download an=
d verify actions into backend
>   Resolve all conflicts manually, mark them as resolved with
>   "git add/rm <conflicted_files>", then run "git rebase --continue".
>   You can instead skip this commit: run "git rebase --skip".
>   To abort and get back to the state before "git rebase", run "git rebase=
 --abort".
>   error: impossible d'analyser la section en conflit dans 'scutiger-lfs/s=
rc/bin/git-lfs-transfer.rs'
>   zsh: segmentation fault  git rebase --continue
>
> I can provide a tarball of the broken repo upon request.  It's 108 MB,
> so you'll need to provide some place for me to drop it.
>
> At that point, I needed to remove .git/MERGE_RR.lock (which is empty),
> and I ran "git rebase --abort" (because I realized my resolution was
> bad).  Upon which, I received a second segfault (traceback from tip of
> next):
>
>   #0  0x00000000005b6e6b in has_rerere_resolution (id=3D0x229b3a0) at rer=
ere.c:162
>   162             return ((id->collection->status[variant] & both) =3D=3D=
 both);
>=20=20=20
>   #0  0x00000000005b6e6b in has_rerere_resolution (id=3D0x229b3a0) at rer=
ere.c:162
>           both =3D 3
>           variant =3D 0
>   #1  rerere_clear (r=3D0x722880 <the_repo>, merge_rr=3Dmerge_rr@entry=3D=
0x7ffe8c703810) at rerere.c:1239
>           id =3D 0x229b3a0
>           i =3D 0
>
> It appears to be because id->collection->status here is NULL.  It's
> unclear to me why that's the case, but it does appear to be linked to my
> .git/MERGE_RR file, which looks like this (xxd -g1):
>
>   00000000: 30 34 39 62 31 34 32 39 34 65 64 30 63 30 65 66  049b14294ed0=
c0ef
>   00000010: 62 65 39 32 66 34 66 64 33 31 31 63 37 63 34 30  be92f4fd311c=
7c40
>   00000020: 39 30 39 34 65 63 64 65 09 73 63 75 74 69 67 65  9094ecde.scu=
tige
>   00000030: 72 2d 6c 66 73 2f 73 72 63 2f 62 69 6e 2f 67 69  r-lfs/src/bi=
n/gi
>   00000040: 74 2d 6c 66 73 2d 74 72 61 6e 73 66 65 72 2e 72  t-lfs-transf=
er.r
>   00000050: 73 00                                            s.
>
> The corresponding directory under .git/rr-cache is empty.  This
> specifically seems to be the problem, and I've included a snippet of a
> test below that causes the same segfault.  My guess is that the original
> segfault left the MERGE_RR file present but the files in the rr-cache
> directory absent.
>
> Since rerere isn't a strong suit of mine, I'm not sending a patch, but I
> am including a failing test[0] which indicates the problem (and to which
> anyone is welcome to add my sign-off) in hopes that someone more
> familiar with this subsystem can figure out what's going on.

I haven't taken time to familiarize myself with it, but I have one
segfault fix for it already[1] which needs a test, I tried and this is
completely unrelated.

The "fix" for this segfault you're reporting could be, this makes your
test pass, along with the rest of the test suite:

diff --git a/rerere.c b/rerere.c
index d83d58df4fb..cbad6a89ebc 100644
--- a/rerere.c
+++ b/rerere.c
@@ -157,6 +157,9 @@ static int has_rerere_resolution(const struct rerere_id=
 *id)
 	const int both =3D RR_HAS_POSTIMAGE|RR_HAS_PREIMAGE;
 	int variant =3D id->variant;
=20
+	if (variant =3D=3D id->collection->status_nr)
+		return 1;
+
 	if (variant < 0)
 		return 0;
 	return ((id->collection->status[variant] & both) =3D=3D both);

But I have no idea if that's sensible. I.e. as you found the immediate
cause here is that our "id" is being looked up in
"id->collection->status" where that's NULL, there's similar checks
elsewhere for "id->collection->status_nr", but if that's correct here I
don't know, nor what the deeper logic error is of how the two went out
of sync.

1. https://lore.kernel.org/git/87v96p4w3f.fsf@evledraar.gmail.com/

> ----- %< -----
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 9f8c76dffb..c44dfe248a 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -623,6 +623,7 @@ test_expect_success 'rerere with inner conflict marke=
rs' '
>  	git commit -q -m "will solve conflicts later" &&
>  	test_must_fail git merge A &&
>=20=20
> +	cp .git/MERGE_RR merge_rr &&
>  	echo "resolved" >test &&
>  	git add test &&
>  	git commit -q -m "solved conflict" &&
> @@ -645,6 +646,13 @@ test_expect_success 'rerere with inner conflict mark=
ers' '
>  	test_cmp expect actual
>  '
>=20=20
> +test_expect_success 'rerere clear does not segfault with bad data' '
> +	res_id=3D$($PERL_PATH -nF"\t" -e "print \$F[0]" merge_rr) &&
> +	cp merge_rr .git/MERGE_RR &&
> +	rm -f .git/rr-cache/$res_id/* &&
> +	git rerere clear
> +'
> +
>  test_expect_success 'setup simple stage 1 handling' '
>  	test_create_repo stage_1_handling &&
>  	(
> ----- %< -----
>
> As an aside, I generally find Git's codebase to be of exceptionally good
> quality for a C program, and so seeing two segfaults back to back led me
> to downgrade my recently upgraded version of glibc to see if somehow
> that was the problem.  Unfortunately, that was not the case, and we just
> have two separate bugs here.
>
> [0] The test uses perl because the MERGE_RR file contains a NUL byte and
> therefore cannot be used with standard POSIX utilities.

(Just a side-note, I think the use of perl here is fine)

I haven't tried, but I think you can probably do that res_id assignment
with "git grep" and -o, see t7816-grep-binary-pattern.sh for how we can
support greps with \0 in them with -f.
