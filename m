Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E7C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiGKUMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKUMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 16:12:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD6D357ED
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:12:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so7626147edc.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AeKBajSxQFitb6tgqNX7891RZcF1x0eVzeU1Zzgwc8k=;
        b=kS66WUTyesE8UZLwHiyS7IWKdh97HdtJ4ephC8yrZiqfly7uANLdrz+Y9M/+VNba6/
         q8VATxW/tf8yqCHkMjesdapRifPP9Zm0qGYLSf/8yDdO6pUOjfBgTullM6ypTqjEHwXK
         pMeqalRbIw4JV9nzpEDevR7eel+hUSLmJxEjz0LSsnJ9ZIBdeCVVo0+zpqwrA1X/Y8AE
         3ZTkVv/+60qIxo58Nkh+M7sAfJcrinMISRRFrQQVkm8F3iM4JjBAxz+Q2aK4fHEP5yDK
         oNDHI9OPGIXVVwP6VJ1WLWEJn9l7VV3uwJu+XMQaWPnkdC7K3ZigZH9j9x/43A4nzEFk
         RttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AeKBajSxQFitb6tgqNX7891RZcF1x0eVzeU1Zzgwc8k=;
        b=GgS4vWUtdrMixEVyn0fElQCpVRzuLQZsotPOBvpasYOcteVsqGNXxIV9PmSEe0yW3d
         CJY7eJ7b+fjWP4HOJPVvADOSwLmzqIG5vmvw2w8Xjeeu45SXafxLT05APbxd22z+91qe
         2CtET/JoGIFVTMZXxYlKCL+WLCsY4V2YuoOt770mJs0TbzJ5vO/wHLEDSsg2aFk0lNRN
         Vs4I8WIvyTRUHD1Fw3kQcZ7l6dd2rKrbtK8Fg7OSEgfVE2I97QMsfYmzjSQjLjt5ZHw+
         oFSONLKkrAIMrE91VIox4igwYKY7egMP2Ic80v5MzBbneZ/mmPlwZKdkI7t9LQpyj7cy
         zFQQ==
X-Gm-Message-State: AJIora9N/lq7cAj9zwp+m3i9qO7EhkSkmFMeM+01reyJ31Uvu8e7o9/f
        MQElQcb2DkWjGG3wguPq2gI=
X-Google-Smtp-Source: AGRyM1uHHRqg5+FoFLprCZ5glv0d82xY3s5AlkbrWCaQAZI8qqX87aafIadKLW1XwqazZjfnpuHNMg==
X-Received: by 2002:a05:6402:4410:b0:434:f35f:132e with SMTP id y16-20020a056402441000b00434f35f132emr27181424eda.215.1657570364057;
        Mon, 11 Jul 2022 13:12:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906199800b00724261b592esm2955312ejd.186.2022.07.11.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:12:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAzlo-0015Sv-VE;
        Mon, 11 Jul 2022 22:12:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 11/27] revisions API users: add "goto cleanup" for
 release_revisions()
Date:   Mon, 11 Jul 2022 22:12:18 +0200
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
 <patch-v6-11.27-e93791b6242-20220413T195935Z-avarab@gmail.com>
 <YsxmrRCSpze1csHz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YsxmrRCSpze1csHz@coredump.intra.peff.net>
Message-ID: <220711.86tu7n5ryf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Jeff King wrote:

> On Wed, Apr 13, 2022 at 10:01:40PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
>> index 70103c40952..2bfaf9ba7ae 100644
>> --- a/builtin/diff-files.c
>> +++ b/builtin/diff-files.c
>> @@ -77,8 +77,12 @@ int cmd_diff_files(int argc, const char **argv, const=
 char *prefix)
>>=20=20
>>  	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
>>  		perror("read_cache_preload");
>> -		return -1;
>> +		result =3D -1;
>> +		goto cleanup;
>>  	}
>> +cleanup:
>>  	result =3D run_diff_files(&rev, options);
>> -	return diff_result_code(&rev.diffopt, result);
>> +	result =3D diff_result_code(&rev.diffopt, result);
>> +	release_revisions(&rev);
>> +	return result;
>>  }
>
> A bit late, but I happened to notice Coverity complaining about this
> code. And indeed, this patch seems pretty broken. If
> read_cache_preload() fails, we assign "-1" to result and jump to
> cleanup.
>
> But then the first thing we do in cleanup is overwrite result! That
> hides the error (depending on how run_diff_files behaves if the cache
> load failed, but one can imagine it thinks there are no files to diff).
>
> Should the cleanup label come after the call to run_diff_files()?
>
> I was also somewhat confused by the double-assignment of "result" in the
> cleanup label. But I think that is because diff_result_code() is
> massaging the current value of "result" into the right thing. But in
> that case, should the "-1" from earlier be passed to diff_result_code()?
> I think probably not (and certainly it was not before your patch). Which
> would imply that the label should go after that, like:
>
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 2bfaf9ba7a..92cf6e1e92 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -80,9 +80,9 @@ int cmd_diff_files(int argc, const char **argv, const c=
har *prefix)
>  		result =3D -1;
>  		goto cleanup;
>  	}
> -cleanup:
>  	result =3D run_diff_files(&rev, options);
>  	result =3D diff_result_code(&rev.diffopt, result);
> +cleanup:
>  	release_revisions(&rev);
>  	return result;
>  }
>
> -Peff

Urgh, yes that's the obviously correct fix to bring it back to the
previous behavior, it's indeed just a misplaced "cleanup" label, sorry
about that.
