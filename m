Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE3C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 05:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiCaFxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 01:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiCaFxv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 01:53:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F727D8E
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 22:52:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so39536419lfj.11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 22:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJ4LC+z4h9dnDuYRSS9ykAhSAUm9oK0jsfk859iRWXg=;
        b=BEFkhrzSOu1svEW6TUj20PbcGPCs3wwO2JUvhcMhK8nZBpqjtfVX5wC3nVL8RKIpp2
         1D1dN5h0IqYzFHjRmgdDUBEqkLulBDdQ+1m0FaTsoRsbfk3I9xpfOsHu5lULlpRzZXkH
         x+Lar3iNAtHhPkBGVDfYIQtuQnAnN+zdGMd2b54cb6t5cky1lmHKTYE+dTDBr5vyuedd
         w/jNvYsVkV4xcHmAqE6U4jbFjC+9pHZpbwCeZ/I3GovJ3Nd+sOCb1PFlIcV+r7D/G6K2
         VAu3OhoFSJWs8Ya/B+Ija3s6Hf0EcsN5Taje6HHQ8YWQTAD88PeDN3UuQvnPcILi16To
         wJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJ4LC+z4h9dnDuYRSS9ykAhSAUm9oK0jsfk859iRWXg=;
        b=MzEOguFz10iUSZdEmd/BBxBeRJEFHGt62c8d2DPZPkFa/N7YWq89tVd2Qbip8hWg36
         bNIbit4CzOzY6V9hhzygkMJ4Nf6hzOLO6CZOrGnuvM0lJQKbxZE8hCpKAxG3pUMyCdbR
         hDRnSEkm42zHd9ydl2n7Lbo0Wf6ivJQmvdzJgLBfoupb52DCEZrw8H13jGrEThqoZBZY
         DpcS1rLvk9eS6ycEeSz+fUsdWHl53QQ8An7mYjTQoJe9RCO3QV8hgtbFZLw62zUkPyWE
         xpF/1KMjkmqwFvmF+7nL1I9KKpm0PPLCMpbYDPGOIrls1mrNtNudMTJLstL4aIqEHMSJ
         evqg==
X-Gm-Message-State: AOAM532bdLftMfudqHvb6upd5sWJx8jSiZeHuRjq8D4dAAIMZRfcp1lP
        5vRJ5uaaxe8lIDN/RGY5eCsBixqfbwwFvR6jCUs=
X-Google-Smtp-Source: ABdhPJz04sQp6foGL+aHhR6TO05ae3AZQx56H5q6FGhDsa2rOpcUfFpz0+M4USkbqDabM0PhKTD9lsGKsnsVY74oXrI=
X-Received: by 2002:a05:6512:3909:b0:44a:2428:3ecb with SMTP id
 a9-20020a056512390900b0044a24283ecbmr9654457lfu.522.1648705919488; Wed, 30
 Mar 2022 22:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <d045b13795b38caa27f8e25340212f736b66bb05.1648616734.git.gitgitgadget@gmail.com>
 <xmqqk0cb9x78.fsf@gitster.g>
In-Reply-To: <xmqqk0cb9x78.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 22:51:46 -0700
Message-ID: <CANQDOdex_84nhQu=86jrkyVfnRenRtxQ_8B-mmnXE-a1DfuUJg@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 10:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Make it clearer in the naming and documentation of the plug_bulk_checkin
> > and unplug_bulk_checkin APIs that they can be thought of as
> > a "transaction" to optimize operations on the object database. These
> > transactions may be nested so that subsystems like the cache-tree
> > writing code can optimize their operations without caring whether the
> > top-level code has a transaction active.
>
> I can see that "checkin" part of the name is too limiting (you may
> want to do more than optimize checkin, e.g. fsync), and that you may
> prefer "begin/end" over "plug/unplug", but I am not sure if we want
> to limit ourselves to "odb".  If we find our code doing things on
> many instances of something that are not objects (e.g. refs, config
> variables), don't we want to give them the same chance to be optimized
> by batching them?
>
> {begin,end}_bulk_transaction perhaps?  I dunno.

At least in the current code where the implementation of each
'database table' (odb, refs-db, config, index) is pretty separate, it
seems better to keep bulk-checkin.c and its plugging scoped to the
ODB.  Patrick's (who I previously misnamed as 'Peter') older patch at
https://lore.kernel.org/git/d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im/
showed a pretty nice and concise implementation for refs tied to the
ref-transaction infrastructure.

Thanks,
Neeraj
