Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C270C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhKVSni (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhKVSnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:43:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB14C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:40:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so47473938edx.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=F4n32TJlKuaxlFTccMR8C3oHvOsAzl22bOG3KXVIw3A=;
        b=V5CRIW/lhntq89yD+DAmEwtXcLwQXuY/55edEe85nQCsREBa4OHlJCDnXqUhfHICzr
         k7c1Uyg9wS9BcevAdo61TCME3mRLoPYijYAu1/ZrcjLKfWDB/hgNc5KMSuU64kGC44Hd
         v9kDaM95ZO7yJX0Z9DYlRsLHcmJVhxHpxJayPaEBoGdJpmOOtU5p4rCqEMdQqGejyu5o
         RMi/OyBL18M4tLoLHIl3bSgRdg2E6GTYGySOLtyqe4GN1Un+kOOTuIeL8YuKL7u+WjtE
         JyE9iH2/DImDCfKOaism0G7evZuFagcm6Tfmgm0mgEaKdOEKEhX6igqNX2JULXSNFk9a
         7oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=F4n32TJlKuaxlFTccMR8C3oHvOsAzl22bOG3KXVIw3A=;
        b=fwJBJlFgZkIDWjWqH50mRWbt5bmH44rBch/8ztVRMEdXNTDoUhQxBLa66NNg4vq92O
         QJzgLiy4pT/ZfKGw8ZyLbkFCycOg4VGC1dY7YOXwhUGH73M5uNvIdieJhPw7vvjHQW/B
         gqdwCKy4HKrp0fM4UgGt9mIAqEg0Kv41U8Kevoy22DvdAWgRl3YngeA5n0uT+9LWshar
         W2ckMEHyXuvakvmyMVtsXxG3DIxxRChbQ87VOs+fEuDbB/sqmLnEPUsFB2Tq8+RDNwwS
         cLy6nk5YIHncHwNigggnXwvAWvrCFrxdJSaxXrOZjBEKgLq8trXi5Jjy0qBSStgofRVN
         /nGw==
X-Gm-Message-State: AOAM533nBbneySCZevvaloZU7jIunUAgElS732g3mAmkdZb+dNMZk+dK
        DFLDzDSPmjcNQT94lsX7ndI=
X-Google-Smtp-Source: ABdhPJzPYt5eKJDRfLtwTMl/7HasQ0UKNo/SgSA9le4OYLScjoKOfRKFpdt3taPiiZw/fqg/Wd2n8A==
X-Received: by 2002:a05:6402:3481:: with SMTP id v1mr68756121edc.337.1637606428614;
        Mon, 22 Nov 2021 10:40:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ig1sm4076536ejc.77.2021.11.22.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 10:40:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpEEt-001ATD-Nx;
        Mon, 22 Nov 2021 19:40:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Date:   Mon, 22 Nov 2021 19:35:43 +0100
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net> <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
 <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com> <xmqq8rxgi0ej.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq8rxgi0ej.fsf@gitster.g>
Message-ID: <211122.86k0h0xcdg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think an alternate direction of simply getting rid of "argv" is better
>> in this case, and I've just submitted a topic to do that:
>> https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avara=
b@gmail.com/
>
> I see you just submitted, but I am more curious on when you started
> working on it.

I've been using this series in my local build since mid-September, I
just hadn't submitted it.

I just did some cosmetic fixes to it today, and got the Windows CI
working with it (the GIT_WINDOWS_NATIVE code in run-command.c).
