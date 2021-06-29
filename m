Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7849AC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4707B61D6E
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhF2IWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2IWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:22:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46656C061574
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 01:20:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id df12so30122499edb.2
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I2CWQEOnlseEJCyMYMlBNB7rGuVkScxFC8334Zyl7UQ=;
        b=Xw3igjQ3FaFl1BFU6AGOlTVlpj8Fma6i2fWj+78dr8AYz6BUVFPik5P0d4DqYd7V00
         yOiMtCOkt0CsJCSf9S88V+wth3CLvTCrA9JLwB6ZlmhZ41gdVXqk2MWm1W1ZLoDv23N3
         faHlR3LhqWPJQLeITu0SQBFIQD0rSmTER18vtQh7+EEGsUhO6xIdM/C212mopCmslXJF
         VA+DWb0hVIk1P07UiMAPIM8oZOt8rgdtWoNZM/MPWYo0d6KPrv8/E8YyVaxqB3xcwO9j
         33SwOEtolvf04iHZM1uCm4zLih70Kq+J7jCiis1pzCn+co+eBKHH2eopP0PeDtZ0h6IN
         ICyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I2CWQEOnlseEJCyMYMlBNB7rGuVkScxFC8334Zyl7UQ=;
        b=Mgb9EPP6xWKE/QL9epQ7W8YL5G2ZmJ2pjcOuVPrYBbdgQ9ndj4fjY8HyEtZY7IA5A2
         RQW2Z40NJnAJ94xPVYS9YpdzaUsEUp+lNY5iSNFOpBLEqFV0ceLVyiWF9xS9vD7+OiCG
         4oi73L5I+ET4VG4VA3loWRHYbE6RZfgL3PdWJf+7UhP0mRx99iNlfvXzCNrIs/sDJ8ky
         tV2YY8IYTAW18jbZfznzsY7XWRst1+Ue+MjN7vDjxBBQdC9Y6XVIz726Mgk9D4mDqukS
         SXhjbUWJiEEeXTm3v8MxtHEO+4yk2PqFxEvQ0D3LQaPZlCcVezbxxGQSli37aSdzwZmF
         tTEg==
X-Gm-Message-State: AOAM533BL8GJaAnqTthHa1sFnFTMHBei3hCT390fUeSvurSjz/CaP2Bi
        LkUJqQKIFE2iNWs3wcCR0A4=
X-Google-Smtp-Source: ABdhPJzRNVzjLu0iuI5bugqNyhjpijEFB1WsBINMEqC+ShsOb/VSvcuUkuUeiL2BF8EldK4P3w2DiA==
X-Received: by 2002:aa7:dcd5:: with SMTP id w21mr37870674edu.144.1624954803669;
        Tue, 29 Jun 2021 01:20:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e16sm1603821edr.86.2021.06.29.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:20:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Tue, 29 Jun 2021 10:17:43 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d389d015943_4290208ae@natae.notmuch>
 <87o8bw1hc5.fsf@evledraar.gmail.com>
 <60d39ef9a8071_429020896@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60d39ef9a8071_429020896@natae.notmuch>
Message-ID: <8735t1gk0d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Jun 23 2021, Felipe Contreras wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> @@ -2243,7 +2253,6 @@ SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):=
$(GIT_VERSION):\
>> >>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
>> >>  	$(perllibdir_SQ)
>> >>  define cmd_munge_script
>> >> -$(RM) $@ $@+ && \
>> >>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>> >>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
>> >>      -e 's|@@DIFF@@|$(DIFF_SQ)|' \
>> >
>> > Any reason why the same isn't done for the $(BUILT_INS) target?
>> >
>> >> @@ -2514,7 +2522,6 @@ endif
>> >>  ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
>> >>  all:: compile_commands.json
>> >>  compile_commands.json:
>> >> -	@$(RM) $@
>> >>  	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json=
 > $@+
>> >>  	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
>> >>  endif
>> >
>> > What about these?
>> >
>> >   $(REMOTE_CURL_ALIASES):
>>=20
>> Uses a chain of ln/ln -s/cp, would need to add "-f" flags.
>
> Why? Isn't "x && a || b || c" the same as "a || b || c" if x is always tr=
ue?

It does:

    rm x &&
    ln y x || ln -s y x || cp y x

If you run that you'll get a hardlink the first time around, but the
second time around you'll fall back to the "cp" if you remove the "rm".

>> >   $(LIB_FILE):
>>=20
>> Can we rely on $(AR) happily clobbering things everywhere? Not knowing
>> is why I skipped it.
>
> We have c (create) in ARFLAGS, so presumably yes.

Will change.

>> >   $(ETAGS_TARGET):
>> >   tags:
>> >   cscope:
>>=20
>> Addressed in the related:
>> https://lore.kernel.org/git/YNH+zsXDnRsT3uvZ@nand.local/T/#t
>
> I think ideally this patch should remove the $(RM) and the other patch
> should focus on the rest of the changes, but given the difficulty of
> landing chained patch series in git I understand the decision to clump
> them together.
>
> Cheers.

