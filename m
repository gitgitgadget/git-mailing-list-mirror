Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED12C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFAD60EB8
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhKBUsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:48:38 -0400
Received: from mout.web.de ([212.227.15.3]:38361 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhKBUsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 16:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635885961;
        bh=mvrpBR84MutE19RoBmX2G0hRLtE0GSUDrHaOaevMGTU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=e+bAeGPtYry3Gia/7Fv4HxzoZqFReMSmhmT9Y7dy+PjWg5oBhmUYpisFYFEksCyPz
         QmTuyH0s2icRXL+r6ipPlfHSodNPAulSBLx37EGLmWFz1ahL+BTCdRJiPt9/zuopPE
         Jf6L7+wgdflJ6BbsQBZ3DjKKl1XdTRtY9i739i0Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1mdWVF3NmC-014Nsf; Tue, 02
 Nov 2021 21:40:41 +0100
Date:   Tue, 2 Nov 2021 21:40:41 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v4 5/8] odb: teach read_blob_entry to use size_t
Message-ID: <20211102204040.nnndsqrzu7ozpva7@tb-raspi4>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
 <308a8f2a3ade63ef21feb945e45866f2a83ae101.1635867971.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308a8f2a3ade63ef21feb945e45866f2a83ae101.1635867971.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:6c2GyAf5Ko2EZHbwOKwIYxAIYjjJW6k7JrjlHjxZsz/o8WJF6CW
 xncCRDfYjev8oD6T/CoWnMYuhCj+UD4RSnFQ8pjT4SXaBcIMqMw4Od4nv13iHWqrGf+FHiz
 hWiGowD/FN0nFpY0V0eIHGuBmGKDDrAn0dj7oSUHtkTN7zYKt11y1DduUWLGkV/MEqkdrrJ
 Z64m8SMvIhQgdwq21yOWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nYdRoNdlytA=:5n3I3qGm56CTnGIYwhOSXH
 jpGY/SzU/WOh1K/2YaKqkk9EibnGLscXC4SBPvD7E4KOGjMQPHpPa8yqmiwxwngJiZ0Sq/xxG
 DrVDtIw2C42YuyN9xDF1jZyy4c8rCri3Tb10ou5oMVwD9dxeAyClGrsciR8LzkQGxTAAp+vg8
 bUPcdxRRhomc8nE/KNgXl2ffFAnXIXbc6El+OqlZTcGnvPPfW3frCUOIhestAkFWMZ+53aJVA
 K4Bh7ZTGQcwc4ubBatJ7hIzC7YOubF32NW6l8ZD57UVfEPNSKeEnEJSvIBTMShxjdh8dTn5sv
 fwIrvI7r4w/2uFn6FGew1VRMZaZNxr2WV3viyNj6qGUAWzj0+FVIz9FLg9/TMAIoZ5uDJF9GD
 GVaY4CJmY7d+4w2po+X6ALwUuuCzrCY5M0Pd9I3AOC86rM2wNxHJgDLSPN0Ut+1/hLp5bGngU
 PsOKGDm+iCx7ab0DKp1O/5IYAPCSaYR73MnZZVxHhP4ztKP7dzAZvvdCuhgK26OWwj4+gsFwI
 44ZiWOX37XcmxUDLchObQYa1/xuIMSpzly4hCinsrODygJsDg+lM3o+eWrfy/uCUeu5/BgtpA
 270WP1h++J1x35NyLDIE+XrpXwXb8Qm0ZBO9Wx39/Ak9kNTiNj328T7z4B+7pudr6sNOYnKft
 MkzvRMFHln7Ngdxmvbyae86LGjGcEdKqKdYhHL6xhocB/0pQJ+GCT7DpKAd3qqmV1EJaDEMHV
 2rbhEhBUlE3rXKAFGnrxChfMBQmQL2RxBWJOBc8McwBwZUvZ+lcEoIL9kzqOTABtorEcIAcKA
 ITJUoSal793Fn7iGuqzYaFV1MvqFkAB2al4xvNnQRgwSXE0D+cSxPdoRkwskOniVgQGCpmtxH
 fXBKIHbUABX+/pr3FCV2Xad7wsvXnfKPzu6Gcrd/ygYdvC3MeEcsdaleHwPm/fiq/4R3lhE/U
 Zli6dC3Z7sZHD6LVatVy1qcH+YLgj1N9eGx+C4a1PDZkeBhJPE5VSe/s0E5ix/HHIa6soUMFh
 QqiKLn8KBhQFrQQNow25VROMDfisd2bcSJuoRSU+ReviHCFegyi59XbNOE1tdskQ3149C8kGs
 9g6vmmUlBguluo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicely explained, some comments inline

On Tue, Nov 02, 2021 at 03:46:08PM +0000, Matt Cooper via GitGitGadget wro=
te:
> From: Matt Cooper <vtbassmatt@gmail.com>
>
> There is mixed use of size_t and unsigned long to deal with sizes in the
> codebase. Recall that Windows defines unsigned long as 32 bits even on
> 64-bit platforms, meaning that converting size_t to unsigned long narrow=
s
> the range. This mostly doesn't cause a problem since Git rarely deals
> with files larger than 2^32 bytes.

What does this mean ?
> ... This mostly doesn't cause a problem since Git rarely deals
> with files larger than 2^32 bytes.

Is "mostly" is a good wording here ?
May be
This doesn't cause a problem when files smaller than 2^32 bytes are handle=
d by Git.

>
> But adjunct systems such as Git LFS, which use smudge/clean filters to
> keep huge files out of the repository, may have huge file contents passe=
d
> through some of the functions in entry.c and convert.c. On Windows, this
> results in a truncated file being written to the workdir. I traced this =
to
> one specific use of unsigned long in write_entry (and a similar instance
> in write_pc_item_to_fd for parallel checkout). That appeared to be for
> the call to read_blob_entry, which expects a pointer to unsigned long.
>
> By altering the signature of read_blob_entry to expect a size_t,

"expect" -> "use"

(I am not a native English speaker, would "changing" be better than "alter=
ing" ?)
 By changing the signature of read_blob_entry to use size_t,



> write_entry can be switched to use size_t internally (which all of its
> callers and most of its callees already used). To avoid touching dozens =
of
> additional files, read_blob_entry uses a local unsigned long to call a
> chain of functions which aren't prepared to accept size_t.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  entry.c                     | 8 +++++---
>  entry.h                     | 2 +-
>  parallel-checkout.c         | 2 +-
>  t/t1051-large-conversion.sh | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 711ee0693c7..4cb3942dbdc 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -82,11 +82,13 @@ static int create_file(const char *path, unsigned in=
t mode)
>  	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
>  }
>
> -void *read_blob_entry(const struct cache_entry *ce, unsigned long *size=
)
> +void *read_blob_entry(const struct cache_entry *ce, size_t *size)
>  {
>  	enum object_type type;
> -	void *blob_data =3D read_object_file(&ce->oid, &type, size);
> +	unsigned long ul;
> +	void *blob_data =3D read_object_file(&ce->oid, &type, &ul);
>
> +	*size =3D ul;
>  	if (blob_data) {
>  		if (type =3D=3D OBJ_BLOB)
>  			return blob_data;
> @@ -270,7 +272,7 @@ static int write_entry(struct cache_entry *ce, char =
*path, struct conv_attrs *ca
>  	int fd, ret, fstat_done =3D 0;
>  	char *new_blob;
>  	struct strbuf buf =3D STRBUF_INIT;
> -	unsigned long size;
> +	size_t size;
>  	ssize_t wrote;
>  	size_t newsize =3D 0;
>  	struct stat st;
> diff --git a/entry.h b/entry.h
> index b8c0e170dc7..61ee8c17604 100644
> --- a/entry.h
> +++ b/entry.h
> @@ -51,7 +51,7 @@ int finish_delayed_checkout(struct checkout *state, in=
t *nr_checkouts);
>   */
>  void unlink_entry(const struct cache_entry *ce);
>
> -void *read_blob_entry(const struct cache_entry *ce, unsigned long *size=
);
> +void *read_blob_entry(const struct cache_entry *ce, size_t *size);
>  int fstat_checkout_output(int fd, const struct checkout *state, struct =
stat *st);
>  void update_ce_after_write(const struct checkout *state, struct cache_e=
ntry *ce,
>  			   struct stat *st);
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index 6b1af32bb3d..b6f4a25642e 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -261,7 +261,7 @@ static int write_pc_item_to_fd(struct parallel_check=
out_item *pc_item, int fd,
>  	struct stream_filter *filter;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	char *blob;
> -	unsigned long size;
> +	size_t size;
>  	ssize_t wrote;
>
>  	/* Sanity check */
> diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
> index e7f9f0bdc56..e6d52f98b15 100755
> --- a/t/t1051-large-conversion.sh
> +++ b/t/t1051-large-conversion.sh
> @@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
>
>  # This smudge filter prepends 5GB of zeros to the file it checks out. T=
his
>  # ensures that smudging doesn't mangle large files on 64-bit Windows.
> -test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
>  		'files over 4GB convert on output' '
>  	test_commit test small "a small file" &&
>  	small_size=3D$(test_file_size small) &&
> --
> gitgitgadget
>
