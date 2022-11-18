Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8B1C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 00:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiKSAYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiKSAX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 19:23:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F452171
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:37:55 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f9so2066830pgf.7
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VmFhDVLa4mk0zpTD5Lw1z22Bg+w+NG7WtTTBAE9kKHg=;
        b=c8UsJMmQWi8qDpLJydeaTdA1cUdpfX+ipPvdj6ILmTZHe3uDjrxJu2reUlQAHODBqk
         He+LAwOUH7bv26jEvZX6mbc+qXMWUrCTWJ6x0GP2IbD75M7ZiPLaNa/Qbu9e5jUCKudL
         yI9XRzEGShPrrgL5hXsymuQLd24qNQFtqgy7aDhiCRMNbQmMrbj8LdhhcjN2UplpNTha
         59mRAntzs+D3EIkPEu4VhvHSmDc0emCdBLjerDbNahijl4fWq9xnPuK6zXsYF7vev3WJ
         dl4gIRG2/QQvLsZsuNMnR16v2I2xUQas0fzPYq07ZELN/0VDMJ71aJRLkiWGcnVgs85Y
         APZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmFhDVLa4mk0zpTD5Lw1z22Bg+w+NG7WtTTBAE9kKHg=;
        b=2UMwMJ2s/gbXHFFfiV7QJac4WZl2V+/txj2N10cbQLxLH+UaVWwTRG03ToTFkdxz9q
         MFplBHQk8TdyIsc/V+90lff6lP73qrTfjPO3tTe06+scwpNn/y2azniW6+tP5KXDsaUP
         8wnq4bRYxTodbHxDtDMyiIUdXg5kBpHKCqUbplgN8/+dwtvd651ypUIpUtrB2bytJkLa
         qpGg5HLjMDTjSiaLx21CZ6deePAgrmPK054j4qeWQBZPnx+pgiGgLZZcQY2Dps4lxaEO
         VoX8mE51FoPAd4A8FdIk/Q0ZExA8vz5gm5tblrvQmtoRne9Q7wjtpaOYvsy8W83S1c+I
         nmQw==
X-Gm-Message-State: ANoB5pmjtYq1XeihyrMZDevEQM5zV1uJOP4/pYB7c3D8gb8WfyT9A0/P
        yc7YwHWj/VWWxnh/35ML5gITbZiTIClnRQ==
X-Google-Smtp-Source: AA0mqf6uN4+idFpHFn4yKOxV+sS7apEdZdXcgM2G8CG3A2/NmF9R5okrMCdu/Mn041OH39qPHb0QuA==
X-Received: by 2002:a05:6a00:2161:b0:573:3580:4754 with SMTP id r1-20020a056a00216100b0057335804754mr4203614pff.37.1668814649943;
        Fri, 18 Nov 2022 15:37:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902768100b00187197c4999sm4254606pll.167.2022.11.18.15.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:37:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [Q] Where does "git commit -q -m msg" spend time?
Date:   Fri, 18 Nov 2022 15:37:29 -0800
Message-ID: <xmqqbkp3kf5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a slow filesystem it gets more noticeable, but I have been
wondering (without a debugger or a profiler, as I am supposed to be
on vacation) for the past few weeks why these two commands in the
same repository perform very differently:

    $ git write-tree
    $ git commit -q -m msg

Especially even after running the former, running the latter, which
I naïvely thought that it only needs to create a commit object with
"msg" and wrapping the result of the former (which is more-or-less
instant) into it, and do nothing else.
