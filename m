Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8351F406
	for <e@80x24.org>; Wed, 16 May 2018 19:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEPTDp (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:03:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeEPTDo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:03:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02B1160C65; Wed, 16 May 2018 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526497424;
        bh=vf1i55TRWyOO3RD4c5J4h6RnA1wPgiQhYYOXhODgVhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUHwdUymqTekyToHR4ZLfqEqJvOrSDWWZvD9XBQunroDP8+TgcH5Vk2htE0rn8kZh
         lNvBgScfAPX+svUL3hm9UkTnxE0bm7gz7t3/B+ybknmf1oIvPsC/c7E4dYrhz0NRKh
         TQtTXHXOZyYnm+u3wB06cLJ7qPR4sDXjXQtVHCWw=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D157605A8;
        Wed, 16 May 2018 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526497423;
        bh=vf1i55TRWyOO3RD4c5J4h6RnA1wPgiQhYYOXhODgVhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKTQwmwgMp9DjPxp0v20tAoKOGRM/VzG5Cc+k6GSmFEgynVRu7+dRidzHOfV+lNj/
         3rhU9BUwCWLRZnBseuGQ0fgb5lNWV1J4d+fdD/6g6vRBO/JHEWpk/3OvCPHh5qh6Vn
         qzlcHdxgo6ju+5GJy6XR04l5fffaylCTBquZPmso=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D157605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Date:   Wed, 16 May 2018 13:03:42 -0600
Message-ID: <2828274.Q9q2dc6g5t@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <1950199.Z2x8tXoTfI@mfick-lnx> <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 16, 2018 03:01:13 PM Konstantin Ryabitsev 
wrote:
> On 05/16/18 14:26, Martin Fick wrote:
> > If you are going to keep the unreferenced objects around
> > forever, it might be better to keep them around in
> > packed
> > form?
> 
> I'm undecided about that. On the one hand this does create
> lots of small files and inevitably causes (some)
> performance degradation. On the other hand, I don't want
> to keep useless objects in the pack, because that would
> also cause performance degradation for people cloning the
> "mother repo." If my assumptions on any of that are
> incorrect, I'm happy to learn more.

My suggestion is to use science, not logic or hearsay. :) 
i.e. test it!

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

