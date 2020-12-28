Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCEAC433E9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8183229EF
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgL1Wzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgL1Wkb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 17:40:31 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384FC061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 14:39:51 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e2so8102743pgi.5
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5J5yvCdXbAX+UsVQvw/l6slrbO/nMBLeUw/Mtet9tTk=;
        b=le3Sm1qvfuDlvHaW6y497rdQKYt+qrndzT7hdfETwi85GqEfPLdwFVcOi2XZKdpKUA
         KHXX9dexxZPDbIDdoGY/ITrzS5xC+MoicOqYV6jozMQreu6P2xhhTkYPpY6HCYpQ6XHk
         BQjVzTgJNuVjhgdajvNSpd6YQ4BavYsGA4ZVyVzA6mD7zIR+7Kvy2MOPZXlDs9mxH2Iu
         D2F3nLbBclDsDSmg4CkqCAw3N81DyoCx2THWkF5G1SR0KG5UJEu3LSpl2lUyIgHuTXEC
         /LiQ5Jl7R1yVAdPoW4tiPHWQwJZAnozNHivsz2b1EgJcYn1yQSWj7Vyazs8dfenFLYea
         kJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5J5yvCdXbAX+UsVQvw/l6slrbO/nMBLeUw/Mtet9tTk=;
        b=TTzKx1jjSUA0FL4b3AA9ttKxU0Ukkh7LTX6VS8CMsqC8FJ4CVF24Pg6Uw3r0auB2cv
         YYBich3S9hAK5WNjY0g5w5gMu/xPHXudxvG8qjvkDVbCxkpTvJ8jZ9rPhmZ3PPrUyIky
         hmv4J1unxiFCrIbY9hAuVdt9C+c7+J7D2Bm0zCt82cvnrhWohRK6jUAmlE9tTb2Kqtfv
         O33eoJ7wxs3lhPaOXCA2wDUdupyiYj/ZsiI6PTXj66s9cdzGEVl+D6+GhtCW55bPSef8
         /LITNuS+2yfV+qZAYLzLuwAI8tcTE7dN6RbeWjzIv3ObleFrGY6Z3OIM/mYIFfYO8xbx
         FJAw==
X-Gm-Message-State: AOAM53144K+fxRFrQxI/zkizchoBPSPrO0nHtGIyHelin39azy46uLpO
        x56vxM3coJtT0/LU0xNM4bvnRgtBS/8a9g==
X-Google-Smtp-Source: ABdhPJx3SCbltSHoKeTV0TIuyidMJO/A4wxYUk3y1EhOelGH68tZrxjcYNSPHfFfIDrx4j+Z1ZDpQg==
X-Received: by 2002:a63:1e1a:: with SMTP id e26mr31212658pge.66.1609195190652;
        Mon, 28 Dec 2020 14:39:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id c10sm452074pjn.22.2020.12.28.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 14:39:50 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:39:45 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 18/17] doc: make git-hook.txt point of truth
Message-ID: <X+pesdee13Uia9PR@google.com>
References: <20201222000220.1491091-1-emilyshaffer@google.com>
 <20201228223716.275101-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228223716.275101-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 02:37:16PM -0800, Emily Shaffer wrote:

Argh. I am having awful Monday brain and this should have been
in-reply-to the other thread. I guess that's a point in opposition of
splitting big topics into multiple threads. :|

I'll resend it on the other topic. I'm sorry.

 - Emily
