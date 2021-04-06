Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D29EC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A07461359
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhDFKdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhDFKdF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 06:33:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69AC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 03:32:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y2so7247393plg.5
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tUuS6isf0Q2u847k0T7nVTlwgnni3T0DlC1CsCRbBkw=;
        b=rBfnQwFyp0G8cjnKchq4Cq2d+sm+aMpgyBEjig0WRrvKDxQIXj1GNKxAsOCtbLEXow
         XcfljThQ5t/eOJjHrefcm00yiNFXR2fOVcWbCbD/4cDvW1HpShpkF2bk4nyKnIBNHIBn
         R9dgobhxmGLTC5GaVh96tPXclZ7+B851WdTkWKjEucPA0b2dinIypZxCQX2zMwFjqNdx
         003XhOVYcEp4GDfBN/d0KhCVm3XN/TNGhuo3V17sfdY+Yi03T9YmUvpX44/4fizASfF9
         2EVxy6ytOfQvB9vUwCy82j+QebBRZSI3nGu0VLqGzOMhs4iEtSdf8JIeo9K4v92Dipe9
         mRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tUuS6isf0Q2u847k0T7nVTlwgnni3T0DlC1CsCRbBkw=;
        b=iy6ycj8eBucoi8fFOx2PMCar0wKo2vKvOTK5LUMQ/2ucWvkWaXS38j3ZTUZH1p0CHT
         zT1wsL5EwNMFpoOLKkxp6BWXGtgOyg4QFYEo5mxbB2NBnYhst8f1afdR29HmF6YyDhvv
         2V02GxuMhYccDF4zMGk5qfENdN2OwvxcE8vnNwFB+HPCRkyQCAS/dvFGlhmzg2ITcuEX
         LPuScujNBGAeyoe20Ftoj89M9A8rSMieqb1p8Ub7ovgUMTxIsHoj6uP2RDuQBGO+9HeW
         4g5b8DcYux/fnP6psmo/s5vIf6jFxO1yX+J1qDYw4n91NNWKtWwGAsONCniF69g6Fb6C
         KM5A==
X-Gm-Message-State: AOAM530lFz42QgeKEBBp0js6Fe3cnhLhkDQIw1Adm+pNjHQvFa/mBb20
        E3LirwPF1+tVGl5RosyGON8=
X-Google-Smtp-Source: ABdhPJw6vVw7QXoEtUwLTzWjpysmbaWnHhGFLpOlz3TlCXX9C8U0IsvP6bEGI3WExnKaUgGc9hLYYQ==
X-Received: by 2002:a17:902:24a:b029:e8:fe62:2840 with SMTP id 68-20020a170902024ab02900e8fe622840mr10359161plc.71.1617705177329;
        Tue, 06 Apr 2021 03:32:57 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.157])
        by smtp.gmail.com with ESMTPSA id h1sm17176968pfc.122.2021.04.06.03.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 03:32:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC][PATCH v2 1/1] userdiff: add support for scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <4a9bdf0c-dc0f-a0fa-5c13-2b4732d21ca8@gmail.com>
Date:   Tue, 6 Apr 2021 16:02:54 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86EBA5B6-2DAE-4D4C-BCCD-46279595FA75@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <20210403131612.97194-1-raykar.ath@gmail.com>
 <20210403131612.97194-2-raykar.ath@gmail.com>
 <4a9bdf0c-dc0f-a0fa-5c13-2b4732d21ca8@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05-Apr-2021, at 15:51, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>=20
> Hi Atharva
> On 03/04/2021 14:16, Atharva Raykar wrote:
>> Add a diff driver for Scheme-like languages which recognizes top =
level
>> and local `define` forms, whether it is a function definition, =
binding,
>> syntax definition or a user-defined `define-xyzzy` form.
>> Also supports R6RS `library` forms, `module` forms along with class =
and
>> struct declarations used in Racket (PLT Scheme).
>> Alternate "def" syntax such as those in Gerbil Scheme are also
>> supported, like defstruct, defsyntax and so on.
>> The rationale for picking `define` forms for the hunk headers is =
because
>> it is usually the only significant form for defining the structure of
>> the program, and it is a common pattern for schemers to have local
>> function definitions to hide their visibility, so it is not only the =
top
>> level `define`'s that are of interest. Schemers also extend the =
language
>> with macros to provide their own define forms (for example, something
>> like a `define-test-suite`) which is also captured in the hunk =
header.
>> Since it is common practice to extend syntax with variants of a form
>> like `module+`, `class*` etc, those have been supported as well.
>> The word regex is a best-effort attempt to conform to R6RS[1] valid
>> identifiers, symbols and numbers.
>> [1] http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-7.html#node_chap_4
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> [...]
>> diff --git a/userdiff.c b/userdiff.c
>> index 3f81a2261c..ac1999bbc5 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -191,6 +191,10 @@ PATTERNS("rust",
>>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>>  	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>>  	 =
"|[-+*\\/<>%&^|=3D!:]=3D|<<=3D?|>>=3D?|&&|\\|\\||->|=3D>|\\.{2}=3D|\\.{3}|=
::"),
>> +PATTERNS("scheme",
>> +	 "^[\t =
]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[=
-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
>> +	 /* All words should be delimited by spaces or parentheses */
>> +	 "([^][)(}{[ \t])+"),
>=20
> I think it would be nice to match single '(' and '[' to highlight when =
they have been added or deleted - I find this useful when I get a syntax =
error. Also it would be nice to handle r7rs identifiers like | this is a =
symbol |. Maybe something like
> "(\\|([^\\\\|]*(\\\\|)*)*\\||[^][}{)( \t]|[][(){}])"

My patch seems to detect additions and removals of singular parentheses
already -- I am not sure why it works, but my suspicion is that the
userdiff code seems to fall back to some default rules for additions and
removals that do not match the current word regex? Either way that seems
to work.

As for the R7RS identifiers, I can definitely add that, thanks for
pointing that out!

> Best Wishes
>=20
> Phillip
>=20
>>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ =
\t\"@',\\#}{~%]*).*$",
>>  	 "[=3D{}\"]|[^=3D{}\" \t]+"),
>>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",

