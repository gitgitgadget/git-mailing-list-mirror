Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAB91F453
	for <e@80x24.org>; Thu, 18 Oct 2018 04:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJRMjR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 08:39:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJRMjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 08:39:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so3999007wmw.2
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FDEKAIA0tR0ffeHXZfGIGSew2y9CGpk9whTne2s0jHw=;
        b=fh6Xk2OAeKiW38WV8xZm0MnkdF9EOK163oHIAxODP5ygMP1Jb0JHnPcSAnK9fDPCBr
         mY2OKKd6EPBfjIsOfkU+0UdRd1zKH1glhhfelaomwyIG6Qzo8pK8VQw6EHZLcg9Lmj4w
         5CrWTohkqCES8hJyaxvNKI67fKbzou9rcY5+Y+oBgOWJ3t9ovFdWLPufCB/f2PlgFwn8
         BjCGulFKvrfYJFHxhV39tg6NA59PUEPf3FrB3GN2tMKfPIctqMSV3L0E5mHUZOpjliO+
         MqeeiOzM2H7O/mKMZZZOCPom9ArT2jdocuFSscUPhxaehu9pQvtVusSjbh/RkN6jmluP
         Y8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FDEKAIA0tR0ffeHXZfGIGSew2y9CGpk9whTne2s0jHw=;
        b=RNerXun2OQ/fgMilIVS0y6KNhUlBx+5oPbGioMGVdrkjEbXxVeW8Y0ezgcX6gVUq+A
         h3YmG+eSgOy4SNag9CfLmbU+JtIOrlCLxcvZYevYiwq9sfnjFs8TzZ+mATBIFPZ4Ao4+
         UJ37wzpXHH3+yOZpKo1juc8ugxbBfF51+O85xblBXBVQcto392h2WATg4xJOCzyV8qUZ
         ihrpa3RCR6gPLIboVff116JHHE7O8y2qXwa+UVQNRD5fZX2/fBkszJeKklOyVEQEqCAe
         UyX3ecFAo6nB5AXczX1liOX+gKI8de+/oij1J+Ep/Q+l8bwv/oMNLOU+6dsztH6L0yW2
         OsAg==
X-Gm-Message-State: ABuFfoj3ffZYxPnUrINhBITisnO7WUJgCajFYDvfsRoJyZ1MBzkGGoyH
        EmrmjXcr7keMFNsHN6p89LQ=
X-Google-Smtp-Source: ACcGV63s7DMWYFniX73dIPfzRY1XI/hXZsUn8g1rDJQuPfTXRIlG2dQkgQXSPfVZ2rcx2c53CjddQA==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr5407089wma.69.1539837613019;
        Wed, 17 Oct 2018 21:40:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm13185549wro.28.2018.10.17.21.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 21:40:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrn@google.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2] list-objects: support for skipping tree traversal
References: <20181018003915.60237-1-matvore@google.com>
Date:   Thu, 18 Oct 2018 13:40:11 +0900
In-Reply-To: <20181018003915.60237-1-matvore@google.com> (Matthew DeVore's
        message of "Wed, 17 Oct 2018 17:39:15 -0700")
Message-ID: <xmqqh8hjvpec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> The tree:0 filter does not need to traverse the trees that it has
> filtered out, so optimize list-objects and list-objects-filter to skip
> traversing the trees entirely. Before this patch, we iterated over all
> children of the tree, and did nothing for all of them, which was
> wasteful.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---

Thanks, will queue.
