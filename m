Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF0AC433FE
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 12:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiANMHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiANMHk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 07:07:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF2C06173E
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:07:39 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so34175114edd.12
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kJH+9v+xJqoPxF6mMDd47TIjjdEO+vVZ79K0j7uyahc=;
        b=B9fyhBcIuhrAH60mlFiORecW3PaMMfll/wyUoNWJ41nZf61KI2PEwSF2AvMdgEuA03
         cnY69Nb0FmPIJTvHIhvTu33OrIyrePsGvRP6gaUb1Rh25jvJsw1kZPRpxHFGgfbpkHgF
         RMOOB6hLAr7Qmt6rucLJEo8lXGGcKKM+XGIndDUU+munxl+ZVp5MPtkKZWy4O9DI6EXq
         0AmOOBlwlMgUW/54ONWg1WAlkWXNsJzegr2RjA8hM0LEYwOpsH4ZT3fuXf2GX0LLKJV3
         5pEH9fO4RoCY4BIi5q+j2R7KcLDLrB0UkTMEn76c4xV4x8VSTSW38x2+w1VtMJpTK5Jx
         omNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kJH+9v+xJqoPxF6mMDd47TIjjdEO+vVZ79K0j7uyahc=;
        b=eblP/j+c66TY6vjY0u2qy6Ii61V7O0MbozqJ2WLFN+KdEi5HHmuLuzcNwdmMHgtgfK
         qxDM0/WkJeUMllcB94LLW9QJM4mv/f3t+8oS4h7tgPOZlr/A7rOjPSZ8Xl4gANcnlgb4
         7Yuszz/w7lcT3TsVFLQK55B7pHHppxahPmoc5/4+MggjEWoLMqF7TTx/rTXUBolEdJZz
         K9Mz5g9EJpAboThHy7gQw8dQeZr2Qeow/SHD8vLI3HRwb7TjcajqrD6weYtqpblIwRQ4
         m/ANUsScTFvFDbDTzQTXil56mb5f71gf0mkrO943C+AZdsKwoD5bUscqRn6qEqD4fCoX
         fqkA==
X-Gm-Message-State: AOAM532+bQjyeWNi/L0gkaiizWPOBO7wmqatljYoaFR2HePzuZLTU9iG
        0qCGzWlE6ebc82sxRt5NU7/pA1DjrwQ=
X-Google-Smtp-Source: ABdhPJziri7+iUbbYc5A5cAICi25Y4uTaJ/FIlkUXjfjw1QcUovRmobmjp12XuJEXTHAVawSx5SgjA==
X-Received: by 2002:a17:907:6e89:: with SMTP id sh9mr6988856ejc.309.1642162058130;
        Fri, 14 Jan 2022 04:07:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i14sm1806797ejw.111.2022.01.14.04.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:07:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8LMm-0015NW-VM;
        Fri, 14 Jan 2022 13:07:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 4/6] object-name: show date for ambiguous tag objects
Date:   Fri, 14 Jan 2022 13:05:45 +0100
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
 <patch-v7-4.6-2e5511c9fa5-20220111T130811Z-avarab@gmail.com>
 <xmqq1r1bgso2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1r1bgso2.fsf@gitster.g>
Message-ID: <220114.865yqmtt9z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  	} else if (type =3D=3D OBJ_TAG) {
>>  		struct tag *tag =3D lookup_tag(ds->repo, oid);
>>  		const char *tag_tag =3D "";
>> +		timestamp_t tag_date =3D 0;
>
> How about leaving these two uninitialized and introduce one extra
> bool,
> 		int tag_info_valid =3D 0;
>
> and then
>
>>=20=20
>> -		if (!parse_tag(tag) && tag->tag)
>> +		if (!parse_tag(tag) && tag->tag) {
>>  			tag_tag =3D tag->tag;
>> +			tag_date =3D tag->date;
>
> 			tag_info_valid =3D 1;
>
>> +		}
>>=20=20
>>  		/*
>>  		 * TRANSLATORS: This is a line of
>>  		 * ambiguous tag object output. E.g.:
>>  		 *
>> -		 *    "deadbeef tag Some Tag Message"
>> +		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
>>  		 *
>>  		 * The second argument is the "tag" string from
>>  		 * object.c.
>>  		 */
>> -		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
>> +		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
>> +			    show_date(tag_date, 0, DATE_MODE(SHORT)),
>> +			    tag_tag);
>
> Then this part can use tag_info_valid to conditionally use tag_date
> and tag_tag:
>
> 		if (tag_info_valid)
> 			strbuf_addf(&desc, ... <hash,date,tag>);
> 		else
> 			strbuf_addf(&desc, _("%s tag [bad]"), hash);
>
> without throwing a misleading "In 1970 this happened".

I still think the trade-off of not doing that discussed in the commit
message is better, i.e. (to quote upthread):
=20=20=20=20
    We could detect that and emit a "%s [bad tag object]" message (to go
    with the existing generic "%s [bad object]"), but I don't think it's
    worth the effort. Users are unlikely to ever run into cases where
    they've got a broken object that's also ambiguous, and in case they do
    output that's a bit nonsensical beats wasting translator time on this
    obscure edge case.
=20=20=20=20
    We should instead change parse_tag_buffer() to be more eager to emit
    an error() instead of silently aborting with "return -1;". In the case
    of "t3800-mktag.sh" it takes the "size < the_hash_algo->hexsz + 24"
    branch.

This really is so obscure that I don't think it warrants having N
translators re-translate this message users are very likely never to
see, ever.

And to the extent that they will see anything I've got some
planned/upcoming changes to make some of the underlying object machinery
emit better diagnostic messages on these bad objects, which would hint
in the general case about what's going wrong, instead of needing
ambiguous-object-display-specific messaging.
=20=20=20=20
>>  	} else if (type =3D=3D OBJ_TREE) {
>>  		/*
>>  		 * TRANSLATORS: This is a line of ambiguous <type>

