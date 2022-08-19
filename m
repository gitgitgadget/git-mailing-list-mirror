Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4ABC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbiHSSPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350196AbiHSSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:14:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F902DECA
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:10:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z16so6024275wrh.12
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=/uQ/wY3O2DLvXJF7aFLpTR8jumBRrfJ8jOdYLRZtLo8=;
        b=NmTtT2MP2mceWvKRvOSyDWIl3Be0VoMyDY2oCE9jJbJN63wXkNTPZtWXTwptLAfFXY
         WoQTLWr9vJwpErTpfCRKjI8V9r7hLFHVb/8ODPdh7dVtJTTLpL+XOEtkgc2u9wE+Lwo1
         hSvyeRrLoSk6AFeUmEYfjYTlhcy4nbP2R2Jae6lAPSuLw3IAnZyaeV6wueM7cRJmHkkP
         tQ9/fn1nHoZoMfTZzGB8snZap06ykjtqtc54l8qVjB7YOA8a0K3OApC0wvPCyeQZkRU8
         waD830DqShtRN9ngO8jPwHINTxt4OqU4wpQ5Q/IV7UKC5Uvkcv3deiX4u4n6D7UkCrZC
         cuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=/uQ/wY3O2DLvXJF7aFLpTR8jumBRrfJ8jOdYLRZtLo8=;
        b=ujNL/IqeiDDgKB1C7a210NRPpUEEAULnGnrG50knIqdt3U53IWyKrdN6FSC6k6VH/C
         du2psNF+UnFpyGMc23muNWc0wUSGre6ElTl/5NHIg5VVnTzhFkwcb2D8cTdHBr2vGqnq
         H2MNB6Q4CLw+yn3XnpV/Jr1QUbWBn/AFVKPAH0tqQN5PWWk/FdO/myP4cTjWj+4awIL2
         /1xRda7ons44T/b5g8EhgS3Td26X3cGAKIiNGZWhT1rf410NNUQ1LUm/20pAkAscUqyr
         /8kuNtywSz2OIW/M4TppHFsjAXZUJl6ll6V9PiyssFDAYtanezRGOeXRXqUdWMjcFgUk
         Yp7w==
X-Gm-Message-State: ACgBeo2wZneeOGtgIrCUVNPFdUu3hUGekXfJb5ScF14RfuSbjGbMlykL
        1GrQcuLe0Y1H7FDk6Zz8cL8=
X-Google-Smtp-Source: AA6agR55xJkCfxV6OLU96mVD2/tioTzRPpYHgfRAaWDuPmNShq/UgwW8dtjkmKnYAMxVmcPhpHosXA==
X-Received: by 2002:a5d:5a9b:0:b0:225:3fa0:f9ca with SMTP id bp27-20020a5d5a9b000000b002253fa0f9camr1300706wrb.204.1660932631772;
        Fri, 19 Aug 2022 11:10:31 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id j14-20020adfff8e000000b0021f0af83142sm4595441wrr.91.2022.08.19.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:10:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP6Ry-000qJe-0B;
        Fri, 19 Aug 2022 20:10:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/20] builtin/reflog.c: let parse-options parse
 subcommands
Date:   Fri, 19 Aug 2022 20:08:22 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-17-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-17-szeder.dev@gmail.com>
Message-ID: <220819.86lerk5ckq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> +	parse_opt_subcommand_fn *fn =3D NULL;

Re the comment on notes.c this is a bit like that pattern...

> -log_reflog:
> -	return cmd_log_reflog(argc, argv, prefix);
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT);
> +	if (fn)
> +		return fn(argc - 1, argv + 1, prefix);
> +	else
> +		return cmd_log_reflog(argc, argv, prefix);
>  }

Maybe more obvious (untested):

	if (!fn) {
		argc--;
		argv++;
		fn =3D cmd_log_reflog;
	}
	return fn(argc, argv, prefix);

