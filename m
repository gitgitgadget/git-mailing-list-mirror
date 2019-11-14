Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE941F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKNSP6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 13:15:58 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:37106 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNSP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 13:15:58 -0500
Received: by mail-vs1-f74.google.com with SMTP id n7so1007977vsp.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LZZLUftZHpYs6O4h17iHBtpbZjv88VVelwkexa2OxQY=;
        b=jPrJMktmHFGH3ILDN6TPZJ0xo59wUjs920rMaKF0oW2c60OjRA21lGu7FAgZhbtkxZ
         Za5t1rAPmZfSArcjXPukHwdMF3riL4CRK+erHVrvxarLYXkFgapyFP12xOf0c8tCXGIa
         k0eGidIxyBglRmHroZT9BxT8jd5T8m5gE0fF2h54eJtfS7AEd0LKJ5bGzZC3AR6w2egH
         Bb5MfZDuNOfztBC+hQRxzj9DcexrvLCLAyhOcFcYqXiEMSAnTA/LaJKnbayECZAaNn7k
         SXKRRDQXOmlDGychf7ZAzX3SPBUTYYfOWk+FZMPS0pbNcialyRK7ecul04JzYlJcqvdO
         Nh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LZZLUftZHpYs6O4h17iHBtpbZjv88VVelwkexa2OxQY=;
        b=ePiwHfuhhx6qzEkMuhicDHW/oJl7dy1BMYl7D2TCQKX5ZzNKJHMXskgqn5c8Ml0KEg
         e3wZHPU5e87jZ68bs/2T9smvC+LHaHHSMAhNngA60Z561SeNAN7W63WnVH7CVYdHnchK
         yGwkl+P9o+C2BF6RwEH+kZ9WV7PnWpIMJeoZVsGYRMXJFFvklpRk6pkaJcy0tXh2rlRT
         qh3vt2bX9c2Mp4HagsA2ddbkVrWZh8stXf2AdASMs/heme5BTtFk4Gl2XcaYsSp+tp4V
         djKGoa7eiv0OzBlenOj0+wfT9AIXHqfHAznM0blX8s5T0CVkCXzBtMkb5MmEHgboKWCS
         pqhw==
X-Gm-Message-State: APjAAAVdN4PDJFmho82CH8YiL4WrC8bU3sER/7bnqfbsA9RvzHN1zeTp
        ZmDMlTtExu2vIM37MxwUZTenQ9yqEUB8nRELozOM
X-Google-Smtp-Source: APXvYqxveBsS77oms1r9vH/fP2NoL5tRYXHJFrw6ohHq3i324GBuxQFIS7EMey43y0SG0l9JQ/bFNYW5d9hwUWCcCyoQ
X-Received: by 2002:ac5:c399:: with SMTP id s25mr1264307vkk.65.1573755356995;
 Thu, 14 Nov 2019 10:15:56 -0800 (PST)
Date:   Thu, 14 Nov 2019 10:15:52 -0800
In-Reply-To: <20191114060134.GB10643@sigill.intra.peff.net>
Message-Id: <20191114181552.137071-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191114060134.GB10643@sigill.intra.peff.net>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object reading
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     matheus.bernardino@usp.br, jonathantanmy@google.com,
        git@vger.kernel.org, christian.couder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        jrnieder@gmail.com, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > A pthread_rwlock would work, but it would be the first use in Git. I
> > > think we'd need to find an equivalent for compat/win32/pthread.h.
> > 
> > These[1][2] seems to be the equivalent options on Windows. I'll have
> > to read these docs more carefully, but [2] seems to be more
> > interesting in terms of speed. Also, the extra features of [1] are not
> > really needed for our use case here.
> > 
> > [1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/reader-writer-spin-locks
> > [2]: https://docs.microsoft.com/en-us/windows/win32/sync/slim-reader-writer--srw--locks
> 
> Yeah, looks like it, but I don't have any expertise there (nor a Windows
> system to test on).

One thing to note is that that if we do this, we'll be having one rwlock
per pack window. I couldn't find out what the Windows limits were, but
it seems that pthreads does not mandate having no limit [1]:

> Defining symbols for the maximum number of mutexes and condition
> variables was considered but rejected because the number of these
> objects may change dynamically. Furthermore, many implementations
> place these objects into application memory; thus, there is no
> explicit maximum.

[1] https://linux.die.net/man/3/pthread_mutex_init
