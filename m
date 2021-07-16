Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E90C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B51613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGPSQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:16:28 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33AC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:13:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10781240otl.3
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3ZBN04sR0Tio1mRGdzEobgNDqGWepoD4dCUsL2aixi4=;
        b=Dpj92Xi8mxBNFcsI/OXTsYLooXyIXgiUQR1cXa72Z5vLjx9r7R8LRq3EI7Cp+zAebz
         cSN9EqLxWMusBm3EepEpukeijKNCY9TC1laNNM2FObxIS+tbXMjhk0BvUMXQuJ5nUXnG
         t9gik10KcIrIZ/SuB+5b1k1mN6eBRLGkhf5NgG2xfpETJZuyEVxCQtXoMTxCDJwyYn1O
         f7mgNPJZjiaiOF5ka5pvJv6soUWH06VJjZli8aN3+PrjTMimAzaW9EwWwj/IVt2p1T6r
         1jp4n2v1yDj/tMOqWhe88v3XSGDUku+av5nn9qkuWnli/rfz+YDrY8txRsxe6TI34EeH
         eepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3ZBN04sR0Tio1mRGdzEobgNDqGWepoD4dCUsL2aixi4=;
        b=atKr5a/SFJ5OGPrwR65/GT9iHx8ipH050MQRdwDVYo7LADerIL9Sd0bWNx8D4jNPXr
         Xm2q5k5PGoTr2TBIegxy2bHLMY0HctFvPdhD9mK26XYJiHSHmCpliGm4E+hZpZb2OL5L
         RNJz2eYclPvH2hiXA9SAWw/JmzawzuMgoDZxPCl8QxT3g4Z7tRzoHlP1fm0++UEOEeNz
         Lf/DZrudS9O16uzEZq25jBFBe+5OMbPRTGLRzKaCYQ3nI3rjG/XedffBwKOKiY7jdBYb
         y5FBgNov+SecKEcqeo+at+KoHezI2i3sdFCbPOwrE+y3JcEpB9px+TQ4Xp1SnNL4w0Zj
         ILRQ==
X-Gm-Message-State: AOAM532Vdb6aqbshO9d02pj0698SacUEbHyJGaEr/j9SSy6M45G1FfQH
        89J5tP7XlTGeW+AdRJU3qNc=
X-Google-Smtp-Source: ABdhPJw5Yx4n51Gnc/DOMgnJP8MLP9wlsqtKjBS9BQ8OK2wCXa/dn+X6MFN7uZrr4GjFRE5XPathnw==
X-Received: by 2002:a9d:7349:: with SMTP id l9mr9074866otk.207.1626459212382;
        Fri, 16 Jul 2021 11:13:32 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id k7sm1656919otn.60.2021.07.16.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:13:31 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:13:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f1cc4a71af9_3302082a@natae.notmuch>
In-Reply-To: <87czriy557.fsf@evledraar.gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
 <87czriy557.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 5/5] pull: abort by default when fast-forwarding is not
 possible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jul 15 2021, Elijah Newren via GitGitGadget wrote:

> >  int cmd_pull(int argc, const char **argv, const char *prefix)
> > @@ -1074,9 +1074,8 @@ int cmd_pull(int argc, const char **argv, const=
 char *prefix)
> >  		if (opt_ff) {
> >  			if (!strcmp(opt_ff, "--ff-only"))
> >  				die_ff_impossible();
> > -		} else {
> > -			if (rebase_unspecified && opt_verbosity >=3D 0)
> > -				show_advice_pull_non_ff();
> > +		} else if (rebase_unspecified) {
> > +			die_pull_non_ff();
> >  		}
> =

> Here we should:
> =

>     show_advice_pull_non_ff();
>     die(_("some much briefer summary"))
> =

> I.e. we should not being showing giantic advice-y die() messages, the
> die messages should always be brief, but we might also show advice just=

> before dying.

Indeed, just like my proposal does:

		diverging_advice();
		die(_("The pull was not fast-forward, either merge or rebase.\n"));

-- =

Felipe Contreras=
