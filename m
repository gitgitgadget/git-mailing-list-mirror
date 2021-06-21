Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A561C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0510C60FE6
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFUUfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:35:28 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794CCC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:33:13 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z1so6571599ils.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vpCbuuT+XHSDysLOb5eTTICkPIII2yKCcvWZbFDnsM0=;
        b=OGs0vx/qtOcICVbgviI6XuoXC54MHSoyfdmf4o12VRUUyDY+lcF76m2nVSTG32CPx2
         CV51y6E6e5436j2NQ8PbiAWxx+iwt1BKEtYUkptznhS1MpYW5tuZAWieiDdzXYFyPCwv
         /Acpmu/+ZKlgCPFDgU8PxNdDVe53QYtVcXZuhNR1OrrGPn2byhCEtKON+2Jk5TBt1MGg
         ElfyLglYi0CF4Txxq+umXoHcg7z6UFiE1WlKcHJA37muXnXqauJUIAl10L06xK3WR1iY
         w/Ihml6i0b8C5BUf2v3CefENu8G4BzdNejld8pxd/dpCxF/RJMyDxTyAAl6eyJa8BoeN
         30/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vpCbuuT+XHSDysLOb5eTTICkPIII2yKCcvWZbFDnsM0=;
        b=BvNIUT9twlGrs47usNU3Wd3KkqDMBm9tq39QRewhuTBLTz2eQ+m/sRMJ+XpkEUai5G
         8N/8siI/KkbQ1dYwigYQRQkGNtFQDrU6QXtyW3eFEnGIdNmnljlrjZmbImh94B5+qxSe
         9C2kGsITlpbEAMk8zCGNHPTr4/slpKF+OZD92IHkyLT5S68WbO1txXmpYxTd+ZuCk+hR
         juDG6f00JCZAQUpsR25tH4C9qJmp6fSuFwjcqT/+825RVC75dZdJl5rFWdwr4rcK0yY6
         VA3PT0ww0Uh7UtPN9PV7/ORX1NOG3tQJ8IcwR9bmOqDYqmhLr6mPwoBME+Tdc5LvDqRH
         YPhw==
X-Gm-Message-State: AOAM530Q8qsE2/G8OWc71uTeDaR8xv6c5bfwJTCnuadUcTy7KiqKTE3c
        zLxyrf3sTMvNoqwITwunYuvhOQ==
X-Google-Smtp-Source: ABdhPJzi5t3U4gTba2x0++gIL9tEtEnKf0C10Z4OJlJs/eqdRWLYKg3E3aLIuvxxwWznRy1s/k5BTw==
X-Received: by 2002:a05:6e02:dc7:: with SMTP id l7mr68762ilj.40.1624307592905;
        Mon, 21 Jun 2021 13:33:12 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id w11sm6626902iow.15.2021.06.21.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:33:12 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:33:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix segfault in --stdin-packs option
Message-ID: <YND3h2l10PlnSNGJ@nand.local>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
 <patch-2.2-a9702132385-20210621T145819Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-a9702132385-20210621T145819Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 05:03:38PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a segfault in the --stdin-packs option added in
> 339bce27f4f (builtin/pack-objects.c: add '--stdin-packs' option,
> 2021-02-22). The read_packs_list_from_stdin() function didn't check
> that the lines it was reading were valid packs, and thus when doing
> the QSORT() with pack_mtime_cmp() we'd have a NULL "util" field.

It may be worth mentioning that the util pointer is used to associate
the names of included/excluded packs with the packed_git structs they
correspond to. I see it's mentioned in the very next paragraph, but it
may be helpful for other readers to see this information earlier.

> The logic error was in assuming that we could iterate all packs and
> annotate the excluded and included packs we got, as opposed to
> checking the lines we got on stdin. There was a check for excluded
> packs, but included packs were simply assumed to be valid.
>
> As noted in the test we'll not report the first bad line, but whatever
> line sorted first according to the string-list.c API. In this case I
> think that's fine.

Yeah. There isn't really a better way to do that since we don't have a
convenient function to look up packs by their name. Much more convenient
is to loop through all packs and assign them to entries in the
string_list one by one. That's O(n*log(n)), but it doesn't really matter
here since we expect n to be small-ish, and this is by far not the most
expensive part of writing a pack.

You could imagine doing something O(n^2) by looping through all packs
each time you receive a line of input. That performs worse, but arguably
provides a better experience when using this mode interactively. But
that is probably a relatively rare occurrence, so it likely doesn't
matter.

Equally, you could build a mapping from pack name to packed_git struct
ahead of time, and then do the lookups in constant time. That's linear,
of course, but you pay for it in memory. Honestly, the memory cost is
probably quite reasonable, but it may not be worth the effort, since I
suspect the vast majority of usage here is from 'git repack
--geometric'.


> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/pack-objects.c | 10 ++++++++++
>  t/t5300-pack-object.sh | 18 ++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index de00adbb9e0..65579e09fe0 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3310,6 +3310,16 @@ static void read_packs_list_from_stdin(void)
>  			item->util = p;
>  	}
>
> +	/*
> +	 * Arguments we got on stdin may not even be packs. Check that
> +	 * to avoid segfaulting later on in e.g. pack_mtime_cmp().
> +	 */

Could be worth adding "excluded packs are handled below".

> +	for_each_string_list_item(item, &include_packs) {
> +		struct packed_git *p = item->util;
> +		if (!p)
> +			die(_("could not find pack '%s'"), item->string);
> +	}
> +
>  	/*
>  	 * First handle all of the excluded packs, marking them as kept in-core

...and it may be worth updating this comment with s/First/Then.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 65e991e3706..330deec656b 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -119,6 +119,24 @@ test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
>  	test_cmp err.expect err.actual
>  '
>
> +test_expect_success 'pack-object <stdin parsing: --stdin-packs handles garbage' '
> +	cat >in <<-EOF &&
> +	$(git -C pack-object-stdin rev-parse one)
> +	$(git -C pack-object-stdin rev-parse two)
> +	EOF

It's not a big deal, but here-doc directly into `git pack-objects` is
much more common in t5300 than first redirecting it to a separate file.
I probably would have written (in a sub-shell to avoid -C
pack-object-stdin everywhere):


  cd pack-object-stdin &&
  test_must_fail git pack-objects --stdout --stdin-packs >/dev/null 2>actual <<-EOF
  $(git rev-parse one)
  $(git rev-parse two)
  EOF

Although the line is kind of long anyway (and it'd be even longer since
the subshell will get its own level of indentation). So I could entirely
buy that you did this for readability, which is fine by me.

> +
> +	# We actually just report the first bad line in strcmp()
> +	# order, it just so happens that we get the same result under
> +	# SHA-1 and SHA-256 here. It does not really matter that we
> +	# report the first bad item in this obscure case, so this
> +	# oddity of the test is OK.
> +	cat >err.expect <<-EOF &&
> +	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse two)'"'"'
> +	EOF
> +	test_must_fail git -C pack-object-stdin pack-objects stdin-with-stdin-option --stdin-packs <in 2>err.actual &&
> +	test_cmp err.expect err.actual

If we don't care which is reported (and it just so happens that we'll
get the first one in lexical order), I would be fine with

    test_i18ngrep "could not find pack" err.actual

too. It would be good to get rid of this comment and put it in the patch
message in more detail (instead of just referring to it as "[a]s noted
in the test".

Thanks,
Taylor
