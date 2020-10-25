Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5797C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773DF20795
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 12:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415707AbgJYM16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415704AbgJYM16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 08:27:58 -0400
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF858C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 05:27:57 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kWf7n-0007fT-03; Sun, 25 Oct 2020 13:27:51 +0100
Subject: Re: [bug] Stashes lost after out-of-memory situation
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Marek Mrva <mrva@eof-studios.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <65a3061a-47ef-9ca6-2468-5449cfc5b37c@eof-studios.com>
 <618d66a8-e2c1-241c-5200-2298bfe24ac0@web.de>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <5a3db65b-1877-c5be-8077-2926637fba6e@virtuell-zuhause.de>
Date:   Sun, 25 Oct 2020 13:27:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <618d66a8-e2c1-241c-5200-2298bfe24ac0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1603628877;6e2dbf5d;
X-HE-SMSGID: 1kWf7n-0007fT-03
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2020 7:06 PM, René Scharfe wrote:

[...]

> Looks like stash calls rev-parse to see if a
> stash pop removed the last stash and in that case proceeds to delete the
> stash ref and its reflog

I was a bit suprised to learn that removing the last stash entry also
removes it from the reflog.

Wouldn't it be more convenient if it would be kept in the reflog even
after popping?

So that in cases like

git init
echo 1 > test
git add test
git commit -m "one" test
echo 2 > test
git stash
git checkout .
git stash pop
git checkout .
git reflog -p

my once stashed change would still be in the reflog?
