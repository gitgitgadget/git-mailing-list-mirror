Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6905E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeBBWsv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:48:51 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeBBWsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:48:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so15684141wmd.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mqMUkPMzdNvH08MubLq7np8J8mug5XKirpag6c6HzLg=;
        b=ovhyUq4HoQ6NIhaLq8+PvwYV9ZItz9gKu1DvNf/zPOhCt5Z0yO5N59BP0SoJub8CEG
         312qXDh+G5XJ0ezLd8XZEj9lkFgSQ++GKA7yiCOCHCJ21PzAmumPV2Ep0oBXkRnExUaZ
         i5Ag88HL7eslmrBb5i/y+cRhTUvx9rqDt+oddrRBWHs+L0vmyAF0ft49XQpPEpPLIeog
         Jx93iszYqgPU8FCou+UFcQnI/gyhx+74dDTNVlgRqFpPI0G3k+SJfqUf93g/cqYT7r95
         KCiwxdo34z52BqLXBWHPCQmGdfRZ91/8OHogQFwnvaEzVG73UwZ5cJbhPGTR5IJYD5Ls
         TisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mqMUkPMzdNvH08MubLq7np8J8mug5XKirpag6c6HzLg=;
        b=FFsjBwASFRvjYhj3s5x4MihTld3iG/+XlfAF64XRjiYPKEd3GDxrwR+50ICFMSgsHT
         pFDe9y9Ak5ZgyAF9kmeK/fQdVS64S4SwltDC/R+d4iET6uw3ietCarBehYpXiodNtDCc
         Ksdqiy80pXTzqZM/s116CbiE+cnblyaPijQPFxT8smVduc6h00OM0p2dNVWXsI/nf7y4
         NUjR46JoPQxagH82bLke+Q5DGEHz/GkJ64MjBqcB/VwNWkA2QRsxAV1sjxcWjdZ4XsVp
         ZveVIYP7FyV8b1D1mKXOyubApXlbiWqdsUnTsXrR+MUJWFtzxm6NUIbhJ/SwfE9Vg3zV
         54Dg==
X-Gm-Message-State: APf1xPD3FYQ8JrIgapG1dZJe1+ciff17VRhlI8HO1QhJ8api/MtTYpcg
        lk6M/pw8wS6qFbjBGYbWNVw=
X-Google-Smtp-Source: AH8x226gBAQGYYndqu6O7RcK9cJi+zWi10uAF5FrfHrmvwNLe5STNMs+MyI1kPUrB8EtKJXtPv/JIQ==
X-Received: by 10.28.197.201 with SMTP id v192mr4872699wmf.53.1517611725031;
        Fri, 02 Feb 2018 14:48:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 77sm2288459wmt.37.2018.02.02.14.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 14:48:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
        <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
        <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
Date:   Fri, 02 Feb 2018 14:48:43 -0800
In-Reply-To: <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
        (Stefan Beller's message of "Fri, 2 Feb 2018 10:36:51 -0800")
Message-ID: <xmqq607fc8j8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is true for git-submodule and a few others (the minority of commands IIRC)
> git-tag for example takes subcommands such as --list or --verify.
> https://public-inbox.org/git/xmqqiomodkt9.fsf@gitster.dls.corp.google.com/

Thanks.  It refers to an article at gmane, which is not readily
accessible unless you use newsreader.  The original discussion it
refers to appears at:

    https://public-inbox.org/git/7vbo5itjfl.fsf@alter.siamese.dyndns.org/

for those who are interested.

I am still not sure if it is a good design to add a new command like
this series does, though.  I would naively have expected that this
would be a new pack index format that is produced by pack-objects
and index-pack, for example, in which case its maintenance would
almost be invisible to end users (i.e. just like how the pack bitmap
feature was added to the system).


