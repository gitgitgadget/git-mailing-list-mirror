Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFCC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 10:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJDKSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJDKSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 06:18:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141D32AAF
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 03:18:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w10so5288771edd.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=GcuTbKK1A8TO9bqkv2ypNpc9623lVvyeyd/1RAVAM/w=;
        b=QZhT5bBgiCLvZ8LKLeumWZuaQNyeToqzE4hmJMhujPko+gL48XMmrnl/4oIVVUDeWW
         I7oBIDeWDtdbVmtvgJQlD++GFCyTVa7PVTQe/gwOAoNCrx4rmyjEVivNryFTyV81K/9T
         qh/Zo0uhJcSqe9gzLr2c+AhLrHOjSgN2CpL0O53S0o9xFUd3IkNLMzrMjm1V4RGal2ZO
         9U1gLLqafe4XA3YzlrhzYzoZYUu4qcVuJeC2iAF4kVVShNeLw5T/KqY9ABSUxa74BTIT
         54SkBXMBVbzFPtTj77ey8stOQnm5VpEvvJOCFD8JAi0Lwc9AS1nitf0v/jNNt6Hg9/m2
         IB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GcuTbKK1A8TO9bqkv2ypNpc9623lVvyeyd/1RAVAM/w=;
        b=5880LqvhmI6EU0XIhhDaGMjl5tboXx4q8WiLxlxEXYz8SOn8xhsAtUA7F/sfpaOx9y
         OpncTDRnqzFwkE5L7Mr9X1IRCjbPWkz9y6WjXrA0QMdkeO3TxPj6GnehgNOGDPztqr6h
         +6eVfaRsqni27jjvN3dTSlVLDDef8N8TQk5aHstoUBo4NCDD/Yj5eqvcpVTdWYWwQGiB
         L1KzsYXMuo+5N8548etKaTXZHc7DquY4CvCVLaIxtQhr2tf7ytYxl3oRKohKQm72ceNH
         uInajDmzDpBJF1bjHg0Yhi/shJoQlbLVlbDdLY/qX7YUYqR0t2a6+GlJF7XxWcEgqx19
         z9Ig==
X-Gm-Message-State: ACrzQf3GWBRaGsZRlspTWV4VxXrGrHcfEefEYubFh/gqF8sn9CTkr/NJ
        Wfq6H0uXBIdqp3gqvDzPYcV1xeYpQ3w=
X-Google-Smtp-Source: AMsMyM4Ls6bpvG9/5jZFHgIzQd+bzbEFZftERFYWAiVQWRfhrDgWMQoqWsGTw9O7fNySHhVFl4wNUQ==
X-Received: by 2002:a05:6402:35ce:b0:458:f863:e5 with SMTP id z14-20020a05640235ce00b00458f86300e5mr8951007edc.415.1664878695462;
        Tue, 04 Oct 2022 03:18:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078080a97edbsm6765449ejg.111.2022.10.04.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:18:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1off09-002AW2-1q;
        Tue, 04 Oct 2022 12:18:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 21/36] doc txt & -h consistency: add missing options
 and labels
Date:   Tue, 04 Oct 2022 12:13:29 +0200
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
 <patch-v3-21.36-1713227d497-20220930T180415Z-avarab@gmail.com>
 <xmqqwn9j2xmu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqwn9j2xmu.fsf@gitster.g>
Message-ID: <221004.86bkqruc2i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 01 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> [...]
>> diff --git a/Documentation/git-update-server-info.txt b/Documentation/gi=
t-update-server-info.txt
>> index 969bb2e15f1..4e6bf44427f 100644
>> --- a/Documentation/git-update-server-info.txt
>> +++ b/Documentation/git-update-server-info.txt
>> @@ -9,7 +9,7 @@ git-update-server-info - Update auxiliary info file to h=
elp dumb servers
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git update-server-info'
>> +'git update-server-info' [-f | --force]
>>=20=20
>>  DESCRIPTION
>>  -----------
>> @@ -19,6 +19,12 @@ $GIT_OBJECT_DIRECTORY/info directories to help client=
s discover
>>  what references and packs the server has.  This command
>>  generates such auxiliary files.
>>=20=20
>> +OPTIONS
>> +-------
>> +-f::
>> +--force::
>> +	Allow adding otherwise ignored files.
>
> The option help text says this:
>
>     N_("update the info files from scratch"), 0),

That was a copy/paste error, thanks!

> [...]
>> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
>> index df44e5cc0d1..5d5ac038716 100644
>> --- a/builtin/ls-remote.c
>> +++ b/builtin/ls-remote.c
>> @@ -7,7 +7,7 @@
>>=20=20
>>  static const char * const ls_remote_usage[] =3D {
>>  	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]=
\n"
>> -	   "              [-q | --quiet] [--exit-code] [--get-url]\n"
>> +	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=3D<=
key>]\n"
>>  	   "              [--symref] [<repository> [<refs>...]]"),
>>  	NULL
>>  };
>
> OK.

I've triped to fix all the issues you noted above (including what I elided).

> We do not need to express that --sort=3D<key0> --sort=3D<key1>... can be
> given multiple times without triggering the usual last-one-wins?  In
> the documentation, the option description can say "this option can
> be given multiple times", but here we cannot, so the best we could
> do would be [--sort=3D<key>...] and I wonder if that is worth it.

Yes, FWIW I've left this at an explanation in the commit message. It
should be [(--sort=3D<key>)...], but also far git-branch.txt etc., but
fixing everything everywhere is a much bigger change.

>> diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
>> index cfbd5c36c76..27c2ca06acb 100644
>> --- a/builtin/pack-refs.c
>> +++ b/builtin/pack-refs.c
>> @@ -5,7 +5,7 @@
>>  #include "repository.h"
>>=20=20
>>  static char const * const pack_refs_usage[] =3D {
>> -	N_("git pack-refs [<options>]"),
>> +	N_("git pack-refs [--all] [--no-prune]"),
>>  	NULL
>>  };
>
> Even though "[--[no-]all] [--[no-]prune" would be more complete, I
> do not mind listing only the side that makes it behave differently
> from the default.  But if you reroll with a more complete version
> with documentation updates, I wouldn't complain at all.

For now I'm just trying to make commands consistent with their "other
side", but not all things consistent with all other things.

Having said that I really prefer when we have an "--all" as opposed to
"[--no-all | --all]", or the briefer "[--[no-]all]", it makes it clearer
that "--no-all" is the default, and that your "--all" is turning on the
non-default.

Likewise "--no-prune".

>>  static const char * const cherry_pick_usage[] =3D {
>> -	N_("git cherry-pick [<options>] <commit-ish>..."),
>> -	N_("git cherry-pick <subcommand>"),
>> +	N_("git cherry-pick [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff=
]\n"
>> +	   "                [-S[<keyid>]] <commit>..."),
>> +	N_("git cherry-pick (--continue | --skip | --abort | --quit)"),
>>  	NULL
>>  };
>
> And here we see "[--edit]", which is not exactly consistent.

*Nod*, but I'll leave this, per the "not trying to make all things
consistent with everything else", it's now consistent with its own
other side.

>> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
>> index 64962be0168..4c5d125fa0a 100644
>> --- a/builtin/send-pack.c
>> +++ b/builtin/send-pack.c
>> @@ -20,6 +20,7 @@ static const char * const send_pack_usage[] =3D {
>>  	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
>>  	   "              [--receive-pack=3D<git-receive-pack>]\n"
>>  	   "              [--verbose] [--thin] [--atomic]\n"
>> +	   "              [--[no-]signed | --signed=3D(true|false|if-asked)]\n"
>>  	   "              [<host>:]<directory> (--all | <ref>...)"),
>>  	NULL,
>>  };
>
> Excellent.
>
>> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
>> index 1b0f10225f0..50b6df78df0 100644
>> --- a/builtin/symbolic-ref.c
>> +++ b/builtin/symbolic-ref.c
>> @@ -5,8 +5,9 @@
>>  #include "parse-options.h"
>>=20=20
>>  static const char * const git_symbolic_ref_usage[] =3D {
>> -	N_("git symbolic-ref [<options>] <name> [<ref>]"),
>> -	N_("git symbolic-ref -d [-q] <name>"),
>> +	N_("git symbolic-ref [-m <reason>] <name> <ref>"),
>> +	N_("git symbolic-ref [-q] [--short] <name>"),
>> +	N_("git symbolic-ref --delete [-q] <name>"),
>>  	NULL
>>  };
>
> Why spell out --delete without allowing -d?  Especially when listing
> only -q for OPT__QUIET()?
>
>     git symbolic-ref (-d|--delete) [-q|--quiet] <name>
>
> would be more complete but I think the original (i.e. "-d [-q]") is
> more consistent.

I can do this if you'd like, but didn't per the above, i.e. the *.txt
uses just "symbolic-ref --delete".
