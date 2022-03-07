Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD1C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiCGQYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244102AbiCGQYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:24:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E656750
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:23:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so33160080ejb.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=h7/yeAwxJeNoWUG39QEUJ1S+cuLTlzG8VYjKrNNmM7U=;
        b=L3K2of0fM65O4/bOA37iuk8BorPAAxYcP5dzAcXw54f3HSfDXlSR5/SwrfKYpnybaJ
         XmN3ZzcX5CoIb9VrLAmXa4Q5aLZE3SGxd/Js6gDT2+OLFYF0xiyczgMPrQTMjzQIgT9Q
         8UfxyGYnc1yDd1SbNmUXtKlEOOWB7WNvEMtZN6tDdzkEHZJXOeKtvM0CONimFs1ynkQ+
         FLilnWKMK1T/s3QyDh5Ggn6mjGs5nimJQHlqIhBPRMQeuTUj3RIaymhi+9aP0rb2Qr21
         gb9EbIg+zDecV21Q0DITzUWR9WnX3rGsFCXEBamOiQGGGIgtQtbAXNqaUJ8OrtkmwU12
         M8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=h7/yeAwxJeNoWUG39QEUJ1S+cuLTlzG8VYjKrNNmM7U=;
        b=tZIe04/iJxsINTu+An2sFuqFYXxY33a13scLdM3N9HqTXALTTfLasdZp9OOzEcKHkg
         +E/5/Sv/Vjp73FpHiyEmYqIKOnO2qHdV/F/MiMYb4xC80qOEoghwxOnLlKBeU6K8UOZ4
         r9Ov2hFGjC9+gy/R4BoVaqjAC4dLnGeZCFnoYT+MXn7S9t3nXkmFsSKmSen2x70bwz2C
         9DYruKoKM6cp81Eq33Hx3+OHHCWdI9zHLlbsIDnKAeHHhisWUbV4KmbfIs2V2rdcdMyi
         m+GPToxhHr2c4klRSvalTZpfSrkWfBlXcDVxeFCediVeVIu3Qr3uprLQinK1IGvJdBY2
         Pwfw==
X-Gm-Message-State: AOAM533tHW6+Gaa8crkHwtCuwqSkgEilljVeNt2f6PrL51SKBnsKKScP
        eqgfB7KuhX4Nl9RAMf8rnMk=
X-Google-Smtp-Source: ABdhPJwc3z2zYYuIRe3xsfMxN+Y9i85QIx47SsFH9fTnSKyYvNlKVMGGa8qo+XWwSTG86wK85GvMgQ==
X-Received: by 2002:a17:906:f85:b0:6d6:e97b:d276 with SMTP id q5-20020a1709060f8500b006d6e97bd276mr9715833ejj.431.1646670230080;
        Mon, 07 Mar 2022 08:23:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170907761a00b006dab610d263sm3851715ejc.83.2022.03.07.08.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:23:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRG9E-001bX8-Ot;
        Mon, 07 Mar 2022 17:23:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 08/11] bundle: parse filter capability
Date:   Mon, 07 Mar 2022 17:22:21 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
 <220307.86bkyhzs3r.gmgdl@evledraar.gmail.com>
 <142219bd-5047-a27d-d53f-2ec2f6cb9c08@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <142219bd-5047-a27d-d53f-2ec2f6cb9c08@github.com>
Message-ID: <220307.86pmmxybmz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Derrick Stolee wrote:

> On 3/7/2022 10:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
> ...
>>> diff --git a/bundle.h b/bundle.h
>>> index 06009fe6b1f..eb026153d56 100644
>>> --- a/bundle.h
>>> +++ b/bundle.h
>>> @@ -5,11 +5,14 @@
>>>  #include "cache.h"
>>>  #include "string-list.h"
>>>=20=20
>>> +struct list_objects_filter_options;
>>> +
>>=20
>> For the other ones we include the relevant header, do the same here (or
>> if there's a need to not do it, do we need it for the rest too?)
>
> The others are .c files that require looking into the struct. This
> declaration is all that's required for this header file.
>
>>>  struct bundle_header {
>>>  	unsigned version;
>>>  	struct string_list prerequisites;
>>>  	struct string_list references;
>>>  	const struct git_hash_algo *hash_algo;
>>> +	struct list_objects_filter_options *filter;
>>>  };
>>=20
>> I haven't tried, but any reason this needs to be a *filter
>> v.s. embedding it in the struct?
>>=20
>> Then we'd just need list_objects_filter_release() and not the free() as
>> well.
>>=20
>> Is it because you're piggy-backing on "if (header->filter)" as "do we
>> have it" state, better to check .nr?
>
> Yes. I replied to Junio before that there is some assumption in
> the filtering code that the .nr =3D=3D 0 case is listed as a BUG()
> so we would possibly be breaking expectations in a different
> way doing the embedded version.

Having an "unsigned int using_filter:1" or whatever IMO makes that much
clearer than needing to carefully eyeball code that's already using
embedded structs & see why the one exception that's malloc'd is because
of that or some other reason...
