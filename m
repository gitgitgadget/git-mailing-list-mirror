Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE63C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65BC61165
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 11:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJDLNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhJDLNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 07:13:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD491C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 04:11:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so28804801edk.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iCC3U/SWjUIeH3bIVDRO9ieCP3w2KeeADNcl7tp5n4A=;
        b=CzbNMBlcHsWX6Dz2HuXjLk5pfUXYJNthVB2PTyoNXXmoU51TSI2hzANBJBvlSQrdl/
         D34rDj9GgLH+goKaQxAE/mdOgp62rSTLOv41FA1mD2LF5DmHu2uDw11dVhJm7AmAwWY1
         BI1oX18EZnpWNP1EcDYU2r6ekYwdbbk8kLKoU30Lev+yzZ6QcLL8g8RchWI7si1cMsxr
         Ailq8irn7RDCfkeqi5Ik2CVCrgYkWRKNTBEa3KQjmJkG3syCteTB7AHbNp4RVTuKrl7J
         wQkTvqphCz78LJzfQ8LgOexgHWvBCXnrPB9+Sn7Lgyi1yDzmOnHm8qJ6T9TXfYgXTao+
         ABIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iCC3U/SWjUIeH3bIVDRO9ieCP3w2KeeADNcl7tp5n4A=;
        b=W0Ca4aSjsSb459fH5VRwDVZgx/dp4aFhTFae28my9cMDT5lOgeln4H+jW2WLt1mWGf
         feqjzqx4YsbKzJrWtOXlDZuK6Ty2PAsJOJArcKAdZtFgPQwcHrU5NPM3nqWeasAeV75Y
         euaYiF381ecAZ7MN4OXRAyiUHnHD/stmT4CH1BnH3AJnKbBZ7oYjQMD9psNnRHa5N2vS
         K/xLt/aGOjgG/oQXBPK8NDNYNAn+u8fKHoQNryYXIFvNTvuuZEXHsJAQ8ZrWyUxhK40i
         93GRE2GRK4jhNlhFmyWT6K5q6qeS08mmtCFNhQEXEuvvCn1tdT8Tw+mqaiF34lZ3gftr
         LNcw==
X-Gm-Message-State: AOAM5311+0/dIjTUx3KAh2T3AQM1eFr4xJUKl6Ql2X0xnKs7sCs6+74i
        /qxps9syVn/Ea90XJON8sSo=
X-Google-Smtp-Source: ABdhPJxBKepg1wNCbxPt9PqlN+bFK/4l8rre87ey0euJX0B18Iz9Y3oAprpz7F0xmWQgc3M0zB4DoA==
X-Received: by 2002:a17:906:b05a:: with SMTP id bj26mr16180888ejb.226.1633345915261;
        Mon, 04 Oct 2021 04:11:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fx4sm6376761ejb.113.2021.10.04.04.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 04:11:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/10] unpack-trees API: rename
 clear_unpack_trees_porcelain()
Date:   Mon, 04 Oct 2021 13:10:37 +0200
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-07.10-646e610d8dd-20211004T002226Z-avarab@gmail.com>
 <ebc72146-4431-c29c-ebab-37cf886cf28f@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <ebc72146-4431-c29c-ebab-37cf886cf28f@gmail.com>
Message-ID: <87fsthnix1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 04/10/2021 01:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Since a preceding commit we've been using
>> clear_unpack_trees_porcelain() to call dir_clear(). So it's no longer
>> a function that corresponds to setup_unpack_trees_porcelain(), as it
>> was when it was added in 1c41d2805e4 (unpack_trees_options: free
>> messages when done, 2018-05-21).
>> Instead it's similar to strbuf_release() and other similar generic
>> "free" functions. Let's rename it to avoid any future confusion on the
>> topic.
>> Let's also update the API documentation for it to note this, and to
>> cover e.g. the code added around update_sparsity() in
>> 4ee5d50fc39 (sparse-checkout: use improved unpack_trees porcelain
>> messages, 2020-03-27).
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   builtin/checkout.c        | 2 +-
>>   builtin/sparse-checkout.c | 2 +-
>>   merge-ort.c               | 2 +-
>>   merge-recursive.c         | 2 +-
>>   merge.c                   | 4 ++--
>>   reset.c                   | 2 +-
>
> I was expecting to see sequencer.c here, but it appears it does not
> call clear_unpack_trees_porcelain() to free the memory allocated with=20
> setup_unpack_trees_porcelain(). If you're interested in fixing memory
> leaks from unpack trees it might be worth checking that all the calls
> to setup_unpack_trees_porcelain() have a matching call to=20
> clear_unpack_trees_porcelain().

Well spotted, I thought I was doing that, but see that I missed this one
special-case, will fix.

With this series grepping for "UNPACK_TREES_OPTIONS_INIT" is better (and
knowing about the one special-case of merge-recursive.c).
