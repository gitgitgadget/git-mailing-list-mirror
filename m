Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4711C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83041613BE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhEFGZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFGZD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:25:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420AEC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 23:24:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so6546695ejc.4
        for <git@vger.kernel.org>; Wed, 05 May 2021 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xVnvGofnA2rej2/Ab1EQbwMk5TLQkJKDyWlxUYLJx1g=;
        b=JIcr2IE1OB2VBkpAsf33MlxmUDrmNoUsNTY5hxQjPFsPSDvS68AOW6l/cyq/FvyGi3
         l3pyxFPBJWO2OAUZ35gpaR8n4J3BLsh4hqZSog+TQ4dTdmgkZARrWvm3Qj0xcAb8gC+D
         2hmfnj9bPpfAfGVXaI6GSf3RvrvaRMvnACdV0LSzMViM5ykwvjXcm88zLtFIjRs6eGa1
         dqSX/HWs7i/6XvgXBfqqDisnCvT/6Cr0Tgw928tDeG3kTuMNQ72iu6YS5jY2LldOLi/Y
         Lgjm7Z7WETlUC+0W+ctPI/gz9vWWDDFOb4o8FwcOFJ0XLyCRtX2tEBFDi9CsjdtX1zOt
         M71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xVnvGofnA2rej2/Ab1EQbwMk5TLQkJKDyWlxUYLJx1g=;
        b=j5lC+QdButkb7gXg3qgr30TYcx6TfiWmJ+H8ASUPkSIKOKLRWv6sKIY0Us12RzXO5t
         WYf4eJ5ia1uTi4ZXRkIcXKcioAHTHSm3sI/5JvKNui5MZxdZrwqjUlKz7pWmk2HJUvzL
         dTeJJ2gGkvXmL5QV8V7AqLcZrbgfB137F/VhrFmexX4AmfFbQqzkkTURaySw25v0KVhZ
         U8CXvk5SXCCisFU++IGqd0C5bVTGWmu1McQlb4fOsYwyaqsgZYptpG6ItJ9J4a4ptv4R
         nCgPBwjFctEe/MxtucI4vzLz5B4aGEZ+SmuIvSrhbS3U06Uiv9N/RAR9vlppzGVu336S
         6qKQ==
X-Gm-Message-State: AOAM532DUkK5N3ccoiq8+yrv5BGCmVLN2mBkit5mau0UXqVlXzyFY0/Q
        HHyNargmLZj2AgoAJBwSiZQMJgwXvfml6LF9
X-Google-Smtp-Source: ABdhPJxXQmVIHEUTQHkySu1I3w2QM7EdVLeAY+I+dV1y+Wfy4Z/VhGV4UFKlMO+GvWMN6/bfm6LvXg==
X-Received: by 2002:a17:906:63d2:: with SMTP id u18mr2710791ejk.186.1620282242675;
        Wed, 05 May 2021 23:24:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g26sm728611ejz.70.2021.05.05.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:24:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
Date:   Thu, 06 May 2021 08:23:28 +0200
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
 <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
 <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
Message-ID: <87y2csv0qm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 05 2021, Jeff King wrote:

> On Wed, May 05, 2021 at 02:21:38PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
>> 2018-04-10) we have been declaring PERL_DEFINES right after assigning
>> to it, with the effect that the first PERL_DEFINES was ignored.
>>=20
>> That bug didn't matter in practice since the first line had all the
>> same variables as the second, so we'd correctly re-generate
>> everything. It just made for confusing reading.
>>=20
>> Let's remove that first assignment, and while we're at it split these
>> across lines to make them more maintainable.
>
> This and the other three patches all look sensible to me.
>
> I did have one question:
>
>> diff --git a/Makefile b/Makefile
>> index 93664d67146..1d4c02e59d9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2270,9 +2270,10 @@ perl_localedir_SQ =3D $(localedir_SQ)
>>=20=20
>>  ifndef NO_PERL
>>  PERL_HEADER_TEMPLATE =3D perl/header_templates/fixed_prefix.template.pl
>> -PERL_DEFINES =3D $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
>> -
>> -PERL_DEFINES :=3D $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
>> +PERL_DEFINES :=3D
>> +PERL_DEFINES +=3D $(PERL_PATH_SQ)
>> +PERL_DEFINES +=3D $(PERLLIB_EXTRA_SQ)
>> +PERL_DEFINES +=3D $(perllibdir_SQ)
>>  PERL_DEFINES +=3D $(RUNTIME_PREFIX)
>
> I don't think we generally use simply-expanded variables in our Makefile
> unless there's a reason. Do we actually need it here? Obviously not new
> in your patch, but just a curiosity I noticed while reading it.

I didn't notice it at the time. I suppose it could be changed to not do
expansion, but per-se unrelated to the more narrorw bugfix in this
patch.
