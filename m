Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACC2C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6D560F46
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhKAT3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhKAT3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:29:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AE1C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:27:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so67555854edj.1
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=X51028GuBBzBJczNkqrLVgb/OzwIAmDNyqfo8f0ux7A=;
        b=cvjxNM/yhkJQoes3NJzZ68M/lzIR+0X//Mhj+CT3mrZonycLUHj42aHJ9TejfMvKP7
         tZYcJKEXLAiqn4vNmKBaOXRwE8BhCc2myl3pBb0XQe2pPwNtYY6cfZyLDVFSdDVFi+0W
         1X75RnceEDaCWj6r5qqoioj0awwhOB1Hk8utzDf+je2ha3pgzblpaFfX5tyuSTn98nIN
         Tl+iWFO6O8WwAU2ysY1f2mWVTMSehDGkh/FFU0V/V5OpHszmjyCGJ1Ow91TLPmOygYsF
         4Eji4LwE8wW/RL3/BvMBJk5xQJozprs67t5xDLJOiO3n/+PJfWIigHD/tPUKpzpBK2eI
         DpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=X51028GuBBzBJczNkqrLVgb/OzwIAmDNyqfo8f0ux7A=;
        b=dv6JuVygf4H7pAx6fOnmEYku0j2gj7JHILtUlM0l5SZTz0qfyZIv82YQWpEqV6BqU9
         p4vKk8SgBsig7WxCiPcrbov1vm69zRjj7vrElFpoRoQjw1tJrSVPO1Kf68s779izXQxC
         iptFPlm1tpgLEwkIELIRMMdOApB1WoLyAs7n6CWM3uXonoSDs45N7CIjr0uDbNZNyvLs
         6cDYZkMBO/me55eCRa+WNynHt7jldS1uw+7mLb1mjBTSSEPqdzZ27LfihB5hvrwkFF2P
         8yBp4T88mGkub4j/QRKpUetyBIlh+pXv2J/hbN+R/ijo396R/gwEuICF9kPqyKyZkDUo
         FFXA==
X-Gm-Message-State: AOAM532uJhDDR9nSJsB4nVCMSW6JOkGbp3JcWtYiTwPh5wJfGa/JWS30
        6RSXENUGzCuIN6zOQweeTO1ZHNuV6Rn1xOK0
X-Google-Smtp-Source: ABdhPJy/rR8gix5Ea9fS+ACDyNr9WUzFEY7SxlJ7Ip+Pomshijl2DYtjz8tBdBhqz9V1kW6x4sqP5w==
X-Received: by 2002:a17:906:a08d:: with SMTP id q13mr39239039ejy.465.1635794829482;
        Mon, 01 Nov 2021 12:27:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j11sm7205749ejt.114.2021.11.01.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:27:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhcxY-002Bf6-L7;
        Mon, 01 Nov 2021 20:27:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: ab/config-based-hooks-2 (was: What's cooking in git.git (Oct 2021,
 #07; Fri, 29))
Date:   Mon, 01 Nov 2021 20:26:14 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqr1c3e57a.fsf@gitster.g>
Message-ID: <211101.861r3z4qyb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> * ab/config-based-hooks-2 (2021-10-20) 14 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: convert post-merge to use hook.h
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook: add 'run' subcommand
>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
>
>  More "config-based hooks".

Re-rolled with the simplifications you requested, and now with a smaller
diffstat:
https://lore.kernel.org/git/cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com/
