Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE12610C8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhIIHyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 03:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhIIHyV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 03:54:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24699C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 00:53:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eb14so1410068edb.8
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Bw5sKjZVdSVVbz9MkUs9/9XQGfI3R8zENABNuuXSZ4k=;
        b=GLvoqMG3u7t5fh8nLZJLTj76f5e0sIvzr4Ifj18TEzf5N4afoOd7gR6vhxVJeOyRC0
         SmYtBLF8+c9paPWrcAp1MdJsBnBJcNCXyzJMHm8B1KtEA0ArvPM5yqVVUy9LhHZpagpU
         lVjse01PNAYCN7yogwI4+YXd3RgReO/+cCeAU3vgHrg+VCsRNPTx7DG/+Rl+WoGkdM/u
         yABMmCMC5H/3c9Uj49kDQZTlO1RmPgw4b9Z1QdJOu3VpW/SXgRwESDW7OtZKzijR5ejU
         zzaDr2NWXq+F9AXpktXVSv/iOm96x/XXjsadn/h7U4MjgZkhGNdkUV/qdj9LK0/+uwuM
         03pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Bw5sKjZVdSVVbz9MkUs9/9XQGfI3R8zENABNuuXSZ4k=;
        b=U/n0OsiX/0rBr8ukwg5MWvh7eOgmFttTAgsZMKaMqeqQLjW8dgzUay/LRY3YXUd5VD
         bI0ENDYKXUUqmGTfP21d7jYXLGIbQz69Jur8hhnmSQ05UOMr93tws5lBIwMfyiJBNjZA
         kHrQothixmCjdXBbbCaEgOucE0WS+u+5mzUPMvRSda1H/OJclY+CtTuP6W19UUAUE7N8
         yKPzZDx/Xcs1MbRIA+n/SyODkeJwJG7nvFpyfrm3m9qCsSuiEEdk2+U0fl3/lvsfiC1k
         bjdE/Q4YEvv3KlIV+HkkW9LiPo5OtnBc/gRpF89osGdwVKx3YVMzrgX1JlLsRy/pyvEs
         WOmQ==
X-Gm-Message-State: AOAM532Ce20CYtM0QbfNkV0Fim4o7PHqlkZnlgKltrxkV/vOHpgus1PG
        mQfXqlrhKFZuWrmDCOHkjBs=
X-Google-Smtp-Source: ABdhPJzPaXSdTGC5lQcMmh0DZzJYPRXm8WLSEYWAFfSgajfKhLflcDRFpuEI48d/jY/o5i7KH7hmLA==
X-Received: by 2002:a50:bae1:: with SMTP id x88mr1800287ede.345.1631173990729;
        Thu, 09 Sep 2021 00:53:10 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gz22sm480380ejb.15.2021.09.09.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:53:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 7/9] builtin/index-pack.c: move `.idx` files into place
 last
Date:   Thu, 09 Sep 2021 09:52:47 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <8d67a715014b9daa9a6ca3a77be647e733324522.1631157880.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8d67a715014b9daa9a6ca3a77be647e733324522.1631157880.git.me@ttaylorr.com>
Message-ID: <87czpifamz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Ditto the comment on 4/9 about duplicate Signed-off-by headers, looks
good otherwise!
