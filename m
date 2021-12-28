Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715BC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhL1QrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:47:20 -0500
Received: from mout.web.de ([217.72.192.78]:39449 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhL1QrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640710032;
        bh=9adz+2TjuAbzn4BiM8EwBSR+KXY7jkIAAKSXHltlc7g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=baxpQvdQSaw26gQuXMn61XVQeKwuiu0Hz9LMelp0Y5q67D4rZJLjPQQBFa90yDETH
         caYMPLd/dtVDHs5d2MZ8QVLT2HcAIbd6jmgkhzhrOpbMj5u7D9U7iD6Lf6Yxo9rC+M
         Lv6ghdgrSxO1b8l28Tp28R1biIqSx9XdnElNQcwU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1nE0g10nAD-00GVG2; Tue, 28
 Dec 2021 17:47:12 +0100
Message-ID: <d0bdc7e5-9e34-49d8-33cf-dd96a807617e@web.de>
Date:   Tue, 28 Dec 2021 17:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v8 7/7] *.c: use isatty(0|2), not
 isatty(STDIN_FILENO|STDERR_FILENO)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
 <patch-v8-7.7-060483fb5ce-20211228T150728Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v8-7.7-060483fb5ce-20211228T150728Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dqs4EBblD0Z3R6Fqhst2SA9cWeQ97R36LXIOGCd5Awovizmjv6I
 NAaTBjTalvw912ntHzITVOOLjihB3gMQSHNNeMHXA4hAJLc6l1HQ1NdbMZ/MUq0hCKBYBOJ
 4BS1YmFI5s30l22EItWc+jcqhMuqOJDAbw6mAe7NaU2ahP2rEC3y36mmd5o2wWL6zqYiO/y
 UlxJuoqJcrE4g5Gn5sm0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8b7ZfyXSXM=:WZJ4CtdnXRcsNHaWGRCAGC
 tfkCyUyLZNljUsg+QQhvi+kebP0pab2EqzHE/B7x9Eo5sjnEMCSdxi28OdUHCFQ8WH6BERT6N
 Y8UGlyUJx3g7Qga6hOKwxKYM6kF0blkikfRzRoq8Msx3byXU7BlQrTmgbvez3P64azhEXKYTH
 3YqpV0nl7kBlNCvly5xSUtIIkN3FKPhiTTLEo3TIPcOMLxfs5Sd7i4RARVNPhFM/szvpj/th5
 uMdD6/n4T+icFLHe8+FYB4Uyx+B+2Yke9iqNMyo57QQL3L+j9uEtt7koiHcnfDBs1nrUt3UsT
 uurliadL882rkF3biPXFMmVdLZYKzIsZfCa7ieS5hlATdfhczNtImDOcl/dKOFJYUicdWqA+I
 kSjvVx8l7xvCJ/D2CtDzLmlNr86IaKdtFjbg6HiXf+GB8+F9u8KttSrauGAKvZScX/iYJqap4
 nQa9Dhi+UzNT1fWE9A44hjLRbtwG6N4uD6kHe0HMMUmio+xnBRdAqOhb27An9VkIXE5nXLSdW
 Iy3B8axE+bn/DuPxMjd8k4InXugkqfDTVGZcoqvdyq76WuN3+Zg9CPXzBiGGijEnwcIvAVzTC
 aM/aMKX9nJ7cZOqxLwrO5ywmw1egN5g27adD+mYJc5tWlwUtRRaiLB4jcnuRWZrDwUrZGFl0j
 JH2PYgbwpjjaWqMxYopPrTZ1iMVRyLhgIleWY76l2es3cb6iI1SRa5gOU4fxNSJ3BLcPh2VJd
 03RECQni7E5FXqu8pCLEhiq58lCh9RZWBJXoXFFQbaWtRF/dg2BpXbKsPInf5Dw+kF7ygdFss
 0/0X8DMR9XaJdD4LeuHJ7yaTnnxjGXvUlvf9RNQ8adi53V70SWFQ3h5Uo51VxGweOpuzW+kOy
 Yra0vma+Ya6IZjOs3BiYdtJJZ98a619XokZzQecmebmiz+v8gHVBigzwxllfQ9BDVxK5cH6i1
 fUS+2XEKSuOPkxjZ3rWdyw+/MHRisIZQ3X/Qo0YsDQp3cIFhT7UJEOz5lDGiqGroH1djvCDp4
 ZNtadQeWHCkatH4E0couoQj3NpgcYv+WMPa0jaOtc2C8DxXEbrneE2/cS1G7AiuvBEHtDXKVM
 KOTpRPQRpD4s60=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.21 um 16:19 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
> and around 10 "isatty(0)", but three callers used the
> {STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
> them.
>
> Let's change these for consistency.  This makes it easier to change
> all calls to isatty() at a whim, which is useful to test some
> scenarios[1].

Hmm.  Matching e.g. "(0|STDIN_FILENO)" instead of "0" is harder, of
course, but not much.

Shouldn't we use these macros more to reduce the number of magic values?
The code is slightly easier to read before this patch because it doesn't
require the reader to know the meaning of these numbers.

Reducing the constants to their numerical values is easy to automate in
general; the opposite direction is harder.  Coccinelle can help us take
such a step with a semantic patch like this:

	@@
	@@
	  isatty(
	(
	- 0
	+ STDIN_FILENO
	|
	- 1
	+ STDOUT_FILENO
	|
	- 2
	+ STDERR_FILENO
	)
	  )

>
> 1. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z=
-avarab@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/bisect--helper.c | 2 +-
>  builtin/bundle.c         | 2 +-
>  compat/mingw.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a5750..21360a4e70b 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *ter=
ms)
>  	fprintf_ln(stderr, _("You need to start by \"git bisect "
>  			  "start\"\n"));
>
> -	if (!isatty(STDIN_FILENO))
> +	if (!isatty(0))
>  		return -1;
>
>  	/*
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 5a85d7cd0fe..df69c651753 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -56,7 +56,7 @@ static int parse_options_cmd_bundle(int argc,
>
>  static int cmd_bundle_create(int argc, const char **argv, const char *p=
refix) {
>  	int all_progress_implied =3D 0;
> -	int progress =3D isatty(STDERR_FILENO);
> +	int progress =3D isatty(2);
>  	struct strvec pack_opts;
>  	int version =3D -1;
>  	int ret;
> diff --git a/compat/mingw.c b/compat/mingw.c
> index e14f2d5f77c..7c55d0f0414 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2376,7 +2376,7 @@ int mingw_raise(int sig)
>  	switch (sig) {
>  	case SIGALRM:
>  		if (timer_fn =3D=3D SIG_DFL) {
> -			if (isatty(STDERR_FILENO))
> +			if (isatty(2))
>  				fputs("Alarm clock\n", stderr);
>  			exit(128 + SIGALRM);
>  		} else if (timer_fn !=3D SIG_IGN)
