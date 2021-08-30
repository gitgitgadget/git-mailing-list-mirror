Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614AAC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A48C60184
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbhH3OME (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhH3OMD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:12:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE315C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:11:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d26so22755474wrc.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7O6M2OGHHdfH1MdNQVKi7x7Hs5cPs8POJhP+p8yYO/w=;
        b=p1sBWuJKV0ZknHzaidoN9DoMpo61PLVcEZGomcMSXUdvmljGfJx9H+Zs/wATZLl6py
         T+viz1aQSg2AVmMlKy4buJohMJ8lj5PZx0cjVypxCIUQOadm2mzKAM+jsXs+clPxCO8H
         nE1AJrY6tGmX4NqnxuL2RvWbis+sn0/vIb17s1Y4KWD4yNf87QpBmK7mAQdYJkbm3/21
         We/kaOEiH0VlVFDXHEjatRZHEvNBbFGExV/0KA4KA7+lIjRRCau2GP0CbejWgNi/q0SY
         sMwzXLCpTRDgHjbrkPvIWqsbzPKqIMB4eFIZC8d+ZtdVeS320jbKcGHgOY92jGUhuX7X
         EWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7O6M2OGHHdfH1MdNQVKi7x7Hs5cPs8POJhP+p8yYO/w=;
        b=enQwruMXdn2UWb0IN3LxoAOU6n5t3uomfNwoFK9id3Mb0KLKTXuFk8ee1fPYUPSmyK
         tM0fNyjNq5R8QCtETMixhXdQR46Plg19fVSPQ/72wx0knA6IlzdNuH2VNd35EkCq3bk3
         QjMZwTFMQzgU3BvthD7PzbQr32khFRO8KO6q7Z/xMRL5ohbHjcK2TyeXPVECX0TFR0+5
         j7ack+1mly1ewgCsUQlBQmS/dJ9SGK+nzNqVLSnIovyCcmqUIV9hO7/Wj6pNiMF9lj1J
         Sf4PUzZAuYHK+ZXIYg3yC0nBQ4D0aMxKyA5dUeh6unQ4z3FPuUBrql9JMtLKAPySD02N
         d2kw==
X-Gm-Message-State: AOAM530uqAKJA/DuPT76gja0N6DQyLJO56fux87m1ZARrQR2KYddPJq1
        /KdtjnpQX+nlgFpnQIs/9cWuU7LeI1y/i6IR
X-Google-Smtp-Source: ABdhPJy6M5T22huPQ3xhlX/lcLqLN7XTzifYaKBiq50NgCYQZxssadcIoI+5Ri4jKbU6hQCBoZKxMg==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr26090934wrp.297.1630332668447;
        Mon, 30 Aug 2021 07:11:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q11sm20049565wmc.41.2021.08.30.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:11:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 20/25] refs: RFC: Reftable support for git-core
Date:   Mon, 30 Aug 2021 16:10:02 +0200
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <3d57f7c443082fd2a7f01aee003a9cd3ca2dd910.1629207607.git.gitgitgadget@gmail.com>
 <871r6kh3m8.fsf@evledraar.gmail.com>
 <CAFQ2z_OTdXSvPcjPRi8fx6F_yjwiL3vRpPtnEOTyaeBxMB2wHQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_OTdXSvPcjPRi8fx6F_yjwiL3vRpPtnEOTyaeBxMB2wHQ@mail.gmail.com>
Message-ID: <87ilznxbt0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Han-Wen Nienhuys wrote:

> On Mon, Aug 23, 2021 at 12:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> [ omitting addressed points]
>> > +initialize ()  {
>> > +     rm -rf .git &&
>>
>> Should instead set up a test_when_finished "rm -rf .git" ?
>
> No. The test framework sets up a scratch repo, but the scratch repo
> doesn't use reftable, so it interferes with the tests.

Perhaps "TEST_NO_CREATE_REPO=3D1" at the top of the test is more
straightforward in this case?
