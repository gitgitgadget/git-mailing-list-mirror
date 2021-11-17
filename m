Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8104C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB31161BD3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhKQJWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhKQJWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:22:18 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51204C06122B
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:19:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z10so7867637edc.11
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UujPdjTaBZIJg7coPoHOdodt67RTgM4WXs8y3HNy8JQ=;
        b=Eez05XgAfAOlF++9PqpF3ozJGfgRFAeGBVt6TE/Ypxq1JuT/I7jltitSdxdpXlZA8y
         afX19dLA2Zvx0LXoq60RkQ+gr/v0jy2UAqWUE5c11d4fQgoB/LBiHe33N4oKrG+Na2ma
         HK67HYX1tgAzYh8/T0IYhDsLOPpW3uLAFnzCIpToVj+7gx3+zSF8lGnzqnNaQTnHOzMJ
         frxM+5AnVxD3psKI+j054bQ9qVLSl0+ulW2LJGmPg5f2DuCEPuPubKEknkI3XB9oCBuC
         9NpvCilxSyr/djyqc7TE8UcSQm1bV6U9klNxTcMLyy1R4PPajpyeGHr5iAAErp9PyMM6
         GMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UujPdjTaBZIJg7coPoHOdodt67RTgM4WXs8y3HNy8JQ=;
        b=H2S9lzo/3bW3/H2XcUV6CpeQrPdAfgfoTdV3Pfv15zj3WBQBK6cjcsHCz9tHVJVsPO
         AxjRnleSDkwyehdUNErglzR1kBeUCtMBb5mqCFWBh2bpQCGgYTItIuVfgEaObagfn4Cq
         8eO1X9G3QuVScOglAtxEEH23dp7cn/yKWhw7N2nc2hhhcCcOzQl83RQVSqODeN08NvAN
         paC4rBtfagb8JtDbCKs4vc+cvexekZTiCwJ48F4IgrLAPjOO/wkVogkIsz2fu4tnRmO8
         MSCGbq7dyBNeOLisInp/voxPUmoKVm1no7E6yIHRneunV9lmgoPC1DMF1WRX2+PSHCFP
         10ZA==
X-Gm-Message-State: AOAM5322qaOgL6K9cYsBHsSqAcFg1MIZxiYfg/HRHo/erEYzUTg5HQas
        cY3/93CN7KQkT84/dnBgPNzK37+fIC3Dhg==
X-Google-Smtp-Source: ABdhPJyJU5r6ZEgqmw5Vm7jk4VAcrggl47gw5B/eJXAPZmjTxT1+pmAEXykPEXAtKr8S5z3EnAUhJQ==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr19430525eds.386.1637140743711;
        Wed, 17 Nov 2021 01:19:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z25sm9141570ejd.80.2021.11.17.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:19:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnH5q-0004R2-Ms;
        Wed, 17 Nov 2021 10:19:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Generate temporary files using a CSPRNG
Date:   Wed, 17 Nov 2021 09:36:43 +0100
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <211116.864k8bq0xm.gmgdl@evledraar.gmail.com>
 <YZQdRC9nAA/CbMyM@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZQdRC9nAA/CbMyM@coredump.intra.peff.net>
Message-ID: <211117.86a6i387i1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Jeff King wrote:

> On Tue, Nov 16, 2021 at 09:35:59PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I tried testing this codepath real quick now with:
>>=20=20=20=20=20
>>     diff --git a/wrapper.c b/wrapper.c
>>     index 36e12119d76..2f3755886fb 100644
>>     --- a/wrapper.c
>>     +++ b/wrapper.c
>>     @@ -497,6 +497,7 @@ int git_mkstemps_mode(char *pattern, int suffix_=
len, int mode)
>>                             v /=3D num_letters;
>>                     }
>>=20=20=20=20=20=20
>>     +               BUG("%s", pattern);
>>                     fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode=
);
>>                     if (fd >=3D 0)
>>                             return fd;
>>=20=20=20=20=20
>> And then doing:
>>=20
>>     grep BUG test-results/*.out
>>=20
>> And the resulting output is all of the form:
>>=20
>>     .git/objects/9f/tmp_obj_FOzEcZ
>>     .git/objects/pack/tmp_pack_fJC0RI
>>=20
>> And a couple of:
>>=20
>>     .git/info/refs_Lctaew
>>=20
>> I.e. these are all cases where we're creating in-repo tempfiles, we're
>> not racing someone in /tmp/ for these, except perhaps in some cases I've
>> missed (but you allude to) where we presumably should just move those
>> into .git/tmp/, at least by default.
>
> Your patch is way too aggressive. By bailing via BUG(), most commands
> will fail, so we never get to the interesting ones (e.g., we would not
> ever get to the point of writing out a tag signature for gpg to verify,
> because we'd barf when trying to create the tag in the first place).
>
> Try:
>
> diff --git a/wrapper.c b/wrapper.c
> index 36e12119d7..5218a4b3bd 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -497,6 +497,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len,=
 int mode)
>  			v /=3D num_letters;
>  		}
>=20=20
> +		{
> +			static struct trace_key t =3D TRACE_KEY_INIT(TEMPFILE);
> +			trace_printf_key(&t, "%s", pattern);
> +		}
>  		fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>  		if (fd >=3D 0)
>  			return fd;
>
> And then:
>
>   GIT_TRACE_TEMPFILE=3D/tmp/foo make test
>   grep ^/tmp /tmp/foo | wc -l
>
> turns up hundreds of hits.

Thanks, there's a long tail of these, but I came up with this crappy
one-liner one regex at a time while looking at it:

    cat /tmp/git_mkstemps_mode.trace | perl -pe 's[/[0-9a-f]{2}/][/HH/]; s[=
/incoming-\K[^/]+][XXX]; s[/tmp/\K[^_]+][XXX]; s/tmp_(idx|obj|pack)_\K[a-zA=
-Z0-9]+$/XXX/; s[/objects/\
K../][$1??/]g; s[^/run/user.*/objects/][<systemd run/user>/objects/]; s[(vt=
ag_tmp|pack_|refs_)\K.*][XXX]; '|sort|uniq -c|sort -nr|less

Which gives us:

    893 .git/objects/pack/tmp_pack_XXX
    836 ./objects/??/tmp_obj_XXX
    722 .git/objects/pack/tmp_idx_XXX
    401 <systemd run/user>/objects/incoming-XXX/HH/tmp_obj_XXX
    366 /run/user/1001/tmp/XXX_pack_XXX
    289 <systemd run/user>/objects/??/tmp_obj_XXX
    261 .git/info/refs_XXX
    258 /tmp/XXX_vtag_tmpXXX
    185 clone.git/objects/??/tmp_obj_XXX
     77 /tmp/XXX_file
     72 marks-test/.git/objects/??/tmp_obj_XXX
     71 <systemd run/user>/objects/pack/tmp_pack_XXX
     69 <systemd run/user>/objects/pack/tmp_idx_XXX
     34 objects/pack/tmp_pack_XXX
     34 objects/pack/tmp_idx_XXX
     25 /run/user/1001/tmp/XXX.git/objects/??/tmp_obj_XXX
     20 info/refs_XXX
     12 /tmp/XXX_text
     12 foo.git/objects/??/tmp_obj_XXX

I.e. this is stuff that's either already in .git, or a small handful of
special-cases such as "git verify-tag".

>> If there are cases where we actually need this hardening because we're
>> writing in a shared /tmp/ and not .git/, then surely we're better having
>> those API users call a differently named function, or to move those
>> users to using a .git/tmp/ unless they configure things otherwise?
>
> Assuming you can write to .git/tmp means that conceptually read-only
> operations (like verifying tags) require write access to the repository.

That leaves the "differently named function" which I think we should
really do in either case.

I.e. if I'm verifying lots of tags then I'm better off on a modern
systemd system using /run/user/`id -u`, as opposed to /tmp/ which is
often disk-backed. So being aware of $XDG_RUNTIME_DIR seems like a
sensible thing in either case.

And on those systems the DoS aspect of this becomes a non-issue, that
directory is only writable by one (non-super)user.

I think there's a big advantage to having any tricky CSPRNG-implementing
code in its own corner like that.

It means that e.g. if gpg learns some mode to do this that doesn't
require tempfiles, and we're confident we don't create things in /tmp
otherwise that we could drop it, or users who don't want git shipping a
CSPRNG can compile it out.

But I really don't see why it isn't an acceptable solution for git to
just die here if we fail to create the Nth tempfile in a row.

Or something simpler like having the "git verify-tag" code fall back to
writing in say $HOME/.cache/git, which is another simple way to avoid
the issue entirely in most cases.
