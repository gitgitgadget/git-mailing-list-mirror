Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A1E1F406
	for <e@80x24.org>; Wed, 16 May 2018 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeEPTSY (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:18:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPTSX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:18:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66A306055C; Wed, 16 May 2018 19:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526498303;
        bh=g+xbZW+wAvDRJD0063F40IV9HJExnNGSCq7n4jAGM+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+58BROX4s9K372FE1bCXd18/9rdLYW1+Ka+tBkARK8kxtNRHHVps6Bct7ZAYWqrQ
         EjdBOhmNiBWoO8D83jirgQWoLN7P//J93jeffRZ1TsX8eRCZLb1L8d4M1WdLFN2q5o
         6hs/pykIe+STPcqCM19JWJkpV5ETLzqMxRk6tFgw=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C070C6085F;
        Wed, 16 May 2018 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526498302;
        bh=g+xbZW+wAvDRJD0063F40IV9HJExnNGSCq7n4jAGM+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfHQL6HsMH+RClL1bFAeOVj3PSMBbetz1Miu2y1biyjuNEGjRZWnnGVW92RBfLk0n
         bH5ZVEE7uUA0byYyYuENh6RBe80myQQ3Q/qkYbKjyx7cW6sHRsDfV8i2PuJNC4JFVS
         rR8v48WPvu6cff3UeWZJIRX5rDg0wbP5Xmh1eACQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C070C6085F
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
Date:   Wed, 16 May 2018 13:18:20 -0600
Message-ID: <5484271.13heo1O2yY@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <4a18e167-8cec-0141-fe2c-4e0a35f16daf@linuxfoundation.org>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <2828274.Q9q2dc6g5t@mfick-lnx> <4a18e167-8cec-0141-fe2c-4e0a35f16daf@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 16, 2018 03:11:47 PM Konstantin Ryabitsev 
wrote:
> On 05/16/18 15:03, Martin Fick wrote:
> >> I'm undecided about that. On the one hand this does
> >> create lots of small files and inevitably causes
> >> (some) performance degradation. On the other hand, I
> >> don't want to keep useless objects in the pack,
> >> because that would also cause performance degradation
> >> for people cloning the "mother repo." If my
> >> assumptions on any of that are incorrect, I'm happy to
> >> learn more.
> > 
> > My suggestion is to use science, not logic or hearsay.
> > :)
> > i.e. test it!
> 
> I think the answer will be "it depends." In many of our
> cases the repos that need those loose objects are rarely
> accessed -- usually because they are forks with older
> data (hence why they need objects that are no longer used
> by the mother repo). Therefore, performance impacts of
> occasionally touching a handful of loose objects will be
> fairly negligible. This is especially true on
> non-spinning media where seek times are low anyway.
> Having slimmer packs for the mother repo would be more
> beneficial in this case.
> 
> On the other hand, if the "child repo" is frequently used,
> then the impact of needing a bunch of loose objects would
> be greater. For the sake of simplicity, I think I'll
> leave things as they are -- it's cheaper to fix this via
> reducing seek times than by applying complicated logic
> trying to optimize on a per-repo basis.

I think a major performance issue with loose objects is not 
just the seek time, but also the fact that they are not 
delta compressed.  This means that sending them over the 
wire will likely have a significant cost before sending it. 
Unlike the seek time, this cost is not mitigated across 
concurrent fetches by the FS (or jgit if you were to use it) 
caching,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

