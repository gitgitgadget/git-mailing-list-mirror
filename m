Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB4C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB9C650AA
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhCETbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCETat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:30:49 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D0C06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 11:30:48 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id o11so3226075iob.1
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vpMSc9iSsJmZgaMwWPB4Gzf04lFWBoJYBgUT2SfdP8g=;
        b=n8BAlEi+nSpO45h0YGnnfntqwB99q+pxnmHNrt3ELUNPbOV08iyZKMhk9SrYRxuYI/
         AR8l1LHJFhiqGQ2BQVECRrvHApc0Zb7WhnKLHDDyQtk297hLQFzdXFOpbLAIwjlmxPYw
         AosCr/kcPDC60C1AJjSH7p6YS5z9I/4yhyj5FZRsDzdIK5ZgtsOrbwD++IX8ZSzpWV2w
         A1kCvfJ9Z9Q3MSt3Xe5G+p1TuU1WeVMfojPVXRLgvmbHbuLmrhLMHFsZFT1ykKcZYt65
         2USKrKv+BmPUJHBsc6ArF1bhxgaBkXxo0LsEcnCpZhkKRAiEiTqbe4okG3LpMqDpdolw
         U9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vpMSc9iSsJmZgaMwWPB4Gzf04lFWBoJYBgUT2SfdP8g=;
        b=MzXMLnO1W3B/GHuBmXgq24oGsHB1pMHH9MBvEzivRHjvfygO/Dv1e5iEyx6E94eSW1
         VKiq7XoMg1LYUqnpWkiFtqmJ16SQrbod7VuPiIs/p/AAeZznuAw+H8PwI0CGmoGqiz+N
         kQLLhwLNPEJzYedElUOAc6EvYcZ9jEM2rVJLfhtXsZA75Gmc2gUgwaE3u7cA8XYCtnX6
         vJ6jk5qGJuWTnFxDLH3zWfOggSu/wBUP+Q3avUGHaaRLuOR9UcsC9fI/7P5tLTrAd/2Y
         lWglVazOQ45KWCd26TYdDiVj2vk7MDXHv/PQStzy51vsGEIdkARv/nmpkaGIM9Q1sLSx
         Dt8Q==
X-Gm-Message-State: AOAM533Jzzd0Nyf3bDw5DZzzx0kQ9fTtGMBNTRFc8zoWCM6StoAk0a3K
        RAPot3hxxILSlAjnieLyE0yvCw==
X-Google-Smtp-Source: ABdhPJwkGiRXHEUAoWMq0EfD38St1ETyWIcp7DXtZdTi/XV7tVTsXinCH7GNp5BVaXcpU36M8R8mxA==
X-Received: by 2002:a02:9985:: with SMTP id a5mr11490090jal.122.1614972648379;
        Fri, 05 Mar 2021 11:30:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id c9sm1823274ili.34.2021.03.05.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:30:48 -0800 (PST)
Date:   Fri, 5 Mar 2021 14:30:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/5] builtin/repack.c: do not repack single packs with
 --geometric
Message-ID: <YEKG5XtNxArQe/xH@nand.local>
References: <cover.1614957681.git.me@ttaylorr.com>
 <80bc7fa8397491d015b80a39168813d2019e262d.1614957681.git.me@ttaylorr.com>
 <xmqqv9a59ztd.fsf@gitster.c.googlers.com>
 <YEKGLfUM1DSHk74B@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEKGLfUM1DSHk74B@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 02:27:41PM -0500, Taylor Blau wrote:
> instead of only when geometry->pack_nr == 0. But I was pretty sure that
> the code below was doing the right thing even for geometry->pack_nr ==
> 1, and so I decided to avoid making this non-special case "special" by
> returning early.

After "I was pretty sure that the code was doing the right", I should
note that I did the same thing you did in my head, and then confirmed
my thinking by running the tests in t5326.

Re-reading my response, I am worried that I gave the impression of being
lackadaisical about testing.
