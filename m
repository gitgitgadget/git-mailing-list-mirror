Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2ECC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiFBOsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiFBOs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:48:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC78F74BA
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:48:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q21so10464400ejm.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZhBEqSe2ktcBAxRFu3G3PX0xFVp7vwOkQ0Ts1bjdi8Y=;
        b=JeEntJKGk5Jten7soHZB++wRTxWaKdYgoc6nmOFbqp9PjLrEVeb5YVc5sL47TTE5qZ
         dQlledaZFl70doSWAr7levGQ8gJLH7H5kCfU0gsdyApp/6yxUcY5pWuWDIBDS9Vxu2gv
         uKaCYkohRifiljSpjMQqo/J/GZplnJ6bm6gnTh1aKpLAZ9WOZbRrNjVIdRBwc8+b4mXS
         vidZv4lqLzOBs8yIfTTrJNx6iN5AjGZmsA0pOf3I+4pKHQ3hPoLS4y/74zVTD91Ac3l8
         AwwOpTV+dvlIXYVUTNtH+OLwXAxVOYjdonUxhD8gKhsNxTPF5UuwIrFpZRASaEqt6Lpa
         BBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZhBEqSe2ktcBAxRFu3G3PX0xFVp7vwOkQ0Ts1bjdi8Y=;
        b=2O/0XTAcx/CsvwsRRVJk0dJiqAOgQjGDYAp9gLAdFRtLNq90nUiBiDDKqBkknLLzMd
         Z3wUjw5tvr7pjVo5gzkURov0SKcP70De+BFiLNk95uId3UjQFUAVG8qvLqTMRZw8sx0A
         Kk1b88pgxZbXlxDD4K3l6MCW0oOAJw1BFBGuPyx+xo0csFryICgQuscOiD/sQ02yZC1Z
         cqSuUwK/fxXZpkfRfY7wyEmeWztBQ2yFGYNpV6GNpLwg6e1WwgBhcfDTx2hX3ee1uXsq
         vpbVoA3UQRPvLNtlPKPJ3hl6nhDmKZcc97pYNUJkK5RhIH7Y63pf1A8umtHTP0BRlCuk
         n1Iw==
X-Gm-Message-State: AOAM530j1Rm5opQx6sA22djvmsXXFQxYIDffrLoU1LNXhZU1Fo50+n6t
        6DiYwiixolUxl/JwJVqn2tMIsv2+5//Etw==
X-Google-Smtp-Source: ABdhPJzKYa9O56uXsX3S0oVcrrovfLDFWivK6guHpfaxsBQKl+uOqXvcbJzFGO+KlaWWCiMggePoQg==
X-Received: by 2002:a17:907:1623:b0:6f6:e9ce:9926 with SMTP id hb35-20020a170907162300b006f6e9ce9926mr4563924ejc.360.1654181307263;
        Thu, 02 Jun 2022 07:48:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0042dc460bda6sm2585969edw.18.2022.06.02.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:48:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwm7e-001X4L-AX;
        Thu, 02 Jun 2022 16:48:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/hooks-regression-fix (was: What's cooking in git.git (Jun 2022,
 #01; Wed, 1))
Date:   Thu, 02 Jun 2022 16:47:55 +0200
References: <xmqqee07q3xc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqee07q3xc.fsf@gitster.g>
Message-ID: <220602.86wndzxgsl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Junio C Hamano wrote:

> * ab/hooks-regression-fix (2022-06-01) 2 commits
>  - hook API: fix v2.36.0 regression: hooks should be connected to a TTY
>  - run-command: add an "ungroup" option to run_process_parallel()
>
>  In Git 2.36 we revamped the way how hooks are invoked.  One change
>  that is end-user visible is that the output of a hook is no longer
>  directly connected to the standard output of "git" that spawns the
>  hook, which was noticed post release.  This is getting corrected.
>
>  Under discussion.
>  source: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>

Re-rolled
https://lore.kernel.org/git/cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com/
which (hopefully) addresses the outstanding comments, allowing this to
move forward.
