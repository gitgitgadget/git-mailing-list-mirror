Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1887C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiDFMi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiDFMiO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:38:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EB05A3612
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:46:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a6so2891060ejk.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SfkGKH9w5FX7j8ZaKXuVF9iT7AEk2lYneIMCl1pVlQI=;
        b=hokiW5wFrNPB3GPj0ej87mZ2MB5BtHbb6SBlYlBpLh3D6S5BdoCBxaUhVmW38jzCER
         uRuPu8l7expBr7/cx7cGQMlmPmK6IKGh8XMqXWegkR8eICRh/f3ZxJg5eXIZdrXHmHdo
         TudktdKzcTH2o5Amsz4a0Mw0MbH8bj6AXC98N+k08Ml8S5czpkJHL3cM+TMPbg1j0uXT
         McZ0ubdyswvLdAUht3jL/FEMmBtgBOVtroPuivvW12CsvpvUy2/iC3kxNX3X86e6D90q
         /1f6ARbOAybg3bCQd7rNuqjytLGGgZahZmUJoiBkA9ldego0tKTAhLHYVy794ZPC4m81
         uLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SfkGKH9w5FX7j8ZaKXuVF9iT7AEk2lYneIMCl1pVlQI=;
        b=snJ2hcc5tMQ0D1to9nD6DyQWadDUpfASk0Rvvi5ww92ohlSqs2fWKi3BOP93xUlDc8
         Ofo+fn5AaEijm4oj2Uj+XZcYoxHQ3DwmL1w7lcF0mRRBUhxVzhh2p9MChlrbAkhZC/ag
         sKEBRVJRDhUK4lJJ7jQSLsjnm5acOYF9koUXEzs4nwKsqNP1IrnyQ5MOVz1du8PWGaUH
         yDQT8mGr3fBCDX+uImRwBgcH7uevSTzeLhZrtBXy5v5wKMIpK2PtY0KhptfyU2ygrkNu
         q2fU1kcpMzL9QWBjsi2pYelhcQt2bwbea9L6RMzxkRLUoZKPBlrcZ8Q7W3ssmrnFiFfC
         JvJQ==
X-Gm-Message-State: AOAM530X74NvqqSfRR659hp2VRrfxTxTq/T8nFQYBPPm72IDbmCQL746
        ZyaFI2EMHK8733jk9f3TGksc7F8GpoMUhw==
X-Google-Smtp-Source: ABdhPJyBHBrMgeS14ZQyBCL/T60GUYORT564rzhXYcTQJAmcS9KPFsBfZsJC4nWnhQgpIbu5cnLlOQ==
X-Received: by 2002:a17:907:d0d:b0:6e7:edb4:7af5 with SMTP id gn13-20020a1709070d0d00b006e7edb47af5mr7187447ejc.695.1649234779254;
        Wed, 06 Apr 2022 01:46:19 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402278c00b004195a50759fsm7597300ede.84.2022.04.06.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:46:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc1Iw-000aGz-9a;
        Wed, 06 Apr 2022 10:46:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3] blame: report correct number of lines in progress
 when using ranges
Date:   Wed, 06 Apr 2022 10:35:43 +0200
References: <20220405165806.842520-1-eantoranz@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405165806.842520-1-eantoranz@gmail.com>
Message-ID: <220406.86wng2eh0l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Edmundo Carmona Antoranz wrote:

Hint: use --in-reply-to on re-rolls, this is in reply to v2 here:
https://lore.kernel.org/git/20220404182129.33992-1-eantoranz@gmail.com/

Also the --range-diff option to git-format-patch is really helpful,
it'll make a diff between v2 and this v3 and attach it after "--".

Anyway...

> Note: Shamelessly copied show_cr from t0500-progress-display.sh
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>

Formatting: \n before the Signed-off-by.

> ---
>  builtin/blame.c     |  6 ++++-
>  t/annotate-tests.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 8d15b68afc..e33372c56b 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
>  	unsigned int range_i;
>  	long anchor;
>  	const int hexsz =3D the_hash_algo->hexsz;
> +	long num_lines =3D 0;
>=20=20
>  	setup_default_color_by_age();
>  	git_config(git_blame_config, &output_option);
> @@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const c=
har *prefix)
>  	for (range_i =3D ranges.nr; range_i > 0; --range_i) {
>  		const struct range *r =3D &ranges.ranges[range_i - 1];
>  		ent =3D blame_entry_prepend(ent, r->start, r->end, o);
> +		num_lines +=3D (r->end - r->start);
>  	}
> +	if (!num_lines)
> +		num_lines =3D sb.num_lines;
>=20=20
>  	o->suspects =3D ent;
>  	prio_queue_put(&sb.commits, o->commit);
> @@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const ch=
ar *prefix)
>  	sb.found_guilty_entry =3D &found_guilty_entry;
>  	sb.found_guilty_entry_data =3D &pi;
>  	if (show_progress)
> -		pi.progress =3D start_delayed_progress(_("Blaming lines"), sb.num_line=
s);
> +		pi.progress =3D start_delayed_progress(_("Blaming lines"), num_lines);
>=20=20
>  	assign_blame(&sb, opt);
>=20=20
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 09e86f9ba0..90932e304b 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -12,6 +12,10 @@ else
>    }
>  fi
>=20=20
> +show_cr () {
> +	tr '\015' Q | sed -e "s/Q/<CR>\\$LF/g"
> +}
> +
>  check_count () {
>  	head=3D &&
>  	file=3D'file' &&
> @@ -604,3 +608,52 @@ test_expect_success 'blame -L X,-N (non-numeric N)' '
>  test_expect_success 'blame -L ,^/RE/' '
>  	test_must_fail $PROG -L1,^/99/ file
>  '
> +
> +test_expect_success 'blame progress on a full file' '
> +	cat >expect <<-\EOF &&
> +	Blaming lines:  10% (1/10)<CR>
> +	Blaming lines:  50% (5/10)<CR>
> +	Blaming lines:  60% (6/10)<CR>
> +	Blaming lines:  90% (9/10)<CR>
> +	Blaming lines: 100% (10/10)<CR>
> +	Blaming lines: 100% (10/10), done.
> +	EOF
> +
> +	GIT_PROGRESS_DELAY=3D0 \
> +	git blame --progress hello.c 2>stderr &&
> +
> +	show_cr <stderr >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'blame progress on a single range' '
> +	cat >expect <<-\EOF &&
> +	Blaming lines:  25% (1/4)<CR>
> +	Blaming lines:  75% (3/4)<CR>
> +	Blaming lines: 100% (4/4)<CR>
> +	Blaming lines: 100% (4/4), done.
> +	EOF
> +
> +	GIT_PROGRESS_DELAY=3D0 \
> +	git blame --progress -L 3,6 hello.c 2>stderr &&
> +
> +	show_cr <stderr >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'blame progress on multiple ranges' '
> +	cat >expect <<-\EOF &&
> +	Blaming lines:  42% (3/7)<CR>
> +	Blaming lines:  57% (4/7)<CR>
> +	Blaming lines:  85% (6/7)<CR>
> +	Blaming lines: 100% (7/7)<CR>
> +	Blaming lines: 100% (7/7), done.
> +	EOF
> +
> +	GIT_PROGRESS_DELAY=3D0 \
> +	git blame --progress -L 3,6 -L 8,10 hello.c 2>stderr &&
> +
> +	cp stderr /home/antoranz/proyectos/git/git/stderr &&
> +	show_cr <stderr >actual &&
> +	test_cmp expect actual
> +'

We had a small thread that I notice now was off-list in reply to
https://lore.kernel.org/git/220405.86o81flve1.gmgdl@evledraar.gmail.com/. Q=
uoted
below. I assume that was both of our mistakes:

	On Tue, Apr 05 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
=09
	> On Tue, Apr 05 2022, Edmundo Carmona Antoranz wrote:
	>
	>> On Tue, Apr 5, 2022 at 11:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
	>> <avarab@gmail.com> wrote:
	>>>
	>>>
	>>> Let's use test_cmp here instead, as we expect nothing else on stderr,
	>>> and with grep one wonders why it's not ^$ anchored, but just:
	>>>
	>>>     echo "Blaming lines: 100% (6/6), done." >expect &&
	>>>     git blame ... 2>actual &&
	>>>     test_cmp expect actual
	>>>
	>>> is better, both because it's more exhaustive as a test, and because
	>>> it'll give better debug (diff) output on failure than grep will (just =
no
	>>> output at all).
	>>>
	>>
	>> The problem is that progress output is using CRs to write each line
	>> so, when checking the output, if you tried with ^$ with the last line,
	>> it wouldn't match anyway. I switched to match progress output as a
	>> whole using the same technique that is used in
	>> t0500-progress-display.sh.
	>>
	>> v3 is already out there.
	>
	> Ah yes, I forgot about that. Nevermind

I.e. the test_cmp here is now, given what you mentioned I'd have been
fine with the grep, but stealing the show_cr also works.

I suppose it's also abetter as a targeted fix, since the point of this
patch is specifically to fix a bug where we wouldn't do the right
"steps" in-between with the progress bar, in addition to the end-state
not being correct.

Are the small number of missing steps above expected? E.g. 1-2/7 and 5/7
in the last tets above, ditto the rest?

Mm, yes, looking at assign_blame() in blame.c we'll "skip" some.

So if we ever change that algorithm we'll need to adjust these, but it's
probably good to notice that then, even if the test_cmp here does
implicitly encode a bit of internal implementation details, i.e. when
exactly we update the progress bar.
