Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70A82027C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdFBXwT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:52:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36505 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBXwS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:52:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so14050087pfb.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SOgzzlfksQz5DGIwRsHZwuc2d0MUNZfUYrqQQHhDByE=;
        b=rbE/jEGf9KNwSMVvn8lyJe3g+AWnXSy2QAJhiZN6bDhgLGjp4T1G0r/MYXCnb3M4mi
         +C9caNzkAMvi6GXIDjc53yjDv/mnBs2P4wAA914E7iYm9C3J1ygRomV2908AwqrPxZJU
         TGEgvwqs0lmw653se+j3koC2175HjDfxQkB20UjfJLV8kSbWEzDTxaufPhgQwoafIcMM
         CQeJI1ek61UU+UKbA3K5mQYkosbIIDCYzm13vT3Q/iku64GyFXuL4xE1kSWO88VKla1M
         Jk68youTU+YD2Bf8TGSXHzVcg8sjOPdIlXJoX5Eeso4RLfpUfesJ6xD8nxBXQwFpaFTU
         UCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SOgzzlfksQz5DGIwRsHZwuc2d0MUNZfUYrqQQHhDByE=;
        b=RrtBuU/vNo7V2cTw+n51RqmQBoaDDl10oDuCAfBfKWaXVTZ5psd7j9+uxS9IGEbdkJ
         v82y7sCXyXcX+i0x2s4m41aC3zA9n/4BsYd0R2x4Z33khhtW8QI6ala3pPMdQNd276qn
         JMtKq19TN+r9+Y4k7GOXAb8vPQNj89rjqQRWZ3AoxbntNhKxwSPbCLodcQp/rPnLHjOc
         8+/lbbioaU44jYwPtCjsig5QE8VNWqSFKSKo1N4hsDJ4U/qROHuEVrrpN5jBiEjucVkr
         VHVCDk/mn4LwdCVmiD0/o9ad+nJTnlIaV6qEXd9UrHA7HPiE3BENhgxvEO/BXLKmen8T
         nAwA==
X-Gm-Message-State: AODbwcCWOJUUPpUs+mu4w5LuP2b+hX0VjaQasHgd/1ecavlIO+8s7Xfu
        s7zsLaWiOBM2dw==
X-Received: by 10.98.224.194 with SMTP id d63mr3070690pfm.174.1496447537636;
        Fri, 02 Jun 2017 16:52:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id u9sm42414751pgn.55.2017.06.02.16.52.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 16:52:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
References: <20170602103330.25663-1-avarab@gmail.com>
        <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
Date:   Sat, 03 Jun 2017 08:52:16 +0900
In-Reply-To: <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 2 Jun 2017 14:45:07 -0400")
Message-ID: <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I think a more compelling case is that there may be an ongoing
> operation in the original repo (e.g., say you are in the middle of
> writing a commit message) when we do a blind copy of the filesystem
> contents. You might racily pick up a lockfile.
>
> Should we find and delete all *.lock files in the copied directory? That
> would get ref locks, etc. Half-formed object files are OK. Technically
> if you want to get an uncorrupted repository you'd also want to copy
> refs before objects (in case somebody makes a new object and updates a
> ref while you're copying).
>
> I don't know how careful it's worth being. I don't really _object_ to
> this patch exactly, but it does seem like it's picking up one random
> case (that presumably you hit) and ignoring all of the related cases.

My feeling exactly.  Diagnosing and failing upfront saying "well you
made a copy but it is not suitable for testing" sounds more sensible
at lesat to me.
