Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C76C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 10:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBIKUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBIKUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 05:20:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3171CF40
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 02:20:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r3so1637768edq.13
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 02:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j9b2MOqCWqHGPZRzhvDnbhdrQt6h4F322vNTCAzBwc4=;
        b=iOR6TKJeWU1I5KSgNnTXN8sVNVD/Lozq4UFOb2AA5VZFVZMpUqlhUr1faWmQj8c0m5
         K7sUYFLjI7MZXptdlWBNbjGIsFtU1ptVLQKJONBwki4W/AK33Dt57XWgcOwo7EnI6oxo
         w/LJS/S4vFuCw64DI+ZfQeRksRgk7sRO/iZ2uB1gGhskrup93OnnTGThSe+vtqRajkRy
         +mXMjyEzdrxTt8SEpRTHzVHgycXmlL4uh2JAPHqCqwlTE7hF9+iGFvWeUuV6PnLqwZav
         H+T5fi2EHwEuPYqOpD93ozVkK0DijDr9uWpbMWC+eZqaeaOR80vNDk4wYG/Hlg77aDvj
         mfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9b2MOqCWqHGPZRzhvDnbhdrQt6h4F322vNTCAzBwc4=;
        b=lw1wXW+1M0tTEiieHBSHeqz+7/dBps95LJ4jw8q9tgpnLGtmK2ALoUubMMJ9zQJryV
         vXNlEsKe2Rp3x5E8sIAnj2UHTI3EN6gqLgvMexaGXoUruEGbulFK3nReOxUJN0+VA15A
         1vutxsO2ijvi4l0S19yXQa9UUzJJtSa/O7EZu8NGac1cei1pOsASP0inIR5zUUYXF60m
         hQt3gYqAIgKgteLja7NLpZVwddhhsG1ouqFPLlj8U/KHawRVBtq+Du01YIsPv0IQzVqK
         rdWE2LB6BKuuDC2a0dQUjKvN56AikHTitwl40csJW2dnm5Q0BtsXRE+cgMqkOwdpdS/M
         TBYw==
X-Gm-Message-State: AO0yUKUaDEDAL0zxnkcthu6XxecLwrrAI8Mhg2TYhqcYmpSjemQt1hBL
        M3V1TEffUIa5cJd7pm1x+aEUPMGfbsXPSIFd
X-Google-Smtp-Source: AK7set+kKVwCpp4TXG77yXM3o168p5Hgmnv6VLXe0K6gi+Di6DeHvLpscwp1tkr989V8M2HZvsRM7Q==
X-Received: by 2002:a50:9fea:0:b0:4ab:1f95:5c7f with SMTP id c97-20020a509fea000000b004ab1f955c7fmr1173200edf.21.1675938048856;
        Thu, 09 Feb 2023 02:20:48 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p19-20020a50cd93000000b004ab102c90e3sm543395edi.93.2023.02.09.02.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:20:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQ42p-001hJO-1w;
        Thu, 09 Feb 2023 11:20:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v5 03/10] config API: add and use a "git_config_get()"
 family of functions
Date:   Thu, 09 Feb 2023 11:11:01 +0100
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
 <patch-v5-03.10-4a73151abde-20230207T154000Z-avarab@gmail.com>
 <kl6lttzvw8k1.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6lttzvw8k1.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230209.86h6vvxhq8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> [...]
>> This still leaves various inconsistencies and clobbering or ignoring
>> of the return value in place. E.g here we're modifying
>> configset_add_value(), but ever since it was added in [2] we've been
>> ignoring its "int" return value, but as we're changing the
>> configset_find_element() it uses, let's have it faithfully ferry that
>> "ret" along.
>>
>> Let's also use the "RESULT_MUST_BE_USED" macro introduced in [3] to
>> assert that we're checking the return value of
>> configset_find_element().
>>
>> We're leaving the same change to configset_add_value() for some future
>> series. Once we start paying attention to its return value we'd need
>> to ferry it up as deep as do_config_from(), and would need to make
>> least read_{,very_}early_config() and git_protected_config() return an
>> "int" instead of "void". Let's leave that for now, and focus on
>> the *_get_*() functions.
>>
>> In a subsequent commit we'll fix the other *_get_*() functions to so
>> that they'll ferry our underlying "ret" along, rather than normalizing
>> it to a "return 1". But as an intermediate step to that we'll need to
>> fix git_configset_get_value_multi() to return "int", and that change
>> itself is smaller because of this change to migrate some callers away
>> from the *_value_multi() API.
>
> I haven't read ahead, but on first impression this sounds like it might
> be too intrusive for a series whose goal is to clean up
> *_get_value_multi().

Yeah, that was my inclination too :) But Glen seemed to have a strong
opinion on the end-state of the topic being inconsistent in its API
(which he's right about, some stuff returning -1 or 1, some only 1).

I wanted to just leave it for a follow-up topic I've got to fix various
warts in the API, but cherry-picked & included the new 06/10 here to
address that concern.

I'm also confident that we can expose this to current API users, so
partly I'm playing reviewer flip-flop here and seeing what sticks. If
you feel it should be ejected I'm also happy to do that, and re-roll...
