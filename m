Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F8C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKUSuU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Nov 2022 13:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUSuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:50:18 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682CC67F5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:50:17 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id y10so10215347plp.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOqO29Yo5/mWMQ98Z678x5A+3IQi6iejDgcApDFDIws=;
        b=gV6HHtUdG/hTFO4pOHTzvaPpAzB1hLcypdXQBDn1S8z2fHnhOJgU2eUXy2ZIcNQFLz
         EPm2mj4NCXdcBYAp3/+ZSmaPJzb1igd5efMujUmZp6+wPkJVm/K5uHO2aFVoLwHt16Ah
         G3avsBHSrUQ+bTj0YQZ9T/0DLeLRXP4MPAa1M3FJRv9/N5OP7VU+p5ZT0m7FTkO7s4X+
         CrtYKwXudgHfR9C2ri7qqvl7bmL923ttGYOrqf3Mn/AbT7vPV6xbvSRX4pTTcoj2iIM2
         lvgSww2bRCy/ZCrwsAe/+6cck9mo/6T9raQ5N17GKJG3ry3iZOhxUu8G11lt/Hc2LxRQ
         Nksg==
X-Gm-Message-State: ANoB5pkNgaBY1olFnyxiGjsCgVhP7geGHhcN/mcpfic1qUmdoHtECeDp
        LC+efKNa3ZPJRfav7+pk3KAdFLE0s751EF/LxVk=
X-Google-Smtp-Source: AA0mqf5L/Cnore7vRtR6LvrizEmb9PAqxE0ac0I5yCe2NbAfLGOBjTOG1oYkXdYz6R6AuLlreQYzMwVBRg82bA3SSzg=
X-Received: by 2002:a17:90a:bf17:b0:213:587b:8a83 with SMTP id
 c23-20020a17090abf1700b00213587b8a83mr11412292pjs.22.1669056617192; Mon, 21
 Nov 2022 10:50:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr> <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net> <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net> <CAPig+cQfkkY2Eh=QD47QoUGuAiCEpxSsX24x_8ts2GTKVnV1aw@mail.gmail.com>
In-Reply-To: <CAPig+cQfkkY2Eh=QD47QoUGuAiCEpxSsX24x_8ts2GTKVnV1aw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 13:50:06 -0500
Message-ID: <CAPig+cRSoaZJLv3PxT=TKU-Qy8twhAzhgncB=UL5sasgSB3Hiw@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 1:47 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I think Ævar's use-case for `make` parallelization was to speed up
> git-bisect runs. But thinking about it now, the likelihood of "lint"
> problems cropping up during a git-bisect run is effectively nil, in
> which case setting GIT_TEST_CHAIN_LINT=1 should be a perfectly
> appropriate way to take linting out of the equation when bisecting.

I mean "GIT_TEST_CHAIN_LINT=0", of course.
