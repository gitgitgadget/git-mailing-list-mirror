Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D52BC433FE
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiDNMxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243693AbiDNMww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 08:52:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D16DF93
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 05:50:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so6178340edu.10
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qeGSz/JzeCc43ey5gJ0dLbTdgePqigk8csFuJ7KRPHY=;
        b=ENJ+jwdvgQeoZntlUzMvtx8pSOjEBWdaCb2bx1pGYPGqDQnsJ2Fn0yXZx0BkEQG07L
         AjmUrd1GSZqV0AUvlLm1hMu53zdx0kaTTI/wV75lZvLKKnbJZ+TS/8rbA9XtKojPbsvo
         YT4sfzP4wJ4vwuVdCaIWouQC0DwF7AX5uHBKdD/zHhm5C1OZ83TpnuCSq1CBcLIR3OHy
         iwJZKuUJiAAW+Pzow9y1FZgqg5w7Bd2hHbpTXUmwbx+hgrJGiQf1C0wQUcPOltJ1rsP6
         60TB8WE80weFe8/GVw/QGjbJLOFEqKz00wtKM/ABS14G6EtIu4tealWgLbqRD1fzDj8f
         IvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qeGSz/JzeCc43ey5gJ0dLbTdgePqigk8csFuJ7KRPHY=;
        b=CIt1et/6ZSg+Rn1MUlQO2vjl8ctc4KmqJUtgAIk5JR3X1mORKGWc4Rijy1bNWfTWZe
         Jq8uhNoWtTdo2H3PQC/yovTs8IHVDirh3b8YLtZk3w6aGr9Qil7eVbQSL90nkn/EN3Uf
         M6UZs2CWRwjmXbLaPIxSNdjACVcUiytjJl27Ltc//Ce/g8NCfORLCnzRYyiM9r2Y9g6v
         qrsjCy/RT3UKbwy0H409w+qX7DeRPIELJHoqkBcsG18D5U2dsYSLhkDu71oKZ/S3+4kI
         dz6XZc/elb7Xy2ecdQPt5CTuPlUnP8cUM0jdvpda3O0PsHWZNHu5+M4TR1Kv/Rg2br60
         CJfw==
X-Gm-Message-State: AOAM530jVyP7pitXcyZE1UtepV/gluNZiDcJ0/M04SbVVmFrcTpaRH/d
        VUb6x+AESHE2Xi/b/qqhhVo=
X-Google-Smtp-Source: ABdhPJxiU8Nv8txttAM9AFdEkyS4prkN8Znw/T5rdnvKkRyPXoY7H4tmTmi3K8DZYUIOyofapAuS1g==
X-Received: by 2002:a50:c014:0:b0:41d:5ee9:f354 with SMTP id r20-20020a50c014000000b0041d5ee9f354mr2761856edb.257.1649940626509;
        Thu, 14 Apr 2022 05:50:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm963489edw.72.2022.04.14.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:50:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neyvZ-005PCy-Cy;
        Thu, 14 Apr 2022 14:50:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH v4 0/6] CI: js/ci-github-workflow-markup rebased on
 "use $GITHUB_ENV"
Date:   Thu, 14 Apr 2022 14:47:30 +0200
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
 <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
 <xmqq35ig2c6l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35ig2c6l.fsf@gitster.g>
Message-ID: <220414.86tuavde26.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> 6:  1d2b94436fc ! 6:  b291f64821c ci: call `finalize_test_case_output` a=
 little later
>>     @@ t/test-lib.sh: trap '{ code=3D$?; set +x; } 2>/dev/null; exit $co=
de' INT TERM HUP
>>       	test_failure=3D$(($test_failure + 1))
>>       	say_color error "not ok $test_count - $1"
>>       	shift
>>     - 	printf '%s\n' "$*" | sed -e 's/^/#	/'
>>     - 	test "$immediate" =3D "" || _error_exit
>>     +@@ t/test-lib.sh: test_failure_ () {
>>     + 		say_color error "1..$test_count"
>>     + 		_error_exit
>>     + 	fi
>>      +	finalize_test_case_output failure "$failure_label" "$@"
>>       }
>
> This part, specifically the following from [6/6], looks iffy.=20=20
>
> @@ -782,13 +782,13 @@ trap '{ code=3D$?; set +x; } 2>/dev/null; exit $cod=
e' INT TERM HUP
>  # the test_expect_* functions instead.
>=20=20
>  test_ok_ () {
> -	finalize_test_case_output ok "$@"
>  	test_success=3D$(($test_success + 1))
>  	say_color "" "ok $test_count - $@"
> +	finalize_test_case_output ok "$@"
>  }
>=20=20
>  test_failure_ () {
> -	finalize_test_case_output failure "$@"
> +	failure_label=3D$1
>  	test_failure=3D$(($test_failure + 1))
>  	say_color error "not ok $test_count - $1"
>  	shift
> @@ -798,18 +798,19 @@ test_failure_ () {
>  		say_color error "1..$test_count"
>  		_error_exit
>  	fi
> +	finalize_test_case_output failure "$failure_label" "$@"
>  }
>=20=20
>
>
> With the other 29-patch series applied on the same base as before,
> test_failure_ does not have such "fi" inside.  Misapplication of
> rebase or something?

This re-submission was rebased on "master", so that "fi" in the context
is from the now-landed ab/test-tap-fix-for-immediate.

I saw you'd fixed that conflict already, but figured rebasing before
submission (as usual) would be helpful anyway, sorry about the
confusion.

> In any case, I've wiggled both series in and rebuilt 'seen'.
> Looking good as before.

Thanks, the end-state of the resolution looks good, and matches what I
have locally.
