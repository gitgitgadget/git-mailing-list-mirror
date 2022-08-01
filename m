Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB222C19F29
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 12:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiHAMQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiHAMPa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 08:15:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA6779EE9
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 04:58:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k26so4158011ejx.5
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=8rw2yovvnHc1bEJyK9o9u2cfRkPlbC8cm0EnK6muTX4=;
        b=EmfRq7h1T0fkecOCliKIbqoYFgpaK+FTC/UvvkrnaOLWW8tz9iFP9Y1BNEeJDGkJKz
         lB+8pn0htf2QMwZy4EM3kQ4WCxJAGsr0YPFDG3RJOi172PmbVTM6SUq5J/QmzTsv83FF
         hGaHObLSV2kp8X4hdwr40SsI6dhAjReYab8KHzY7M+bRM1cfYVaGbOpv28jlb4dBK7Zr
         XEk+sL+OFIqOW7Wi580T/ccJjBCTXuWL5uIXi+hGGO710SvbKbmPmxuYmae2pP67A5sm
         GvfDVODYUBqXT2IC4iHPcSNcZ4OCwqybQeCpNmhuTFvd1ZHvWr5vrs+q3gOCDwPTIUZ6
         9cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=8rw2yovvnHc1bEJyK9o9u2cfRkPlbC8cm0EnK6muTX4=;
        b=T9ld0QFNh9vHv4APMC5txnw9ze3AVQx170An00ovrHnRG6sTTJcIYmQRwtzYxIxNbZ
         tOon1E/gcUTZEAPNffYNbQNlTFwmiDC96fA3LBpZW5Vx1cAMNT37IU40fLqWGqFFaRck
         5ROjiWod9GYOokzdJZ8aSbNoNarD4rYkKERS9/8AVZczReRCRhxW3+5WNR7paDmGwNJO
         gJeVnwAoT7Eezb12mUmABF4ng6Dd0aoupNVM4Imdhlirs4yvGk85oBg4jWOQae6365Vx
         bqeFL3nbPFX0RmVdsaqsUrk6ox2/cZRx8tCbq1XWRra/oi0ise75rPeP/4bNDE5uxbJs
         tu5g==
X-Gm-Message-State: ACgBeo0I+iX1y1OsM05z5XT+RKlsMcd3BXICYxReV4DzUk+WtjNYgzyG
        s8zdu11zLxQR+OYF4gIMW8k=
X-Google-Smtp-Source: AA6agR5Aq50WBeOSnG+1RWyJDMSmOfvENUYOf5E4It3ULTTuB/Ma65lO9ccdb31OH05bcr9nvyiWbg==
X-Received: by 2002:a17:907:1629:b0:730:7d10:639c with SMTP id hb41-20020a170907162900b007307d10639cmr3937351ejc.256.1659355100153;
        Mon, 01 Aug 2022 04:58:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g36-20020a056402322400b0043d4fe7f8e5sm3867926eda.73.2022.08.01.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:58:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oIU3u-008lZn-Mr;
        Mon, 01 Aug 2022 13:58:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v6 1/9] help.c: BUG() out if "help --guides" can't
 remove "git" prefixes
Date:   Mon, 01 Aug 2022 13:55:11 +0200
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
 <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
 <patch-v6-1.9-f3588319057-20220728T164243Z-avarab@gmail.com>
 <xmqq35ej313l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35ej313l.fsf@gitster.g>
Message-ID: <220801.86czdki3ad.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 29 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Adjust code added in 929d9192828 (git docs: split "User-facing file
>> formats" off from "Guides", 2021-06-04) to be more strict about the
>> prefix trimming of the "guides" category.
>>
>> There are no guides in the command-list.txt that don't start with
>> "git", and we're unlikely to ever add any, if we do we can remove this
>> BUG() invocation, but in the meantime this makes the intent more
>> clear.
>
> I am not sure what this buys us.  After dealing with pages that
> begin with "git-", if the set of documentation we have happen to all
> share "git" as their prefix, then this new BUG() does not do
> anything to them, and when we ever add say "scalar-guide.txt", the
> new BUG() would only force people to rewrite this part of the code.
>
> Instead we could be more forward looking and do something like
> "Yield a name without 'git' prefix if it begins with it, or the
> original name", and then new guides that are outside "git" namespace
> can be added without touching this part of the code again.
>
> IOW, it is not entirely clear to me what we are adding this extra
> roadblock for.

I think if we ever have non-git documentation such as scalar's being
shipped as part of our build it would be good to run into this BUG(),
since presumably a "git help -g" should not list them, but e.g. "scalar
help -g" or whatever.

Or if "git help -g" should list them we should extend it somehow so that
it's not listed under the main "The Git concept guides are" heading.

But per that rationale I should give "git-" the same BUG() treatment,
which I didn't because I wanted to focus just on "git" here, to make
this easier to explain (but perhaps it wasn't).

So I can remove this stricture entirely, or make the BUG() stricter and
remove the "git" (or "git-" requirenment. Whatever you prefer after
reading the above..
