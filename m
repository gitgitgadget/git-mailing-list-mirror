Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9596C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiBVAQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:16:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBVAQc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:16:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CB25583
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1645488962;
    s=strato-dkim-0002; d=pdev.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gOAg5j5Mh2o0LZiAua4hsEtQPm0LSqZzuJe5xH42ceE=;
    b=YkuIEEgYSKqyQzmpI/HyPKLRzl3ImtbXesmotXHYshDJ91z/AHiFmPJ344XDJrI9da
    GlUqS6iur2kpb0B2LVzC/iW2setsmUb+Q1UJk1oJ8/Rjx1CktNPQ+qTuqJZPjKcr8u2I
    1Ta5sFbNZpo3a/jr9nxIT6g/ZgrTJZFB7/eQ9looo+Ub7EuYqdHB1vtalNfI9GZMsIG8
    IR4qY2bKVcktOlyGAPzFWRYjYxkQNMtBTRVTTL733/kItgSz8W5VaZGlErW2JqyEyTmY
    qfQRj+Yat9RlhqiMpUm8q9j82jV9srVuBmIBoSIrMxde331IPKdm2vgul2U3APFR9yRe
    Y6QA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Pm0UfUGtd9+G9p9stmxCE5ta4sApnuCD/i3TNd+y2/o2oXSBVgRMI6humKUuomjdJSO4CKUOGw7k50PtgI8HBmdjCdGTAIhx"
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2003:c8:d70b:fc00:6600:6aff:fe94:255]
    by smtp.strato.de (RZmta 47.40.0 AUTH)
    with ESMTPSA id Zd5b25y1M0G21cM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Feb 2022 01:16:02 +0100 (CET)
Message-ID: <6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de>
Date:   Tue, 22 Feb 2022 01:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Pretty format color bug
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
References: <220222.865yp7aj6z.gmgdl@evledraar.gmail.com>
From:   Raphael Bauer <raphael@pdev.de>
In-Reply-To: <220222.865yp7aj6z.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think you've found a "bug" or unexpected feature, but it's not in git,
> but in your pager.
> 
> Try:
>      PAGER=cat git log --pretty=format:'%h%Cred%+d test'

Interesting, cat works correctly.
But this still fails for me:
PAGER=cat git log --pretty=format:'%h%Cred%+d test' --graph

The pipe symbol printed (because of --graph) for the second line is 
colored and resets the color of the refnames and 'test'.
Now this looks like a bug in git?

> I'm assuming you're using "less" and are about to read about its
> behavior of resetting colors that are still in effect when it hits a
> newline.

There is a section (-R) that mentions less assumes every line starts 
normal / uncolored. Shouldn't git follow this assumption when printing 
colorized to less?
