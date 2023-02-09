Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19886C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 11:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBILCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBILB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 06:01:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EC26F21B
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 03:01:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so5196433ejc.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 03:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjKPU7TvBq+zX+A9FXSErdn0OmzPcEWoHkJ0xqUC0iA=;
        b=qRhRLoOgN2o9e8u1scn+3kxRuuCy2y2N920F5JJlVGMkCiCvuZfOU1KuLhyIGi/wuP
         pXh2gfGkQUVOt3c0S+Zyl9mGG6erEebIgj26b2N9ifSeXcJKDYqhNHcynm4FwGnV8kIR
         JJhLWcCRbOSAEEGq33JTncQL9RkShwqd+Ow6scvGg9gKHtV+mdrckTYZ1LYf3IWcGJr9
         i7XcvWe7qGK571BMzuQ1tNX9/E8UfPsBRu6y0Eqgv6hIkxCX8spkqfx6xt0kQ1Pmuiwn
         KYP4vDb42ZtN9hU1cxNcpisgHouuwU9l62ZHpdqks/3a+r+krPhD9xnVDaD5QrA8ZxoU
         1KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjKPU7TvBq+zX+A9FXSErdn0OmzPcEWoHkJ0xqUC0iA=;
        b=L5mds3eANsfXbxOpexouPKSw6+bOVHQhclgbNOrCJa5KMwo94FTrQyRmWSXOXubCZy
         fu7GFIXM6gC7C1nwUdbnskEWW75L8r8PH3V4WOdumXtq6rqtrK5/0niqfRJrNxC7Kw/Z
         KGm5L+wFXS4AKU53vHCvEk22Ne+XGfcqOPBw07NQIoiCFGK70vDG9ZPyKmzku2+eZJhh
         9Cl4ygAyc0HtAnfIX3CPgCrt3cBsQ4V3Boo+97d7uWbwEe+JgT7PfOOGKQjCzRBjkQUz
         9Rx375AFQF2xQEaZqxQF/v0BASP6LfQUCvYQNyN1ZRvwDVWs1kdaGBhliP/lfQeTYNAJ
         iKIg==
X-Gm-Message-State: AO0yUKXBDJ72yJmuUx6fEwh5m2HPyYUACoXlsqSI9c8/AatEEiH0U0Pj
        htL9zkGlGMISy04/uZwVfjuTBZsWKoRbGpDn
X-Google-Smtp-Source: AK7set/a9OlPEBmPdt+blZ2sdSrrRYAa+YDgBpc2IsZdEcD+abs/0cn2GAMXAZMFI668B+KiRcJidw==
X-Received: by 2002:a17:906:960d:b0:878:78bc:975c with SMTP id s13-20020a170906960d00b0087878bc975cmr12052683ejx.36.1675940471049;
        Thu, 09 Feb 2023 03:01:11 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906584700b008a9e585786dsm727063ejs.64.2023.02.09.03.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 03:01:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQ4fu-001iYL-08;
        Thu, 09 Feb 2023 12:01:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v5 03/10] config API: add and use a "git_config_get()"
 family of functions
Date:   Thu, 09 Feb 2023 11:59:43 +0100
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
 <patch-v5-03.10-4a73151abde-20230207T154000Z-avarab@gmail.com>
 <kl6lttzvw8k1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <230209.86h6vvxhq8.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <230209.86h6vvxhq8.gmgdl@evledraar.gmail.com>
Message-ID: <230209.864jrvxfuy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Feb 09 2023, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> [...]
>>> This still leaves various inconsistencies and clobbering or ignoring
>>> of the return value in place. E.g here we're modifying
>>> configset_add_value(), but ever since it was added in [2] we've been
>>> ignoring its "int" return value, but as we're changing the
>>> configset_find_element() it uses, let's have it faithfully ferry that
>>> "ret" along.
>>>
>>> Let's also use the "RESULT_MUST_BE_USED" macro introduced in [3] to
>>> assert that we're checking the return value of
>>> configset_find_element().
>>>
>>> We're leaving the same change to configset_add_value() for some future
>>> series. Once we start paying attention to its return value we'd need
>>> to ferry it up as deep as do_config_from(), and would need to make
>>> least read_{,very_}early_config() and git_protected_config() return an
>>> "int" instead of "void". Let's leave that for now, and focus on
>>> the *_get_*() functions.
>>>
>>> In a subsequent commit we'll fix the other *_get_*() functions to so
>>> that they'll ferry our underlying "ret" along, rather than normalizing
>>> it to a "return 1". But as an intermediate step to that we'll need to
>>> fix git_configset_get_value_multi() to return "int", and that change
>>> itself is smaller because of this change to migrate some callers away
>>> from the *_value_multi() API.
>>
>> I haven't read ahead, but on first impression this sounds like it might
>> be too intrusive for a series whose goal is to clean up
>> *_get_value_multi().
>
> Yeah, that was my inclination too :) But Glen seemed to have a strong
> opinion on the end-state of the topic being inconsistent in its API
> (which he's right about, some stuff returning -1 or 1, some only 1).

Hrm, so clearly I lost track of who I was replying to there, sorry :)

I thought this was a reply from Junio at the time.

But the rest of this stands, i.e. I thought I'd integrate this based on
your feedback on the previous version.

> I wanted to just leave it for a follow-up topic I've got to fix various
> warts in the API, but cherry-picked & included the new 06/10 here to
> address that concern.
>
> I'm also confident that we can expose this to current API users, so
> partly I'm playing reviewer flip-flop here and seeing what sticks. If
> you feel it should be ejected I'm also happy to do that, and re-roll...

