Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B70C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3057460F56
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhKATgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhKATgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:36:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C96C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:34:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m14so14947001edd.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=q+qlLtDt1PjGh9QI54oC7bzWCcGRv8cg3XqCW6k1m+U=;
        b=UV+6icgDHASFDTbUUKAW0wvaA1ENmS+gVwbfNiOGnLD6oZuWoWsFY7G28QkHCNf9GT
         Jj2MNC+62/9hpSU7lhbHpQi0GOHc+STlgrJTHDFZNbETZMXL90M7gmuvtpQyI4SmuUZ+
         cev0RpnQO4dfTH5/RGYVvNRxoQncA7nxFeyCQJ/TdZi2hfXvaZdIzPQyHEJ7SGvKerf5
         Hyfr+GX5Kndj/JQiyaMWhZKKnzQh4Psiuygbsyv9lnjjdqbunhGs5kjxjz7E4WmvJEfl
         qbXtQPqNvtwuIl3cq8vlambYZv1kcYtu6NbDQBRaQt3XStaMfeghVgKFjDhVyHT5Zwsc
         W8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=q+qlLtDt1PjGh9QI54oC7bzWCcGRv8cg3XqCW6k1m+U=;
        b=Paf3BsmXR7HoK04Ol3GYQ/ElNRiPUBcgMpnUGR/nPT1mZPzjNGXAQ3M5Vp1hjYHPNU
         lYMnKBuk4mdryCfcOejFe1nrxgs6Raw0hcR3x97aYzQTIaOR3DzyAvjWCmfOSLx+3dcP
         8IcSxtL6H+LgRo6vPIWuG+A+pevoUusyTDE75XCPcbGjUFHAobcNE4mFURSIiF3KTfHk
         W5fT9M6dk7MqFxYiuf9KnDVyhHdAEo5chnuqCUUX+NfiCiWwNgglratuLpIShRqucs2e
         UDtPmbT88jLhEQOvXffMBKcuv3WnGvxrWDDqA1zTDbsvhqi3Wh5CDtc0iwY7nz0yf08T
         no5w==
X-Gm-Message-State: AOAM5317jJnDFXmpMJUAJWM5k8icq4EWL5hWP5/t9PdGO2bzZCxzlc86
        YnujrrlZ+xHsjeF8NfWeA7T7ktygT90oEl5I
X-Google-Smtp-Source: ABdhPJxCOrTHtOxyCnwATVOfyHfDEfSwGJkoTmuMC3iLrcwQHKFgCn0Tvk+WTEAEtVK7xB8qbxAEqQ==
X-Received: by 2002:a17:907:a414:: with SMTP id sg20mr4553327ejc.183.1635795242089;
        Mon, 01 Nov 2021 12:34:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3sm7393621ejy.94.2021.11.01.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:34:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhd4D-002Bhd-BC;
        Mon, 01 Nov 2021 20:34:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thiago Perrotta <tbperrotta@gmail.com>
Subject: tp/send-email-completion (was: What's cooking in git.git (Oct 2021,
 #07; Fri, 29))
Date:   Mon, 01 Nov 2021 20:32:38 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqr1c3e57a.fsf@gitster.g>
Message-ID: <211101.86o8733c2e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> * tp/send-email-completion (2021-10-28) 2 commits
>  - send-email docs: add format-patch options
>  - send-email: programmatically generate bash completions
>
>  The command line complation for "git send-email" options have been
>  tweaked to make it easier to keep it in sync with the command itself.
>
>  Will merge to 'next'?

I've been reviewing/helping with multiple iterations of this and think
it's ready.

As noted in [1] it could be improved with some follow-up work, but is
good enough for now, so let's merge it down.

1. https://lore.kernel.org/git/211026.86k0i01u3c.gmgdl@evledraar.gmail.com/
