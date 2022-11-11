Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F775C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiKKCu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiKKCtw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:49:52 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB1817E35
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:48:59 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p141so2767788iod.6
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmPgNRHrHR/byGFaNwF9wFiMfUSdfSkshuYDQ2R9nYU=;
        b=TlqgtY5EL++JmqZHaB2bXyg5573wEa7bONc8tH60zVFKXnYxcUW6XQyoFR4LsFkF8Q
         O7ETIAw4CIhxWW6Ph4BQbAkkeGbJNQ1b+qYkdCR9FLOzz1dZFL2yMzjLH9/Ys/Z6N410
         eERw0wUhoJx+IQMPxX78SYcQQ8hFX+gkOxVueGJrLmD1WRbT71gNw+2spHVfOdlOOjh6
         x9zXqv7lMXyzXvdMmyjyk9IlPoUBtEfHIFrhG5Xzrsm5G+rNuFOhvCmGdk/ArUEa6GxL
         4wFNcnKOP7ec/4TesvLvai6OFiCwP5sdNXvnt7l0slv74cv+UlyKwEF/B5Jdzgjom+Y4
         XBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmPgNRHrHR/byGFaNwF9wFiMfUSdfSkshuYDQ2R9nYU=;
        b=3VGrZY7sfzbJ7ILcSM4/lxT0kRpj+OPXTaorn3BSpKY2MOL77L6Vtf3PBRJ7zgjJFI
         g1uUi5IoyheB+EQRs1vhZBsi27bRJ8DhXbz6mUc+6nInLDazGGIfDlmqzGqLFmBRx0oV
         vD/q98AVLkdDlbdCt78UGzcSR/DW9DA9xGf6u1mtGp7XVFOq/k64ZNVodj4yKXUC+bGj
         i0x3fsGWvVBY4aeoVzS+4PuTSbQqIcobrasFDkThjzB2jHqRydSenSkiInLKzfu4EJIR
         AaE8TeGUCDas0YAXmzXRtRJbiBPVjTD0XDXlak6Ie9ir77AJeVwHWTPVyGhnBbee8NYw
         5izg==
X-Gm-Message-State: ANoB5pmo04Osd0jvIDZNvTYinuZxAU8RRvnxfFdNqqnTbcSdQLPlmEr4
        pK1turUSnoO1jTONcqEc7RRchA==
X-Google-Smtp-Source: AA0mqf4TV9YV6XeduhNKS0MzrEFeFDvyiFxq6v2De9S4HtrTvDeFpbo2caePu3cys9zjpH60G4Dk9g==
X-Received: by 2002:a5d:8999:0:b0:6bc:46d6:5a0d with SMTP id m25-20020a5d8999000000b006bc46d65a0dmr117683iol.158.1668134938635;
        Thu, 10 Nov 2022 18:48:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bg15-20020a0566383c4f00b00356744215f6sm436957jab.47.2022.11.10.18.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:48:58 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:48:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        me@ttaylor.com
Subject: Re: [PATCH] maintenance: improve error reporting for unregister
Message-ID: <Y224GSbupvWD8mu/@nand.local>
References: <20221110225310.7488-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221110225310.7488-1-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 03:53:10PM -0700, Ronan Pigott wrote:
>  Documentation/git-maintenance.txt |  2 +-
>  builtin/gc.c                      | 22 ++++++++++++++--------
>  t/t7900-maintenance.sh            |  6 +++++-
>  3 files changed, 20 insertions(+), 10 deletions(-)

Thanks, this looks pretty reasonable to me. Let's make sure Stolee has a
look, too.

Thanks,
Taylor
