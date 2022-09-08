Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD2C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 07:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIHHs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIHHsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 03:48:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2731D51CF
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 00:48:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gb36so36048539ejc.10
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=Y+5ZOOCpsoBAH3AMcWY0TCGhrJFK27mF6ZlYVb+CEO0=;
        b=O+hdXwaE5OIhzfp5YREWAVP0H0JhWZTBqBayOBY8/CF2QDd3pQXetvlAbHLoYe7IDY
         lwhaR2jftFkdbN8FyI7h0aArl0QyH6cE1w4WlVqsPgAUMlEGSQDE3cHGOW9/M2DreFwE
         bzrMcPHwyFDLzFakssQ21oQ3QIw+bMizo8T/eX+Cr7Z1VloGnM+w9Gq+bqp7jhitPf4A
         62M/cebtGghaQQ+PGT2I45to7QdNLTtkK1J1A3zhAwaaDkBJBFqHrYJdDktw9I1AEOaN
         A1J2Eo3XzMaAp02XZCQLHtdmWdCzvtwqAs23zDyUggOANdqztxCh7m5B4nGk0mr6nlv1
         s/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Y+5ZOOCpsoBAH3AMcWY0TCGhrJFK27mF6ZlYVb+CEO0=;
        b=K4mgwhQ0SIHcmeYjN3efQDrGjqPAQJyNcUzi8yI+fzdR+INT5WKmdGDS3ObgpJDyV1
         +2NWugJE4n1fEa2X962K6p/vCsd2VINNxKg/p8/4EkYoAzBWtCmucamgngis7eQEsJdl
         Y/DpAuZ08jdKlevSiRDqC+3Z39nGAeX4YXeyA/jZde5xS6o0gGeyggc+TVPTogKFxWL4
         UozXWuz/DusQA/9RYlMnyTMkTynp4VNVyul19OE238d3hPsoVA8gZOeHwyuAM4IrKMZq
         Bz6HXRRTfDT6puOj3uIDC2Rd4Mak5b59a4P/iOTFd31o/O1L8CGJSkuqkYs8bvMzq+lT
         O0jA==
X-Gm-Message-State: ACgBeo2y4VOwF4odc2KVa/FNC6+Ye6rMi/rGER+eIdTPwSOCMiwF925A
        XigwVYXacPqngBidcAsH2u0=
X-Google-Smtp-Source: AA6agR7WXWlhozuYH/KQLbIA7OW/GUEGDjdizvxtwXUuPowMoPFHSZb5pU3AgXLbxJOW7jymHcJX8Q==
X-Received: by 2002:a17:907:2721:b0:741:56e5:6802 with SMTP id d1-20020a170907272100b0074156e56802mr5061806ejl.675.1662623329138;
        Thu, 08 Sep 2022 00:48:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7d91a000000b0044ee18e5f79sm4411311edr.28.2022.09.08.00.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:48:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oWCHH-001HR4-29;
        Thu, 08 Sep 2022 09:48:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 01/34] CodingGuidelines: update and clarify command-line
 conventions
Date:   Thu, 08 Sep 2022 09:46:55 +0200
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <patch-01.34-b8cbd443987-20220902T092734Z-avarab@gmail.com>
 <xmqqedwnszsz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqedwnszsz.fsf@gitster.g>
Message-ID: <220908.865yhyl31c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 07 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> + Use spacing around "|" token(s), but not on the inside of "[]()"
>> + tokens:
>> +   Do: [-q | --quiet]
>> +   Don't: [-q|--quiet]
>
> It is unclear what "but not on ..." in the description and it is
> still unclear with the examples.  Does this mean
>
> 	Don't: ( -q | --quiet )
>
> In other words, "on the inside of" above is meant to forbid spaces
> immediately after opening or before closing a [] or () pair?

Yes, that's what I was aiming for, and will obviously need to
rephrase. I.e.:

 Don't: ( -q | --quiet)
 Do: (-q | --quiet)

> Other than that, I think these are good guidelines to have.

"Other than that" as in "let's fix that phrasing" or "let's not have
that concept as part of these guidelines".

I think the phrasing obviously needs to be fixed, here I was just
attempting to cover a blind spot where the guidelines said nothing, and
I picked whatever was the most common convention (as the rest of the
series shows).
