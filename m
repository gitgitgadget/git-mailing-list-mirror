Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F81C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiGUHN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGUHN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 03:13:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7297B780
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:13:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j22so1623863ejs.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EI/frOZkXAzTJjuCvS3UMQ/48fKY8WFwdQFCBJsULYU=;
        b=RTIY56cpFfQVX0ROA1+mmRc4mx+mQWIQx4zfyMYII7ZjRfAjBVlxh3zC6iR1F5/qZ5
         qUUZb9QrjWzDJzPniGqgcRSRupVRp97d+cxunxwvvPr+Fzx7N2MJaYWhl5IJkA8mNY4o
         kqi9tU8DyGEgFSEDjTwz8tEzW1NbifDrIUcj+6DDGlv8u83NE9Znnt3WojknGNAjYDhN
         Rs1AjGcSCog4UFUzTmcKeUmFVqBY6p7zZUaHIHr5+zSMD/vBGZCauPLITh3no6xTWNZ8
         vwWYm4/NfVepJ+hA7BLM6G9CDGaSAe0QMSHFpP2pe9kUalQPGMvyH/tObpu3iz7dFWI9
         EXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EI/frOZkXAzTJjuCvS3UMQ/48fKY8WFwdQFCBJsULYU=;
        b=Q8GzyZmm9KxNTVdTS2whK505UdsSkIGcnn06HQSBIn6q6rGyhpEM57JpelhHWkc8Ex
         bIk7W7NfHVtR3gM87+ITKR5WIFZHp0JVgG6Z1YDRowlnVhoQaP6iGaqA7+eHO5lwCPDc
         h8gut6e6jVGgsWEq9HI/7edeTXxfH/g6Wws3ZJvFIHdgu0xlJAmbSlkrfErfXwczZw4M
         hI8+IzgmXqjHQYiZRa/TC6siPKxwhyq4egvcOtNBKFwFfbZHBhKR4yAcEfnmx0OvUP6X
         xYxu5M2bRoL938l8PUdi/SMW/G5DPgFSRx9H4Ua/p7b9fpE0caDlE3gaXsXsPrTgVxL7
         gzBA==
X-Gm-Message-State: AJIora98PQyMPHCIMScmYlQmRCh4u0FrD59GSYOuPcZ8eJZxFYHKiwV6
        m34heParCoeC7fiHRPtLzBSeVZAGw+kUZA==
X-Google-Smtp-Source: AGRyM1tCgzaLqH3lzWSrg/z/qeki0U0XWLs1aTt/WR7mYozBr5NFFBjvk2aswinFXrl/qIWYg40feQ==
X-Received: by 2002:a17:906:8cb0:b0:72f:6ce7:3a1 with SMTP id qr48-20020a1709068cb000b0072f6ce703a1mr6417786ejc.322.1658387605746;
        Thu, 21 Jul 2022 00:13:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t8-20020aa7db08000000b0043bba84ded6sm505999eds.92.2022.07.21.00.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:13:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEQNA-004SDc-1f;
        Thu, 21 Jul 2022 09:13:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 0/8] git doc + "git help": move "format" docs from
 technical/*
Date:   Thu, 21 Jul 2022 09:12:33 +0200
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
 <xmqqy1wqqs3j.fsf@gitster.g> <220718.86r12iw9jg.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220718.86r12iw9jg.gmgdl@evledraar.gmail.com>
Message-ID: <220721.86zgh3szu4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jul 18 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> This series improves the discoverability of the technical/*
>>> documentation covering those "formats" where we interact with users
>>> (e.g. "gitattributes") by moving them to its own "git help" category.
>>>
>>> It then moves various technical documentation from technical/* to our
>>> main documentation namespace, allowing us to cross-link e.g. from
>>> "git-bundle(1)" to a new "gitformat-bundle(5)".
>>
>> This may be a good direction to go in in the longer term, but there
>> are already topics in flight that change these documents.  Luckily
>> none in 'next' yet, but there are two that have been in 'seen' and
>> need to coordinate with this change.
>
> The v4 merges cleanly for me, unless there's a semantic conflict you've
> spotted that I've missed.
>
> But I assume you mean a "seen" you haven't pushed out yet, which
> includes SZEDER's change here:
> https://lore.kernel.org/git/220718.86cze2y22q.gmgdl@evledraar.gmail.com/
>
> I sent out the v3 with a merge resolution for the only conflict at the
> time:
> https://lore.kernel.org/git/cover-v3-0.7-00000000000-20220712T195419Z-ava=
rab@gmail.com/
>
> But as noted in the v4 CL I thought I'd make even that trivial conflict
> go away in v4, but it looks like I'll need to roll a v5.
>
> I don't want to make it a hassle for you to carry this topic, and I have
> waited a few months to submit this, as there were always various
> Documentation/technical/ changes in-flight.
>
> Would you prefer to have this entirely conflict free, or to have me
> solve the (small) conflicts locally and note the resolution (per
> --remerge-diff) in the CLs?

FWIW this merges cleanly with "seen" due to the magic of "git merge",
i.e. even with the rename we resolve the conflict with SZEDER's work
smoothly.

But there's other reasons to re-roll, just say'n for when you eventually
(hopefully) pick up such a re-roll ...
