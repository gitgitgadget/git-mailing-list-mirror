Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E0C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28DE60F43
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhIFWd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhIFWdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:33:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0EC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:32:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n11so11157033edv.11
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mmTUI4wu3cw7TqQHv2i2c1vVGbz135NXdnqnWF7nMiA=;
        b=bTQPWHzIshuk0I7sB4ICEgBETv9CVdCiEpg2ObbD7fjUgj6WL0jRggI9Lw1LBOcPBl
         MPcRlnKWnhNB6uhCx/LsbX54JIWmwE/74SJf7z/pt0U7HjDuFEdvpa0irysH5NXBPxL2
         lJdOboospDZ0ryR2Luo++vhUei8vnqgmWfy6lXPh3IzVNOoDSP+PxuQ0ODfZX+QlRTYn
         ZmROZ+bZ7CoKwsj42MX6r6j3bCIqHyQZqgS6e3FtecpGL/NGXmWZHSjwGLbTzwNorA2q
         fqhd5+gMWnKHbI0ahiq+SRxifaX0uXi81HfsDxUVp2bjWD/L4BXyZ81aVHMrBbAgWuHQ
         BN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mmTUI4wu3cw7TqQHv2i2c1vVGbz135NXdnqnWF7nMiA=;
        b=nSbFsUTEnHSObE/ZrAb0H76xlA1BuhQXND92X8OHst7AWtd3MZNSF1HASGjEcYXPY0
         r35uC8dh9sxL4wfAvgNEmosk32NVERUoO/WLHTG3rgsUVEbQpL1UClArEY7iJrKw4FZq
         1JPdaxiYAQqNq0mqxPZP0zWQTdhuHgzBwsZ+f6NAUduh8iq0SizkovG/esJzEQLwUrOC
         da5hBEjLzivX6uh6HbHthe0V+CNpdpMWVS5PddbBpd1bU6mCs9IoHqFodxnUHPFb3ABu
         0S2okYCGNY843bKtblApEaH5KaHVlAHm3Ye41kMuAFmm2/Jw45KamkV76plDfvmCqyT2
         rfWw==
X-Gm-Message-State: AOAM530DrlauQBmL0hdm8WcquDTx6jsVWOCj/gPqlqExbUN+ps8bsPuN
        WyRNCav12tRYdBKHtBqVRvQMInMu1SoZ5g==
X-Google-Smtp-Source: ABdhPJxDZpSoqjCbMMv3J1o8VwLfcbBgdlpTp0KlFwPbSznzJeupJEKEHnYrCpM6nG/QJktF3C5gfQ==
X-Received: by 2002:a05:6402:5215:: with SMTP id s21mr15280793edd.236.1630967537640;
        Mon, 06 Sep 2021 15:32:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i6sm4433933ejd.57.2021.09.06.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:32:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
Date:   Tue, 07 Sep 2021 00:27:14 +0200
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
 <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
 <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
Message-ID: <87czplnxn3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 06/09/2021 08:05, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Remove the git_pager() function last referenced by non-test code in
>> 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
>> We can also remove the test for this added in 995bc22d7f8 (pager:
>> move
>> pager-specific setup into the build, 2016-08-04), the test that
>> actually matters is the one added in e54c1f2d253 (pager: set LV=3D-c
>> alongside LESS=3DFRSX, 2014-01-06) just above the removed test.
>> I.e. we don't care if the "LESS" and "LV" variables are set by
>> git-sh-setup anymore, no built-in uses them, we do care that pager.c
>> sets them, which we still test for.
>
> git_pager() might not be documented but I think it is useful for
> script authors and I wouldn't be surprised if someone out there is
> using it. The same goes for peel_committish(). It does not seem like a
> huge maintenance burden to keep and maybe document these two
> functions.

The git_pager() and peel_committish() seem to thoroughly be in the same
camp as the now-removed git-parse-remote.sh (see a89a2fbfccd
(parse-remote: remove this now-unused library, 2020-11-14)) and say its
get_remote_merge_branch(). I.e. we carried it for a while, but the
function was never publicly documented.

I think rather than document these it makes sense to just kick that
maintenance burden over to whoever decided they'd rely on undocumented
shellscript functions git was shipping.

In these cases they can rather easily use the documented GIT_PAGER
environment variable directly, and their own invocation of "git
rev-parse" for peel_committish().
