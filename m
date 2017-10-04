Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3952036C
	for <e@80x24.org>; Wed,  4 Oct 2017 19:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdJDTgW (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 15:36:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34617 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdJDTgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 15:36:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id u27so13891643pgn.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+bMt0T7GcjL3KUzTXu2KoZGoLoOv5umnab+53sBCSL4=;
        b=TJ2+CBK93N2O859owz/45B4mJJEIPPBb6Bgmu/TxVkFc+D5XDssZ/r+gvCwU1bCYoW
         ldCGTeWnzj+wYqTfyt0U3DJTNEEF8zq29yaJAzyy3pk77fzcSnMOIGfqdZlTKAfyFb5D
         0w/yrginF/H1tcGdl5YW7ZGMRsMYMaAHNvkwuqO0hOlhJA3aiATQUJ97nXGBdd7pWP8y
         1bYCFuLH2knGnGrC7mqzALwpFUhWBkDkooFqFEqRQfsoT+GzIupZyG2QfuDQVK5488uV
         leuxeIixnxvp3ITXhquKh2A3Ur3SzGjtubaVvBr0QbT1szi92xMKwC+iBuDzbOhCOicP
         8kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+bMt0T7GcjL3KUzTXu2KoZGoLoOv5umnab+53sBCSL4=;
        b=LWB5SOb3wdL1whdJkgayqloEDGh0o5zAlqPdDkxfO4VGIiyfm5l4lkOy/ffvKtxBeh
         mpyPnMKmWw7K4tZNBCWRKyzE78zDbJm9PkanVUlVtb9+is46QJJzKJTXYPcz3Jev6IO4
         7WxxgosaEDmL0JsKq7GgN6/jQCR+bWYTfcVRI8ElmubT7gApyDCHIFGZrXyk9Gay23fq
         jaqQtTzNxb9E+Jl59gzF8T/Gi+0vROqVHp6I8K70y/0r9EDFD65ZKqxIzn2+KOZ4cfAD
         r8j+9CPbDOE+XIRsO/PKgdpGawqCYsCfkqILGGpV4L7eOG0vIpQwbIC1nK8rwMatfL/S
         Ab6g==
X-Gm-Message-State: AHPjjUjz490AxD5JP7OFaa8Ap2Bqhnka5WFcE/6u+rh0erk9NkwiE2ZY
        WuqW0WVaMT4+zdw2KHFt3p4=
X-Google-Smtp-Source: AOwi7QCEOKydZgwz1jZgsBvV6enLdXbjgcOjQv2DgnaFd6/v5N+LcwRqadbrCh4tibfw1WVekgP34g==
X-Received: by 10.101.70.138 with SMTP id h10mr19469474pgr.8.1507145780574;
        Wed, 04 Oct 2017 12:36:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:e14c:b8fa:a887:14e1])
        by smtp.gmail.com with ESMTPSA id d7sm12722598pgf.20.2017.10.04.12.36.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 12:36:19 -0700 (PDT)
Date:   Wed, 4 Oct 2017 12:36:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
Message-ID: <20171004193617.GR19555@aiede.mtv.corp.google.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-2-t.gummerer@gmail.com>
 <20171003224501.GD19555@aiede.mtv.corp.google.com>
 <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
 <20171003233706.GH19555@aiede.mtv.corp.google.com>
 <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> Date: Tue, 3 Oct 2017 19:30:40 -0400
> Subject: [PATCH] path.c: fix uninitialized memory access
> 
> In cleanup_path we're passing in a char array, run a memcmp on it, and
> run through it without ever checking if something is in the array in the
> first place.  This can lead us to access uninitialized memory, for
> example in t5541-http-push-smart.sh test 7, when run under valgrind:
>
> ==4423== Conditional jump or move depends on uninitialised value(s)
> ==4423==    at 0x242FA9: cleanup_path (path.c:35)
[...]
> ==4423==  Uninitialised value was created by a heap allocation
[...]
> ==4423==    by 0x29A30B: strbuf_grow (strbuf.c:66)
> ==4423==    by 0x29A30B: strbuf_vaddf (strbuf.c:277)
> ==4423==    by 0x242F9F: mkpath (path.c:454)
[...]
> Avoid this by using skip_prefix(), which knows not to go beyond the
> end of the string.
>
> Reported-by: Thomas Gummerer <t.gummerer@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
