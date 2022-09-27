Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2EC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiI0JGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0JGx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 05:06:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372F1A7AA0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 02:06:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v2so11425427edc.7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=bdY3QhsMXgTVCRPe9jRS48Mjg9DLVIY6Gj79O0i2INE=;
        b=o6Z2Zhm1GtCi2oKXi9DdHDJyaPZUe6ZCmRg3KCxfwII1CxYSYkGIxcYtUTWgYGQcF9
         aYcUJz0S4NY2paIeiQjaaWh8Xwkaf1SpaQYHr8mNC7MxuLtEGnXJQUZ0BpDCX1d8v/WQ
         fLXDSTlVctTw3Ftp6NbVDBb3wOsIuEUWtS4YfVooeEPQuz9ZiJV9rYv8fP6RDpKDONju
         YwH+VjbHWlGZvi1t6jiiwvwQ8vMiJwR8pYv69Nw1McPcQ66cR/lGAdLTjO//idcxxEfg
         PNeTxIVuMXPtyYLEEUdJhdPu1xGR4vif/rNKm0bg79S6/gwi7IuuT+qejjg0f4Ip092S
         Kkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bdY3QhsMXgTVCRPe9jRS48Mjg9DLVIY6Gj79O0i2INE=;
        b=pdyK0K7LRoINO9wgKwhcoTT5VvDl4WvNT6o9kEGpDXnSppOFQlKW450Js3pCaAz2tY
         AjGSHZw0lMT8e9BX9K7+PaecMMO9HrPzn6REtkahLq3VE+WcwckAV+8cug5TLe5Gwx+e
         QB5iPayTsVFI5kd8jXqlzySYpWnUrQzQxQS2La7iAcSxluZJtniI37Cxgxxk5dHWtk5p
         ULzPiJJvbdv2QQrxxHEvECmSHQIPVmZEu7+ukAWqDodUep2AokCKq0HSnhF2ayGyKSVp
         dLFjzTjOQR2Af2fKyVzHcVz2/umMGV+egnvK0mNtbyWoI3gnQ+zOHQ6R4Pa+jPYYdvog
         tCzw==
X-Gm-Message-State: ACrzQf1maWH5dnMkHtIctTJu4ONqYIud7BbhhCwad4sjMpzJaBpyMykf
        gK53FBg3bcKzr+smCIoERn0=
X-Google-Smtp-Source: AMsMyM4hH7mniDR85+gX1n15dDNK7VdS/bVM1i/G5aIx17/v33HDTKP7iIsn0KH/PmKZHBhoH3xvug==
X-Received: by 2002:a05:6402:2994:b0:453:4c5c:d31c with SMTP id eq20-20020a056402299400b004534c5cd31cmr26324495edb.412.1664269610504;
        Tue, 27 Sep 2022 02:06:50 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906504e00b00730df07629fsm466393ejk.174.2022.09.27.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:06:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1od6YC-000GaE-2V;
        Tue, 27 Sep 2022 11:06:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
Date:   Tue, 27 Sep 2022 11:05:16 +0200
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-2-calvinwan@google.com>
        <xmqqy1u9uddc.fsf@gitster.g>
        <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
Message-ID: <220927.86ill9yymv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 26 2022, Calvin Wan wrote:

>>  * Why are we configuring an API behaviour via a global variable in
>>    21st century?
>
> I was mimicking how "ungroup" worked, but now that Avar mentions
> that pattern was for a quick regression fix, I can fix it to pass it in as a
> parameter.

I don't know if you started this work or not, but I had a WIP rebase of
those on-list patches lying around in my tree, which I'm rebasing on
"master" currently.

Some of it's a bit tricky with the in-tree activity since then, I'll
send them in when they're ready, maybe you already did your own rebasing
of them, or maybe it helps & you'd like to base a re-submission on top
of them.

