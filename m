Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF85C433E9
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2797D60234
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhA2Ug7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:36:59 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35730 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhA2Ugz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:36:55 -0500
Received: by mail-ed1-f42.google.com with SMTP id j13so12100682edp.2
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 12:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUeTg+vmlBXWRAR5R0PMjEFXsZLbVL3z230dDBN/WnI=;
        b=jpRd6i38kqjOL1qdGGdsnPUokdLzCkdYEtnUlnnW752qcR2EC34RdEIvVuPXaBOpIq
         VewMAEaHZ9BHV2MZFx8COFz8DJEgyWw8UsBDJnXY4bLcB8ii3NziTimSBndsTDze/WUp
         SVptWkbQg/FcbO+3rmHcFvibsrnPfOhO3ht7kIZ4i2PZDj/PAFhQ7aWJup03sLOFiBgZ
         HIhTkdUFF6fPLMtFQFBEEG3mggxoPyPzPmjee1NgL16omIXw2IYuCJIndi+gDOxrt3J/
         pc3MJ+eNoaEaWLlK782Pc+aP6BhWB3xwOh/DxAwmjm/E0RZpOwiX8sNfLDYwM2J4nq1Z
         2p3g==
X-Gm-Message-State: AOAM5335gTmMYvB+bdtb02VMKf9vW5QjxPiQOQNmypxkOLsAmiI/EthP
        VFvFkEjfA+FBpdmaqNgcoWoOQ9sX5nHFEyktKbU=
X-Google-Smtp-Source: ABdhPJxsUMHxCBacaSeFdTDBSkd3kjwCHtN3/Y3E5CLplCCtB7DxMY2TMMgU8bhQsJe3LRftgRoqlfMWp1aXovovqkM=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr7223736edz.89.1611952572326;
 Fri, 29 Jan 2021 12:36:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611098616.git.me@ttaylorr.com> <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com> <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
 <YBRqOI84MkU+HNzt@coredump.intra.peff.net> <CAPig+cTc3RGEu4anOmnYBBQxXgB0UL8Z_vJfnV=FoNTOFYEpTQ@mail.gmail.com>
 <YBRvy3s5gnsrIBEB@coredump.intra.peff.net>
In-Reply-To: <YBRvy3s5gnsrIBEB@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Jan 2021 15:36:01 -0500
Message-ID: <CAPig+cS9Fp3N9XNux8=JZo-T3QWdr7O3+NbChhhs62hh6D_5tQ@mail.gmail.com>
Subject: Re: [PATCH] p5303: avoid sed GNU-ism
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 3:28 PM Jeff King <peff@peff.net> wrote:
> On Fri, Jan 29, 2021 at 03:19:31PM -0500, Eric Sunshine wrote:
> > It's not just exotic platforms on which this can be a problem. BSD
> > lineage `sed`, such as stock `sed` on macOS, doesn't understand this
> > notation.
>
> OK, then I'm doubly surprised nobody has noticed and complained about
> this. :)

Aside from there possibly being relatively few regular Git developers
using macOS, it could also be because it's difficult to run the perf
tests on macOS in the first place due to the GNU prerequisites. For
instance, the perf tests have an unconditional dependency on GNU
`time` which is not installed on macOS by default, and it's not always
easy to figure out how to obtain it.
