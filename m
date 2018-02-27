Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5121FAE2
	for <e@80x24.org>; Tue, 27 Feb 2018 21:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeB0V6E (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:58:04 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55553 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeB0V6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:58:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id q83so1346141wme.5
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nQR2RLjiiJujt82vkPq5z7SuZDOgISxX1Hr9rQ0BCHw=;
        b=LwI2dfmO2v+7mg1kh0MUd4xKukeyUCC1xFiCd96GXIKOs5DVEy2M0sZi5wMp4dNmWf
         AaeOHxDzkL98f9pPbV2c8blrRsO3SYIkDcDERQ98ogh7KVchmsYyvVB2rvP32pgLmEm+
         zNydyGMCYOeNsPRYDZ7MGVYIpmQ/4owzFgMAY2KUvDjaeuXdeq5Mq2vydJRIEM6Y71jV
         7lWOPNjIsDjtXzmbDkdeW40Ypcr4jUC3aXHNpHUAW5TgPN6YDXNKbi+E5GKMhvpNoYfW
         qqZiE5cQOdDwbYu1mB8pMXIUJsa0DuXV9IR86LzDfPBokWq4WF/iN8MLg2NZNYjyolNq
         cYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nQR2RLjiiJujt82vkPq5z7SuZDOgISxX1Hr9rQ0BCHw=;
        b=GapqNS1hVrZpPWM4OHlFwPe1Ti59ihbdR2ZHNe9/iQmN8aPJdxKOTRNavaN234n6FF
         PPzyz8mYymlCF1gAGzzjx/sOSyXQfjTaHSAmwrQTsV9vIm4eW43WVjdaSnhjUanexGVa
         snMFsSjLklyLV6u6Byri7kXs0JHfRIWfvbJpIIBPHHzeawe3/TGTib74epWZ3lzt/MA+
         7/Lh1U7TpoQXzlTvwoihcrXRXohMm0kFhuBLhB5JlK6pFyTScgrNn+68wC5xdp1GN9rR
         VW6Y3zsP8z8mIUCuWBhA3pU2bZU/l7BfEb+N4pVf6Nz5g994wUmDi/VXLy3GNWtKsdQ/
         qPeA==
X-Gm-Message-State: APf1xPCuvVGFIpa58T+GDogps1MeqYpWB9K82tq+WHvqNNdKj2RPBuZu
        SrqSJ23PuHdetkaRCH73sV8=
X-Google-Smtp-Source: AG47ELvGGrL9qu/EPRdjTxRVb8bNaoG7RrPYyQ9x32BwStvaj3zjTNIbUNebWcUTtDTSrVy8T16SUQ==
X-Received: by 10.28.69.65 with SMTP id s62mr12368291wma.78.1519768681751;
        Tue, 27 Feb 2018 13:58:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 42sm130761wrx.92.2018.02.27.13.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 13:58:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-15-bmwill@google.com>
        <20180221145411.35b2ea84747518a499276bdd@google.com>
        <20180222181922.GD185096@google.com>
        <20180222182657.GE19035@sigill.intra.peff.net>
        <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
        <20180227062128.GG65699@aiede.svl.corp.google.com>
Date:   Tue, 27 Feb 2018 13:58:00 -0800
In-Reply-To: <20180227062128.GG65699@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 26 Feb 2018 22:21:28 -0800")
Message-ID: <xmqq8tbep02f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Tan wrote:
>> On Thu, 22 Feb 2018 13:26:58 -0500
>> Jeff King <peff@peff.net> wrote:
>
>>> I agree that it shouldn't matter much here. But if the name argv_array
>>> is standing in the way of using it, I think we should consider giving it
>>> a more general name. I picked that not to evoke "this must be arguments"
>>> but "this is terminated by a single NULL".
> [...]
>> This sounds reasonable - I withdraw my comment about using struct
>> string_list.
>
> Marking with #leftoverbits as a reminder to think about what such a
> more general name would be (or what kind of docs to put in
> argv-array.h) and make it so the next time I do a search for that
> keyword.

So are we looking for a natural name to call an array of trings?  I
personally do not mind argv_array too much, but perhaps we can call
it a string_array and then everybody will be happy?
