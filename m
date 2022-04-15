Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A49CC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354085AbiDONkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbiDONkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:40:08 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6826D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650029847;
        bh=qLIgrnVWaPyIA8XAunw16ErgW5ZbyebPNU5dOftwsWQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hfZi7EOn4kWR5mFQb3+dBnn9czWBoT5EaMED9sZbt4yDunQukQKEvwjkkY6H6VB0f
         KSSOJvchJb/FfrKVK5Edfz79cDStvXgZUFnne0BxK4m/r1vDzrlmihWtirP/Fk+RfN
         4WXSXgHN3fB22RKw+i7GMIIDaJIdw0J0P4Yvx5us=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1nzBJW3pPs-016arv; Fri, 15
 Apr 2022 15:37:26 +0200
Message-ID: <a1b7d41f-561f-6806-1d53-2c15d4a22fdc@web.de>
Date:   Fri, 15 Apr 2022 15:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 1/2] reftable: remove the "return_block" abstraction
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <20220415083058.29495-1-carenas@gmail.com>
 <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-1.2-76ed86bf88c-20220415T101740Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-1.2-76ed86bf88c-20220415T101740Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C6pRw9if5z/cI/nwUyvej5GH8hyOtcfzXZs5RCt3njFqJzgHqHJ
 xlpsTcs7mmIGoX2YIlWve32seBF9UYdSX1kM6QOgPIMVC5oc17ccT82jvhtcFxAp9iavnDG
 xoC7r/1SfripBgWhVu7Vld+1E02Ce8FNfcNLQJ6zQRVlQEFki9jPTIDWqPah/TN16Ca3u8u
 GKmNLgxQmdP+0u55RCz9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zUgd5qDaZjM=:Uc/ond0eE+8cefhgZaKKe6
 SkPTRwWtnYDfNnvuOPxbIwhXAwwmwo71dno+l80QpJR7ZX5MVJyqtux05xPhIVjH9EZ9pkIfy
 H4SKyJirNjMDVyi1+vSFYntfrOwebheSHROmA/v2Y4gke6cImanbnfEyHLuPUKjKC+Lc7XTu1
 I1X9J/2xGwBcbKg2/aMS4uKc4dSFFL56WL7Mk1GmujUkK4DsR2kpR8qilHYPR/kzK+5+vDUYx
 ftRJXPxDAc9I41dICzobGsHqw81IKtSLKFcEYeRPDYKGP9744xZ3E5pnNurkmmdCqUwfzlwha
 7P1lRgDXzrdOIiLRgvWUDFPRzQbrCVbCzDo4kl8T6B4fmhLyoql0xT/cHL31/keSTS5cEcFgm
 f7eXkhuIjOc/CnNCrRjF8z1OkPSjxCIESgYusWmmVvjSkTUHruEvDOqYAOGv+tIJoWx/qc0nH
 FE2TdEDUikVadphDFF9dRSLfnFK4DIQYfWt3f9e/Hon7ksD/uHYk0/ShtV3OpLP5fCxLQMYZy
 ymFs87Cp7AeL2L2+vssDpEGIiLmZWqeUO0OYPKj8elGDwXfiE7MEnqakvRqI6FSo2CA+XnWku
 v4FO/mJjSP0W0ICN3aQ7t0dLwU0fwiq2Zo+dspo458DOFdiRtA191X3sqEdnPHJEGBW49lC3K
 tkZuYgqPW5DhmUDuva90F5KAtRpuivpYFUuhK3+yIgDqBe3BcLRv66ilBEFw9BR2YjjbDGhiR
 gnjDiPWoXMpWD+JGmIQh1puLhNwoDZBVPCQsX6I873rrUPYbZLxEghGAYU54eXHdaoHZGBAox
 LqJioRIPBw5g/vJDeP9UgatzWOdanBxR32hT5WA2SyaSJMInlZsbKW6ZJsbXNCBqUTNxjdGA+
 9cWzIjmqV0ZueiCAw61A8eMnnfQ1EbElyNYxST4HK6ACXgnYTIOz7jNUS7cnyQVDo720frb2S
 dtj4Nvw9hZMzqXNpdrgYfO98ehviMbQZQc00YUce3dMIBnr0N9zS97i6iPfGklqPF0TXK/2B3
 rN7QKw8l/BtQMgzLHslyXH/0nwbn1rWqxoVSp6/zSin+A0KoiNGtfgjViAwPhTYdR7Zaw/pZ6
 GaBtyChsUA2b7Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.04.22 um 12:21 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> This abstraction added in 1214aa841bc (reftable: add blocksource, an
> abstraction for random access reads, 2021-10-07) has the caller
> provide a "blockp->data", so there's not point in having the vtable
> have a custom free() function.
>
> In addition this had what looked like a poor man's SANITIZE=3Daddress
> doing a memset() to 0xff just before the data was free'd.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  reftable/block.c                |  4 +---
>  reftable/blocksource.c          | 28 +---------------------------
>  reftable/reftable-blocksource.h |  2 --
>  3 files changed, 2 insertions(+), 32 deletions(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index 34d4d073692..bb17cc32372 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -442,9 +442,7 @@ void block_writer_release(struct block_writer *bw)
>
>  void reftable_block_done(struct reftable_block *blockp)
>  {
> -	struct reftable_block_source source =3D blockp->source;
> -	if (blockp && source.ops)
> -		source.ops->return_block(source.arg, blockp);

I don't understand this interface.  Why is source.arg passed to the
function?  Is this perhaps done in preparation for some kind of backend
that is planned to be added later which makes use of it?  I suspect we'd
better postpone cleanups until the full functionality is integrated.

> +	FREE_AND_NULL(blockp->data);

If you do that...

>  	blockp->data =3D NULL;

... then this line becomes redundant.

>  	blockp->len =3D 0;
>  	blockp->source.ops =3D NULL;
> diff --git a/reftable/blocksource.c b/reftable/blocksource.c
> index 2605371c28d..d9e47cc316b 100644
> --- a/reftable/blocksource.c
> +++ b/reftable/blocksource.c
> @@ -13,12 +13,6 @@ license that can be found in the LICENSE file or at
>  #include "reftable-blocksource.h"
>  #include "reftable-error.h"
>
> -static void strbuf_return_block(void *b, struct reftable_block *dest)
> -{
> -	memset(dest->data, 0xff, dest->len);
> -	reftable_free(dest->data);
> -}
> -
>  static void strbuf_close(void *b)
>  {
>  }
> @@ -42,7 +36,6 @@ static uint64_t strbuf_size(void *b)
>  static struct reftable_block_source_vtable strbuf_vtable =3D {
>  	.size =3D &strbuf_size,
>  	.read_block =3D &strbuf_read_block,
> -	.return_block =3D &strbuf_return_block,
>  	.close =3D &strbuf_close,
>  };
>
> @@ -54,19 +47,7 @@ void block_source_from_strbuf(struct reftable_block_s=
ource *bs,
>  	bs->arg =3D buf;
>  }
>
> -static void malloc_return_block(void *b, struct reftable_block *dest)
> -{
> -	memset(dest->data, 0xff, dest->len);
> -	reftable_free(dest->data);
> -}
> -
> -static struct reftable_block_source_vtable malloc_vtable =3D {
> -	.return_block =3D &malloc_return_block,
> -};
> -
> -static struct reftable_block_source malloc_block_source_instance =3D {
> -	.ops =3D &malloc_vtable,
> -};
> +static struct reftable_block_source malloc_block_source_instance =3D { =
0 };
>
>  struct reftable_block_source malloc_block_source(void)
>  {
> @@ -83,12 +64,6 @@ static uint64_t file_size(void *b)
>  	return ((struct file_block_source *)b)->size;
>  }
>
> -static void file_return_block(void *b, struct reftable_block *dest)
> -{
> -	memset(dest->data, 0xff, dest->len);
> -	reftable_free(dest->data);
> -}
> -
>  static void file_close(void *b)
>  {
>  	int fd =3D ((struct file_block_source *)b)->fd;
> @@ -115,7 +90,6 @@ static int file_read_block(void *v, struct reftable_b=
lock *dest, uint64_t off,
>  static struct reftable_block_source_vtable file_vtable =3D {
>  	.size =3D &file_size,
>  	.read_block =3D &file_read_block,
> -	.return_block =3D &file_return_block,
>  	.close =3D &file_close,
>  };
>
> diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blockso=
urce.h
> index 5aa3990a573..7b7cb280b73 100644
> --- a/reftable/reftable-blocksource.h
> +++ b/reftable/reftable-blocksource.h
> @@ -35,8 +35,6 @@ struct reftable_block_source_vtable {
>  	   beyond the end of the block */
>  	int (*read_block)(void *source, struct reftable_block *dest,
>  			  uint64_t off, uint32_t size);
> -	/* mark the block as read; may return the data back to malloc */
> -	void (*return_block)(void *source, struct reftable_block *blockp);
>
>  	/* release all resources associated with the block source */
>  	void (*close)(void *source);

