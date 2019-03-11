Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8E320248
	for <e@80x24.org>; Mon, 11 Mar 2019 01:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCKBzu (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 21:55:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52031 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfCKBzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 21:55:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so2753849wmi.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WT5f4dnw8rfOj3EORUJGCvfMUjFqt9laOSNxSGF4QH0=;
        b=CaYsPaHbVSBT56wRycBPojimFtAYwE5grJei5OuAVCqZ0B/JouIiyODPQT4enljreE
         Gn3dPB0llLIeClNTP54d47VqpE2CjRJoZ0waZOJmmHHw4DruMGbqyDP7tWs+L+mjcqU1
         rbsloFCZQtfcmBFl/ouT8gxDeaHr1MJt5jX5B8ubAI64xd9tvgsR7P59T1j2tvMhdekl
         5OI17vd2CKAveOmRI2AEsJxF2zaQvNVR+d29E8aPkwszDLmKoJ0Y7HJ4hCa8yidZQumo
         OiwVf+XUmpnQKU0mHVFJmZswcqP6a8nC54DgQ3ro9FUcuCoARvJDA5obD+WmG2i9EY81
         7AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WT5f4dnw8rfOj3EORUJGCvfMUjFqt9laOSNxSGF4QH0=;
        b=LB759k0r+ixuqxkCnQsPDwmi1zs7XQlgof56jzbo6aMHX0PWaxMu9ASYwJGxAlP7ob
         3VuYBz3DyKf0nOyBVPpNmj9MgaYGvFfc7OovoCkHthIu+ytzKhg0cC5WPuWmOc3oSwDm
         O8gtZLfaR8Nz5M41Abxh3AeCrMrjNqkz+NMzOM5nxd4Q+P6wpF9+8gQGagbNEuiKnIIg
         4B8oUqA4w9coMrig84a6mZGxCn0vLdsc/GpUbAIEX0v/lW2uG0NFLRI3LXFjlhkXpR1x
         18e3VKkQxLQkNUD8W6qSmvKcTaROqQrMU8iWxB9+qlGGDRKlkHdgbr1s9A72oxc6qLBK
         I3Cg==
X-Gm-Message-State: APjAAAVHkqU0Q++WQHedNV9puKoWrpuToQ7XnWRo8C1fHJtqRRs2P+1K
        /iHMuCxBMrPaAlrGtWM3YZ0=
X-Google-Smtp-Source: APXvYqysBYJsFjdUHT/u4/kDfJK1+uLJg249ThrAsrzmm3w5FWScr+lLzr/Rv+5IAql+aoT/P7mRNA==
X-Received: by 2002:a1c:e71a:: with SMTP id e26mr15325077wmh.111.1552269347959;
        Sun, 10 Mar 2019 18:55:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c8sm3690673wrx.6.2019.03.10.18.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 18:55:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>
Subject: Re: [PATCH v3 1/2] worktree: fix worktree add race.
References: <cover.1550508544.git.msuchanek@suse.de>
        <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
        <CACsJy8D_ahM_7mLaAijJsZ0e8BF6PBfr3pPisOnYmRH7U8kmqA@mail.gmail.com>
Date:   Mon, 11 Mar 2019 10:55:46 +0900
In-Reply-To: <CACsJy8D_ahM_7mLaAijJsZ0e8BF6PBfr3pPisOnYmRH7U8kmqA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 8 Mar 2019 16:20:13 +0700")
Message-ID: <xmqq5zsqmaxp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Junio, it seems 2/2 is stuck in an endless discussion. But 1/2 is good
> regardless, maybe pick it up now and let 2/2 come later whenever it's
> ready?

Thanks for poking, and I think it is a good idea.
