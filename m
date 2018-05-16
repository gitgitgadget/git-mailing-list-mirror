Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A1C1F406
	for <e@80x24.org>; Wed, 16 May 2018 17:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeEPROt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 13:14:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeEPROs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 13:14:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE58B60A00; Wed, 16 May 2018 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526490887;
        bh=4D6v8FdHe82UrYzvfwoskP5UgdRC614X4/imgeewunY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFrcQJESsQwKMwmiYK6QcBXZAoonzWFafJ+GFPyTvIEtWv8AsGBSxcHEmQmOUcTPY
         nyoNVR9Hq3kVv4SxK9GHTPOqrkV/kNivZzin+4z9asACnpm96tfd3r4h69ISEHE0qy
         X966zGRSJF79kHbZC6Bwc0vNU56nb7Rgj7LUZTN8=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17BF960209;
        Wed, 16 May 2018 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526490887;
        bh=4D6v8FdHe82UrYzvfwoskP5UgdRC614X4/imgeewunY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFrcQJESsQwKMwmiYK6QcBXZAoonzWFafJ+GFPyTvIEtWv8AsGBSxcHEmQmOUcTPY
         nyoNVR9Hq3kVv4SxK9GHTPOqrkV/kNivZzin+4z9asACnpm96tfd3r4h69ISEHE0qy
         X966zGRSJF79kHbZC6Bwc0vNU56nb7Rgj7LUZTN8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17BF960209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Date:   Wed, 16 May 2018 11:14:44 -0600
Message-ID: <5972145.OdP4kjFpBj@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-144-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com> <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 16, 2018 10:58:19 AM Konstantin Ryabitsev 
wrote:
> 
> 1. Find every repo mentioning the parent repository in
> their alternates 2. Repack them without the -l switch
> (which copies all the borrowed objects into those repos)
> 3. Once all child repos have been repacked this way, prune
> the parent repo (it's safe now)

This is probably only true if the repos are in read-only 
mode?  I suspect this is still racy on a busy server with no 
downtime.

> 4. Repack child repos again, this time with the -l flag,
> to get your savings back.
 
> I would heartily love a way to teach git-repack to
> recognize when an object it's borrowing from the parent
> repo is in danger of being pruned. The cheapest way of
> doing this would probably be to hardlink loose objects
> into its own objects directory and only consider "safe"
> objects those that are part of the parent repository's
> pack. This should make alternates a lot safer, just in
> case git-prune happens to run by accident.

I think that hard linking is generally a good approach to 
solving many of the "pruning" races left in git.

I have uploaded a "hard linking" proposal to jgit that could 
potentially solve a similar situation that is not alternate 
specific, and only for packfiles, with the intent of 
eventually also doing something similar for loose 
objects.  You can see this here: 

https://git.eclipse.org/r/c/122288/2

I think it would be good to fill in more of these pruning 
gaps!

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
