Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE6C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 23:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F5461078
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 23:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhIHX6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 19:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhIHX6X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 19:58:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54318C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 16:57:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id me10so7582988ejb.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 16:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9IglQ+obL1D82Vsd8y0ONQ4HUlgUG5CfYyusJ8zYXvM=;
        b=gGguMYbjcw4Zzbesbaf2GesmQ5pxFQseVlOxRcwIYmy99ECh0ZYuyPaDUDnEaiZrjd
         VieN/1UIaZrtJGb0FTp1C64PYgeWdz1M88VWoZEkepICXb5K3kioNMj13zlsTAq5VOyy
         HaaWl6PnUymM1F+6kobrlnu7i4lIiPNZPymnLdyqSjhvoOtmu1DLxWBAt50owcUpXUeb
         zrx0hhUzBqK3Dxo1+7luLLIB9x96QXIIhmGa4cPZJs3tnoHb+N8hgBPDy6B+udyV1Z3v
         dVi6OMF+eA6OjWLTbf32yX2+PG2gvay+Jsac8V/YmdUrhTSJZRKJbx1v+zMHGtl9PkQI
         F0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9IglQ+obL1D82Vsd8y0ONQ4HUlgUG5CfYyusJ8zYXvM=;
        b=4DyhoGURS4yBxo4FZZW/1GiyWQvbVfI+YPKu6J7t7qn6jCtpxbLxYfErTlio4921k1
         lOUoERVYc3mjRtYh8OCOihpZIYZcNOXqEi91ztqQ7Om17vDZIBVMugF8sU2DMcnuQcnK
         ot4kz7vUmlEhlBSMSoxtTgrPNe47lUl7GLAiG2vmcddntpXAKZ1pWm4qNRGaeiAXNnZU
         725Wl5W17AQFBy67PukGh5rTJoQkhbyZ2GCIoE52JU9QnvpzGP7Bn+74i4NZ17/mKNb/
         Q8lpaPS1fFeMIfabfDbtThy0UDB52hjH0g4/OvgvCbjIbDTHmzp+YZmbEi13mGUjVaYX
         cdIw==
X-Gm-Message-State: AOAM532wYb1ytJ7gX5IaZahEV2hMhX40FEAg0jEWf8aisxJUaICpaZgd
        z4svD/eaPWbAFm6ctLnBcs/793KLdM1LLw==
X-Google-Smtp-Source: ABdhPJy2IvHyCBKiXb9yqV/PIgt44bHDZHTqnXIydg4515grb4apj9rZ2U2mq5mttgEqwCuHKFEz/Q==
X-Received: by 2002:a17:906:1913:: with SMTP id a19mr283556eje.390.1631145433867;
        Wed, 08 Sep 2021 16:57:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jx21sm17922ejb.41.2021.09.08.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:57:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 0/3] prevent opening packs too early
Date:   Thu, 09 Sep 2021 01:52:01 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <cover.1631139433.git.me@ttaylorr.com>
Message-ID: <877dfqhb8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> Here is a very small reroll of a couple of patches to make sure that pack=
s are
> not read before all of their auxiliary files exist and are moved into pla=
ce, by
> renaming the .idx file into place last.
>
> New since the original version is a patch to apply similar treatment to
> index-pack, as noticed by Peff in [1]. This should be queued before =C3=
=86var's
> series on top.

I read Junio's earlier <xmqq8s063m7m.fsf@gitster.g>[1] as a suggestion
that we combine the two into a singe series. I do think that yields a
better end-result, in particular your 1/3 is much more readable if the
refactoring in my 2/4.

I'm mot of the way done with such a rewrite, which also incorporates
your suggestion for how to manage memory in rename_tmp_packfile(), but
I'll hold of on what you & Junio have to say about next steps before
adding to the re-roll competition Junio mentioned...

1. https://lore.kernel.org/git/xmqq8s063m7m.fsf@gitster.g
