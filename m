Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618BC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4100B61374
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhHXVks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhHXVkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:40:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5FC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:40:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d11so47131979eja.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8nnWU3KXwzCQwkjnDzj+atl0+gMu7SGNoQYFnf2fKzU=;
        b=Q5JcX+IWCfueepIwHDiLT4I++7wNpN+/k07kwR1Gx+fc1hsObEJL3//IrFfB1xb9U+
         4gmIyas85ZM3kPOzv+Z14X5xGtW+VELoLnH4DDL3l5kv1S3/fbMujuhVKx6ajkMJfo78
         LPe9qrhPCNu8FYC+EWiHk+0vbYg66O42YqqpUCRw1cnTPUG+bl20AYR1zv52X2R4Lh3O
         ThmWf/PD/eq4O5vQMD8OMNB3KHVFwB69gVz055vpHAXOT93SLFJ5Q/w1GKXjaG9/DOQa
         7bsuxKrMdwwxZKPZmlM9l95Zya7xJrKlZ+gDR7VQmg12IY2Gg1uxRUCiB1dB/U7ZsxXo
         K4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8nnWU3KXwzCQwkjnDzj+atl0+gMu7SGNoQYFnf2fKzU=;
        b=ixwqfiHUCPGPHZLXyc8zmMImbEx91JnU8TLTkBShqvR+rcYER5l+9JMJOL+L+/sWYq
         3mSSnvqGQlyeh9PvT4K5ZjapDg4gRYaSMwPhWCT8LHOA87Jcxp8vE3r5uZuDdEVU6W97
         BOQrTv/w8uufQS5psSOXv5rj5NBP8hoax1AlXUfFeY27pUESkMHnQsJugNam399j8ecX
         CuEHNx5GSbSST1BzEB44S8AnLZ+Pb1GWJ2k/KFwV9yXNsUMUYco5rBpW/R54z9aG+cGZ
         +O9kuqH7Rz8aucszkQ+XebR1daWADxXPNmuTLzgyzI2xrFKZu6fsHQTvezQf8s7EDNr7
         Kbhw==
X-Gm-Message-State: AOAM531mEKznmpOAyQ6earOV/DSY3qWC/deiMYEREjTwQ5B6soWAipZJ
        UjUnQ+dyORzI8JIjj+gXVzc=
X-Google-Smtp-Source: ABdhPJxZNRyOiF2SFkvS1Hqd94ZBK8rGmHgVR2OFwDA8TkWcINla3JiWGr1RjbHfupSbA6VI7sfTFg==
X-Received: by 2002:a17:906:160a:: with SMTP id m10mr19676722ejd.67.1629841201282;
        Tue, 24 Aug 2021 14:40:01 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v8sm10173876ejy.79.2021.08.24.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:40:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] bundle: show progress on "unbundle"
Date:   Tue, 24 Aug 2021 23:39:31 +0200
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-4.4-e4ca8b26962-20210823T110136Z-avarab@gmail.com>
 <aacc0d53-6a95-b5f2-3098-94f6ffc8d2b2@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <aacc0d53-6a95-b5f2-3098-94f6ffc8d2b2@gmail.com>
Message-ID: <87czq2ed3j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Derrick Stolee wrote:

> On 8/23/2021 7:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The "unbundle" command added in 2e0afafebd8 (Add git-bundle: move
>> objects and references by archive, 2007-02-22) did not show progress
>> output, even though the underlying API learned how to show progress in
>> be042aff24c (Teach progress eye-candy to fetch_refs_from_bundle(),
>> 2011-09-18).
>>=20
>> Now we'll show "Unbundling objects" using the new --progress-title
>> option to "git index-pack", to go with its existing "Receiving
>> objects" and "Indexing objects" (which it shows when invoked with
>> "--stdin", and with a pack file, respectively).
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/bundle.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>=20
>> diff --git a/builtin/bundle.c b/builtin/bundle.c
>> index 10f6f45770a..f027cce3fef 100644
>> --- a/builtin/bundle.c
>> +++ b/builtin/bundle.c
>> @@ -162,7 +162,11 @@ static int cmd_bundle_unbundle(int argc, const char=
 **argv, const char *prefix)
>>  	struct bundle_header header =3D BUNDLE_HEADER_INIT;
>>  	int bundle_fd =3D -1;
>>  	int ret;
>> +	int progress =3D isatty(2);
>> +
>>  	struct option options[] =3D {
>> +		OPT_BOOL(0, "progress", &progress,
>> +			 N_("show progress meter")),
>
> We should probably update Documentation/git-bundle.txt, specifically
> the synopsis, which currently reads:
>
> 'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-p=
rogress-implied]
> 		    [--version=3D<version>] <file> <git-rev-list-args>
> 'git bundle' verify [-q | --quiet] <file>
> 'git bundle' list-heads <file> [<refname>...]
> 'git bundle' unbundle <file> [<refname>...]
>
> Add [--progress] to the unbundle line. The --progress option is
> documented further down in the file, although it is confusing
> where it applies.

Will fix...

> What about the --all-progress and --all-progress-implied options?
> Reading the docs, it seems that they won't apply to 'unbundle',
> but it doesn't hurt to ask.

...and clarify...

>> +
>> +	if (progress) {
>> +		strvec_push(&extra_args, "-v");
>> +		strvec_push(&extra_args, "--progress-title");
>> +		strvec_push(&extra_args, _("Unbundling objects"));
>
> If the previous patch changes to match the --progress-title=3DX
> pattern of the other options in index-pack, then these two lines
> will need to change, probably to a strvec_pushf().
>
>> +	}
>> +
>>  	ret =3D !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||
>
> Since this is the first real use of extra_args, as I mentioned
> before it would not be the end of the world to have extra_args
> appear for the first time within this patch.

Sure, will change it. I figured reducing the size of the subsequent
diffs would be better, but will just start by passing NULL.
