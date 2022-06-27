Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A23C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 05:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiF0FGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 01:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiF0FFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 01:05:55 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E05FB6
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 22:05:29 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p128so8459112iof.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 22:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4leJ0WX2FIH0zhAFtNAa80o7DnkIjilc70XpWpyK+7U=;
        b=BZdm3D/dbCsTA5s+XJaTU0Df8i/RGYwMtKa950D+7WhpbumlB0di+BMcvIM0+KXL2y
         fpnQXvPNFL9c1WTUra/iBl4YY2gp3LN4c+1hjhSS2LERnR5bNBXbGC+bySO+B3pdZ6ca
         6w1oOurM3uuhEDfb2dMHSUHJTu1wjt3fc7ZPeKoLGEQEEsSegly8YIe8/OwzZ2j4PwQM
         1BxALuO+bhuRrKBF2bqx0074SX4gcwxMOpLc7Ea5GQHq+sFqmWvdUezii9X7HzOBOkF8
         IJUUQHnSYNTsMquRYmUvV4ZTl0FhmLNKflkAhtuqHNWKjHv5HHCwzcdvDm8COOI8Cy3t
         Iv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4leJ0WX2FIH0zhAFtNAa80o7DnkIjilc70XpWpyK+7U=;
        b=KjBzyy7zgya6QwGVDy1OZHvtBixf/OqXdy3kJYzhzjSdhnQQ5uEXa4tnsu9+dpgAhb
         CfC/xLls0O/kczKf1ShjzDFOHSZjuuRUWeLC4JMJTbp5JPiUxFjI0XJJHd0qY04ebudt
         GKjOKjw6enviEFvkQmGRnaudXe9tfzkkKg59YibLmcaZvRsOdRQS2APkk8fqgTTenp6D
         SFQNtPQ/ILICA/VAXV4wPusbUvt1PFy0tFbIo8g4P8BOfw685vulvRxYG85TgjOfRKI9
         5RB2yuJpmyzCi6PHMAb3LI0aDrXdpNJePPg4FrTmox3XkD5IHk4S51bdyyKqMTfoqfdo
         8mig==
X-Gm-Message-State: AJIora87kERgiQfdgQMcQUvKybwUDoNoQBExQG3qBGZOQbmWEZSSjb6g
        X6yEX1jZ/7KumPVcWjPO218zwnY47v5h4Ta2tAk=
X-Google-Smtp-Source: AGRyM1ubw6qsGRTQyXhGcuX8tBglhOB6tKL0EaHHAGJYuMCBybcf1YBXNjEYx3Xi7/ZqNTjoDtSS7UaYOKUnpol1geY=
X-Received: by 2002:a05:6638:13d5:b0:331:a6f2:3dbf with SMTP id
 i21-20020a05663813d500b00331a6f23dbfmr6687358jaj.9.1656306329319; Sun, 26 Jun
 2022 22:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
 <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com> <xmqqo7yk60vf.fsf@gitster.g>
 <YrNb2x2/7Z31XnFJ@nand.local> <xmqqtu8c31xp.fsf@gitster.g> <YrOKHIjXCb5YgIOr@nand.local>
In-Reply-To: <YrOKHIjXCb5YgIOr@nand.local>
From:   Xiaowen Xia <haoyurenzhuxia@gmail.com>
Date:   Mon, 27 Jun 2022 13:05:18 +0800
Message-ID: <CAHLXgnZFry5mdnznksvuiz2GfCnEi_qT+q9wrYhrbGmDeM-McQ@mail.gmail.com>
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, derrickstolee@github.com,
        dyroneteng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But in general this is not really at all considered common anymore,
> since we expect all new writes to have the reverse index embedded in the
> MIDX itself.

You mean, *.rev file will be embedded in MIDX files in the future, and *.rev
file don't exist anymore?
If this is the plan, the patch is helpless, ignore it.
