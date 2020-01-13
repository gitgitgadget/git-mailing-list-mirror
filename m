Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2525BC33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD8A24690
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 20:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QEhKYhL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAMUrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:47:11 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:37323 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAMUrL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 15:47:11 -0500
Received: by mail-pj1-f50.google.com with SMTP id m13so4804430pjb.2
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nI5aT5cjRLXbohNrLEQ8CMMlwLEAv7ayBHOqHCHlrqI=;
        b=QEhKYhL+GsGczBMEGEMAGL7UmHznTi4Iipr97a93+Hy0EP3YfwILu3O0OxaTfug6vW
         4joOT2pWeE5eBh3zaeftAyK6RH7whrjsWcRl7sGZshnjd/QuI29XkLixU2uvprR/XExq
         RnP2vs/SRUiSEEjT1GF3gaSEz+/dZlKvuJ3KezQEpUaY7SOQFEY5uwrklEMifF9gU1OH
         SmyQf6dYiv7x5yQIENGLbS0Af7wMDLRrzylMtxdNqwJSA3OlpqR6JVDU7tIyHXdFsRG6
         LupEwqN6FhSMBI7p7eGkKmHHJ4ZQXVSWQds7nPbq5dqnwYzM1XtCX1H3EBc1jiuCeRYQ
         kVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nI5aT5cjRLXbohNrLEQ8CMMlwLEAv7ayBHOqHCHlrqI=;
        b=CIDxIy/rAA5kZfbZV8ctEWvqDWTkcFUyEoXauk9iftUdE/ZSxhihlYt8zBc8d9N2yC
         CZsCbWYbuJ2B/78sohMMW7dfyNFv+FQBwmSJTTPIMH0lfK6bfA6CpcJZ2etZa//frPnL
         qtHoHaIH+w+9P6U7fLF7ptK7HW/O5QB1F5dhUrXVUrY3fFDfcdFAt+am7yY/yCPvSIzt
         dw8NI73ZB3sNbqWerYP8oRpU/gB/0v35inK8hbKes0tdU2wItQWgbXg+31RafMg4Pf/a
         n/2AEWl4ODxqcZ4U/26J1Ga4OkTKPkR1ephNDGzkZWYa28BVX/LygCgDfISAh1AsdkXI
         KfhQ==
X-Gm-Message-State: APjAAAUKEMqvd3k7+sVWqagu6WgpDtLFHyiMWuI/xBAUimhFFag79fVo
        wI5OLJf18iDySp7qTczPs76iow==
X-Google-Smtp-Source: APXvYqwaMkHyaDVqJsy3CHaf/ryscHNB7BwfyL47dvxErjHI/TCF64cMzYY3aU6s501ULCoZosiG+g==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr24021946pjz.135.1578948430850;
        Mon, 13 Jan 2020 12:47:10 -0800 (PST)
Received: from localhost ([205.175.106.27])
        by smtp.gmail.com with ESMTPSA id 7sm15681068pfx.52.2020.01.13.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 12:47:10 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 13 Jan 2020 12:47:09 -0800
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0
Message-ID: <20200113204709.GA59304@syl.local>
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Jan 13, 2020 at 11:28:30AM -0800, Junio C Hamano wrote:
> The latest feature release Git v2.25.0 is now available at the
> usual places.  It is comprised of 583 non-merge commits since
> v2.24.0, contributed by 84 people, 32 of which are new faces.

Thanks for another great release. As usual, GitHub's release round-up
can be found at:

  https://github.blog/2020-01-13-highlights-from-git-2-25/

Later this week Stolee is publishing a more in-depth look at 'git
sparse-checkout' on the GitHub blog, and I'll update the above to link
to that, too.


Thanks,
Taylor
