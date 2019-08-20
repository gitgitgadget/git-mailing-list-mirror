Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EA91F461
	for <e@80x24.org>; Tue, 20 Aug 2019 02:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfHTCOO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 22:14:14 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35602 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTCON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 22:14:13 -0400
Received: by mail-lf1-f50.google.com with SMTP id p197so2861819lfa.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aKa42203c+dYn8hdaHaTqrscfZVtNmRQLQd+fhcfPQY=;
        b=Z+2syvBRxeBkpS1nEs4EzJHH2CNgSsAvj128wnGJ2frS6fY/xkRTzkbfT97b7FCpPW
         X4PhksnL/lESZmylPq1+MDsOECbAk9hyo2+fyvTZOReJy7KXDv9iXLAvZnN5EeLMoGT3
         9yxxgCbSefFsHBjlrKpaz6GzlBGt4jfPGfzugA2vKNbEWHppZOsFkAYBgf/vjO/Or8Ia
         tBpmTa4dbJWaTxV1ZQbOP7isE5iqdD58k34/oDcqDNHCzNH+uzhdWH6TTSumMAwv/trd
         kV37SIS57DcVRDjdqVJP2NMhcGc2B8EX3WCbI3FBCh7+nBKC77tgYkxT9q5aLFWqTqyW
         RzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aKa42203c+dYn8hdaHaTqrscfZVtNmRQLQd+fhcfPQY=;
        b=OzEEl+SUwHVUwTJP60SjqriE1W2Szs2a6BbzO4maIKJnLL/+bK5eIPOHg0lKaji47+
         Rwq0aB7+9Alw3BFzcRUu7uRvfutpuZ/vyLT8IWW5BxlHZEkyf4UHSyJsDT+C78pEvgAV
         ZtBuuRUbJzlpu8C6Iv2JRW32owqfB8zt+dtMzEjSrqb1Rnax3VeJlSCuG87QmRQYwtgn
         lggTTeaItE385N6AavXIndNRL9bHrid7TyXvYdDx+7ZT8YAxxzdRTi/qwAIAs9enz3Iv
         pGPUXwdPOpXn2fKRqq/jFYxkUWLeHAdpX3I2GWbWqV5c0U1Sr6QaF7hxPxcxImaA5frT
         8zcA==
X-Gm-Message-State: APjAAAWWfxVSn4rDUp1RJcTBncVo9U2/rk5GKvDnp/kKlSIOVb1/W1n+
        EZ6un5vGPU4n5FTw6oAOBqBOqHVMkhw7WGVT4HlX4n5SWqA=
X-Google-Smtp-Source: APXvYqwfCscfsT+SN7Iazx4sTgFVY6IPoPn7aWInW7yvQtNjgsuLBOIspd01WPT2HvsIT1H8tqOdPuEkJPw2r0D1OLg=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr13665462lfq.119.1566267251257;
 Mon, 19 Aug 2019 19:14:11 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 19 Aug 2019 19:13:59 -0700
Message-ID: <CABURp0r2sn7LUYFNegLVx5G+zZXpiPz2YdmKfG1EDHkXf61E+Q@mail.gmail.com>
Subject: [RFC] Relaxing interpret-trailers' interpretation rules
To:     Git <git@vger.kernel.org>
Cc:     Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to include "Bug" numbers from commit messages in my
one-line log output, like this:
git log --pretty="%h %(trailers:key=Bug,valueonly,separator=;) %s"

But I have a problem.  We have a tool that appends a trailer to commit
messages like this:

   Reviewed at https://reviews.myco.com/012345

Unfortunately, it adds a newline before this line, effectively making
'git interpret-trailers' think there are no other trailers.

    foo: add new feature foo

    yadda yadda yadda

    Bug: PROJ-155485
    Testing: https://jenkins/job/foo-functional/1/console

    Reviewed at https://reviews.myco.com/012345

I could fix this going forward, but it doesn't help with my existing
project and various users' similar formats.

I'm thinking of adding a switch to interpret-trailers to tell it not
to stop searching for my trailer key at the last blank line in the
message.  This feels like it will cheapen the purpose of
interpret-trailers, though.

Do you have thoughts on this idea?

Another option I considered is adding some extension to --pretty's
format to let me post-process fields in a command.  I don't think such
a thing already exists, but with the myriad log formats available,
maybe I've overlooked something.
