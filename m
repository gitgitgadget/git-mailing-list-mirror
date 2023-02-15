Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A114C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBOQlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBOQln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 11:41:43 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5025FCC
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:41:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z3so6950525pfw.7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O9lAoHC15OJjRMqeIclmhJJB3RSGIxW4n8Cmc5FbSRw=;
        b=QUuQDqQj+0Sd48mUFDpmNZl0pUanFUDTtK+Vxn52L2ePrwIlZFCSH9pAPpUrliMex5
         fCU6si/Zt32/eTcbQcnOTbQXMWU9F6VPPkmeTnCFBc1iYN0sZdNpGPPt9MvX+eLoy1ZZ
         SVAlwdNH1AzrAVdGtt+XZq9lhawKMEAzo2H9ZMnb6gy2ymN/TUpEWyP41i/XG3i6LBaB
         tLWmVqz8rBCeNKNy7dt0dd6Aevp7E9KfzFs2PE7FzpuHTeTQcF+Jv2jrdLjO5aH2snpp
         WFAq+xh9SHkyLIpViPbavnFRBArQ1SNad/ZrlpvCQCr2Kq02In4TBhuKGYSmpH38UE4h
         eWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9lAoHC15OJjRMqeIclmhJJB3RSGIxW4n8Cmc5FbSRw=;
        b=h8w9u+Ch4ViCFTNIxEXMhm+CR/xWk1g9Qzd/Hl68QEsf4fSjB5Ye/BJLLTmdLIekA8
         idk52U+IhK795M3Yk20Apk3ZZko+lbqZGFc1bxf9C2c6KKj2PHVrWmPpPuc4fh+JNzuJ
         8fACLohZfksf6lB1Xh321KkIoyVdEFxueKQEDPC8eb6axpVKzv+XFof3b+myX8HzIwjl
         gn52b+litp6iN1UU3J0dcRfV9WE4RU0evXfcDPB9qDpiKz6ww3YBcRoioUqM6XPnsUnt
         izHv9tPCnXM3Afk4laZIBDv8GMnzzfVKaug1ZQV2sckYjnmG5jTdVGBy9cUlptu1evf9
         4nYg==
X-Gm-Message-State: AO0yUKVLmaFq9KFOBwYUuGH3mPFXZTa5oLN0PI9EXCFYi7Mgej1N42Ko
        E9gmr0U9R4+HYDEe0bJmBb+vprO3QN0=
X-Google-Smtp-Source: AK7set8RI7rxOWLXpc/T78xHy9zewGKRGpBoE3j0tmeJBN7CbHM1cwLD3qIi/94FkpTZcdM/3UbrTg==
X-Received: by 2002:aa7:9886:0:b0:5a8:bdc6:c535 with SMTP id r6-20020aa79886000000b005a8bdc6c535mr1934931pfl.33.1676479301390;
        Wed, 15 Feb 2023 08:41:41 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78153000000b00593fa670c88sm11903144pfn.57.2023.02.15.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:41:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
        <xmqqmt5f535i.fsf@gitster.g>
        <Y+wLoFKXhlugxrh1@coredump.intra.peff.net>
        <xmqqwn4j3mhy.fsf@gitster.g>
        <Y+wN0agVK9ZQU/sT@coredump.intra.peff.net>
        <xmqqsff71plf.fsf@gitster.g>
        <Y+zslp55nmAQ5Fvi@coredump.intra.peff.net>
Date:   Wed, 15 Feb 2023 08:41:40 -0800
Message-ID: <xmqq8rgy2857.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had a similar thought, but I think it is fooled by "refs/heads/%foo".
> The correct shortening there is "%foo".  But we'd parse the
> "refs/heads/%.*s" rule up to the ".", and then complain that they do not
> match.

Yeah, you're right.
