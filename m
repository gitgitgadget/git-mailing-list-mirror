Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1311CC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF0820674
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YtGIUWSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgAaAcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:32:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34961 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgAaAcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:32:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2009377plt.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 16:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yOAKsDary05ZLyqBa3EysNto+BDipT0QhjHUQCHfDCw=;
        b=YtGIUWSfaVpZB4skiCbTSrgb9PVyoQHNs554jb6W7CvhBO2R1HQ5s/jLYZaWDav82t
         evKByYQmtnwsTtlbiEsdnLvtfZ3MeeFtd0WDC46kpGJUzu98rKV53oMq+LxEPhr9Xbky
         R+Gt5L+G0LVpn44peqaT1t1U5lkSTpc7NkeI4z1esJErTM90zy+8lf2hlEL02LExJ3hS
         9gUNv+h7H/Xz68D2v8IAj1Viy4oDlwl2ei5aP8gcCUm6SEqXK6+DCNY01hDDoQYCaxr0
         qSyHgE3sqBPBYEzxR8Mt+sppO066R+FVQayUaCePgSG423R7+BcYGNV1Oe6pP3rzS33y
         RzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOAKsDary05ZLyqBa3EysNto+BDipT0QhjHUQCHfDCw=;
        b=StUOeORf1iQq97nk4BDhzzryZmBMaT3bF6cSnCmtezHXE3z0fDyswd7cbHn+BfrPao
         N4Zg0jvPxtgRuJaOQngRkaY09yQaj1miNWAYoMJDeR2qCZxvNLc255Bj1pN4HHiWdpBd
         CcJ2wxE5PylHGHozL03O0i/yBMPR1uIoReTQ/AfgGAEH9oJN+uG7WqQKuV/SLJ6PHwWn
         XAGXbpNmiwRIP2BIe4NEivQpNRl/JcuoL2mgnoZ87jvWwm+xY+JRFykCJ1bde/fU8ml7
         2LhrYqvZgxFvRNTnxKbNz1CpoA1E60OnEGA8WQjdCAcmneps+mTa3i7CTvo7pNy3HtDb
         dVGg==
X-Gm-Message-State: APjAAAW2JaXN3gNb437r/QdhB5rjaMx+zW2ypcppjWXJvnJW4UYqrUkh
        cTJotC4VqmJUauif8YRaAspIJA==
X-Google-Smtp-Source: APXvYqy1eU5nFBgYger6kt0lIIdKHUQIQxmMK4GquE9J1zu4nfsAWjlcAPJIZmwGbC9JtMkYILIATQ==
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr7024421pll.119.1580430731559;
        Thu, 30 Jan 2020 16:32:11 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id s1sm7472375pgv.87.2020.01.30.16.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 16:32:11 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:32:10 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH 0/3] builtin/commit-graph.c: new split/merge options
Message-ID: <20200131003210.GA91635@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 04:28:14PM -0800, Taylor Blau wrote:
> Hi,
>
> Here are another few patches that came out of working on GitHub's
> deployment of incremental commit-graphs. These three patches introduce
> two new options: '--split[=<merge-all|no-merge>]' and
> '--input=<source>'.

I should have mentioned: these patches are based on top of my
'tb/commit-graph-use-odb' branch, which I sent to the list in:

  https://lore.kernel.org/git/cover.1580424766.git.me@ttaylorr.com

I think that it makes sense to queue the above other topic first before
this one is applied, at least since these patches are based on that
branch. I can prepare a version that is based on 'master' if that is
preferable, there are only a handful of conflicts to resolve around use
of '->obj_dir' vs '->odb->path' in changing the order.

The two just felt a little too large and disjoint to send as one larger
series.

> [...]

Thanks,
Taylor
