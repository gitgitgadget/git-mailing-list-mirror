Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70ECA1F406
	for <e@80x24.org>; Sat, 12 May 2018 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeELNnn (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 09:43:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44015 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeELNnm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 09:43:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id v15-v6so7883667wrm.10
        for <git@vger.kernel.org>; Sat, 12 May 2018 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8Q816dX7kvxvweWoVfgWlfGpYy4plBZvvXYDi/TXcJ0=;
        b=s5FEehYEKNN5+6OqcA6TUCY1YNjtoEdFb/gwcBYorSnK1xSwKNyR6ukKRESumirEjA
         jpok3rKASigQ/4YCQFcPmkiWbtN7BX3m7N9wD6YfxH0Kxy6qtwqWr3n0uJ9/Pq3PeXSh
         amtOM4kwV13+AbNI1oNwkjU1UauL5ApoJhZTVQryZnAF1DLic12IqzzZ7ahy1zZl9Ox2
         kBbqBMSLG/KMiNKfYGCeMgPF7MQs8w0D1SOLZHGzZju30qt5g7gdAAilkv5eOeJPzLEW
         KMText6y8pnp+8QAXl+oc2WUnAUfu5AkEgdg7gz0LbRNoSbwzCtaPrfUUZCVjo6muOE6
         fSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8Q816dX7kvxvweWoVfgWlfGpYy4plBZvvXYDi/TXcJ0=;
        b=CCQ8PDphXjQDN4738S+/UMTOqH6HA878VGah9veVpbwd19UEjALqD04HzTxDly/9Yn
         h1lLuOV3Z+l6rllkWG47eB2SWHvIU3pVeS/492KNWSbFIbEyfRYxTm+Z6kpxCRB+SJOQ
         Qsip/zC09n9iWaP35xnU3sAMF1tR56YGy0SJqbWeBNGVGnV4RaawFcKooZkuxoYDMHYv
         sGDe5MYTRU8qsAf+BMNgSeVZVY+sPsI1j2ve+30AatSCWlREB68zAWui1JB9zhEOh55p
         OWXJk6bCg54ClpRR+0CSd7nGhFMExht0x5VXsdUTo2D002xTTlpJKqR7PvSh0N/JtJe1
         5zIw==
X-Gm-Message-State: ALKqPwcDmA0xIqAvN+zW5TZzs6s02ws6RE8xOJ0i0dMf2eGLqDOz43f9
        x8H0bhdIpX1RlHR0IqTLArI=
X-Google-Smtp-Source: AB8JxZo1BhfHE5pMIloezOFNDCwO1fwk1G2TAkOJkqwooO07mwmqY24UjQeXesFVGASYmxwNjUBCng==
X-Received: by 2002:adf:e791:: with SMTP id n17-v6mr2098403wrm.225.1526132621229;
        Sat, 12 May 2018 06:43:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u8-v6sm3371971wmf.3.2018.05.12.06.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 06:43:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 04/12] sequencer.c: use commit-slab to mark seen commits
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180512080028.29611-5-pclouds@gmail.com>
        <20180512092500.GE28279@sigill.intra.peff.net>
Date:   Sat, 12 May 2018 22:43:39 +0900
In-Reply-To: <20180512092500.GE28279@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 12 May 2018 05:25:00 -0400")
Message-ID: <xmqq36yxf0qc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, May 12, 2018 at 10:00:20AM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> +define_commit_slab(commit_seen, int);
>
> Yay, this one is nice and simple. :) This is what I had hoped for all
> along with the slab concept.
>
> -Peff

Does it need to use a full int, not just a byte per commit, though?
