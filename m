Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2282C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 17:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiILRwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 13:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiILRwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 13:52:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF703F33A
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 10:52:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b75so4106907pfb.7
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=0O2L6OaLc43Hs36T0YvuaQKrWKifM6bSZ/NDMSK5OSc=;
        b=QH4b2XHxSdJ3eZm8LSK5RaqsbXoRh9gyrRe0kgc39LrMZVio4Z32W4U/BrJ8yn+FXT
         Hb85a9QvhaWmr6TdgYgwLFSgTGPix94+slyuQ9yhwFrhznIhc769zWxOg12SAbxWxkWz
         Yn3IGqbqu4CQdTD8v2uxkgYIcx/pmb1iveUvLhdrG+R0J6amUG8TSf5IiCR5wQCq7WMb
         gcvNjesToSMHbN6buDzCVmZUjyzH+QoUpuWHD7PrM8GyX6u8FNABc/omDbBxgFM/eeJF
         AdBuXy9Z1oPi9tG7KRgQehcxQIDB40lcSnLwIWMKN848scoHe6VYCmAcHudnCfVFctFJ
         PDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0O2L6OaLc43Hs36T0YvuaQKrWKifM6bSZ/NDMSK5OSc=;
        b=CFpn5btuq4qvbTUlHRPqB+u/nu/iyAIlgeKhrKVvzzt0Pe35ktCaPJYZuwsibPBmzw
         0jECbYJbV9lHvebXqXCaWM+FDE/URfsDJx3tYNZnf1YNESyZgwFrdjvEU1ViO2wFWOtB
         jIhG49Ggo/E2SutzVw1RWaB4l0MrFa8SbEUHt26nL4UzJFYa3vkeWMJkL4/NWW7datxN
         fEBWs/NJOZpPEGAND6jWjZ0RLV9LJWD5fgtGktajsTyAgjzjptj35T5ZDCUnoYzfJQPX
         RNbs7sWJIp+FbdeHeT28LlR2U8Sgqm+t+MKtHANQ3/I3ogcdzwaypcQDyT5upwetT8wy
         pgnQ==
X-Gm-Message-State: ACgBeo0cDWnDlVvsUE9wWhk01HieYkEma7x8t+HroR9xYIYwFdQ3Q7fK
        47rFtfP86ACGEVjGjGyNp9E=
X-Google-Smtp-Source: AA6agR6n/5POlvAHxGCjomwbVjjWE8WU0rPjoPVpSpn8U0JJblAEzb+MzaJbWrIhvbczJwJN6zaBcg==
X-Received: by 2002:a63:4e14:0:b0:438:8275:7246 with SMTP id c20-20020a634e14000000b0043882757246mr16625343pgb.450.1663005126103;
        Mon, 12 Sep 2022 10:52:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y128-20020a623286000000b005360da6b26bsm5784907pfy.159.2022.09.12.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:52:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Erlend E. Aasland" <erlend.aasland@innova.no>,
        Ivan Tham <pickfire@riseup.net>,
        Aaron Greenberg <p@aaronjgreenberg.com>,
        Elena Petrashen <elena.petrashen@gmail.com>,
        Dinesh <dpdineshp2@gmail.com>,
        Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: Re: [PATCH v4] branch: allow "-" as a shortcut for "previous branch"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
        <dbc0b0d8-4b0a-8d4c-1bfa-8bdcd99310e7@gmail.com>
Date:   Mon, 12 Sep 2022 10:52:04 -0700
In-Reply-To: <dbc0b0d8-4b0a-8d4c-1bfa-8bdcd99310e7@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 11 Sep 2022 16:14:55 +0200")
Message-ID: <xmqqedwgfpkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Teach "git branch" the use of "-" as a shortcut for "@{-1}", like in "checkout
> -", "merge -" and other commands.

I am sorry that this is now at v4, but let's not do this.

"git checkout -" was started purely because "cd -" is a fairly well
known way to say "go back to the previous directory" (it is "cd ~-"
in some shells).

No shells accept "mv - newname" to rename the directory we were
previously in, or "rmdir -" to remove it.  And "diff -r - ." does
not compare the previous and the current directory recursively.
But all of these can be done (with some shells) if you use a proper
syntax, "mv ~- newname", "rmdir ~-", or "diff -r ~- .".

Yes, we may have by mistake added "git merge -" as well, but it is
perfectly fine to say that we should admit it as a mistake and plan
to possibly deprecate it in the longer term.  We shouldn't use it as
an excuse to make things even more confusing.

Thanks.  I think your other "git branch -d @{-1}" thing is sound,
though.
