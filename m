Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE00820281
	for <e@80x24.org>; Wed, 27 Sep 2017 04:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967754AbdI0E1t (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 00:27:49 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:44304 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965486AbdI0E1s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 00:27:48 -0400
Received: by mail-pg0-f53.google.com with SMTP id j16so7099557pga.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 21:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LYyIXETuxnxrXEZiZWCO2eqJVQ0swfcc/HkSUAJSlOI=;
        b=VFBHoWtemM+6obSNVhIwhtIwb7TLY6DBcgVJj0jmnPX1vtG4aE5ZIM9CpmxOxo+L44
         L84j2sM/KbYgAb85TD7/m8dkigFeRwH9DpF77iiA/rXQ8GNpx09Mt2Z/MDX3FOHmz4g+
         gIEcZ3DcKcNR5jSLtOFZhF9M+PL/T4t7iCW5i1fTyXokmh+zofE+cMsZ7n63pl5lHk7m
         66NehEjeD7CbTBp1rVmMPU87JX1wN+IaO4DV5qOm7eFVWKCWIUNvVqWqmCTX2loqHWIE
         Yz4+oqHY5BIQwEF/j8a2/Y/1M8vbBgAiCxsPkBMGIkdp6Ix8z5OeLz3SATFJ/JrkM84n
         4vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LYyIXETuxnxrXEZiZWCO2eqJVQ0swfcc/HkSUAJSlOI=;
        b=PpdX4h2tCi4R5bvp8QuZUqZJMYbVrnMIIeXkXM4v2fpn10kpB/XKhqG8qMfaeE8nAv
         RBQGBSQVXr2L8P8msa+SiQzhQk8NpDd3dZhOfhjyPLJXEOeiiw6EnNXqdJAlHuySdebQ
         FrbK9Hk4cZnYsODrGcMBHAFeWFzw4m+HYS9UsFAKeLicJ39SZ+m4CG0NjT95cldp5wda
         R9PNA94QZt9dpti7VbQWvM2qkpl7YbbuP4w/ATzw99kGAQmqlAgA6Uykc0b/cQ86qTb/
         qhjAKxj8A3FaU6+5Be2CudcnS54TQdJydg6Y80KfBMGVqn9YaTAnFchkq/XminO+0jXR
         pcTg==
X-Gm-Message-State: AHPjjUiR8cNFBpb0pDYeTqdlLXjCWc4IyjtgJmyZg7mBATXchjxYBWp0
        9iE1tznjtc8cUnT5Mj1GHQc=
X-Google-Smtp-Source: AOwi7QCdT8g7XmgmY1mpdsSbEakCjz8sU9H4eVerLo8x1iLDHgfzKcM24tc7Yae+b1cj7o7y49CIrQ==
X-Received: by 10.98.80.13 with SMTP id e13mr116672pfb.341.1506486468050;
        Tue, 26 Sep 2017 21:27:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id 184sm16732085pfg.18.2017.09.26.21.27.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 21:27:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
References: <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
        <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
        <20170925235510.GL27425@aiede.mtv.corp.google.com>
        <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
        <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
        <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
        <20170926001602.GO27425@aiede.mtv.corp.google.com>
        <20170926001732.GP27425@aiede.mtv.corp.google.com>
        <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net>
        <xmqqvak6ayk0.fsf@gitster.mtv.corp.google.com>
        <20170927040721.6av4o7cjrrkzizzo@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 13:27:46 +0900
In-Reply-To: <20170927040721.6av4o7cjrrkzizzo@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 27 Sep 2017 00:07:22 -0400")
Message-ID: <xmqqa81g7ol9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You actually don't need errno for that. You can write:
>
>   ret = read_in_full(..., size);
>   if (ret < 0)
> 	die_errno("oops");
>   else if (ret != size)
> 	die("short read");
>
> So I think using errno as a sentinel value to tell between the two cases
> doesn't have much value.
> ...
> One of the reasons I dislike the helper I showed earlier is that it
> involves assembling a lego sentence. But the alternative is requiring
> the caller to write both sentences from scratch (and writing a good
> sentence for the short read really is long: you expected X bytes but got
> Y).

All sensible considerations.  I probably should have read the entire
discussion twice before starting to type X-<.  Sorry about the
noise.

> Sometimes a custom "short read" message can be better, if it's "could
> not read enough bytes for packfile header" or similar. You don't need to
> know the exact number then.

That's true, too.  I dunno, either.
