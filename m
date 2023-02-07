Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC22C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBGWY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBGWYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:24:55 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14C2BF15
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:24:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id x31so2487566pgl.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoxGJXr2LszdojkwVD8DvU2WSDeBmmCIgYRlIgrGHtY=;
        b=N+ykqEseDSjMBlz7rBuJaQNWpMrTBN7g/UEjFdW25Xm2AomcN7vBFdCKSBGX3KrdbK
         XCadeA2qJnJR97wh4UK0lYrZxCkwx8RmhKx3qVS6FONiiw3ohlatZiuNwOhgpmA9ptoG
         kqGFXng9Mm/POeL2OxgJaQZeCO4AffOLexpK8L9Bvzxt6dwnapOoSTrGRP5WBAHcjYAg
         +hgRPFwEdui0BYWkj0r9EfhLfh0chHv4UjyhIA/NaOIFt8Xq9YO9yO+r+PkxasWILw23
         3EJfnHZdTfiS2iObfospfjjqtmK1ctrxweWfGSKM0I9Xcod3raHUTxKFpLwdzeXijX3q
         DB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hoxGJXr2LszdojkwVD8DvU2WSDeBmmCIgYRlIgrGHtY=;
        b=C8OnnOWrn+8Gml7xtWtdrz2+rpYNi0edZo+gxsODt4yDCpGfA3uA2dw7HrS00BcXVY
         AJ9zqMQkgkBOP0W8+xg+TnUakGd22UD541A3G8tCXny9wIqbICjEn4fBaJTyUQrZ9F8o
         WdF4cYRIYKckG11wI6sQkBcePld/diNE93RmfD8fdNpSPcHIgbVZGQ2ol7joGGeVYewc
         /V9jmuqjZi8NrnNF7abR3zKxmfd/9otJmndaMlPR7zsXp/4One/EdiIC373EOY3pZ3nm
         rUNKVqo91QhpSmmd1gRBqw5wkhRoL4JfQGiICToq1+3Bx2sUjk+YU8vvBABQeqapqmEc
         1dvw==
X-Gm-Message-State: AO0yUKWeUUEbBHgpr7yd1ekDtn37678/nKRAaFRBhnSurs8UkZG8dawN
        LPphN5LVLEM+SSxx045eyd2Gp73hqJM=
X-Google-Smtp-Source: AK7set/HwxmA3B8TjCHi2J7z13uzX0Tl5AwI2LPpO26Z2ifvjcWDnw1ap52FOTlYHCIFqp0GRy7Ntg==
X-Received: by 2002:a62:4e49:0:b0:5a8:25c8:f372 with SMTP id c70-20020a624e49000000b005a825c8f372mr225588pfb.20.1675808693382;
        Tue, 07 Feb 2023 14:24:53 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c14-20020a624e0e000000b00586fbbdf6e4sm9659629pfb.34.2023.02.07.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:24:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
        <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
        <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
        <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
        <Y+LNitGAude1vogv@coredump.intra.peff.net>
Date:   Tue, 07 Feb 2023 14:24:52 -0800
In-Reply-To: <Y+LNitGAude1vogv@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 7 Feb 2023 17:15:38 -0500")
Message-ID: <xmqqcz6lw1u3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   Side note: If somebody were proposing to add imap-send at all today,
>   I'd probably say "no, that should be a separate project, and you
>   should probably write it in some language that has a decent imap
>   library". It really has nothing at all to do with Git in terms of
>   implementation, and I suspect it's not super well maintained in
>   general. But perhaps it is too late for that.

amen..

