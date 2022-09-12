Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247A0C6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 19:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiILThu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILThs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 15:37:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180743E67
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:37:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 65so9649675pfx.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=0O15rdRIPLExQoEZGpi0DZA7EIImAuiq8QuG72xoUQI=;
        b=lP1H+E8eb4ra/DnlrAOPCgLsfSqsc8hGb26VtYkXdN/LkTkgSEoeweVDseqZyodpXg
         R19Lw5ffOu+9pX1l120DqAnYSTfpOJqNUjLkegAzedRGueVQhGeCyvwmy7fHBAVCHD28
         GbvIP5E779VjDu4t/5lNAv3gtm5Sg4n2lbmg36WdgbTE+/kMgQW9wU2UlYwBWO7UNuqW
         OqgYulNspDygb8c5d32n3t0Lr+mCiQeQHQK9tAZkuMN9CwNaUpXA/tSaBry6gJN0ol03
         /cvvlS8YGvZtKCnOfH1bZUeESI36S8jBFrJdRFkjSJpgnkjd+KwAWoy3eEsuZMz6RSAl
         qfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=0O15rdRIPLExQoEZGpi0DZA7EIImAuiq8QuG72xoUQI=;
        b=OXgG1kHANF4URVORbOJ8wG8SOOaEXSrZPaQpqn5NZ6q8x7vk5lKhajH13qLHuiSnLR
         llfYlVVt8rBC8IVPR7Vfwk9YlEdqKqTfN0mGcjmPzTYjBEFhM4iDLccIaXAnr9DFPhk3
         ni30lfv9ZFIfsAlZFI4CyZgm5l9KxWEOhk9K9Dben2x5IwlW0ATHdGIb1YUARnPaJbn3
         wzyASuGQEBt6tXa3ABWJ9i0cL+D4/dIvwHcY12cp8QfnFuClV3o6wfDKuu4pDB79MP9q
         BHS3MI68v10I+CNpKujcH318cyHegL2pInAPW0+hew/BUCdULHE+3MqrdO7No6zQMGyv
         N82Q==
X-Gm-Message-State: ACgBeo3aSviuIP5lXDJbJLJnAOHD6t2Q6xpPY7MQP6dl3PKxBwllRufu
        WMH2ppZ8QBfdj8bZBoV/j6s=
X-Google-Smtp-Source: AA6agR7sQR7BhMdX4xZLCn2n5rpL0AP5JcLoC38PUFwDehxVdOxPDp0sLQf1R4tmUuYXu7X9GMvX5A==
X-Received: by 2002:a65:6a4a:0:b0:434:a2b8:1a83 with SMTP id o10-20020a656a4a000000b00434a2b81a83mr24234960pgu.125.1663011466851;
        Mon, 12 Sep 2022 12:37:46 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902c40500b00172dc6e1916sm6476980plk.220.2022.09.12.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:37:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v5 0/4] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <xmqqedwghauv.fsf@gitster.g>
Date:   Mon, 12 Sep 2022 12:37:46 -0700
In-Reply-To: <xmqqedwghauv.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        12 Sep 2022 08:27:04 -0700")
Message-ID: <xmqqr10gcrjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Eric DeCosta (4):
>>   fsmonitor: refactor filesystem checks to common interface
>>   fsmonitor: relocate socket file if .git directory is remote
>>   fsmonitor: avoid socket location check if using hook
>>   fsmonitor: deal with synthetic firmlinks on macOS
>
> It looks like this one is organized quite differently from the last
> iteration <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>

Given that we are very close to -rc period, I am very tempted to say
that this follow-up effort can and should be separated out of the
previous "windows only" one, and we should merge the single patch
that has been in 'next' to 'master' without waiting for this "macOS,
too" topic.  What do people think?

Thanks.
