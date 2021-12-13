Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74523C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 09:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhLMJgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhLMJeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 04:34:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B18C0698D4
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 01:34:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so49753341edc.6
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 01:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aha2I0/uExErhUIHlZLrnGlzF8l4G3cQQrpMsBV+/q8=;
        b=SnHcRCFNtfv2/qBVnX/J/dYr0vr3f9S6Hgp/vVxffe9lmK+OWKiRPlQj6ih91YQAqJ
         BzwQAuvDTxVS479JBo3+kQVwpKXuqvXrE8w8MAJy9s3UN79VnXMu7ql04J/xXcnKOlbG
         8t0aqGtG/N9gSTbqk5PWFtR6d/sYc4YEp01MrYTzgUqyZjlDb5lVTN8cKEC8HFC1D5eD
         qc5hRlyg8HhcczLDZVUW0KlUIZgI6sbZXGQiN7GXbulvnTFTJxKeJ7Hh9n+u21/SjPEd
         ab2UlXcESRg5PvbdLGkvYgyMipj1qkYNq8C0VqMUW+ChX+/qgLITAvLiLeX5uiGPP1m/
         NyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aha2I0/uExErhUIHlZLrnGlzF8l4G3cQQrpMsBV+/q8=;
        b=qdsZb76uzpWOt2VOPUVJyEEhCXMs/6MZinLtlWyEv8tzthTtSWbW6WxBLvdAVn7AtQ
         9Mi3SWRLLdvzxvxlpfN7DnH9hCz61jB4Ml+OemzqwoNCsU6SLtKLGyCp22ebjpA4onzk
         BBja2Qp3oAxFTuIb1HPrygMfxUvjdSVavjHRVhhEcOq2bppKOEynC2sBTtS5YVy9bDuT
         FcpsgNYVPSYu9GFYy29zEa5B/zWYm6/OGbbLL4VWCrtKA4soe92zBiD2ufQPv8BzGvbq
         8rVks+vKwXdxpGzzzkQcQVysnvLZgo3Nmkb+Ql4jDpcvKWE8Qd8qZ+wrhPy9g1y8Ktgh
         VGug==
X-Gm-Message-State: AOAM5327LcsD8EsvDNBAzeL7UVyv5u2lvd2PWri45K6cgLMjNNWuNv1/
        VMFGCBUKG9Wsw5E0wvGHgNQ=
X-Google-Smtp-Source: ABdhPJzG5wxptrEp4wJLSHf/g2euajCVPPTeNF/M1j+UMDH53ZV8uB2QCL/LdIWsj/fx0EY6MlXHhA==
X-Received: by 2002:a17:906:1256:: with SMTP id u22mr44177596eja.317.1639388082395;
        Mon, 13 Dec 2021 01:34:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ck12sm3304745edb.53.2021.12.13.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:34:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwhjF-000muc-7N;
        Mon, 13 Dec 2021 10:34:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>, Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/5] git docs: create a "Git file and wire formats"
 section
Date:   Mon, 13 Dec 2021 10:33:32 +0100
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
 <patch-v2-2.5-b2d73f8c9da-20211212T194047Z-avarab@gmail.com>
 <CAPig+cRb5G7y+Sn3+dQYQq51mTCDTUg1mcrGLjJJ3uoreJ0dsQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cRb5G7y+Sn3+dQYQq51mTCDTUg1mcrGLjJJ3uoreJ0dsQ@mail.gmail.com>
Message-ID: <211213.86y24o97bi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 12 2021, Eric Sunshine wrote:

> On Sun, Dec 12, 2021 at 4:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> diff --git a/help.c b/help.c
>> @@ -38,6 +38,7 @@ static struct category_description main_categories[] =
=3D {
>> +       { CAT_gitformats, N_("Internal file- and wire formats formats") =
},
>
> Should this be: s/file-/file/ ?

I meant to write it like that, i.e. as a shorthand for "Internal file
formats and wire formats", but I see I included "formats" twice, which I
didn't intend to :)

Anyway, it's probably best to just drop the "-" there, and of course get
rid of the "formats formats" for just "formats".
