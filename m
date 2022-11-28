Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EFC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 11:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiK1Lo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 06:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiK1Lo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 06:44:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9391013
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:44:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so25083675ejc.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 03:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3rd8+SEDV/FVye6ppItRck9NrwVpyr+p5FB8c/OdhY=;
        b=jhnNyOi81SHWu1Ym9i2sVZL+yoIXQDVrRprkF6H1K9EXM/3H+qTOOqzVBiywEV+m2W
         vVIJpr1wR7aqp6YKdnTxVOQBLOG4iRjBL6mWtmuuZNmrnIl5IQkOTs6nyu2R1qr2OzE3
         iJDgKaYV2ih5MD5ToJdxUcSUnjGcaHD6H8dYLuuoswva5eHBQdBx39qewfsoM/+D0+aU
         inLktfWnxMZ6jLRvsd+AOotP3I2owvuyi/ZW8KoFsSO2BSnjxneOArBqZUKua0zLkWzx
         cY0VZuIXOz/2sERAVWFxA8Tx7HrHdMctctRGpRauR5/rljlHhZUQBhT2SkoDFjXm4blI
         qtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3rd8+SEDV/FVye6ppItRck9NrwVpyr+p5FB8c/OdhY=;
        b=qjANK8vl4o0RTb7MjN7LukrYUBy7+7l6aIH5K/KyaTx0rmO8UF4f8MMpUT1bu7jH0G
         eWXpcijLZW2qrc1IEWozdWzrtFJnqHKzrC3cPHKmzCHvLy3jHyNTcwXltHnzTbLEkAK2
         5PRxy1hT+PxdgToq3dktXzVT+U5oEUBiTh7HdPAkDkkOYvPhpDT2jTYya6yXJ3E99hEK
         BAu9JWvhs5Y+EWnd1CWyIhQ5hhhfzFu4txY6T5RC8ogTd8C2hD8+1vsqonigXITkwMPc
         WsZPHV/a3WJaovP/+lfgY1VPyYtwyT3sbvn5xtBAv4qd43lwhlmOAJRx2iJlM/HU6amU
         amuA==
X-Gm-Message-State: ANoB5pnPJI7lrKKiNkTojFhcs/pLZPaaFfS6HHLAJEV0FPXTNyaRdMaC
        Zr2+1sx9ImGnWgGKyxqL8Ww=
X-Google-Smtp-Source: AA0mqf5SLZc3fPe7LDi51IgxKFd/tMwI7wNz9P79MYBAz6bGm954FlZ3QjlhkQF7nkE2BICKcpq8HQ==
X-Received: by 2002:a17:906:b2c6:b0:78d:20f7:1294 with SMTP id cf6-20020a170906b2c600b0078d20f71294mr44461316ejb.442.1669635863752;
        Mon, 28 Nov 2022 03:44:23 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b00463a83ce063sm5084327edv.96.2022.11.28.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:44:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozcYg-0010VU-2R;
        Mon, 28 Nov 2022 12:44:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 12:31:17 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
Message-ID: <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>
>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>> calling repo_init_revisions() only when the .filter member was actually
>>> needed, but then still leaking it.  That was fixed later by 2108fe4a19
>>> (revisions API users: add straightforward release_revisions(),
>>> 2022-04-13), making the reverted commit unnecessary.
>>
>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>> way.
>>
>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#step:=
5:3917
>>
>> Does anybody want to help looking into it?

[I see we crossed E-Mails]:
https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/

> The patch exposes that release_revisions() leaks the diffopt allocations
> as we're yet to address the TODO added by 54c8a7c379 (revisions API: add
> a TODO for diff_free(&revs->diffopt), 2022-04-14).

That's correct, and we have that leak in various places in our codebase,
but per the above side-thread I think this is primarily exposing that
we're setting up the "struct rev_info" with your change when we don't
need to. Why can't we just skip it?

Yeah, if we do set it up we'll run into an outstanding leak, and that
should also be fixed (I have some local patches...), but the other cases
I know of where we'll leak that data is where we're actually using the
"struct rev_info".

I haven't tried tearing your change apart to poke at it myself, and
maybe there's some really good reason for why you can't separate getting
rid of the J.5.7 dependency and removing the lazy-init.

> The patch below plugs it locally.
>
> --- >8 ---
> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revisions()
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/pack-objects.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 3e74fbb0cd..a47a3f0fba 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
>  	} else {
>  		get_object_list(&revs, rp.nr, rp.v);
>  	}
> +	diff_free(&revs.diffopt);
>  	release_revisions(&revs);
>  	cleanup_preferred_base();
>  	if (include_tag && nr_result)

So, the main motivation for the change was paranoia that a compiler or
platform might show up without J.5.7 support and that would bite us, but
we're now adding a double-free-in-waiting?

I think we're both a bit paranoid, but clearly have different
paranoia-priorities :)

If we do end up with some hack like this instead of fixing the
underlying problem I'd much prefer that such a hack just be an UNLEAK()
here.

I.e. we have a destructor for "revs.*" already, let's not bypass it and
start freeing things from under it, which will result in a double-free
if we forget this callsite once the TODO in 54c8a7c379 is addressed.

As you'd see if you made release_revisions() simply call
diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
cases.

I haven't dug into this one, but offhand I'm not confident in saying
that this isn't exposing us to some aspect of that gnarlyness (maybe
not, it's been a while since I looked).

(IIRC some of the most gnarly edge cases will only show up as CI
failures on Windows, to do with the ordering of when we'll fclose()
files hanging off that "diffopt").

