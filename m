Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BB9C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 20:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343996112D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 20:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWUDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWUDT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 16:03:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B6C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 13:01:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gt18so5778744ejc.11
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SsprVPE0pLjL0KxIC9O/Yyi88yGkgxSjlVjx6GZEhLw=;
        b=B5TrVdFAy1U5YTvvfBiboHbbqvEFoCCN4dZORQurlG+jeUfi90We1JJv0W1Lny2KdM
         ikODKblmO6ztyBbNatfwo6MzO0pUNvBUBWCC2Rz3VwUTQkitMwnAtboFgb59jvxPvFHA
         4xoKCYl2w5v8k9C+hxsDdXDPPtnqXRbNB8V4NvT+ZeIwL325q2t96Cd6gkkB8AMDoESh
         umHo2aLyciLVE/VaisSgX+FlTIbBr94uTre/R8IekHFnurA7IqooUivfKNV8qaAnMGuC
         Ay2WgwoYTJr+qTjeMZgXCA2pm99c6cIZccRyO/dXwURpJqldKAQWMNvfOxE6G7nllrHZ
         R24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SsprVPE0pLjL0KxIC9O/Yyi88yGkgxSjlVjx6GZEhLw=;
        b=NU6UmxzYsOnzdvH4bEsuxWyJOnSM5a6nplt+Eoo968x/fLbdZFdo4MHltYEKETn9xI
         O+aZ7AlmJ3QwaumZsNFYWvFxO+EhWmyc3p7L7j6RhX8O2sVRDl1oZjM9FfJk0xMXsnuT
         3pmdqioFrhqSZnGcvOOff6bC2Q8bUDuSywUQshM1eyGNwFvm5+Q+j9oyiCOtPk6As9QU
         D9E6vTV2rmJIyW2lEH5nsYCDzZefL0xj9j9N5wLDoW/gexk+e4YE0mk3UX/6c48am5Cr
         TO+h5i2bECXLf1b2QWjm5unsQWK/BTiNBLUa5ZlEjhQDvEEh3yXfZfdXH+Ev6NxtZwTC
         pbXA==
X-Gm-Message-State: AOAM532Q/H35lbahBEotKHZKCcQamzYIsi9CK7B9glMGCEjoU321jQeH
        7hp0CoxCKx78Uuk0zWGo/I4=
X-Google-Smtp-Source: ABdhPJzFhDTVew6wku8Jidw5C+N09pgwbrs5lWz5qm9haZEJEQhDT6AkBmbvCfe6J1Lysy0msiT6SQ==
X-Received: by 2002:a17:907:2a45:: with SMTP id fe5mr1727146ejc.287.1624478459177;
        Wed, 23 Jun 2021 13:00:59 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dj24sm590533edb.21.2021.06.23.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:00:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Wed, 23 Jun 2021 21:59:16 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d389d015943_4290208ae@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <60d389d015943_4290208ae@natae.notmuch>
Message-ID: <87o8bw1hc5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> @@ -2243,7 +2253,6 @@ SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(G=
IT_VERSION):\
>>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
>>  	$(perllibdir_SQ)
>>  define cmd_munge_script
>> -$(RM) $@ $@+ && \
>>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
>>      -e 's|@@DIFF@@|$(DIFF_SQ)|' \
>
> Any reason why the same isn't done for the $(BUILT_INS) target?
>
>> @@ -2514,7 +2522,6 @@ endif
>>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>>  all:: compile_commands.json
>>  compile_commands.json:
>> -	@$(RM) $@
>>  	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json > =
$@+
>>  	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
>>  endif
>
> What about these?
>
>   $(REMOTE_CURL_ALIASES):

Uses a chain of ln/ln -s/cp, would need to add "-f" flags.

I've got another series I'm planning to (re-)submit to fix those ln/ln
-s/cp patterns.

>   $(LIB_FILE):

Can we rely on $(AR) happily clobbering things everywhere? Not knowing
is why I skipped it.

>   $(XDIFF_LIB):=20

ditto.

>   $(ETAGS_TARGET):
>   tags:
>   cscope:

Addressed in the related:
https://lore.kernel.org/git/YNH+zsXDnRsT3uvZ@nand.local/T/#t

But yeah, the implicit point of "note that in the commit message" is
taken.
