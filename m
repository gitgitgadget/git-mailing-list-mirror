Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0055BC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 13:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiHCNTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiHCNTP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 09:19:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E54186E1
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 06:19:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gk3so19257555ejb.8
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=txexGK6+OamhUet1aWq5UzMN5EiLCHqo603uoGFCpZE=;
        b=LPkY3UXPpjqaxD5rajVeXO9q4g2Rt760nggmmwEAnl4kEWoYnsGklYujk0+0NuzLQP
         VtBYUWPYFveo7NnGEs4hAXVTYC0Wb4lJrg0cX5Pl8EkEGTqQY/KHVraMNvX83gRFoaOQ
         80Ro5LBoyJsa640r+J3FMqIPTk2hSgCoX+Jh5SDuqg+c2NP3eygcI2yJhj1z7fL91bUh
         TaA53bOglHVn8G2ZZhA0ZUmjPxUdxQj24a4D19seGj9PpF13mu4oZIdk1lNwMSQT0Fl2
         ay+/RGBM9LTpZ62X1b732AORMFUMGzAOVCsB21vyjNqp8j8tFgtzMN9gTvJbJo6m0uIJ
         0STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=txexGK6+OamhUet1aWq5UzMN5EiLCHqo603uoGFCpZE=;
        b=HFsybHa//Yaj4G/4mJ1T24vMGfM0l7T6vODn+xa5p+Fz5u9dWRcrp7gVstknd6hQBf
         Ko9Y+znezmgpYrdThS96BSljxiCPunU6fI/HA9mDVzXAdYSmllIf+If6490LH3e2GTAh
         +GlLb81eZd1Klhjm0esEnfpHxt5A2oljcflX3mq/9obQUBPw/VWSlz07E7uAaomdQBYi
         wMnDmsiKU7TKzHzt02fSLdbFJQ+zaUnMXTMxziwmjdaKqXx2D1QXzILVZ3n7VJafzNa6
         KvivCPNZV3L0OFnlT24bONqvNiKrz9Xi8eeASdDImuxWAZipDWEejGGPjA+sKtjLZ6Yy
         jG0w==
X-Gm-Message-State: ACgBeo3CHbGu4XQLJPrmBs5pIcceXveWwDi7DympOAJgxI5XeDcB5DyE
        Q1DO2PPNBNUUXucNN5wFvvQbnX4gXrdo0A==
X-Google-Smtp-Source: AA6agR4mWgpASdARA43jIy60Q2ph5mikjyoiR2jbZ0gqOcGs+pLmNDggDB8CQHqpCTjwcMQQl+Z3zg==
X-Received: by 2002:a17:907:2cf8:b0:730:6854:1c26 with SMTP id hz24-20020a1709072cf800b0073068541c26mr13167120ejc.766.1659532752542;
        Wed, 03 Aug 2022 06:19:12 -0700 (PDT)
Received: from gmgdl ([2a02:a213:23c2:bf80:c530:8f19:38e6:f393])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7dacd000000b0043cab10f702sm9608535eds.90.2022.08.03.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:19:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJEHH-009TeJ-0x;
        Wed, 03 Aug 2022 15:19:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Date:   Wed, 03 Aug 2022 15:11:13 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
 <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
 <20220802173754.GA10040@szeder.dev> <xmqqsfmefjja.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqsfmefjja.fsf@gitster.g>
Message-ID: <220803.86czdhfos0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 02 2022, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> Dunno.  I don't like this NO_PARSEOPT thing, and instead of testing it
>> I'm thinking about removing it altogether.
>
> Sorry if this is obvious to the others, but I am confused here.
>
> Lack of NO_PARSEOPT bit is used as a mark to say "this subcommand
> takes '--git-completion-helper' option to help listing the options,
> so include it in the 'git --list-cmds=3Dparseopt' output", right?  I
> do not mind removing an unused or unnecessary bit at all, but what
> is your plan of getting rid of the bit?  Will we make sure everybody
> supports the "--git-completion-helper" option?

We could:

 * Handle it in git-completion.bash itself, e.g. send-email supports
   --git-completion-helper but isn't a built-in, the git-completion.bash
   itself knows it can be invoked with it.

 * We could just try to run the command with --git-comletion-helper, and
   fall back if it returns 128 or 129. AFAICT the only ones we'd need to
   handle specially would be rev-list (returns 0) and fast-import (will
   hang, expecting stdin input).

The non-parse_options() supporting ones are rare enough these days (and
we've been ~quickly converting them) that perhaps an on-the-fly check
would be fine (and we cache the result, as with most/all other such
checks in git-completion.bsah).
