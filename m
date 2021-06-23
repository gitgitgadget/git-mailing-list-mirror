Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15747C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 20:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7D9610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 20:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFWUyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFWUya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 16:54:30 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5AC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 13:52:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so3338495oti.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=i9irubmaWFC/oevAqp1dBJZPtxiCOmStTx/l/PhZOk8=;
        b=jRhBezVlZ3qfOE6qA9aldsXBFEdiCsqtqHHbhvtc9TbTrM2M3Vk4zSgjWwsMs+JUiD
         f8AWdtYvKTjOq+Tc/a35s47QA8/0R7j3j1zrPkIiLxyrg6tlO87toJPk6NSz/Edr81vA
         2XRZdOPfNJhDCu0Od/qgnXVN4qTqSQDoVAcuCNvRzR+14sDQV6YJdJujDv7uDg4LmDNc
         0uFsREKADb4cz6/fvGarmbrQ1bm1cwahtj8CK9F3vPTf9zxm3NEQN53PTG+Zvf4X5KGU
         4K1zZ+DP2CuoELA8zTk93uWVZUcpHYLJqngjWFZ9sI9gbC2mgMf+MHhMP1tDo2xfO713
         6Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=i9irubmaWFC/oevAqp1dBJZPtxiCOmStTx/l/PhZOk8=;
        b=Ik96W9YYj3MQ+4lnRcFVHiKa8jjsTeJJxuNiUhSy0IdLt/s4q3HTcjsQUfF77Bwi1W
         2dFwo5pZjJCP4nTch16HXPryR8R46RiRdJ7ggWR7xkK/yIHI/xAP/EG61Yaok5V43zXM
         JSxw6t/JRf+uyUBv68XqkRVGEstmnPYTCp7rxhU4fTE6jLpsx7yrv64AzPuszJMp6Okk
         XwnbL69R9qbW5PFensuc48JhwNMyqMzjvA53hVYgRCQGjYDSZeWhvkoLdc00lujHsIyT
         pp/NIgvg4Ddg0kNoqtqgEV9rUol3zC4UiDK/SmaRxUGoxjuijMUYxcZE+l1Ds1GsVw9Y
         xfxw==
X-Gm-Message-State: AOAM530taFw7e/GtCLGC0qcwSnQ2XqH3eK72HAoP+keyn7Bts3clvrjw
        NowNgbHOpoj7WKX8j+N+oKg=
X-Google-Smtp-Source: ABdhPJw+KeVFZsnIQv4yzPFFznLmWmcZn9ZRIdolk3QKx5kLp7wgx1abhmCf1gPR9nBUcucQL93zKA==
X-Received: by 2002:a9d:5f07:: with SMTP id f7mr1577586oti.183.1624481531572;
        Wed, 23 Jun 2021 13:52:11 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l3sm195431oif.49.2021.06.23.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:52:11 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:52:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Message-ID: <60d39ef9a8071_429020896@natae.notmuch>
In-Reply-To: <87o8bw1hc5.fsf@evledraar.gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d389d015943_4290208ae@natae.notmuch>
 <87o8bw1hc5.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, Jun 23 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> @@ -2243,7 +2253,6 @@ SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ)=
:$(GIT_VERSION):\
> >>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
> >>  	$(perllibdir_SQ)
> >>  define cmd_munge_script
> >> -$(RM) $@ $@+ && \
> >>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> >>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
> >>      -e 's|@@DIFF@@|$(DIFF_SQ)|' \
> >
> > Any reason why the same isn't done for the $(BUILT_INS) target?
> >
> >> @@ -2514,7 +2522,6 @@ endif
> >>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> >>  all:: compile_commands.json
> >>  compile_commands.json:
> >> -	@$(RM) $@
> >>  	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.jso=
n > $@+
> >>  	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
> >>  endif
> >
> > What about these?
> >
> >   $(REMOTE_CURL_ALIASES):
> =

> Uses a chain of ln/ln -s/cp, would need to add "-f" flags.

Why? Isn't "x && a || b || c" the same as "a || b || c" if x is always tr=
ue?

> >   $(LIB_FILE):
> =

> Can we rely on $(AR) happily clobbering things everywhere? Not knowing
> is why I skipped it.

We have c (create) in ARFLAGS, so presumably yes.

> >   $(ETAGS_TARGET):
> >   tags:
> >   cscope:
> =

> Addressed in the related:
> https://lore.kernel.org/git/YNH+zsXDnRsT3uvZ@nand.local/T/#t

I think ideally this patch should remove the $(RM) and the other patch
should focus on the rest of the changes, but given the difficulty of
landing chained patch series in git I understand the decision to clump
them together.

Cheers.

-- =

Felipe Contreras=
