Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312AC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 11:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDXLR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDXLR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 07:17:57 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248530D5
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 04:17:52 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pquCb-00DYcw-LH; Mon, 24 Apr 2023 13:17:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=pRYfAC+/kqwUPu2yuTVK2ds5znMP/abWsIzCOiPFXRw=; b=zheKB3ms7zo7yBCf6ceDd05KSC
        6v295iqg08RHnHcihDNiWWaVVDar7fwkUuDoUZ8c1KHdk4JjLdRjaXQ6fFZjqMO9STw37+ycMS4dp
        53afpKe5mBvwl/meUcdJhHJZAr1Yii+/qhVgAENh/BJcfXIm71BUzx3GW74oYX/2WRfP0Xkl7i6QP
        ooDiBGVlu+1css18olF5N0oq2yigk8hvmf9YG7d6+gwP2sRJaGV3LgAhx8GU7bmccUhAlqmlyoz4H
        6MPjiB0MJoGHUqKp88bVwKvN6XQyh2U/bL9Npuqtec893pRALIR51zhFQGbd9xyCod7LNHkTDFP9H
        oUByGfRA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pquCa-0007D8-RF; Mon, 24 Apr 2023 13:17:49 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pquC9-0000GB-IB; Mon, 24 Apr 2023 13:17:21 +0200
Subject: Re: Proposal: tell git a file has been renamed
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
 <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
From:   Jeremy Morton <admin@game-point.net>
Message-ID: <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
Date:   Mon, 24 Apr 2023 12:17:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/2023 11:49, Erik Cervin Edin wrote:

> I always find this to be the main dilemma.
> I try to make commits as discrete changes but it's not always possible
> with renames.
> Sometimes, renaming a file changes it so much that the rename
> detection doesn't work by default.
> There are also other problems that arise when reordering commits and
> changes in a feature branch.
> I've found that the safest thing is to split renames out into discrete
> commits and only do 100% renames.

There's no getting away from the fact that this adds a lot of (IMHO 
unnecessary) work if you've already done a rename that git can't 
detect and have both that and a bunch of other changes sitting in the 
index.  What feels like it would be a natural resolution in these 
cases, though, is a "no, this remove/add is actually a rename" command.

-- 
Best regards,
Jeremy Morton (Jez)
