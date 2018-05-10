Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90941F424
	for <e@80x24.org>; Thu, 10 May 2018 06:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeEJGBM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:01:12 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46298 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEJGBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:01:12 -0400
Received: by mail-wr0-f173.google.com with SMTP id a12-v6so735770wrn.13
        for <git@vger.kernel.org>; Wed, 09 May 2018 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=itaMubZ+go5rSwqYTLCvSPSyGRRM2M9Xnxu+FfWN4TQ=;
        b=NPcJ1E7uz2EUa6x0t8Lm5zOwNWECU6AG3l0aD9sCVlYcHOX4vDIbepHg24jkT7Y7PH
         tw3UopZpV1cykov4X32+4S3Bu/JgA2vm1i3FzgMiquyE6VHuJnbJYQ3ZT/hhB0j1wuCo
         BgY18DGwhSONz4JBgzVoU4paJhFfe3BljvLl0XE82WoqQz2/RYjd2YI4gGcz9bfJ7c06
         SU8yeOAusovWFZ+FOHPT8S/rLz020o7q0fXO30Zi/jWBO1OC228LAfY6LL1Fot2GW7v6
         LL1xww6y93PZKgdzJO6Cc8XhfgTuqy2NAujgnnn5kGCj5aUiCVWjZ4eNhFwexO+spMoF
         olqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=itaMubZ+go5rSwqYTLCvSPSyGRRM2M9Xnxu+FfWN4TQ=;
        b=HBJQX2+2EVzm+GbCiqSm+cJ+iK1wYRZI1fBt+M1wQSyIo+SsEYgxZWbJGE3NINC7Hr
         Y1LMN82GewHg/ZZnHu8kJURa71mNZ2o3YAahy1pYMnDFrmJ463011jd4vAtfHLxuZr42
         EA2v/Chvtfso4bmSHoiVBHfIx8fVZDQqCcwic72i+52P0LYUFDOXIo5MR8922qrlxuXa
         MfmUPQMsBQwSF5FDZPQoCurf34WKCZIdstpSwqpEWCXQgZCdjzMobBxe063mbNj4V5I8
         Uw2KUTaBYlAXi5YU3G9tpzeuyfWJwT5CR8GsbHZX4WcH3kmGoz0L3ul57arBzPC/vg+b
         BQFw==
X-Gm-Message-State: ALKqPwem9NEpbSXat5d2qTPdkD64I/iWLr66j7kRUMoIdt10IktMKvTE
        5Kybyo/9DJVFNxTHekdSJDU=
X-Google-Smtp-Source: AB8JxZqnriAzY4uZYXVZ2PNdNr4FqQzW1hFepwr/WWYQfvAyQLDzP5zB1B/peFYMJxOM8slnJkMFEQ==
X-Received: by 2002:adf:93e5:: with SMTP id 92-v6mr72428wrp.230.1525932070633;
        Wed, 09 May 2018 23:01:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l69-v6sm247560wmb.6.2018.05.09.23.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 23:01:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/5] getting rid of most "static struct lock_file"s
References: <20180508182548.GD7210@sigill.intra.peff.net>
        <cover.1525898125.git.martin.agren@gmail.com>
        <20180510052137.GC27259@sigill.intra.peff.net>
Date:   Thu, 10 May 2018 15:01:09 +0900
In-Reply-To: <20180510052137.GC27259@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 10 May 2018 01:21:37 -0400")
Message-ID: <xmqqwowcjbh6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think it's worth re-rolling, but one thing to think about for
> future cleanups: you split the patches by touched area, not by
> functionality. So the first three patches have a "while we're here..."
> that has to explain why dropping the "static" is the right thing over
> and over. If you instead did the error-handling fixes independently
> first, then you could lump the "static" cleanups together with one
> explanation (possibly even just as part of the 4th patch).

Thanks Peff for a good pice of advice.  I agree with the assessment
after reading the series through (includng "not worth rerolling"
part).

Thanks, Martin.
