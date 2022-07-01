Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C6C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 09:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiGAJ0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiGAJ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 05:26:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3452873934
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 02:26:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lw20so2968304ejb.4
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=C2lAb+dVzeRGALO9bm/Ql1Kt3K4OwmOr0gnkiYibe3A=;
        b=W8KVqlg1jztmMLZg2Pe6yjaMYmzBaH42NkkSRMLoV4D7pgxtnqokMDnZjry+Yza3Fu
         PFDyPibe+RgYjq5M/8ZJfJ3TK8utWtXNcEFwvg7KenP4rYNTvj4ahshQ5o4XPOrMh1kW
         MlEJO+K+RxfYFvbZQWb/p2ISFJW+cfPiq2pc2VhYvpr3S3h9o0sgVe+U8SimBM3oaqEN
         rs5sB5UIzzLYMtmAfghNvdw6UJUhR/AiEBJ0IA1vBhGE4CbxP1qNoyaZ/sRxuNuYDNGJ
         GswuzR5Hm5RCv5k22apPPkAQ2EM8r+AEfz8gp+5QLVp2GB5GxtouLYbLXabTH4oXK1vJ
         D+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=C2lAb+dVzeRGALO9bm/Ql1Kt3K4OwmOr0gnkiYibe3A=;
        b=VUVkWyAtUF+uZAt7j5/VGR+C+O29otpiD95QI36RTn0juIVAh++tP62MzLZKq0BThM
         5nbz+rDDWFPGhx8N54NBNPwqPQag6g4pPkguLXoqsh9nmd3c1gi7iGFyXF89TuzqTxHs
         wnA/ddjS+4/xXWPJU/N7vXHEZAfddqyw9Epp8Anx6ARGtUDjk0YumI5d/8CY3aFWET8m
         vPp6EUpqWyg9I35AwtSTRP8+IHuSXcdlZeHV9I8vc8JcFfxA6dZUloWa8DBXyv6SlPH/
         lR5wys284kigsM+KpHO/+vTsBFdZGCgeMv0+OXLMULQHMw3HhWGHMBQ9ZoLsp/LOwjcS
         eZWw==
X-Gm-Message-State: AJIora+vooPQn+KqMbYTlLlYTp8OGCZ4y3y3Q2zKklmH5ayVOxt/Xd4L
        s8CeB7TEJcMjn6d8w5jrN8+zQf79S6asHQ==
X-Google-Smtp-Source: AGRyM1uOHLA4UlAv75TIzRKy053Ai16Cwmalfcfc5YDAXoYWCvjh5o9QPGvVJQ/ONftqKwXeYfcwiQ==
X-Received: by 2002:a17:907:76b2:b0:726:d02f:dee with SMTP id jw18-20020a17090776b200b00726d02f0deemr12919000ejc.249.1656667570602;
        Fri, 01 Jul 2022 02:26:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170906e94c00b00722e8827c53sm10150147ejb.208.2022.07.01.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 02:26:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o7Cue-0039BC-Ga;
        Fri, 01 Jul 2022 11:26:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] test-tool bloom: fix a memory leak
Date:   Fri, 01 Jul 2022 11:25:54 +0200
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
 <patch-7.9-bdb467d1414-20220630T180129Z-avarab@gmail.com>
 <CAPig+cQeR6Ku-RCEa6qvrzq7wF+cSDYRUREofwDTeYNB-iw7JQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPig+cQeR6Ku-RCEa6qvrzq7wF+cSDYRUREofwDTeYNB-iw7JQ@mail.gmail.com>
Message-ID: <220701.86fsjlb2vj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, Eric Sunshine wrote:

> On Thu, Jun 30, 2022 at 7:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> test-tool bloom: fix a memory leak
>>
>> Fix memory leaks introduced with these tests in f1294eaf7fb (bloom.c:
>
> pure nit: the subject talks about a single leak but the message body
> talks about multiple leaks.

Will fix, I was copy/pasting the commit messages forward & adjusting,
but clearly not enough...
