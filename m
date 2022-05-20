Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17601C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 15:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350960AbiETPl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350913AbiETPlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 11:41:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B463A1790AC
        for <git@vger.kernel.org>; Fri, 20 May 2022 08:41:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so15593151eje.2
        for <git@vger.kernel.org>; Fri, 20 May 2022 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cmUEMDqbAjWunm8+KV4OJJOuvJZvGWK4a/bMA3KaT0Q=;
        b=UvXisDMogI668RqKpWrDbln4A6FrY6EIWYky3s645C58asW7+x5L1E+Gns/IyzGNUh
         WLFvkp2s/2eLkHMOvo4AzDIS4JCq/0WW0jr8iMs4uYEL7+TyC7ZJ+6Gajjc+KiyewZMW
         oJfqylT7R8lka8JwnVIsifIbnksyryz7D9fNXi7nUmH53mPaJaJ7ziqHo/uCTdSge3p8
         OfIPrGGChOeAYtu/nZ5Y7hPDNbzic542seehKRxq8Z4c6NuofnTtO8/tnKnBnMX7PRC1
         pIXGiNaKfMUFftlRCqdg5McZsSoxOQU+4ZnsPthXct5DMss4z/CiXkKPIAGH91mHDx7C
         fW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cmUEMDqbAjWunm8+KV4OJJOuvJZvGWK4a/bMA3KaT0Q=;
        b=CBqTAJQ/orqdCw6MlOiyCKbrMVCRb1Z9aURB97PHIX1/L79OUKOP0Rs8U9DG87f2pp
         RuCY5EAzuLviAbP9OByeFQmkrpDLzOnQqUO9YXd7IiZQgZezEOApoWH5TtqnvJf6mrDz
         kTKMdO0WylHiS69DboZf/SRh/TK5/CycxbhhNebdJIPegiuzHK6kXxhuyrBGRm4RWpDM
         Dn2I3aJj2zL+YHO4Bws9PqtvlYSiO+7SaAigO0gBhQgn2+8wh3Ln4IrCDx+cwEE0zg6X
         GIiWjwiS4dKCJkQhF7jkUXcAU1CC6ei9muhfKAeSRXuQJThfgId9fNjB//fcsjdQPfPp
         WTaQ==
X-Gm-Message-State: AOAM533e82Se5xQOkr+bbwdFnaQPLxnEAjf9va56nbXpOzgxTdTcXau0
        yW3dhzEaodj1ZFC1w6mYULc=
X-Google-Smtp-Source: ABdhPJzyJaesAmVSAXC8Jsgb7xXr6FG2hnPkKB1iHet4Jm5rpKEcnqjW8NkUa4XxfsmtZxObC8h2yg==
X-Received: by 2002:a17:907:c24:b0:6f4:d6f2:9f6c with SMTP id ga36-20020a1709070c2400b006f4d6f29f6cmr8987645ejc.539.1653061306105;
        Fri, 20 May 2022 08:41:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jz17-20020a17090775f100b006f3ef214e68sm3202864ejc.206.2022.05.20.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:41:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ns4l6-002aBe-Bp;
        Fri, 20 May 2022 17:41:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Daniel Li <dan@danielyli.com>, git@vger.kernel.org
Subject: the state of diff_free() and release_revisions() (was: [PATCH] 2.36
 format-patch regression fix)
Date:   Fri, 20 May 2022 17:23:01 +0200
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
        <xmqqzgk388tt.fsf@gitster.g> <xmqqo80j87g0.fsf_-_@gitster.g>
        <c36896a1-6247-123b-4fa3-b7eb24af1897@web.de>
        <20220430163232.ytvwru4fnylow2jk@carlos-mbp.lan>
        <6af1aed1-ab13-ee0e-e979-d2f826ec776a@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6af1aed1-ab13-ee0e-e979-d2f826ec776a@web.de>
Message-ID: <220520.86pmk81a9z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 01 2022, Ren=C3=A9 Scharfe wrote:

> Am 30.04.22 um 18:32 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
>> On Sat, Apr 30, 2022 at 12:32:44PM +0200, Ren=C3=A9 Scharfe wrote:
>>> e900d494dc (diff: add an API for deferred freeing, 2021-02-11) added a
>>> way to allow reusing diffopts: the no_free bit.  244c27242f (diff.[ch]:
>>> have diff_free() call clear_pathspec(opts.pathspec), 2022-02-16) made
>>> that mechanism mandatory.
>>>
>>> git format-patch only sets no_free when --output is given, causing it to
>>> forget pathspecs after the first commit.  Set no_free unconditionally
>>> instead.
>>
>> I remember when I saw the first commit long ago, and thought; well that =
is
>> very round about way to reintroduce the UNLEAK removal that might have m=
ade
>> it visible.
>>
>> Haven't looked too closely, but considering that we were warned[1] the
>> interface was hard to use and might cause problems later and it did.
>>
>> wouldn't it a better and more secure solution to UNLEAK and remove all t=
his
>> code, at least until it could be refactored cleanly, of course?
>
> Silently self-destructing pathspecs are a safety hazard indeed.
>
> no_free also affects freeing ignore_regex and parseopts, and even
> closing the output file.  I don't know about the file, but leaking the
> first two is harmless.  So removing the flag is safe as long as we make
> sure the output file is closed as needed.
>
> A safe diff_free() would only be called a particular diffopt once, when
> it's no longer needed.  It could check for reuse by setting a flag the
> first time, like in the patch below.  1426 tests in 163 test scripts
> fail for me with it applied on top of the regression fixes from this
> thread.
>
> Removing the diff_free() calls from diff.c::diff_flush() and
> log-tree.c::log_tree_commit() reduces this to just one or two in t7527
> (seems to be flaky).  Perhaps this is still salvageable?

Thanks both for handling this, and sorry that I was away at the time.

AFAICT the current status in this area is that with 2cc712324d5 (Merge
branch 'rs/fast-export-pathspec-fix', 2022-05-04) and 5048b20d1c2 (Merge
branch 'rs/format-patch-pathspec-fix', 2022-05-04) merged the known bugs
related to this have been fixed, along with 3da993f2e63 (Merge branch
'jc/diff-tree-stdin-fix', 2022-04-28).

"This" being my e900d494dcf (diff: add an API for deferred freeing,
2021-02-11), and 244c27242f4 (diff.[ch]: have diff_free() call
clear_pathspec(opts.pathspec), 2022-02-16) for the diff-tree case.

Not coincidentally around the same time my ab/plug-leak-in-revisions got
un-marked for "next" from [1] to [2], and I'm looking for a path forward
for this whole thing...

1. https://lore.kernel.org/git/xmqqbkwyz78z.fsf@gitster.g/
2. https://lore.kernel.org/git/xmqqwnfcskw2.fsf@gitster.g/

>> [1] https://lore.kernel.org/git/YCUFNVj7qlt9wzlX@coredump.intra.peff.net/
>
>
> ---
>  diff.c | 3 +++
>  diff.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index ef7159968b..01296829b5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6458,10 +6458,13 @@ void diff_free(struct diff_options *options)
>  	if (options->no_free)
>  		return;
>
> +	if (options->is_dead)
> +		BUG("double diff_free() on %p", (void *)options);
>  	diff_free_file(options);
>  	diff_free_ignore_regex(options);
>  	clear_pathspec(&options->pathspec);
>  	FREE_AND_NULL(options->parseopts);
> +	options->is_dead =3D 1;
>  }
>
>  void diff_flush(struct diff_options *options)
> diff --git a/diff.h b/diff.h
> index 8ae18e5ab1..c31d32ba19 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -398,6 +398,7 @@ struct diff_options {
>  	struct strmap *additional_path_headers;
>
>  	int no_free;
> +	int is_dead;
>  };
>
>  unsigned diff_filter_bit(char status);

Yes, that's quite scary. It shows that in general diff_free() isn't
reentrant-safe, but that we do call it repeatedly again.

However if we patch it like this instead we can see that (gulp!) we just
barely putter along, according to our test coverage at least. I.e. we
don't end up calling the parts of it that would be unsafe to call again:
=09
	diff --git a/diff.c b/diff.c
	index ef7159968b6..0fe8bc5fade 100644
	--- a/diff.c
	+++ b/diff.c
	@@ -6438,14 +6438,23 @@ static void diff_flush_patch_all_file_pairs(struct=
 diff_options *o)
=09=20
	 static void diff_free_file(struct diff_options *options)
	 {
	-	if (options->close_file)
	+	if (options->close_file) {
	+		if (options->is_dead)
	+			BUG("double diff_free() on %p", (void *)options);
	 		fclose(options->file);
	+	}
	 }
=09=20
	 static void diff_free_ignore_regex(struct diff_options *options)
	 {
	 	int i;
=09=20
	+	if (!options->ignore_regex_nr && !options->ignore_regex)
	+		return;
	+
	+	if (options->is_dead)
	+		BUG("double diff_free() on %p", (void *)options);
	+
	 	for (i =3D 0; i < options->ignore_regex_nr; i++) {
	 		regfree(options->ignore_regex[i]);
	 		free(options->ignore_regex[i]);
	@@ -6462,6 +6471,7 @@ void diff_free(struct diff_options *options)
	 	diff_free_ignore_regex(options);
	 	clear_pathspec(&options->pathspec);
	 	FREE_AND_NULL(options->parseopts);
	+	options->is_dead =3D 1;
	 }
=09=20
	 void diff_flush(struct diff_options *options)
	@@ -6560,7 +6570,6 @@ void diff_flush(struct diff_options *options)
	 free_queue:
	 	free(q->queue);
	 	DIFF_QUEUE_CLEAR(q);
	-	diff_free(options);
=09=20
	 	/*
	 	 * Report the content-level differences with HAS_CHANGES;
	diff --git a/diff.h b/diff.h
	index 8ae18e5ab1e..c31d32ba192 100644
	--- a/diff.h
	+++ b/diff.h
	@@ -398,6 +398,7 @@ struct diff_options {
	 	struct strmap *additional_path_headers;
=09=20
	 	int no_free;
	+	int is_dead;
	 };
=09=20
	 unsigned diff_filter_bit(char status);

I'd really like to fix this properly, but AFAICT the best way to do that
is to:

 A. Get ab/plug-leak-in-revisions merged down
 B. Fix diff_free() on top of that

Before I knew of these bugs I'd already written patches to get rid of
that whole "no_free" business. In retrospect it was completely the wrong
thing to do, but in hindsight something like it was needed to fix those
leaks as long as we didn't have a revisions_release().

I.e. the tricky cases where I ended up needing to set "no_free" are ones
where all the complexity neatly goes away once we start releasing the
"struct rev_info" properly, as it contains the data we'd like to
diff_free() at the end.

How does that plan sound, and is there anything I've missed?

I could also re-roll ab/plug-leak-in-revisions to include a fix that
makes it safe in the interim, i.e.:

	diff --git a/diff.c b/diff.c
	index ef7159968b6..2bc7ee81e4e 100644
	--- a/diff.c
	+++ b/diff.c
	@@ -6438,8 +6438,12 @@ static void diff_flush_patch_all_file_pairs(struct =
diff_options *o)
=09=20
	 static void diff_free_file(struct diff_options *options)
	 {
	-	if (options->close_file)
	+	if (options->close_file) {
	 		fclose(options->file);
	+
	+		options->file =3D NULL;
	+		options->close_file =3D 0;
	+	}
	 }
=09=20
	 static void diff_free_ignore_regex(struct diff_options *options)
	@@ -6450,7 +6454,8 @@ static void diff_free_ignore_regex(struct diff_optio=
ns *options)
	 		regfree(options->ignore_regex[i]);
	 		free(options->ignore_regex[i]);
	 	}
	-	free(options->ignore_regex);
	+	options->ignore_regex_nr =3D 0;
	+	FREE_AND_NULL(options->ignore_regex);
	 }
=09=20
	 void diff_free(struct diff_options *options)

But as long as we're not adding new API users of it until the follow-up
after ab/plug-leak-in-revisions we should also be safe for now, but
perhaps it's prudent to do it anyway.

I *could* potentially produce a shorter series than
ab/plug-leak-in-revisions to narrowly try to remove "no_free" from
diff.c first, but it would basically need to first introduce a
release_revisions(), and without the other revisions API leaks being
fixed testing it would be much tricker. I'd really prefer not to do
that.

How does all that sound?
