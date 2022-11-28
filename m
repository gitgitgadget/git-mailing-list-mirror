Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E146EC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiK1MsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiK1MsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:48:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A2FE3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:48:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 62so9779403pgb.13
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKmFZXnotnJ3VMJTpBgYiWM0pIItYyZlJ3J3K+Ixm74=;
        b=haksDqczhaIXCCzw5yx3J3gmax37qjlr2ViLarF/3HcjXudp8f4NuyLBSh+qZng6l7
         coNSs7wiUsP+oQOPVbLofQ3nCFsZqJb8R5rWG1Wu+AUB4OTIcr/igZOJ3ZdVOzeM4bta
         gOxU7EUOwji4dQGt59BxFClVHKVOdCW/wDaZ4rpzh/d30zJRitQGefM5+WJ4yg/K2Jj5
         Z15175XTpIh3HrQQnapDJhq8jr1Eglw2uLT4UEO6jxgnIJ89Wr12J+AqCMN4EOEy3ACK
         TkHkvQ0bLdHDperL86SVM/8sqUkzTqDgbCf0aAjqGOwzj6ska7ERvFA8NKkck5IHXAtX
         qBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKmFZXnotnJ3VMJTpBgYiWM0pIItYyZlJ3J3K+Ixm74=;
        b=YMN29+w5g4cSHGUE1GRluzGzgA92B5eOmTTr5wh64ygZivkEWsXnv8fsmrXuPLoesX
         Twlc11pNh0u00P5Kp8xENhoqMvdCF9Z2/9xWKVTVAC45Zi/HqzpZMI3oMxaOydLDExf+
         UiHWwxJPWs9wnSZLKSF7oegKYjfUj7MoX+c2km8HrmHMZFeajLD3O1zx3ReZ+TX5J6Ul
         WXjVC1h0nPUioj+BqoqshON3JMmcZKpzBiEKTUDX8c7SWaRjc6+qC+XkaGPgFY105y7E
         CqgmWsHVRGIi36i6RGKHNgwbSnyy0OFuUdopEjq+ksz5VQIx1RQ5kvmnwuAvfmYicPRu
         lrDQ==
X-Gm-Message-State: ANoB5pmxfj0cFjf8mNxLH3c07T1WuBh43xP43Ddj4QPktOBxHQoygBvv
        EX6bFYFzn9mHS3JkyA9hJ58=
X-Google-Smtp-Source: AA0mqf48xngcerSXid7AVyFq+xH7Knqd1ha+1yMkiZjnsbWmpoZ2vBobMd//pguofzb8lndumfDAjA==
X-Received: by 2002:a65:58ca:0:b0:470:2c91:9579 with SMTP id e10-20020a6558ca000000b004702c919579mr26592864pgu.22.1669639693930;
        Mon, 28 Nov 2022 04:48:13 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902714e00b0017da2798025sm8671012plm.295.2022.11.28.04.48.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 04:48:13 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 0/4] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 28 Nov 2022 20:48:07 +0800
Message-Id: <20221128124807.54707-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.473.ga0789512c5a.dirty
In-Reply-To: <Y3vL1zWa99z/Liy7@coredump.intra.peff.net>
References: <Y3vL1zWa99z/Liy7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> > Diff since v3:
> >
> > I picked Peff's two new constructive patches[1] which I think are meaningful.
> > Peff also mentioned whether to design a "GIT_TRACE2_BITMAP" ENV to help
> > debugging bitmap, and I think it's very interesting but maybe it's a bigger
> > scale on current patchset, so I prefer to do it in another series.
>
> I think the first two are already in 'next', so they aren't eligible for
> re-roll, though from the range diff it looks like those changes are
> already there?

Oops, I created the wrong range-diff. I didn't check the 'next', but now
I think I shall make the reroll here because the new replies from Junio
and you.

Thanks.
