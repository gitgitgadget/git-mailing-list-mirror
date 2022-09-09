Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9273ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIISsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIISsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 14:48:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D04130D0A
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 11:48:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so2494460pjl.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=nf4NOmsXhYc4ws4uEHVkYGCW9PUQcU5VV7neVBSItWw=;
        b=I9zKbx8sGxBaGW0p9cgiEHC9HuONX5irvj0IRY3oXvgIIhz3u8e9WG57nVpW0r8Vog
         pH4xNUxeEAgJ6lIQVQKYWscUfHresgRo6X1yaSSIC9HqHA+hr2q3sw8HgOj7N/rr3e0A
         Lkkjoz+3nVOez1pDOatrrizVtLRRTIH+bdJebdBIi0pzLPEPHedFr2tSTsk2HlZ8CvpQ
         Ida7zk5jjfKwCvGTYvzTrLiY21CVRgHnibiojENi7DshPgamCEanmxavW7zttlBnQqPV
         3Dzfy4mj4MXaYaU9xThBJfzBEgt4HhHhZFIk6kVYRCOW+KQWcwMx1P3oMX2zK92qppZ3
         CZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=nf4NOmsXhYc4ws4uEHVkYGCW9PUQcU5VV7neVBSItWw=;
        b=KJXq40OwSpIhfxNlxH8h6WqEfxCfjcfwQqgBSj1iye/qgblg8cc9qKkHkO2/cbknP0
         ysybGkF2ZZe+BGy0Wyq4bPz1VOxOu8drr99FK7prV67NAfeCN39JB6AWJwDgAfhQc/pJ
         s1IFQvyv3RX3innKfW6GatreYhiSKw4VPpBbxkznKDAD3WrdEHwVvwbhqg3SRxbgszwr
         7AQNo/WPFIuu3VR2G7xbKlhtDufFW3FelWr5M4zgUxuLyhqeZ9Ia5qlfeuvUvAyu7LI1
         G4Y8kyrb0Kt9iZFUosvmB/0j9vvYqoJisJq7dxmRnP2fpyrWyBXNKAX11w1tDlv9Ye7H
         bFrQ==
X-Gm-Message-State: ACgBeo1KsRn878rJM1MLMEfBzubpZfMr6oqMoU+TXeCeCr/oOvbTwqm/
        7dPBs8DvWWgwYR0CDteeOwsFFvTuPIk=
X-Google-Smtp-Source: AA6agR4oZY8tAQweMrhOruq/uKP+6ueNWPqhdnsVEAHlt+MJdzNU36sJY4O8iqNNCcq9z+SHtlvjwQ==
X-Received: by 2002:a17:90b:1d08:b0:200:823f:9745 with SMTP id on8-20020a17090b1d0800b00200823f9745mr10841425pjb.84.1662749300916;
        Fri, 09 Sep 2022 11:48:20 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i17-20020aa796f1000000b00540d03f522fsm70006pfq.66.2022.09.09.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 11:48:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: git mergetool, merge.tool, merge.guitool and DISPLAY
References: <CAPMMpogZd_em4_Fdk0sNFqAXqH19VOVyw3WsNT2LHsQNOb0_rw@mail.gmail.com>
        <xmqqpmg4lbnd.fsf@gitster.g>
        <CAPMMpoj9ww18j4gUKhXsLFUGrYsbuq6Aww4z9VDboA3h78eHsw@mail.gmail.com>
Date:   Fri, 09 Sep 2022 11:48:20 -0700
In-Reply-To: <CAPMMpoj9ww18j4gUKhXsLFUGrYsbuq6Aww4z9VDboA3h78eHsw@mail.gmail.com>
        (Tao Klerks's message of "Fri, 9 Sep 2022 20:09:03 +0200")
Message-ID: <xmqqmtb8jsej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> Excellent, I agree. My concern then is whether this behavior should be
> placed behind a new config switch, to avoid surprising users who might
> have come to expect the current (in my opinion suboptimal) behavior,
> or whether invoking the merge.guitool instead of the merge.tool, when
> there is a merge.guitool of course and the DISPLAY is set, would be a
> net improvement even for those users and should just be implemented.

I wonder if we can think of a new config knob as giving the default
value for the --gui option that is a tristate <false, auto, true>.
When the knob is not set, it default to 'false', which is the
current behaviour.  The default most likely to be the most sensible
would be 'auto' which is "see the environment to guess if use of GUI
is appropriate".

