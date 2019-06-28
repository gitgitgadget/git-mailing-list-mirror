Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8741F4B6
	for <e@80x24.org>; Fri, 28 Jun 2019 07:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfF1HVX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 03:21:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33185 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1HVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 03:21:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so9732759edq.0
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wi9obPsY5dPxowkeTx+rTGnhwBUhYuS+FvWTA247lFk=;
        b=JYy10FTXz7wwuQnb/yOVhyjrsG03LblwK0W7u118yHY2Cb5rADk69hdERcUr6KVphv
         nyaLDfBK+vXlgpHn5WWbM8LHTtvDK5VTTuos9DO+6V0otA+tZ9rygb8uGHbhW5GpF61x
         Eu3EgILlzkdc3fSTo/huJsyY50EyNnrA0C04Jn0ddlXnAyL2m6tTUEtFZe9bxE1bof22
         qO6LAW/g2MG3kjG38oueFuP1YAL6GaPYmRSBoxuIGDOZ5xBia+S3hPHsZJpeXrUVzCtG
         WbiGBLih6ahdh418tG2vilvni1mGUMcaWlvgZffqDtJFi87Cg3wgDvbLJ+rM5W+3UeIu
         skJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wi9obPsY5dPxowkeTx+rTGnhwBUhYuS+FvWTA247lFk=;
        b=Ob0+UkgAxalp8h21FeEk56/Q2KqFl4P4y+gc0fTv2IO70NAheoi4m+18B05njo8MDC
         nrT5LRx1pPJDxDHLGNr6pZsxM9maGKxPNULWhRCpHkCnglZ9bMIKqE8rTXkU2tgy1sBk
         TOSbQoMMu0L1POWwkX04nwknzWrfl/bQKwAhtbiJPMtE62th7Nb00/Qp26VpBMV1OX5t
         VCOKhnfRH95J57apyKdCXvUlkA87sCkrC/LUdSfRMKkHWRdOBn1Bsdrf7B3Z9w8Xg0Wh
         NNI91dIQrjNlMbt+MEuXzZUOHw4j9SlwRNzj0f/FzDMuoY2PCqj8fSxcPNCv9s/jIwU4
         CEYA==
X-Gm-Message-State: APjAAAVGVaJBzJnMciksAgaVw/dAZCcqeupaAkCRtJBOw3IGea2Rn8Wv
        Kb8EbrlCrMa5HPeSoKCAjOH/ih11bmk=
X-Google-Smtp-Source: APXvYqxGla0EGSSYZWhutufmgQspUWadb9R1kRhLMRGs4JKIrs/5bHgMVPBs9hOHdnoLf/Jrhh6SpQ==
X-Received: by 2002:a17:906:fac7:: with SMTP id lu7mr7066978ejb.109.1561706480274;
        Fri, 28 Jun 2019 00:21:20 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id d44sm434767eda.75.2019.06.28.00.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 00:21:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Janos Farkas <chexum@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] repack: disable bitmaps-by-default if .keep files exist
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com> <875zow8i85.fsf@evledraar.gmail.com> <20190623180226.GA1100@sigill.intra.peff.net> <20190623180825.3ospajjgat3clwiu@dcvr> <20190623224244.GB1100@sigill.intra.peff.net> <20190628070211.hfweqcons6c6gy52@dcvr>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190628070211.hfweqcons6c6gy52@dcvr>
Date:   Fri, 28 Jun 2019 09:21:18 +0200
Message-ID: <87zhm26uq9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 28 2019, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
>> On Sun, Jun 23, 2019 at 06:08:25PM +0000, Eric Wong wrote:
>>
>> > > I'm not sure of the right solution. For maximal backwards-compatibility,
>> > > the default for bitmaps could become "if not bare and if there are no
>> > > .keep files". But that would mean bitmaps sometimes not getting
>> > > generated because of the problems that ee34a2bead was trying to solve.
>> > >
>> > > That's probably OK, though; you can always flip the bitmap config to
>> > > "true" yourself if you _must_ have bitmaps.
>> >
>> > What about something like this?  Needs tests but I need to leave, now.
>>
>> Yeah, I think that's the right direction.
>
> OK.  I have a real patch with one additional test, below.
> (don't have a lot of time for hacking)
>
>> Though...
>>
>> > +static int has_pack_keep_file(void)
>> > +{
>> > +	DIR *dir;
>> > +	struct dirent *e;
>> > +	int found = 0;
>> > +
>> > +	if (!(dir = opendir(packdir)))
>> > +		return found;
>> > +
>> > +	while ((e = readdir(dir)) != NULL) {
>> > +		if (ends_with(e->d_name, ".keep")) {
>> > +			found = 1;
>> > +			break;
>> > +		}
>> > +	}
>> > +	closedir(dir);
>> > +	return found;
>> > +}
>>
>> I think this can be replaced with just checking p->pack_keep for each
>> item in the packed_git list.
>
> Good point, I tend to forget git C API internals as soon as I
> learn them :x
>
>> That's racy, but then so is your code here, since it's really the child
>> pack-objects which is going to deal with the .keep. I don't think we
>> need to care much about the race, though. Either:
>
> Agreed.  <snip>
>
> --------8<-------
> Subject: [PATCH] repack: disable bitmaps-by-default if .keep files exist
>
> Bitmaps aren't useful with multiple packs, and users with
> .keep files ended up with redundant packs when bitmaps
> got enabled by default in bare repos.
>
> So detect when .keep files exist and stop enabling bitmaps
> by default in that case.
>
> Wasteful (but otherwise harmless) race conditions with .keep files
> documented by Jeff King still apply and there's a chance we'd
> still end up with redundant data on the FS:
>
>   https://public-inbox.org/git/20190623224244.GB1100@sigill.intra.peff.net/
>
> Fixes: 36eba0323d3288a8 ("repack: enable bitmaps by default on bare repos")
> Signed-off-by: Eric Wong <e@80x24.org>
> Helped-by: Jeff King <peff@peff.net>
> Reported-by: Janos Farkas <chexum@gmail.com>
> ---
>  builtin/repack.c  | 18 ++++++++++++++++--
>  t/t7700-repack.sh | 10 ++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index caca113927..a9529d1afc 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -89,6 +89,17 @@ static void remove_pack_on_signal(int signo)
>  	raise(signo);
>  }
>
> +static int has_pack_keep_file(void)
> +{
> +	struct packed_git *p;
> +
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
> +		if (p->pack_keep)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Adds all packs hex strings to the fname list, which do not
>   * have a corresponding .keep file. These packs are not to
> @@ -343,9 +354,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>  		die(_("--keep-unreachable and -A are incompatible"));
>
> -	if (write_bitmaps < 0)
> +	if (write_bitmaps < 0) {
>  		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
> -				 is_bare_repository();
> +				 is_bare_repository() &&
> +				 keep_pack_list.nr == 0 &&
> +				 !has_pack_keep_file();
> +	}
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects = write_bitmaps;
>
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 86d05160a3..0acde3b1f8 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -239,4 +239,14 @@ test_expect_success 'bitmaps can be disabled on bare repos' '
>  	test -z "$bitmap"
>  '

I have the feedback I posted before this patch in
https://public-inbox.org/git/874l4f8h4c.fsf@evledraar.gmail.com/

In particular "b" there since "a" is clearly more work. I.e. shouldn't
we at least in interactive mode on a "gc" print something about skipping
what we'd otherwise do.

Maybe that's tricky with the gc.log functionality, but I think we should
at least document this before the next guy shows up with "sometimes my
.bitmap files aren't generated...".


> +test_expect_success 'no bitmaps created if .keep files present' '
> +	pack=$(ls bare.git/objects/pack/*.pack) &&
> +	test_path_is_file "$pack" &&
> +	keep=${pack%.pack}.keep &&
> +	>"$keep" &&
> +	git -C bare.git repack -ad &&
> +	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
> +	test -z "$bitmap"

Maybe more readable as:

	find .git/objects/pack/ -type f -name '*.bitmap' >actual &&
	test_must_be_empty actual

I.e. it avoids the "|| :" & subshell.

> +'
> +
>  test_done
