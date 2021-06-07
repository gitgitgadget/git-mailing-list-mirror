Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D51C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD735610FB
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGN6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGN6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 09:58:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5576C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 06:56:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so20479851edc.7
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=G60BTV2WZ30PbqJ/pb4wKnJyjOi1k/WGD7dRG6mPD7Q=;
        b=PkLQqTgRPIcvK3uPrGQkGJkWJ2Nd0+n9t9gptSr68QgzUhDdvbWH+9agF/H2urZ9Pg
         0z2/WQcw0l3fqkp5TB7GDzsdfUnSdKofuzsHg0ApFyaNwtQHoJWgus0zEFWROtQQTIuM
         AvbXSOWvFatPBMZp9bWqIRvKPOPn0aYsJlDn8M4WE8e2bhZthU1vvZNRosfW6GnwZeaW
         Zi0xEZsMfc5oljRE4P7uyE5rtkUdbKbYmSRvN69L+2rhP9M0EXDo7wx7YvZH9pzHdeA9
         dOmJJ2MmkoZUwniT2gZw5gx+EPHwlnW5gTdFBX9JFiMmnzj6V6AUZ/waGSZl9Ph1ksNl
         P9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=G60BTV2WZ30PbqJ/pb4wKnJyjOi1k/WGD7dRG6mPD7Q=;
        b=IpPVuqb/7w2xDnP3yIGbfoUqR0OygS8qFG1YJjv2ywTWbN8CyN5y/2ff0pHgJrrDGH
         MaX/z0ePqcMK0Ssw12+dTFiCSD/ZrRFhZRak5ElSzaK2AX2OdjHaHh0MdbRR8QLpVSBq
         Q8pvQmaMm1rDQe8OZDIyw9r2mGozaQ81SHpCvHEe7e4gE+kzUjFtDLU4RwgehBH3VIAV
         IJEsZ4hMCDybr2oOSfKvrHisExtTSZIDZb9cKtUnX1pfeQq25VNjGyG3HooBxFs9ikj0
         yr6VIUS3zHUVbXbySHX1wPNaGVn1/NURxnWYzyXivUyY2FD6O83GVRHngtotPsCKyUtU
         aSiA==
X-Gm-Message-State: AOAM531nJxNuoOFD60c/mdIhTAfBW/jZryGoMPzcCRheYQ2+nYFg4kqu
        kZHTs5J4hBWzPlTftTMjZ8RitpH4SxXcEA==
X-Google-Smtp-Source: ABdhPJxUm3enpicXt/PAYaiLqvNN/7QWJkHpa6y6xXonA2fv4gEhDh2S4mZdJCsehW9cBBbrq9xtFA==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr20243172edu.370.1623074181230;
        Mon, 07 Jun 2021 06:56:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n1sm2249802edt.1.2021.06.07.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 06:56:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rerere: enable by default
Date:   Mon, 07 Jun 2021 14:56:08 +0200
References: <xmqqfsxvxjj2.fsf@gitster.g>
 <877dj654or.fsf@evledraar.gmail.com> <xmqqpmwyue8q.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqpmwyue8q.fsf@gitster.g>
Message-ID: <87v96p4w3f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Jun 06 2021, Junio C Hamano wrote:
>>
>>> By default, the rerere machinery has been disabled since a bug in
>>> the machinery could screw up the end user's data at the most
>>> stressful time during the end user's workday (i.e. during conflict
>>> resolution).
>>
>> What was that bug & in what commit was it fixed? Makes sense to note
>> that here.
>
> There is no such bug ;-).
>
> Writing buggy code, not thinking about it carefully enough and
> jumping up and down yelling this shiny new toy must be merged down
> immediately is something we see on this list from others, but it is
> the total opposite of how I operate.  I just am extra cautious and
> even after I am reasonably sure the code would not break, I prefer
> to have volunteers to opt into testing.

Thanks. I misread that, and was (perhaps mis-)remembering the previous
thread about this discussing some past bugs...

>> 	@@ -130,7 +129,6 @@ test_expect_success 'unmerge with plumbing' '
>> 	 test_expect_success 'rerere and rerere forget' '
>> 	 	# from here on, use rerere.
>> 	 	git config rerere.enabled true &&
>> 	-	mkdir .git/rr-cache &&
>> 	 	prime_resolve_undo &&
>> 	 	echo record the resolution &&
>> 	 	git rerere &&
>>
>> So the only impact of that rerere.enabled=3Dfalse early is to make sure
>> we're not creating the .git/rr-cache.
>
> Not really.  Unresolve is about recording the initial conflict in
> the index, so it is far easier to see its effect if you do not
> enable rerere, when you are manually debugging these earlier tests.
>
> And later test do check how it works with rerere enabled, but the
> way the original sequence of tests enable it is with the "mkdir".
> I.e. "if rerere.enabled is not set either way, presence of the
> directory means it is already enabled".  The new test sequence
> uses the configuration variable explicitly, because in the new world
> order, the presence of the directory does not mean a thing.

I mean you added "from here on, use rerere", but if I instrument the
tests to set rerere.enabled=3Dfalse they also pass, sans the .git/rr-cache
directory being created.

So we weren't "using rerere", we were just writing the data on the side.

We *do* get a failure in test #3, "rm records reset clears", if we set
rerere.autoUpdate=3Dtrue. So it seems to me that what those first tests
would benefit more from not having the addition of your
rerere.enabled=3Dfalse line early on.

After all it's more interesting to test that the merge resolution is not
different in any way under rerere.enabled=3Dtrue & rerere.autoUpdate=3Dfalse
than to not write the rr-cache data at all. It seems like having just
one test with rerere.enabled=3Dfalse & "I did not write .git/rr-cache"
would make for better coverage.

I.e. this on top works:
=09
	diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
	index 8c571ddf92..b010f504b0 100755
	--- a/t/t2030-unresolve-info.sh
	+++ b/t/t2030-unresolve-info.sh
	@@ -46,11 +46,12 @@ prime_resolve_undo () {
	 }
=09=20
	 test_expect_success setup '
	-	git config rerere.enabled false &&
	 	mkdir fi &&
	 	printf "a\0a" >binary &&
	 	git add binary &&
	+	! test_path_is_dir .git/rr-cache &&
	 	test_commit initial fi/le first &&
	+	test_path_is_dir .git/rr-cache &&
	 	git branch side &&
	 	git branch another &&
	 	printf "a\0b" >binary &&
	@@ -128,9 +129,6 @@ test_expect_success 'unmerge with plumbing' '
	 '
=09=20
	 test_expect_success 'rerere and rerere forget' '
	-	# from here on, use rerere.
	-	git config rerere.enabled true &&
	-	mkdir .git/rr-cache &&
	 	prime_resolve_undo &&
	 	echo record the resolution &&
	 	git rerere &&
	@@ -156,7 +154,6 @@ test_expect_success 'rerere and rerere forget' '
=09=20
	 test_expect_success 'rerere and rerere forget (subdirectory)' '
	 	rm -fr .git/rr-cache &&
	-	mkdir .git/rr-cache &&
	 	prime_resolve_undo &&
	 	echo record the resolution &&
	 	(cd fi && git rerere) &&

As an aside when testing this I found that I could make it segfault by
not doing the mkdir() in setup_rerere() and without:

	diff --git a/rerere.c b/rerere.c
	index 83e740d730..06fb86d5b7 100644
	--- a/rerere.c
	+++ b/rerere.c
	@@ -731,7 +731,10 @@ static void do_rerere_one_path(struct index_state *is=
tate,
	 	/* Has the user resolved it already? */
	 	if (variant >=3D 0) {
	 		if (!handle_file(istate, path, NULL, NULL)) {
	-			copy_file(rerere_path(id, "postimage"), path, 0666);
	+			const char *dst =3D rerere_path(id, "postimage");
	+			if (copy_file(dst, path, 0666))
	+				die_errno(_("could not copy '%s' to '%s'"),
	+					  path, dst);
	 			id->collection->status[variant] |=3D RR_HAS_POSTIMAGE;
	 			fprintf_ln(stderr, _("Recorded resolution for '%s'."), path);
	 			free_rerere_id(rr_item);
=09

I.e. we make the hard assumption that the directory has been created,
and don't check the return value(s) of various subsequent file copying
etc. So there's a rare segfault in the wild if the "setup_rerere()"
races with something that removes the .git/rr-cache (perhaps git-gc will
remove it entirely?).
