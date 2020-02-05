Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3DCC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E96F2082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1idqAJad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBEAaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:30:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38715 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBEAaO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:30:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so171338pjz.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sB70zHtjhUbYl7sS2h63j3u9EBgv45PyIMfWEGigGyU=;
        b=1idqAJadBHnb3YBevzcnzhhA1x+RgSFR1R5Z/wz8P4HyUlH0JHt6jjV7eB0hdErneK
         sehbuRgqlveJhVRwtVP+2W8UuEJRGC+HoWWrlM7EKO6e3V+yh5a+fa9/l4678y9jsIT/
         406rVBQ64PmYw1GDJhHxwKJg0TRwajuT8RUTGDwJXOPZUHDuGX6bwFkuP64/7fUKf3/U
         1TLQggpEo9Tit7KOSKhypPpI+z1Jh6ALaXRaxeFZMR2tufFYOqC1YJETW9yliCyUmbpN
         RmojHCJikUkcS0uhdrNAm1dFVr6NkGw6rabRi8IHP/qgC1Gf6s2ENSPoJVW86G259Btf
         GWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sB70zHtjhUbYl7sS2h63j3u9EBgv45PyIMfWEGigGyU=;
        b=ERdQ8FWTXBTFbnWFkTDdI1mMum9ZIZMx3mJGNP+sx5vJJM03phENl/0U8FsXut6pk5
         WvuJxW2K5bfvmx4urfWys/bShSHHq4HK/dpDu3A8piWC4nmPxdWBWaF9Fn6pwVg8P3sD
         cK5P1ceNvpgIqUIxhvACJ9R7TfjIoW3hESThnctYsWCzocU4EPuQ4yTOsD7aiMoUXhne
         6E4+fPnAwJMbyrTgWiIDSr7O6tW5zRXPlyQVfyrdjpHm4TaZntfiRs4wwQSX486wIFjd
         oWQvUBOjqJv9NPjjfyBE6GjI7Y3/yE071nir9yoNPvYt/CEqD9s+8t9xzGNmwortZNNy
         RyyA==
X-Gm-Message-State: APjAAAV79JcCwD2aiNQVT4zFkPDJd07ohBVThnxETMT16mH+bOdssjaY
        9zgS5DXnlqvtrJTZpYLXNzjOLA==
X-Google-Smtp-Source: APXvYqxuDUXIPvfUkhNvB4lD45hj6xEwF1yOn1ZL08x1+x7hesX45Gv6ZJUsOjANDtQulfLfKCh7gw==
X-Received: by 2002:a17:90a:928c:: with SMTP id n12mr2367496pjo.45.1580862611954;
        Tue, 04 Feb 2020 16:30:11 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:fd92:b4b9:d992:34e6])
        by smtp.gmail.com with ESMTPSA id v5sm10772782pgc.11.2020.02.04.16.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:30:11 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:30:10 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 0/3] builtin/commit-graph.c: new split/merge options
Message-ID: <20200205003010.GA50096@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <xmqq5zgl7waj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zgl7waj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Feb 04, 2020 at 03:44:04PM -0800, Junio C Hamano wrote:
> As the topoic this depends on has been updated, I tried to rebase
> this on top, but I am seeing segfaults in tests.  We'd probably need
> a fresh round of this one to replace it.

Sure, although in fairness this test failure is unique to this series.
But, I sent a rebased version of these three patches to be based on the
latest from the 'tb/commit-graph-use-odb.v2' topic.

> Thanks.

Thanks for taking a look at it.

Thanks,
Taylor
