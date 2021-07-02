Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41354C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F099611F1
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhGBM5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhGBM5k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 08:57:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012DC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 05:55:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hc16so15946274ejc.12
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=meSeLiAK+tFZ1Cj29F8DYtQA9ly89G/YHj2bYDM8vUQ=;
        b=Pbd2b8+OAHD9RMKMxihv7ScrKRMD5dwmLIHwXOjP9GEj+WN2ailUE/yqB0ykJqINb6
         hwmxQ34TsTKkUS6japWDx1EDtge+nisvpTIr+NYudWND5rIbXcvgJty1MU+RV+qTYKyl
         Od0U9F9HW4NSB68bUF9Rq5OAnu1ORAzR+wykKmfWDZ8OrSmJJgcvTHLL+C165jCC/L0o
         SK0bJ4TMIm5BAzdY9TLyfS9H/bmQ8+4XFrpwps6qsZdt04rQ7LY+u0Eildb76wWDmOjT
         U/cj5ZOptAqKh7JDZpJadGy5KqTBqgC9AJdeKhLjMi5zLZ/B8F0F1SGnOlHcwi+a2snO
         z+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=meSeLiAK+tFZ1Cj29F8DYtQA9ly89G/YHj2bYDM8vUQ=;
        b=eQ667+2HQI0vJWqGhUIaVD8RVa5exHYvdnCiRG/DqDhsFcmq9/MkkRGfDhAEiYt+fz
         X0j9+o7Pr27RwR7WGXq4EUMHHSIEEq3wRZKT1XzngehduibVDN9/GHPNzntE/p7k2DZs
         mcQy9A4MNqfs9QsYcWBP/vWu+3ps+waINfFaa2SoSqK1mc8gWBrXutl0hPrdC+aA6SYr
         OMMdowTX4hyWdymQQRAE1i20LLL22tjOvbaO4qBhuD2kvBMDhxA1l2NtdpXkF3TLC2D3
         7xQyVc163EN8IsjEgJYieeLJcuUX8Q+5tfYgA/4t+VEukMhCNz4KrfOJsjq3hSxLX87E
         ozRg==
X-Gm-Message-State: AOAM532uV9EeNcBvLGqTEdJ+9bK2vTjqO0W2Sw5dUkIenYx26ot1UT6I
        qRXNfQNUwF5lZ5qw8kcPbAM=
X-Google-Smtp-Source: ABdhPJz2VQ+Ujy9HSWItTVPaQ2s/Kab3IjZbth8FVjm1J2FR5HI/4tfOc/FXzV9TXcNRRz+lsByrvg==
X-Received: by 2002:a17:906:eca1:: with SMTP id qh1mr5242554ejb.287.1625230506509;
        Fri, 02 Jul 2021 05:55:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id du7sm1314952edb.1.2021.07.02.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:55:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/8] serve.c: add trace2 regions for advertise & command
Date:   Fri, 02 Jul 2021 14:54:56 +0200
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <patch-6.8-baeee6539ad-20210628T191634Z-avarab@gmail.com>
 <YN3tjEE8Ir7Zuvkq@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YN3tjEE8Ir7Zuvkq@coredump.intra.peff.net>
Message-ID: <87r1ggan9y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff King wrote:

> On Mon, Jun 28, 2021 at 09:19:23PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Now that we've factored out "call_{advertise,command}()" in a
>> preceding commit it becomes easy to trace all these callbacks with
>> trace2. Let's do that. As the tests demonstrate there's no v2 push
>> protocol, which the tests assert.
>
> Seems reasonable. I haven't ever wanted these myself, but it seems like
> a natural spot to mention when debugging server-side actions (especially
> because we may get multiple rounds of "fetch" for a single upload-pack
> invocation).
>
>> diff --git a/serve.c b/serve.c
>> index 85cd3eab26e..6dbd05248b9 100644
>> --- a/serve.c
>> +++ b/serve.c
>> @@ -111,14 +111,34 @@ static struct protocol_capability capabilities[] =
=3D {
>>  static int call_advertise(struct protocol_capability *command,
>>  			  struct repository *r, struct strbuf *value)
>>  {
>> -	return command->advertise(r, value);
>> +	int ret;
>> +	struct strbuf sb =3D STRBUF_INIT;
>> +	const char *msg;
>> +
>> +	strbuf_addf(&sb, "advertise/%s", command->name);
>> +	trace2_region_enter("serve", sb.buf, r);
>> +	ret =3D command->advertise(r, value);
>> +	msg =3D ret ? "advertised" : "hidden";
>> +	trace2_region_leave_printf("serve", sb.buf, r, "%s", msg);
>> +	strbuf_release(&sb);
>
> We'll do these allocations even if trace2 isn't enabled. I guess that's
> probably not that big a deal in practice. I think:
>
>   if (trace2_is_enabled())
> 	strbuf_addf(&sb, "advertise/%s", command->name);
>
> would work (everything else is cheap and handles the unallocated state
> fine), but it might not be worth the readability hit (and it's probably
> premature optimization anyway).

Will change it to be conditional, pending further discussion...
