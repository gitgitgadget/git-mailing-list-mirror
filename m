Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2608F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935238AbcHJUB3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:01:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36462 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935372AbcHJUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 16:00:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so11634438wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 13:00:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VbZM5AtNDLWZ5IOYQMcIsx7ZAYneUmNdf/iiprMyWZA=;
        b=AtY0LSF1saE7KTz9VWJmtAUJDtYeVkW3ymwWgqltwrrd8YxfKdUC4wYLerViFbewh+
         UEEgM3nLH/BORwTdVLUT50KSj33CDnxTsYlIhJNvGwEUhaCdToYsVk/ReWOn16NWFRxh
         iW2rnt7Og1k7+h4e9OAGK1KCCLh9EatPvDZ8yWLk+JmkGoaJgVe0+9lxxZ0NK2k6n4Sw
         fzK0GJLGFjd43zt0OJduBPteapZQe3skmlQKVUDFohpu689Re1IhnIMZakAN6se286YV
         2NQ5nQ3vvuzZGaAd4w0pHSszcyXB1lmXVfluJjMw98YOnaHXnb79zA7mXwlDf3DLVgFu
         gQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VbZM5AtNDLWZ5IOYQMcIsx7ZAYneUmNdf/iiprMyWZA=;
        b=KlprhduHhb/hETN3cyjrmalojiXwnNxEC99HrcIyyYa+pzYZTaUCzANE6IiDQAP73+
         F3EXgSC5kQyBQ1s8wnX9rAeBkPWJ96EqHU5/3bcdbM5YJAi6+KisGhJkdcyFTkQblR3P
         nC0yS3jPnqex6WouDC+XEYUdmETFvDbVW39Ggd7RaIhulowQZbm1RtSgdf88mNiEc/Eo
         dsFDLyzVuwof5pWh8FafE3OguwzASQE8UDp9bc1NiHXtLOKTgl+ZXTrg+L1imGQ5zAoz
         ft4vFAleCmZCnNv5TRICo5WKMYHQDHTSNUAN5brEmXJz01+8vh6BZ887Lygoi8OBPG5M
         HKfg==
X-Gm-Message-State: AEkoouvN/0Zb73MiHin10MrOMB20lvC+QTwSOPXOO8cDwQ9OyfILQRiRSeoxsRAcfBaIpQ==
X-Received: by 10.194.37.101 with SMTP id x5mr4753629wjj.95.1470835479849;
        Wed, 10 Aug 2016 06:24:39 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k3sm43057311wjf.7.2016.08.10.06.24.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:24:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 02/15] pkt-line: call packet_trace() only if a packet is actually send
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810131317.a4npld5hf2qk6wiq@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 15:24:38 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, mlbright@gmail.com, e@80x24.org,
	Johannes.Schindelin@gmx.de, ben@wijen.net
Content-Transfer-Encoding: 7bit
Message-Id: <4111F00D-74A9-449D-BDE9-EE170DA4A403@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-3-larsxschneider@gmail.com> <20160810131317.a4npld5hf2qk6wiq@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 15:13, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 10, 2016 at 03:03:58PM +0200, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The packet_trace() call is not ideal in format_packet() as we would print
>> a trace when a packet is formatted and (potentially) when the packet is
>> actually send. This was no problem up until now because format_packet()
>> was only used by one function. Fix it by moving the trace call into the
>> function that actually sends the packet.
> 
> It looks like there are two functions: packet_write() and
> packet_buf_write().

I did not call trace in packet_buf_write() because this function does not
perform any writes.


> Your patch only touches one of them, and it looks like we would fail to
> trace many packets (e.g., see receive-pack.c:report(), which uses
> packet_buf_write() and then write()s out the result).

I see. But isn't it confusing if packet_buf_write() issues a trace call?
If I just call this function then nothing happens at all. Shouldn't the
trace call be made in receive-pack.c:report() ? Or shouldn't receive-pack
let pkt-line.c perform the write calls?

-Lars


> PS Also, s/send/sent/ in the commit message.

Thanks :)
