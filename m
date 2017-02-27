Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DD01F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 00:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdB1AuM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 19:50:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36667 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdB1Atz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 19:49:55 -0500
Received: by mail-pf0-f196.google.com with SMTP id j5so2884534pfb.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Mxz9ie53atHhYrEUV3helk8SLJlauXrbXJzi0zewLKA=;
        b=tnBVPDBtINMfxe1xs3amX4uH4HLsjI+C5tiym1iWNYuuw5+b+f9HWYRwXeXRCwsWgt
         /UoToXZ7YDtGnPV2mh6VpRKJgNaTvvHO3e5Oct51vvChP1MU1ptY2DOlUa+NXQ2hAE8Z
         oveB0Xb9KlHCEEe9ANCg7X4qBBFIJvsCI7XlFSbiUWUbrhWkKCbiB8mCv8+R6fk0BLv9
         ge49rnM90SHQXSjhKr3nZUyH0M10XgrvhQ6j+eQ93FmosH8VHysHYsTzPLMp/lV1lSFy
         saRaH4VjRFBAd6vaH0/Xq05jZOAVFdHtQ+XBpFzLw2bhNbHHJVWMlo1ejFLrDStQ28Fa
         e0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Mxz9ie53atHhYrEUV3helk8SLJlauXrbXJzi0zewLKA=;
        b=RvfcR3KkpKOxAAMRMf11CyFoNSCP5Xam09JyyDPH9xrhT1z/jetInSUt6TdsxqiBYJ
         lE1cAskRtw1wGi3BDzY8reywFnGvjwXT5RVTeLKS5b3RYjgT6/qFj8YbMONLSjgy8g7E
         rP23WLGKNAFCacv4nbMrLoUI1wTovZsMrStZdgOQrQBgRgsmtYtXO345WT91MjapjJPb
         am94GnROs3ZRfwRSaJ/bvVI7VcYt5E64FIYIVkr74x/NsFcfjL/Tzdl4omV8znTwL4k+
         1dRf9BjV0EAL2CC3j09uwDo07H3tL8GWJl2yGHLkr+thV9xlEWA6jmm/wuTIeu2l4tWB
         5lKA==
X-Gm-Message-State: AMke39lS4NA3G3lfdJJekqW5lZPjdSLJndb7NpEJyRB8Z+Po0qSGi/iICiWWBNpslvRb6w==
X-Received: by 10.98.39.195 with SMTP id n186mr23330177pfn.17.1488235684543;
        Mon, 27 Feb 2017 14:48:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id d2sm6475293pgf.35.2017.02.27.14.48.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:48:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
Date:   Mon, 27 Feb 2017 14:48:03 -0800
Message-ID: <xmqqlgsrmesc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> One notable fallout of this patch series is that on 64-bit Linux (and
> other platforms where `unsigned long` is 64-bit), we now limit the range
> of dates to LONG_MAX (i.e. the *signed* maximum value). This needs to be
> done as `time_t` can be signed (and indeed is at least on my Ubuntu
> setup).
>
> Obviously, I think that we can live with that, and I hope that all
> interested parties agree.

s/ulong/time_t/ is definintely a good change, and it will take us to
a place we would want to be in in some future.  

As long as there remains no platform we care about whose time_t and
long are still 32-bit signed integer, there will be a fallout to
them with this change.  Probably it is of a larger impact than
losing the upper half of a 64-bit timestamp range on larger boxes.
Hopefully those platforms have died out (or at least we don't mind
breaking them)?

It appears that we use uint64_t in many places in our code.  So
while philosophically time_t is the right type, uint64_t might be
practically a safer alternative type to use at the endgame patch in
this series.  I haven't seen it yet, but presumably the last one 6/6
is the endgame?


