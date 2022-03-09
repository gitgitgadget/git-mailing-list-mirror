Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38336C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiCINnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiCINm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:42:59 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682417B0E2
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:42:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so5139191ejc.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MggAm6xibXDhBOuBPPvQEZJduRZnE3WHuX2Jd5ysRS4=;
        b=mljAgyBATqCXeIh6Lq/nm9iUlNyw60EKL05XXX941nkysMRLVTMWmCg5DnwCiiW5Ko
         eim1j2s9iYQSaTbIS05Po07msrgLXTFRecaiiIpneCquiIZI66upqA12Ye0J99JCfBPh
         Yb4AfQrYuM8iSaxvEH2A8iyIn1z0AoVRYCB6btve+XqRtzgbhDf/jCQ81x4AIys8eNsK
         lfsHTAbXx9Q8Psy61QjmyojP/t6YTkIyzT2o4xPTvoxwaE56AAHyeLlVxwdn3s5bbpaZ
         bPWtfoVHt6L395Co2jzqUqVkgLyRWU6pEbEDV9z22nefIax6CC7KEBWYc8vCF+xzJiut
         dlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MggAm6xibXDhBOuBPPvQEZJduRZnE3WHuX2Jd5ysRS4=;
        b=Q4R8YZrQbW/umPxL7ZYTUGX63pPNi3NrQBt/gbvydngG5piEIAewRYKLxORIxlpJwa
         iS9rFk5k338apM4ErGE1U7zXVcm3uxh7Bz1ydXtcUWqFVi4l0BV0TySpaSpAHN1h3V0n
         yKgT0QVqXIBiKFdPcRNjxUTLxEZjzqCn7k3kIyhgD2zCWPSdbCPtbxANBk9vi3siKqgm
         CK793EZ30w4ohePq+cXEpOdZdcwDJzVOF0QK6+DdKzJymudJd+1UfMrqT4HMR+YWOFit
         zLzZjUFT079odqmcQz/qfS+6E3jDtQMVFmYUbI/r68pFwbDknYBiJSKjbpPcgqWpst2s
         Cu9Q==
X-Gm-Message-State: AOAM5306JIL1clHZMH3g3pi3GDWeHpKvmKaBDk7FsEhzCIkhSkq5zria
        n4nw08dNX0hmXjDEz44Lcjw=
X-Google-Smtp-Source: ABdhPJyubkoVf0VQgOhCp/9Td+OMTVu6dqBxu0tGPO0i8hfnYZ/9q/V/PltkL4HPhGGIIzNiPpMnwQ==
X-Received: by 2002:a17:907:7fa9:b0:6db:698:28a9 with SMTP id qk41-20020a1709077fa900b006db069828a9mr16274038ejc.569.1646833317602;
        Wed, 09 Mar 2022 05:41:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z3-20020a056402274300b004169771bd91sm748858edd.39.2022.03.09.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:41:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRwZg-000Afi-DT;
        Wed, 09 Mar 2022 14:41:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason via
         GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, zhiyou.jx@alibaba-inc.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 07/12] list-objects: handle NULL function pointers
Date:   Wed, 09 Mar 2022 14:40:03 +0100
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <782182a26e37eb8e84aef7d8cc67cf276b2abb54.1646750359.git.gitgitgadget@gmail.com>
 <xmqq8rtknyni.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rtknyni.fsf@gitster.g>
Message-ID: <220309.86k0d3mee3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Junio C Hamano wrote:

> "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason via GitGitGadget"  <gitgitgadget@=
gmail.com>
> writes:
>
>> Replace all callers of the show_commit and show_object function pointers
>> in list-objects.c to be local methods show_commit() and show_object()
>
> "to be local methods" -> "to call helper functions"
>
>> which check that the given contex has non-NULL functions before passing
>
> "contex" -> "context"
>
>> the necessary data. One extra benefit is that it reduces duplication
>> due to passing ctx->show_data to every caller.
>
>> -		ctx->show_object(obj, path->buf, ctx->show_data);
>> +		show_object(ctx, obj, path->buf);
>
> I guess this is the "reduced duplication" refers to.  The helper
> does make it easier to follow and reason about: "show the given
> object at the path in this context" is what it asks.
>
>> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
>> index b13e8a52a93..6522401617d 100755
>> --- a/t/t6020-bundle-misc.sh
>> +++ b/t/t6020-bundle-misc.sh
>> @@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
>>  	test_cmp expect actual
>>  '
>>=20=20
>> +test_expect_success 'unfiltered bundle with --objects' '
>> +	git bundle create all-objects.bdl \
>> +		--all --objects &&
>> +	git bundle create all.bdl \
>> +		--all &&
>> +
>> +	# Compare the headers of these files.
>> +	head -11 all.bdl >expect &&
>> +	head -11 all-objects.bdl >actual &&
>
> "head -n 11" but more importantly, why eleven and not ten or twelve?
> Is that a number this code can automatically learn from the given
> .bdl file?

I suspect what's wanted here is "print all stuff before the "\n\n"
header/PACK delimiter, which is better done with "sed" like this:

	sed -n -e '/^$/q' -e 'p'
