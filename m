Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A840DC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiKVTs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiKVTsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:48:52 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB77C699
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:48:45 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id w23so14633981ply.12
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tkn7kkOPpt1mvV2KEMI2lHA9qGODZmCgUwAsi5wYQeA=;
        b=S+nM3O/3BWhBSCqNPsgOxuZEavvsou6MyNPpD70rLG9zJaz1/wk1iplU6FXWQ1I/n1
         hyp406kYsi3c28oqUz8fDPV7dC6rprktRxR0SIgoekGuXFI8dJzy3OQ7lvM7v1JeaGK2
         RFJDHudiIUTJgD54Pvkca1qDhfi60G58KVCSAz48SrJt5WAXSbdxp++SuqTe1ONF2cbz
         dNn6OGRLl7o1lqdNHDdbPFf6kyb8kFrCGDUWQXQQC6yk7WgJ/UV0EsMoKKHNls1SoY5d
         N6MP0pMPNKOQDEe+U5oScCu4BlZCwa50NhF/nt+xKrDaPVaGScduzjtZhmqrZ7JKQugl
         4LeA==
X-Gm-Message-State: ANoB5plw910ZXDGaSRFsS1yDNocwytFugL/OxRLaig/QRqhLra75yWu3
        ywfNVgZ9mT6SSaSEkoQEetusECllKixKXmTgMvA=
X-Google-Smtp-Source: AA0mqf7TGfWEQ0+cusJxLs0nXeW6ONN0K9m9eGB+0E4AyVXNWkxuNN+47qp/HkjABYf2GD4BlzXftt7wEQfCbJZrqYY=
X-Received: by 2002:a17:90a:bf17:b0:213:587b:8a83 with SMTP id
 c23-20020a17090abf1700b00213587b8a83mr16584477pjs.22.1669146524563; Tue, 22
 Nov 2022 11:48:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
 <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
 <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
 <CAPig+cQF8vjGNUux-ZMBRxbEd3V0p27oLWZ7k2=mf40kAkWVeg@mail.gmail.com>
 <CAPig+cSR0MAYRLtPS1YcegqMZn4FDbdRvbCbuDfXWR=wF_ofGw@mail.gmail.com> <CANaDLW+3HfVDrXmqNwcmbdbfeYBvCAR2pjo4FSuiGn_S=sOL5g@mail.gmail.com>
In-Reply-To: <CANaDLW+3HfVDrXmqNwcmbdbfeYBvCAR2pjo4FSuiGn_S=sOL5g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 14:48:33 -0500
Message-ID: <CAPig+cQrKZZwo9suXmVFzNEPwCJZ6J0Sau4dpjkH=PSoQav2yA@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 2:19 PM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> Holy snap it worked! Patch coming as soon as CI confirms it's good
> everywhere. I believe I was able to integrate all of your advice.
> Thanks a lot for your guidance!

Glad to hear that it all worked out.
