Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB605C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiKDVlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDVlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:41:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661B40444
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:41:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 11so4865772iou.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiLq+Po3Jyr/4pgkfXmsWleT0mQv13lJWTSc0BaXtF8=;
        b=vcKUCM7qxKLHzy8WzVgaYl18zqUHEsKc3+9Alszn0sg36DzkURdlglVBz9ocVWd9Xi
         yIPvybrtL+JxmfqqvG8XYGWgoE1cL2fKmDDu7Fti0j0mnnItIAQbRi9q2XGYmV8nWyuK
         ObZFtM3J6eqKVlBSYc5JfEpvq5foHj7Jaq3YP2vbUNDiIwkRVqf/NmIR2WeUmP/F2EX7
         d+xQnu4ykyIgZa5hgCNBUncjU6EjALbtsxN6QFLCyWcTtfQTDhhRswJkPz2H7zchvxzV
         XUopoSnhdBFSjzQb05Wl53fx2i9ioYLq8Jevm/mWRxLGe4dvPE4RUfvs8+E+9nEkMyGA
         Q3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiLq+Po3Jyr/4pgkfXmsWleT0mQv13lJWTSc0BaXtF8=;
        b=rCqXsPP3hpqAHeeMYxYZmRtNjY4qeBBURT9Xk61PbH3MzP1VksDPTfDopyMCXXVTd0
         iFen54N9jUILRx1WcaJDslphsGy61WeC6gYEKajDxaikDjwdRCFVz9I+k9LYlQKBGUAD
         971aZr/a//LgJdZMppO/Cc3GH6zJzJ7W+8Y5PUloF96soLfuEokddlT2bWdwoJp4dm1a
         c+amJ0rFMin9q7o4E9/acpsw3D2xODiURBw1E0RqyEsRoFo7/607edtqUYKqENb1fNFC
         VzMFOtfP+43gW58OdTo+lRW8mJoi2SQYOhVyfCbBRlx/qQA6fv2Ul9ONKbdYDK09eYia
         k1Vw==
X-Gm-Message-State: ACrzQf0D8qX9XwX6XBW+iJYYhpiH1iNQbLOjXe+d6oUFpM4wVS90jNAB
        g1kudQJOhS+iLZX6McOZ6oG5HA==
X-Google-Smtp-Source: AMsMyM7IPN/C0ktQT5do8fG+IJuqMtQyJm2/MIf7mRlzDpp5Alxj16BF1ze9YdS1so0tWlN5TX2gtQ==
X-Received: by 2002:a6b:671c:0:b0:6ca:d264:6d84 with SMTP id b28-20020a6b671c000000b006cad2646d84mr23090126ioc.174.1667598059750;
        Fri, 04 Nov 2022 14:40:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w5-20020a056e021a6500b002f916f15625sm221334ilv.23.2022.11.04.14.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:40:59 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:40:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Subject: Re: [PATCH v3] status: long status advice adapted to recent
 capabilities
Message-ID: <Y2WG6ursW7qT29lc@nand.local>
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 09:27:47PM +0000, Rudy Rigot via GitGitGadget wrote:
> From: Rudy Rigot <rudy.rigot@gmail.com>
>
> Improve the advice displayed when `git status` is slow because
> of excessive numbers of untracked files.  Update the `git status`
> man page to explain the various configuration options.

This one is looking good to me. Jeff: do you agree? If so, I'm ready to
start merging this one down.

Thanks,
Taylor
