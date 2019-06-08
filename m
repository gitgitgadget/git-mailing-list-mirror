Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340501F462
	for <e@80x24.org>; Sat,  8 Jun 2019 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfFHW2T (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 18:28:19 -0400
Received: from mout.web.de ([212.227.15.3]:35795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfFHW2T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 18:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560032886;
        bh=aQtJEJvYTwQLgHrgBuD602L04hmB6BzF0j9Bt3hKoLc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I1CfUTfWDAwp7X920LoSZd98iXz6xlhlsgLq3FptIdKz4qR1dWVaVZhF1/ltG1NrE
         zcf5hkF6Sfx78ifjIy22re+Do0laPblbKuQXLAyMX+1BZsLUFhfaLaacWv29F6cMeJ
         oNJ97R+zuBMKNSNuyJdgL9dnWi+jcaD4yc1KA+JI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeNUV-1hBJqD2WnH-00QFVP; Sun, 09
 Jun 2019 00:28:06 +0200
Subject: Re: [PATCH 1/1] diffcore-rename: speed up register_rename_src
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.142.git.gitgitgadget@gmail.com>
 <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bcaff0ce-365d-1d17-6ea0-7e3b52fc928b@web.de>
Date:   Sun, 9 Jun 2019 00:27:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kF4W9Mbi6qYBluwbTQByYqeCQtKT3tQqcutYMifrjWIYiY6mZOp
 jiV6oVjrgakid4+3UCEmPMI0Iy5Ev3r98YOeyIYe09g/ZVQ061l8UmIznV1mOahWnbO5Z3s
 0pIH6c66CZTY98E1EUVMuYqa2U3oJCZYLGKfoD0BZvFBd6nByNxgUdIgi09wQSjjTSCoGi1
 qYqFXUbW4i6d9Rg6CXdOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:599L/Pfd13U=:RYvr8pARws3DwxVt9jT7OA
 1cr0bhVin4mRGvsWG8GHt0pzgJM3RmodY6oEl+3SkQljVI830zvPJPOKF6Tzv4/f9FdaAP829
 xk/5PmLgzJyakwYqhcd6kqdusgjRl9YQ3wSkjK3Fl6WEvaC6IOyPZjLjs3lqfM7he+fbiR4Xg
 VMQmW9gTo/Nd3vduAruZBTUYysNzAIXG/htlKD4AfQP+RiQj+nu72C326JGv/YvwKeh6kS3X8
 M1E8BuaR8ddPNIydiE0ETysb3T21+wMgj5ECkIUaghxQT1U6FEonO9mCV/rBtuJCZc5vj9pJW
 bkmLTt8xraswNpJ3LunkL1d2+5FOYevxxAoLhi/aauGUBGldHyDaFqTJU0PkWkhXCumRmPf3F
 RZdcV0n8QRiZDYzlgOPU3ugabvVJfgAC/iLRJPvRN2NsIwHy42tFxofvfh1L+MsIuH+NNqh27
 uksf9snTSI0ziz5jxhBrfg9DPaGkWm+eQ75mA/FHfSD62aHgwhpj/jwljr2gs422qpRjhbMRl
 SIfLFAQlch3j8d4VwF+BWF1asABEraU1DqwtfDLeSs0DuMV/E+Hm3SkBgOT+whczMOCOZ7ExG
 kWwfS8D/pFW6/ksUkVhQJ3LZSZCMHj/MVKRN9cRgBXbx8kr2EJuuwEAree6G4yc/AGigKwC3n
 IINFxwzUwKt0KLaDxjRAnsfmYF6CINr6Lq1M0NptsIscqSvJ7PXqWR9u44gbWfwtskGLZKSRE
 euX+CcinS6Cb6qJINUY4HP70G/59M2fPRuWRuaOnsVgtpGujUjHUWPw6PVPfk5psqqXg4No6o
 JkfuuSo80QvvTiSJ+d3kNboCcBNZHD87flUh/LeNlhdqq8Dq7zcuNeoP2K6Qd3SXZGfaLGn2Y
 f2EwccgYcz9+CpCKxlgz9rct7d79O4eDTKuY2g8ersAc8ZnmXfX3z/wAdgvGcuErLvgsO/GI8
 qic866axcNG+CMrB1VCJ26GfrdsF7b+Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.06.19 um 16:42 schrieb Jeff Hostetler via GitGitGadget:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach register_rename_src() to see if new file pair
> can simply be appended to the rename_src[] array before
> performing the binary search to find the proper insertion
> point.
>
> This is a performance optimization.  This routine is called
> during run_diff_files in status and the caller is iterating
> over the sorted index, so we should expect to be able to
> append in the normal case.  The existing insert logic is
> preserved so we don't have to assume that, but simply take
> advantage of it if possible.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diffcore-rename.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 07bd34b631..5bfc5f6c22 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -82,6 +82,18 @@ static struct diff_rename_src *register_rename_src(st=
ruct diff_filepair *p)
>
>  	first =3D 0;
>  	last =3D rename_src_nr;
> +
> +	if (last > 0) {
> +		struct diff_rename_src *src =3D &(rename_src[last-1]);
> +		int cmp =3D strcmp(one->path, src->p->one->path);
> +		if (!cmp)
> +			return src;
> +		if (cmp > 0) {
> +			first =3D last;
> +			goto append_it;

The goto is not necessary from a logical point of view; the binary
search is skipped even without it because the loop condition below is
not met anymore.

> +		}

You could decrement "last" at this point as a micro-optimization, to use
all three possible outcomes of the comparison to make some progress.

Not sure if any of that would have a _measurable_ impact, though, so I
don't mind the patch going in as is.

> +	}
> +
>  	while (last > first) {
>  		int next =3D (last + first) >> 1;

Hmm, "last" and "first" are ints as well, so this will give weird results
when "last" > INT_MAX / 2.  I thought 19716b21a4 ("cleanup: fix possible
overflow errors in binary search", 2017-10-08) got us rid of those, but
git grep -n '(.*+.*) >> 1' actually finds some more cases:

   builtin/ls-files.c:376:         int next =3D (last + first) >> 1;
   diffcore-rename.c:26:           int next =3D (last + first) >> 1;
   diffcore-rename.c:86:           int next =3D (last + first) >> 1;
   dir.c:704:              int cmp, next =3D (last + first) >> 1;
   name-hash.c:349:                        int mid =3D (begin + end) >> 1;
   read-cache.c:552:               int next =3D (last + first) >> 1;
   sh-i18n--envsubst.c:252:          size_t j =3D (j1 + j2) >> 1;

(Not caused by this patch, of course, just noticed it in the context.)

>  		struct diff_rename_src *src =3D &(rename_src[next]);
> @@ -95,6 +107,7 @@ static struct diff_rename_src *register_rename_src(st=
ruct diff_filepair *p)
>  		first =3D next+1;
>  	}
>
> +append_it:
>  	/* insert to make it at "first" */
>  	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
>  	rename_src_nr++;
>

Anyway, this here should work as well (and fix the possible overflow),
but may be too terse and quirky:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 07bd34b631..f2a9007e08 100644
=2D-- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -76,14 +76,13 @@ static int rename_src_nr, rename_src_alloc;

 static struct diff_rename_src *register_rename_src(struct diff_filepair *=
p)
 {
-	int first, last;
+	int first, last, next;
 	struct diff_filespec *one =3D p->one;
 	unsigned short score =3D p->score;

 	first =3D 0;
 	last =3D rename_src_nr;
-	while (last > first) {
-		int next =3D (last + first) >> 1;
+	for (next =3D last - 1; last > first; next =3D first + (last - first) / =
2) {
 		struct diff_rename_src *src =3D &(rename_src[next]);
 		int cmp =3D strcmp(one->path, src->p->one->path);
 		if (!cmp)
