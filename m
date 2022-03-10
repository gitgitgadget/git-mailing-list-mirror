Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFF6C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbiCJPKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbiCJPKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:10:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4587DAB1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:03:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c25so5196653edj.13
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wMxu13JFvBsz0JtlmwPZGw3xmWUWYwf10g5P/Ke28VE=;
        b=PVlOV9rKde3PykQe63diG0w2zEDSy43pP95vRSlTbRjEUvaFmDfySDo84KVq9zF/ST
         S50s/zGWoV2HhxWs9TTcOVdMwQ3+ezWoUwuH/y1bCVh5w6ORr1xQTfsvNu6Bp+zaqlzm
         yh9RGG5Oj+O9QeM3pYiDGoDFhRAtBepuB99BoBE9+8d1xAQQoBbGoBT6vFevctjodzom
         SpEJ5+kfSnsZLLqp695jQ9ASq5rLo0ZY8KNYq8zugZch4RPTVUjekoerARrWxoudtxh4
         LK3vYch9UAQ9YAy5B/OVlWTS4fvT6pp//1Lia9MVgmmV3bzyIYtG6HTomoIO0KSeXyTA
         5czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wMxu13JFvBsz0JtlmwPZGw3xmWUWYwf10g5P/Ke28VE=;
        b=TeqrydvObbCtpOeOrEaMTg0O8u+EnSwdIgzU/sMt/hl2T/9WGBgkTrTd6r83O6qy7l
         i/KL0pL70YvYH5Ys3sne6z1d6huWUwitCPaXHvyyOwrtrxqizAB2BEJTitKxABZhmJTU
         bsHnkIPNEJWMgOcNNR82dp3g1q7f1HPFFfk1RyUF/XIfjbw+KoF2cVyGIbx3m011sECd
         U4ScLWnx+GqX8JW/LZpezTJ0Zyw/TGWZIZhzahnoYSPDhjMcCxrLME9KV9ddLOJjVUa8
         bsqhe6fwtfdzG7owVsnJc/ccXZVD9ssan8Cctjwks6Uc5M9lDhHVQe+B1DwFr9QqmzYc
         vYjA==
X-Gm-Message-State: AOAM533XLG1cEWGtrJZWMxXlmFF60o99o24hPWg4J6JSZNLIS12GFEEb
        AjDBf9OpGcYJuYt/UmYaZA0KSc2OD3hoUQ==
X-Google-Smtp-Source: ABdhPJwWQGMeVGnHqp/6CR12gxypCP4KQVmSYoCoW37e0jstu60o54Kh/JDBzoMU2JZIcxG2xEC2EQ==
X-Received: by 2002:aa7:cb18:0:b0:413:3a7a:b5d6 with SMTP id s24-20020aa7cb18000000b004133a7ab5d6mr4691558edt.254.1646924595216;
        Thu, 10 Mar 2022 07:03:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b006da9456e802sm1888353ejd.102.2022.03.10.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:03:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSKJt-000Xlv-Sg;
        Thu, 10 Mar 2022 16:03:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/24] revision.[ch]: provide and start using a
 release_revisions()
Date:   Thu, 10 Mar 2022 15:57:28 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-05.24-b89dcadcc22-20220309T123321Z-avarab@gmail.com>
 <xmqqmthylonj.fsf@gitster.g> <220310.864k46lk7x.gmgdl@evledraar.gmail.com>
 <xmqqee3aipbz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee3aipbz.fsf@gitster.g>
Message-ID: <220310.86wnh1j1e6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> So I'd prefer to keep this part of the general structure as-is,
>> i.e. even if we do nothing with "diffopt" *yet* we can assert ...
>
> Please don't.
>
> It will become hard to tell during the patch progression if "we can
> do so even though we do not need to do so *yet*" is correct
> (e.g. diffopt---which does not have a separate allocation to be
> released), or if "pretending that the field is cleared by _release()
> function is premature and will lead to a new leak" (e.g. if you lost
> separate clearing of .prune_data at this step, that would be an
> incorrect change because it does hold on to an allocated resource).

For a v2 I've rewritten those sorts of changes out. I've bundled them up
to a commit for "diffopt" at the end, even though whe don't free() it
yet.

Depending on what you think of that change we can either drop it or keep
it, but in either case it should be obvious what is and isn't in
anticipation of any future free() we aren't yet doing.
