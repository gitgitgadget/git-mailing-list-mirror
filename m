Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B4E20357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbdGJQJi (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:09:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32844 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753936AbdGJQJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:09:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id u62so13275910pgb.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yLP10PiZq7HTOCs2X+1+lq1L/3MwVzCrBbJ8PSQmnC0=;
        b=Faiqm4s0rQz5sXSmhnf/l3tS4POcIrkhUBZE/wkYGFQTSoRofcVoEyog63YSTXybYA
         e6Z6BGIg50WN62H22w1ap/WKvctHjuflGO69/T2OwT+QOpgOARxUTF1wIEgq0IxjUnr5
         UScnd0K0mcCxmyiYGAF/FTa2nQsK04AioBOTMDzdh28Npjp9tJRY5+ZvhoNMtUIw3tg9
         rNujN/0dggd4k2k5+uS1ujGm73MTzSYoidqy5llPSQc9wcaO+JuH7di637EstJ4NffaV
         ys4HKCN+F2SIZVKf2V0X92ocF+fhKRPCu0zlajQCMvSkOtx8yc8x76x4xWOELQRIw3z4
         kxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yLP10PiZq7HTOCs2X+1+lq1L/3MwVzCrBbJ8PSQmnC0=;
        b=bngiFfwITZ8EQ+ddsq1bkjUEzCuBcs/+gX+XXgSObgh4WVA4VDLjfNRTHS9eiJfvzK
         EzSFMCulfWcXZpyoFykIQg6H0kTtY9diDQcNhiPXTSZAkkJB1eVB87gdm00KbKTjXzmc
         3rD7XWTvnOL+ClWWBX03Audd80rHIzrJU5II1Lzccjlho9Gx5GcDFQEIHSdKOzFhFOaL
         tWQ9280yTANSqk/KKBEjxvOqz8N3Xg8rkPKiOHX2oUP/muzNqKziwwfG/u7/gUp7XY51
         lY6Yfz31leNQCrNWCy8M4wvuGQUzUkAXnNbfDLUCmC/HaayB8Lfy+imJqGeMqNd474sP
         tk+w==
X-Gm-Message-State: AIVw112mDtqvwzbV3CvTZtVblRXZRHeE+zNK9gmUdjN9/llkjjwATpba
        GhYi8CjntvTj5w==
X-Received: by 10.99.60.28 with SMTP id j28mr15064725pga.18.1499702976962;
        Mon, 10 Jul 2017 09:09:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id z6sm23152770pff.46.2017.07.10.09.09.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 09:09:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 6/6] reflog-walk: stop using fake parents
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705080904.idlpm6ecslzfbm75@sigill.intra.peff.net>
        <20170707003239.GA13431@untitled>
        <20170707030224.4iubuzsz2qwdhgiw@sigill.intra.peff.net>
        <20170710094255.GA8170@untitled>
Date:   Mon, 10 Jul 2017 09:09:35 -0700
In-Reply-To: <20170710094255.GA8170@untitled> (Eric Wong's message of "Mon, 10
        Jul 2017 09:42:55 +0000")
Message-ID: <xmqq4luk8e9s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> To notice similar errors sooner, I wonder if we should have a
> test target for 64-bit users to test with -m32 enabled, somehow.

Thanks.  Hopefully https://travis-ci.org/git/git/jobs/251772744 and
its later incarnations should be sufficient?
