Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD75CC2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FA620658
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577747784;
	bh=qY9SfJ2xKUV/KCuIeSu4FD3Y9EcHVHIKKt5sdOhiCYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gtssLtGOrDcVFJG4g7VWVxf1WN8uGfZRGnRtUOdnFEpQNhW0z7A/lBRClfzlQ+7rw
	 ZPJt/NDOVWCdfx0o4i2YGHyKr40B258F9GfcvAu5/v53m4nILYNgEPyiNAf8t3i5UX
	 1eISer6d3oczxyHgCc4wU0tfNmLQ44t7Jx/pV8BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfL3XQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:16:23 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41561 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3XQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:16:23 -0500
Received: by mail-qv1-f68.google.com with SMTP id x1so12878760qvr.8
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ndjAxpJ63W50Lr9KJrYeHPmtNPebHXaQf0Uopr6SDNc=;
        b=J3OYxHKl4cQBrwhEZghua3oy8v21RkwbIfrHO4pre2ATrNoLpylqKO5owAWEUSGrtU
         L6/V1MlNAskGGWrBLy+PJ7yK05inbWz0zJsNWyUTpZ5U8iFUr7GpN/XvlXKjAi1X5g7Q
         rFt37eaYks0QJIkcN9h2q0nSTm/O+IM3e9nC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ndjAxpJ63W50Lr9KJrYeHPmtNPebHXaQf0Uopr6SDNc=;
        b=OnZ6R+hvYw1cJHQoCHYn72g/YYPBv36/vxm5sdml0HtCA6su5XQAyZMqcHYwtfuI5q
         EpQwTBa4+QFZW6r1iQeTAHMAdIsNmIYOv4EqwwoZyKkTW0NabZuw3FXRZjUBQ3bgIGrp
         R7ixeoID0VEWwqYgxLwzi5SZzm5z93wUvkDLHTCNT9vxAMo28AsJ0LU3q3vsqLiLBqGM
         BltkOXOW9lxPyskyN+XYBMNZvlWaSz6x8BYk6yI0QUYoF3TZ2iWgV0MZe7T+qWxG/ABE
         TP6GoWbEbWMs+BCqxZdW1uusF8WEk/3fs4tRdF5sB03IbAdkvU2hcHI1xxrTDpuv6Kwb
         gTWw==
X-Gm-Message-State: APjAAAXORw3jEu5rx70CH7/Ru45hdvymxJpYcNk/2ArVuzPbt1dvpxH5
        pIxPgWm7jkRwSZyurnsedx62rA==
X-Google-Smtp-Source: APXvYqz7pLSwVc3Ei3NtVlMcX0S5gm67jQdo/3d+vAlFiULj3frWPVe5W1ikO4ZMBMf1lc23sQmqbw==
X-Received: by 2002:a0c:d788:: with SMTP id z8mr44751213qvi.211.1577747782282;
        Mon, 30 Dec 2019 15:16:22 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id t1sm10643923qkt.129.2019.12.30.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 15:16:21 -0800 (PST)
Date:   Mon, 30 Dec 2019 18:16:20 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Wong <e@80x24.org>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Subject: Re: "gmane:" search undocumented on lore.kernel.org/git
Message-ID: <20191230231620.lcydd5egk4ma2rph@chatter.i7.local>
Mail-Followup-To: Eric Wong <e@80x24.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
References: <03879A6A-2E8B-45D9-A06E-51926AC949F9@gmail.com>
 <20191230231350.GA16499@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230231350.GA16499@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 30, 2019 at 11:13:50PM +0000, Eric Wong wrote:
> Philippe Blain <levraiphilippeblain@gmail.com> wrote:
> > Hello all,
> > 
> > I just noticed that the help page on lore.kernel.org/git does not mention the possibility of searching for messages using Gmane id’s, as the public-inbox.org/git help page does. 
> > 
> > The search works though, it’s just undocumented, so I thought I’d share; I don’t know how much control we have on the lore.kernel.org public-inbox installation. 
> 
> +Cc Konstantin who runs lore.
> 
> Unless you're getting load-balanced to differently configured
> instances, I think it's luck that the "gmane:" queries you tried
> work.
> 
> gmane:  doesn't seem configured on lore at all.  Compare:
> 
> 	https://lore.kernel.org/git/?q=gmane:1
> 	https://public-inbox.org/git/?q=gmane:1

I haven't configured them because I don't understand what benefit they 
serve. If someone can explain their benefit, I can consider adding this 
to the roadmap.

-K
