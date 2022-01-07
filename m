Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF1AC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 23:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiAGXbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 18:31:02 -0500
Received: from mout.web.de ([212.227.15.3]:37993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231465AbiAGXbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 18:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641598246;
        bh=YyT/rKHnUTXWCX95pMBbGbMmXYAjjzlYewrlR6S47UE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JvwitonGB47PpeQMaaonu3kdvUaIcCR9S4qoAAGSArAV956yqnBGAPVypJpyFuUCO
         +tELsD6hm6zXlM2MZPTA5e7HRbKXVq4cS+uyc9DKcMyyeVD7L4Zaon/OGDeMChq32+
         nr+S7ar79RtMBHy1Oz1BVuWa37JgXTDh8/s1KUhg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHSb-1mu8Ce3c85-00W4qY; Sat, 08
 Jan 2022 00:30:45 +0100
Message-ID: <f40c1b47-9aad-2dcc-ceeb-5dee2b517cd8@web.de>
Date:   Sat, 8 Jan 2022 00:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g> <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
 <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
 <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net> <xmqq7dbb9wcz.fsf@gitster.g>
 <40077881-e91a-dfba-5950-cdc03719264d@web.de> <xmqqzgo76xpj.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqzgo76xpj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ADJTtHHjiJrWl0J4eKNc3urcu+iKraYLayDKkLIiJlM6b9wFZy
 dvbxaDCZFWX0mWH2zkGsauhyFd9HgXYzpFCtcwTlYOc1X6xBduYi7Ir96iKHF8G4eB+3YYB
 ckyG/Gq9w70dj6AAEynXVebaWxGuWJfAG2EmaD3ZSLKBBWeb8smb6tL9b8G0MpKs/hObtQ0
 yVEkbJTkv0tJVgCI9ledg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Lw80fP7a3U=:c/Jq5GfDteq/RWyYgOEvRI
 UJujPqZZ4tatP7PsVFOcTFox0YM+i342B9UjjdwDWDsX6AxTVjUwOYp10Fol/S/c/j5pFGwj7
 6M1G+3OADjrnwTjZS86PRuwjAPEv2F5PYx/DgA56VXph8rrJnF3pj1/ng8LqFUFFy/D8T3sBM
 Skfg4Pq7s4HM16HHNy9UloG/8OnglX6xsBHjjtssEme7Tdy6l6EAvRcKN5j4dSbJ6PyGk0D2z
 6VrytiUE7SzvGGsrsZzXFP6MG91T5jFg4PKm7J6K5Pfrvu7+x0f71GecBMYus2drhfzfGn4cA
 lon57YLs+g/JL5qIiWey8s6IYZN4nJwemEcjW95zEewoAoTI4gtNFqf/KPrmHSdqbGx9bngdk
 sVVp2xXFKY5/wAzcq/UGNXz+lw193IaG+cvCKBdEDuNmWXsWn/r5UJfalnYFnBa3tjSOWVLNW
 KnlmHpM71etP4s0Jt9h7DVdXoR4P70wNFL0mZIJ1iufbKZyQo8KbyPC5SKxwkkDZ5QUyOkdoP
 jHpBllrUU4+DuAD7XkIGdvdeqZ3R7N1RChT7UE/vcnkfJuoRMX60vG33xemsoFIDQSV2g/Dia
 oXeo5oxdZFUYmEZhWcTFvxKqPagbc1MaqETTH5Y0N0G3daCIGcwULM4rFUL7SGoG/o26h4bo0
 5eLxOPRpCcB0SvlQBCpYrOHa4TKJqV1ZyJY8lHtFFIOa4QkCOEd3JXkmVAY6bvb1Hf8oRw+Pe
 grNRqTkor4/FcDQhkGD0nZ6qGFCaIPUEh+LAu3j1qFOl8FxfvnBdVDJSSmwmEOWL0cZqLHK/j
 WtWhcM/NJ8leiE9uEtNBEtFi9mHHUNINwbwhdD966bV/xKWpJa8NO6dU1vzKp9ZOEw5PaAj1K
 x7z4ujkrx7b6QO2xUEZqJY/Fc5K0nOcla3cF7OUFcZX9jKtGfgRwCQSIsRgx/9KjqeYLBWqtk
 4tdBk3bcyVwPU3wqJvZ60qrcjnV6aKbYvBH1aToIbDAYecSt3cBGcvzZUxp0TpaweuvMOTal8
 LzEWU8VgF4FIVZ/CyDvH8HhERNajxkGXe2mqqBG6KjJZf/9z3J5tKlS32KdmSE1ycnCxDncSA
 74K6PPpTtqiWzc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.22 um 22:30 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> If falling back to malloc(3) is fine in general then I wonder if we can
>> just it use always.  This would save two branches and make buffer
>> management trivial here.  How much worse is malloc(3) on platforms with
>> alloca(3)?  Do we sort lots of short lists somewhere?  In other words:
>> Does this stack allocation optimization actually make a measurable
>> difference?
>
> Well all the preimage of this came from your 04ee8b87 (compat: add
> qsort_s(), 2017-01-22), so you tell me ;-)

Right, except I stole the code almost verbatim from compat/qsort.c,
which had this optimization since 43fe901b71 (compat: Add simplified
merge sort implementation from glibc, 2008-02-05).  :)  The
optimization may have raised my eyebrow a bit at the time, but not
enough to come up with a meaningful benchmark..

https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dstdlib/msort.c (the
original) still uses alloca(3) (and more tricks), by the way;
https://cgit.freebsd.org/src/tree/lib/libc/stdlib/merge.c still
doesn't.

>
>> Heap fragmention should not be a concern here, at least, because the
>> pattern of requesting, using and releasing a single allocation won't
>> leave holes.
>
> Sure.  Even in a multi-threaded environment that should be true.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: compat/qsort_s.c: avoid using potentially unaligned access
>
> The compatibility definition for qsort_s() uses "char buffer[1024]"
> on the stack to avoid making malloc() calls for small temporary
> space, which essentially hand-rolls alloca().
>
> But the elements of the array being sorted may have alignment needs
> more strict than what an array of bytes may have. &buf[0] may be
> word aligned, but using the address as if it stores the first
> element of an array of a struct, whose first member may need to be
> aligned on double-word boundary, would be a no-no.
>
> We could use xalloca() from git-compat-util.h, or alloca() directly
> on platforms with HAVE_ALLOCA_H, but let's try using unconditionally
> xmalloc() before we know the performance characteristics of the
> callers.
>
> It may not make much of an argument to inspect the current callers
> and say "it shouldn't matter to any of them", but anyway:
>
>  * The one in object-name.c is used to sort potential matches to a
>    given ambiguous object name prefix in the error path;
>
>  * The one in pack-write.c is done once per a pack .idx file being
>    written to create the reverse index, so (1) the cost of malloc()
>    overhead is dwarfed by the cost of the packing operation, and (2)
>    the number of entries being sorted is the number of objects in a
>    pack;
>
>  * The one in ref-filter.c is used by "branch --list", "tag --list",
>    and "for-each-ref", only once per operation.  We sort an array of
>    pointers with entries, each corresponding to a ref that is shown.
>
>  * The one in string-list.c is used by sort_string_list(), which is
>    way too generic to assume any access patterns, so it may or may
>    not matter, but I do not care too much ;-)
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/qsort_s.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git c/compat/qsort_s.c w/compat/qsort_s.c
> index 52d1f0a73d..0f7ff30f5f 100644
> --- c/compat/qsort_s.c
> +++ w/compat/qsort_s.c
> @@ -49,21 +49,15 @@ int git_qsort_s(void *b, size_t n, size_t s,
>  		int (*cmp)(const void *, const void *, void *), void *ctx)
>  {
>  	const size_t size =3D st_mult(n, s);
> -	char buf[1024];
> +	char *tmp;
>
>  	if (!n)
>  		return 0;
>  	if (!b || !cmp)
>  		return -1;
>
> -	if (size < sizeof(buf)) {
> -		/* The temporary array fits on the small on-stack buffer. */
> -		msort_with_tmp(b, n, s, cmp, buf, ctx);
> -	} else {
> -		/* It's somewhat large, so malloc it.  */
> -		char *tmp =3D xmalloc(size);
> -		msort_with_tmp(b, n, s, cmp, tmp, ctx);
> -		free(tmp);
> -	}
> +	tmp =3D xmalloc(size);
> +	msort_with_tmp(b, n, s, cmp, tmp, ctx);
> +	free(tmp);
>  	return 0;
>  }

=2D-- >8 ---
Subject: [PATCH] stable-qsort: avoid using potentially unaligned access

Like in the previous patch for compat/qsort_s.c, remove the optimization
of using an on-stack buffer to avoid small allocations.  This ensures
maximum alignment for the array elements and simplifies the code a bit.

The performance impact for the current callers is unlikely to be
noticeable:

 * compat/mingw.c::make_environment_block() uses ALLOC_ARRAY and
   ALLOC_GROW several times already, so another allocation of up to 1KB
   should not matter much.

 * diffcore-rename.c::diffcore_rename_extended() is called once per diff
   or twice per merge, and those require allocations for each object and
   more already.

 * merge-ort.c::detect_and_process_renames() is called once per merge.
   It's responsible for the two per-merge diffcore_rename_extended()
   calls mentioned above as well, though.  So this is possibly the most
   impacted caller.  Per-object allocations are likely to dwarf the
   additional small allocations in git_stable_qsort(), though.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 stable-qsort.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/stable-qsort.c b/stable-qsort.c
index 6cbaf39f7b..7ff12467cd 100644
=2D-- a/stable-qsort.c
+++ b/stable-qsort.c
@@ -48,15 +48,9 @@ void git_stable_qsort(void *b, size_t n, size_t s,
 		      int (*cmp)(const void *, const void *))
 {
 	const size_t size =3D st_mult(n, s);
-	char buf[1024];
-
-	if (size < sizeof(buf)) {
-		/* The temporary array fits on the small on-stack buffer. */
-		msort_with_tmp(b, n, s, cmp, buf);
-	} else {
-		/* It's somewhat large, so malloc it.  */
-		char *tmp =3D xmalloc(size);
-		msort_with_tmp(b, n, s, cmp, tmp);
-		free(tmp);
-	}
+	char *tmp;
+
+	tmp =3D xmalloc(size);
+	msort_with_tmp(b, n, s, cmp, tmp);
+	free(tmp);
 }
=2D-
2.34.1


