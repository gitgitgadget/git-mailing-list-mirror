Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8F81F406
	for <e@80x24.org>; Wed, 16 May 2018 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEPTk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:40:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEPTk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:40:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 89DEA60541; Wed, 16 May 2018 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526499657;
        bh=j45X9QW1PeRu6GqPub3WftuGsZVUs8sJt+lEKgEepdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8I7sFJgZwKk00JxbiiWjADy7fzgWpUrTb/ilG1ojfk/gKunlE+j9iRwQmEIWuBOP
         dS/ucMXHHy/SJCODuHWNHJWAl6jGRm0n9PcYLZw8yhaOCDlBKuIS9saAww7e82+XkB
         5rq0W5vn5qHsMXtpvB8DLED79C6UaSznlIY23nvM=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBE1B60541;
        Wed, 16 May 2018 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526499657;
        bh=j45X9QW1PeRu6GqPub3WftuGsZVUs8sJt+lEKgEepdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8I7sFJgZwKk00JxbiiWjADy7fzgWpUrTb/ilG1ojfk/gKunlE+j9iRwQmEIWuBOP
         dS/ucMXHHy/SJCODuHWNHJWAl6jGRm0n9PcYLZw8yhaOCDlBKuIS9saAww7e82+XkB
         5rq0W5vn5qHsMXtpvB8DLED79C6UaSznlIY23nvM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBE1B60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Date:   Wed, 16 May 2018 13:40:56 -0600
Message-ID: <42435260.5sd4EuToWN@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20180516193744.GA4036@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org> <20180516193744.GA4036@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 16, 2018 12:37:45 PM Jeff King wrote:
> On Wed, May 16, 2018 at 03:29:42PM -0400, Konstantin 
Ryabitsev wrote:
> Yes, that's pretty close to what we do at GitHub. Before
> doing any repacking in the mother repo, we actually do
> the equivalent of:
> 
>   git fetch --prune ../$id.git +refs/*:refs/remotes/$id/*
>   git repack -Adl
> 
> from each child to pick up any new objects to de-duplicate
> (our "mother" repos are not real repos at all, but just
> big shared-object stores).
... 
> In theory the fetch means that it's safe to actually prune
> in the mother repo, but in practice there are still
> races. They don't come up often, but if you have enough
> repositories, they do eventually. :)

Peff,

I would be very curious to hear what you think of this 
approach to mitigating the effect of those races?

https://git.eclipse.org/r/c/122288/2

-Martin
-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

