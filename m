Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436581F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfBFWTz (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:19:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44382 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWTy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 17:19:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so7511596wrn.11
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mM+A3JCrX+rLArbPz196+aKvrys/gtnWhi9EskzdyWw=;
        b=L+SsAXtZ0NOW/W2GrW0xsTJ8au7bSQ1ISxzxfpy6+4u/yMTJK0QAFkv9ruDGZNeuP0
         zrraKxWf048TSSsv1B2TdsKe5xVyJeGvvZ9G5yfPxQ8E9eQQcFBhyd+j0f3vRoII3BMb
         8AzKLh9jrhmWO8JKjOjPzmJvGgd8XpTn9/8Rt+//HgOi0Ue6R+UPpHSLsXe//tfL/mz/
         Hx2wHr0/jr/RM2RUUYRm35ZY+qS/tO+fKzSEMFWG8XtR0w7XjmMuc/94W+5sAJv3MhBr
         cfmcqjcJri6hdZEndzOcTk+2oagz1CwREn9+5atdSm71zsafzChb1AuzUtpQRQEvRLsv
         UfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mM+A3JCrX+rLArbPz196+aKvrys/gtnWhi9EskzdyWw=;
        b=QKog2AIEXh5FVhvDhq+XvwKKe0+EWV/pQPEJjqi4fN1TFT50zlH0xO4OOfsyRuiua8
         a5PPxCSNjV6+hA+12hatq6MN9RlOhYf3EZ3z8L7yywDNUT4lX+CtlkTqOdwMsCovCI42
         7WGLl7DDmXe6/NFrjGHH/tgHsC1sVn7LMZ7SKuQ6hqzkEpP4nLAqgbJs/NAKZQbdQn2b
         G1Lep1p6GXGGDOTLUmHTdqTVx9mOKH5NaT1HJ6lFk8bnXF4ZnAn2vsCUZPbc4ogEBlDI
         YqSPblh8o6eOtVFPcTSp8JEDRY1nVa5WDfMqtFx3ikL6JnVHI5N5H9Ev9lMvESXr0m6u
         3Nrw==
X-Gm-Message-State: AHQUAubErLyqKgkFe+02S0wCx+2+oi1OEk/8tJv4peQeLUoW2arzXVYt
        pNRcIA+LLiPyhO/WkahbMAGBrbE9
X-Google-Smtp-Source: AHgI3IbQO8puRNCblbnl5KagNHJpmIi0ovUyEYty4Uvr/34NtrAmEciObeOn71mwh+eTTydxWo2SQw==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr9286948wrm.309.1549491592669;
        Wed, 06 Feb 2019 14:19:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m14sm11192903wrx.59.2019.02.06.14.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:19:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
References: <20181116084427.GA31493@sigill.intra.peff.net>
        <20181116084725.GA31603@sigill.intra.peff.net>
        <xmqq5ztxstkh.fsf@gitster-ct.c.googlers.com>
        <20190206191657.GE10231@sigill.intra.peff.net>
Date:   Wed, 06 Feb 2019 14:19:51 -0800
In-Reply-To: <20190206191657.GE10231@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 6 Feb 2019 14:16:57 -0500")
Message-ID: <xmqqsgx0pnjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yep. Here it is.
>
> Rather than a range-diff, which is quite large due to the code movement,
> I'll include below the interesting hunk of a diff between the two
> endpoints (i.e., what we would have seen applying the packet-err-check
> changes on top of my code movement, which is more or less what I did to
> generate it).

Thanks.  The hunks shown below are to use packet_reader interface in
check_smart_http(), which is exactly what we want to see in this
step, and what I was too lazy to recreate as a part of conflict
resolution ;-)

Thanks, queued.
