Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F77FC433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 10:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbiEQKZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbiEQKY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 06:24:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA1A4C429
        for <git@vger.kernel.org>; Tue, 17 May 2022 03:23:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so33720142ejd.9
        for <git@vger.kernel.org>; Tue, 17 May 2022 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=n6Ji9ZgpqyqS/xu6W5VXJDdS1PA4wV4lFa9QrqcIri0=;
        b=RBdVfgFd8sMuKhS/oPUza3jKQ6xR4u+D6ZexYts01sUNZMNKCpyAd+seID+x8a2T4/
         jNs12V2lL7pvEUnA9Q0LiCw4KUJfMuD5NH/D/kmfzvsdNP+Rq1jGvi/eYCkASKMtFVun
         /1VizV7BDsD0a/ckJXGbMCV5JW6MZqrqUJjT3nhdZmNoIUu/euHKswMw1/K6xASnSV4b
         WAOgIQ78nutTvTmx7gXhIP49/6co7arz3uIZg+VUgXrMMTbItNkAzMfgnsUGFuzcxHCo
         flQs4pGVRltMkbyIz2cG4Hs2AAHcphqmsiQ+Hy4HA7nqPOG/h3nwTUaO2bezjCHq6ET3
         7ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=n6Ji9ZgpqyqS/xu6W5VXJDdS1PA4wV4lFa9QrqcIri0=;
        b=AeJiySHeNFbAiKu3kdO5z/B3sl5J80tE9m4E6aP3A6RLfwBq0Q/k480TwibFcmUPOW
         ABrsU2A+Yao5sBgSI+UPXK9VyfelKixODyeNWRe8/8rABmtGJfgWK+C0kXcu0Uoqkdan
         9mbK87HX+2/fceJ7z7lsaCGXK2khke9qThcfnvfz/rUSfc1ZKrJ3cp9dH+1hOtv3TlaF
         t3UjCGWljqIgYnFXtTf0lrelQYCqLUlaKQzGnedsp2/o3suhUqb5rEzgNTuI4Ihk8Joe
         UpZI8SqtYFUt+6iidbNiQ7cxBQLlLHuQwyGbFgPc5x9wEh7jy4A35GPLyWLp3rogQcOb
         nVRg==
X-Gm-Message-State: AOAM532x9oSYGCY0PLLGXYzeaZ5x2kFSi3n580IqWKb2M+aenllBVWKC
        OgZmT4lM+HOYUJpmA5kZgxk=
X-Google-Smtp-Source: ABdhPJyB+iuCnC3YLvMyVwcZxKejvGIfz+x8ItGuc1U0bfx2RrVwcemCN9XB4SqtI5neP3GLVNEQvQ==
X-Received: by 2002:a17:907:3f15:b0:6fc:30f0:6561 with SMTP id hq21-20020a1709073f1500b006fc30f06561mr18754809ejc.691.1652783035411;
        Tue, 17 May 2022 03:23:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id zd20-20020a17090698d400b006f3ef214e46sm852316ejb.172.2022.05.17.03.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:23:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nquMq-001TEp-Pw;
        Tue, 17 May 2022 12:23:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Hurst <tom@hur.st>
Subject: Re: Corrupt name-rev output
Date:   Tue, 17 May 2022 12:15:20 +0200
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net> <xmqq4k2otpkb.fsf@gitster.g>
 <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
 <779eb30b-fdb9-81fb-5d43-c8d388c5cb5a@web.de>
 <340c8810-d912-7b18-d46e-a9d43f20216a@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <340c8810-d912-7b18-d46e-a9d43f20216a@web.de>
Message-ID: <220517.86sfp878zr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 22 2022, Ren=C3=A9 Scharfe wrote:

> Am 21.04.22 um 19:55 schrieb Ren=C3=A9 Scharfe:
>> Am 21.04.22 um 04:11 schrieb Elijah Newren:
>>
>>> Reverting 2d53975488 fixes the problem.
>>
>> That's a good band-aid.
> Or perhaps it's all we need.  I can't replicate the original reduction
> of peak memory usage for the Chromium repo anymore.  In fact, the very
> next commit, 079f970971 (name-rev: sort tip names before applying,
> 2020-02-05), reduced the number of times free(3) is called there from
> 44245 to 5, and 3656f84278 (name-rev: prefer shorter names over
> following merges, 2021-12-04) brought that number down to zero.
>
> I can't reproduce the issue with the hardenedBSD repo, by the way, but
> e.g. with 'git name-rev 58b82150da' in the Linux repo.
>
> --- >8 ---
> Subject: [PATCH] Revert "name-rev: release unused name strings"
>
> This reverts commit 2d53975488df195e1431c3f90bfb5b60018d5bf6.
>
> 3656f84278 (name-rev: prefer shorter names over following merges,
> 2021-12-04) broke the assumption of 2d53975488 (name-rev: release unused
> name strings, 2020-02-04) that a better name for a child is a better
> name for all of its ancestors as well, because it added a penalty for
> generation > 0.  This leads to strings being free(3)'d that are still
> needed.
>
> 079f970971 (name-rev: sort tip names before applying, 2020-02-05)
> already reduced the number of free(3) calls for the use case that
> motivated the original patch (name-rev --all in the Chromium repository)
> from ca. 44000 to 5, and 3656f84278 eliminated even those few.  So this
> revert won't affect name-rev's performance on that particular repo.
>
> Reported-by: Thomas Hurst <tom@hur.st>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/name-rev.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c59b5699fe..02ea9d1633 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -18,7 +18,7 @@
>  #define CUTOFF_DATE_SLOP 86400
>
>  struct rev_name {
> -	char *tip_name;
> +	const char *tip_name;
>  	timestamp_t taggerdate;
>  	int generation;
>  	int distance;
> @@ -84,7 +84,7 @@ static int commit_is_before_cutoff(struct commit *commi=
t)
>
>  static int is_valid_rev_name(const struct rev_name *name)
>  {
> -	return name && (name->generation || name->tip_name);
> +	return name && name->tip_name;
>  }
>
>  static struct rev_name *get_commit_rev_name(const struct commit *commit)
> @@ -146,20 +146,9 @@ static struct rev_name *create_or_update_name(struct=
 commit *commit,
>  {
>  	struct rev_name *name =3D commit_rev_name_at(&rev_names, commit);
>
> -	if (is_valid_rev_name(name)) {
> -		if (!is_better_name(name, taggerdate, generation, distance, from_tag))
> -			return NULL;
> -
> -		/*
> -		 * This string might still be shared with ancestors
> -		 * (generation > 0).  We can release it here regardless,
> -		 * because the new name that has just won will be better
> -		 * for them as well, so name_rev() will replace these
> -		 * stale pointers when it processes the parents.
> -		 */
> -		if (!name->generation)
> -			free(name->tip_name);
> -	}
> +	if (is_valid_rev_name(name) &&
> +	    !is_better_name(name, taggerdate, generation, distance, from_tag))
> +		return NULL;
>
>  	name->taggerdate =3D taggerdate;
>  	name->generation =3D generation;

I haven't dug into whether it's a false positive, but with this change
GCC's -fanalyzer has started complaining about a potential NULL
dereference:

    builtin/name-rev.c:230:50: error: dereference of NULL =E2=80=98name=E2=
=80=99 [CWE-476] [-Werror=3Danalyzer-null-dereference]
      230 |                                 generation =3D name->generation=
 + 1;

This "fixes" it, and passes all tests, but presumably a better fix
involves the callers of get_commit_rev_name() (or that function itself)
deciding if they're OK with NULL here earlier?:
=09
	diff --git a/builtin/name-rev.c b/builtin/name-rev.c
	index 02ea9d16330..1d3a620ac72 100644
	--- a/builtin/name-rev.c
	+++ b/builtin/name-rev.c
	@@ -209,6 +209,7 @@ static void name_rev(struct commit *start_commit,
	 		struct rev_name *name =3D get_commit_rev_name(commit);
	 		struct commit_list *parents;
	 		int parent_number =3D 1;
	+		assert(name);
=09=20
	 		parents_to_queue_nr =3D 0;
=09=20
=09
