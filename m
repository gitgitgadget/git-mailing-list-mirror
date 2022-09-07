Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADDC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIGUTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIGUTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:19:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A80C12C8
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:19:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 65so5495621pfx.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=ucLWj0cyrlCW4Srl0V15W6kyTKuHuYFFMj0cKB7JZKg=;
        b=mptsIrXkfwI9QU+sjqEJhzasTN6+N7o0/oiAuEJManz1uI4vD6Cvg8dSwjspTVaEkL
         QmdA/qvEVpyIMn8MBGnw9LOfS+cdh0RpcWEQj/1exI/4jsO/AnHRqyUIJ9L1B2iwl0+X
         r6GrCxRqCXLko2G53o/1NKn7PM9pM3nThKui1ekSRvFhnhoisiVv6tRc2XVIbGqbAkAl
         E4ehVC127zZQ/e3XaVHxwj5glKSsLL4Em9tOI2BXhtUvVWCLB+pYNgpJ7DDkWD9sCk3A
         jFHEE+iXIk+CMTfBnFn4RyB1WOf5aBfS+FgAZ9Z4+Xm8M6rMnQOqwypwZaMTss1TYprz
         wEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ucLWj0cyrlCW4Srl0V15W6kyTKuHuYFFMj0cKB7JZKg=;
        b=VA//3mL9quKvfUaSdwDnjXz16dkR+VfxQhR/TNSompo6yDRpG8+BEUgCRTt3ibuLLC
         Dkyi1lxh2TDhO5eqrJKxVtICs5AsFUeY+4XNVWLpDK+wTYGrxI0fPPEYrqYxLBht6EYM
         hyQewcExiyF2D/DIQLWoIpRQZruky2Bw4fLsbg4N4zQQZ6N+QxjXpkYqdSpBcTPyBNRk
         4AxgRmpNNRBnbwLKcApjT2bAnToSuU2QkxjjuBD8LvHXl6h0R7My57H2XdAtgBZ0iU50
         338IiL2YA+LU7ZMbC/3vaIR/aujrLyHv0EODmPXsBxMf8JJXEdN0jU4is+uiwsMJUmgt
         ZKpg==
X-Gm-Message-State: ACgBeo0NL87DdyrMS4zF1GJS7jJYJXQ2Xldgm8dxSHq/NzrjhZodd1U4
        iy5v8y/Kr1Kyn5XDoMW83dc=
X-Google-Smtp-Source: AA6agR59ENRvEDH7i2qSMsmlHDrERCkgmLtNsxWNfhx2rY4ECGlQqwIVEuVWEkvqoH8JHaBsV55FTQ==
X-Received: by 2002:a05:6a00:21cc:b0:53d:debc:2ea1 with SMTP id t12-20020a056a0021cc00b0053ddebc2ea1mr5840270pfj.56.1662581948838;
        Wed, 07 Sep 2022 13:19:08 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 205-20020a6217d6000000b0053818255880sm12903421pfx.193.2022.09.07.13.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:19:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 01/34] CodingGuidelines: update and clarify command-line
 conventions
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
        <patch-01.34-b8cbd443987-20220902T092734Z-avarab@gmail.com>
Date:   Wed, 07 Sep 2022 13:19:08 -0700
In-Reply-To: <patch-01.34-b8cbd443987-20220902T092734Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 5 Sep
 2022 10:26:12
        +0200")
Message-ID: <xmqqedwnszsz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> + Use spacing around "|" token(s), but not on the inside of "[]()"
> + tokens:
> +   Do: [-q | --quiet]
> +   Don't: [-q|--quiet]

It is unclear what "but not on ..." in the description and it is
still unclear with the examples.  Does this mean

	Don't: ( -q | --quiet )

In other words, "on the inside of" above is meant to forbid spaces
immediately after opening or before closing a [] or () pair?

Other than that, I think these are good guidelines to have.

Thanks.

