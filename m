Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A1C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiDFVcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiDFVce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:32:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9E2EC12A
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 13:39:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ot30so6608656ejb.12
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ps/VHp4eB4YYbVgSmCCkF+WdMH04PhDs3pujVpUwj0s=;
        b=d1XThKfS9c/6qhne2Fo/ob7tIzKA/sIuFuD6Q1U5DzQbMiee7NtTiME3ZvK9MohwPT
         ac2z4ZZ1B9+cXGTCyA0M6aRpS2XHDjDoPHS/kovFmZan3N+9kd8dxp9aWJgZ/03NT3dH
         qMsMXlIN3WP0lEWPMsg3Crmu/peNfa02ck7VUC0lyvE/M/mM30+1CQjEIjQBKGOWIbRK
         Dvvsdd9iDyw75hJy6jEROPLVYi07gyY0Oigp/LoKH+Zn8Vot1PKKZ4l/FX95yPvh5riT
         7fw3obWf1xjnHAV1kvJDNz9YRGLH9iOawOd8PKFm6rg7fqMDaOdGk+u48EK3yeCAXy5m
         10fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ps/VHp4eB4YYbVgSmCCkF+WdMH04PhDs3pujVpUwj0s=;
        b=c+qtbNqO3dc+9U7zcXcqg1zqVDjsIfpMTrb1wc9isiM1bN6okBXxTWNRlJVcjkt9w3
         gCKxYshjDun0l4wB8mmViRmpmfB3dbiZ6ABfsogYKotzn/8cCeqQc+kFOkewmqdzwamV
         QufUO01bV28tu91Sv2xFtb8qvwoEc5eQQ5sGcKsdKPPUXKsUj/bsjymug5IdDyYzqMFg
         v7KRHGmzYTW/b/A7/maOxL7njd2rh/6jYatYlToVZ2b5/C0madEYG8eICe8+bBT502jF
         IFjRWBuhD4PrHp6pZ+WvJmG7ib3dI9Td9SpWzAuwHJ5NMoD9uqjmo7QD2I1b8FyYZmeG
         6Kow==
X-Gm-Message-State: AOAM532vvLtcDOF0jmqe/i0r3xrHg2S9GoXgq56IgP6psuRuW4vOvMwG
        II7j4r6WV79A7HEnrQjunqw=
X-Google-Smtp-Source: ABdhPJwA0XdDpSG+VdHwRuMQb63qAu2v1w/aQ6/ds3/SsCaOe9/O43IsSQnH7+XIJ5X4k1vuI9dZYA==
X-Received: by 2002:a17:906:974a:b0:6e0:5d30:bef6 with SMTP id o10-20020a170906974a00b006e05d30bef6mr10018889ejy.207.1649277583833;
        Wed, 06 Apr 2022 13:39:43 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm8195194edz.29.2022.04.06.13.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:39:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncCRK-000jd5-28;
        Wed, 06 Apr 2022 22:39:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2] ls-tree: fix --long implying -r regression in
 9c4d58ff2c3
Date:   Wed, 06 Apr 2022 22:36:20 +0200
References: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
 <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
 <xmqqwng2xfi8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqwng2xfi8.fsf@gitster.g>
Message-ID: <220406.8635iqdjzl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 06 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Haing written them I guess we could do them post-release, since the
>> important thing is to validate the changes. As noted in the commit
>> message we're now testing all combinations of the "mode" and "format"
>> options.
>>
>>  builtin/ls-tree.c         |   2 +-
>>  t/t3104-ls-tree-format.sh | 126 +++++++++++++++++++++++++++++++++++---
>>  2 files changed, 119 insertions(+), 9 deletions(-)
>>
>> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
>> index 5dac9ee5b9d..e279be8bb63 100644
>> --- a/builtin/ls-tree.c
>> +++ b/builtin/ls-tree.c
>> @@ -255,7 +255,7 @@ static int show_tree_long(const struct object_id *oi=
d, struct strbuf *base,
>>  	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
>>  	       find_unique_abbrev(data.oid, abbrev), size_text);
>>  	show_tree_common_default_long(base, pathname, data.base->len);
>> -	return 1;
>> +	return recurse;
>>  }
>
> OK, two people by happenstance wrote the same fix is reassuring ;-)

*nod*

>> +	cat >expect &&
>> +	cat <&6 >expect.-d &&
>> +	cat <&7 >expect.-r &&
>> +	cat <&8 >expect.-t &&
>
> Let's not go too cute like this.  This forces the caller to remember
> which among 6, 7, and 8 corresponds to which option.  It is too ugly
> to live.

I think it's rather elegant actually, but to be fair it would, per:

	git grep '<&[1-9]| [1-9]<<-'

Be the user with the most FD's using this sort of pattern.

>>  test_ls_tree_format \
>>  	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
>> -	""
>> +	"" \
>> +	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
>> +	040000 tree $(git rev-parse HEAD:dir)	dir
>> +	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
>> +	OUT
>> +	040000 tree $(git rev-parse HEAD:dir)	dir
>> +	OUT_D
>> +	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
>> +	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
>> +	OUT_R
>> +	040000 tree $(git rev-parse HEAD:dir)	dir
>> +	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
>> +	OUT_T
>
> I do not actually mind if it were more like this:
>
> 	test_ls_tree_format \
> 		"%(objectmode) %(objecttype) %(objectname)%x09%(path)" <<-EXPECT
> 	git ls-tree HEAD
> 	040000 tree $(git rev-parse HEAD:dir)	dir
> 	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
> 	git ls-tree -d HEAD
> 	040000 tree $(git rev-parse HEAD:dir)	dir
> 	git ls-tree -r HEAD
> 	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
> 	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
> 	git ls-tree -t HEAD
> 	040000 tree $(git rev-parse HEAD:dir)	dir
> 	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
> 	EXPECT
>
> that is, we only read from the standard input, each section begins
> with "git ls-tree" command invocation that gets tested, followed by
> its expected output, and ends at either the end of the input or the
> beginning of the next section.

I don't see how needing to implementa while-loop parser for a custom
format just to get to the end-goal of having those things split up for
us is more elegant, when the shell can do that by splitting those up by
stream.

But if you insist on this being rewritten we could just unroll the loop,
and have each test_ls_tree_format specify the full option and one
standard input, but doing it in the function was a bit less verbosity.

Anyway, I see you replied on Josh's that you'd queue it, so it's unclear
to me if you'd like to pick this up with the version with the tests at
all, so I won't hack up a "v3" until that's clear...
