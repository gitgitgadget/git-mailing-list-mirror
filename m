Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292561F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967541AbeF1R3E (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:29:04 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34860 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967499AbeF1R3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:29:01 -0400
Received: by mail-wm0-f49.google.com with SMTP id z137-v6so9935598wmc.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=En7WW3fACPmNbFTyXV9giAsBjV+xQ+9dOrLGa4mMVj8=;
        b=ZyzMxgJ9OO4k3U9v6J6RlyczJkob9HbxiV933gHxidW2sKx+90eXcHl4QyVki1TPtA
         zKf7zF9OjKoNr8/GADUZ2DTxToFgil1NzUonVj5lsq6Lmkqv0qBduU2lBaAK2eAGSyQM
         r7ju90HeZAQT4wV3EEMxJ3l/jUbHNtMxoppMXgdPGt4i+jWDrLdXKvx1yoHnlrO/vDcL
         zIrjaC8tUgbq7kgeTJyn9eRA7E7LxI/rJ7AEx9brXM6EvuCf7Wz+0o+vI9/ZUBUurxNF
         8w1TxQwW+cnBy1pH5dhGCXkySjr4EOZNfsiXVgZY5jWHGrmrwoeeP/F1i6hez8MIin+N
         v4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=En7WW3fACPmNbFTyXV9giAsBjV+xQ+9dOrLGa4mMVj8=;
        b=bAx8RwqFqoeYPws2UPMMPycKNIdvL5WOduNwBjhlYGlFBx7WW68M8cublTs8Wdn3ZK
         cTDRfLo3vr9an7QrADmsziqRBi+kkvhzZUHUkKdO+u6BFjEmoGjFINEG/DES5LUs/kXH
         wk3OQRAId02YGm5bGcXLbN3ihcjrk/EYJSlwdPQ92YWweCBVwpkaRoRF30DA2/Bs97HY
         r5PPOamIaa8X1J7yWeoA133/7379MmDtSdnsUrkxj9YQk8EfpMj+l8UVAYaiWm7nY+uE
         Ig+nBP+GAKcXgunc1CW0Nh9GKb5zZucL29/YuOtQ/rKueE+pAdFvjp51eII/ULKTUVKZ
         L/HA==
X-Gm-Message-State: APt69E04aREry6HME/o76rXWo4gD0GRTn+qNcM0aH5pojj4I9OzK4Fk/
        e7xWPVAPn2L9tY17aCQEEtw=
X-Google-Smtp-Source: AAOMgpcj3JYCyX/a1U/pslf0iWMbmxHetXsr98SFW21OnnFWmaFAGhRaE6Zyca3aFRizd2KolIFcbg==
X-Received: by 2002:a1c:5c82:: with SMTP id q124-v6mr9472844wmb.24.1530206940269;
        Thu, 28 Jun 2018 10:29:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m3-v6sm3961842wrs.39.2018.06.28.10.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 10:28:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
        <20180628114912.GA12901@sigill.intra.peff.net>
        <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
Date:   Thu, 28 Jun 2018 10:28:59 -0700
In-Reply-To: <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 28 Jun 2018 17:56:18 +0100")
Message-ID: <xmqq6022yg4k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Junio, do you want me to address the above 'rejected push'
> issue in this patch, or with a follow-up patch? (It should
> be a pretty rare problem - famous last words!)

If you feel the need to say "famous last words", it is an indication
that it is better done as a follow-up, I would think ;-)

Thanks for spotting and addressing this issue.
