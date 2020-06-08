Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D695C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5863F208A7
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.de header.i=@mail.de header.b="Pna3ytJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgFHRVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgFHRVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 13:21:18 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Jun 2020 10:21:18 PDT
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A46C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 10:21:17 -0700 (PDT)
Received: from postfix01.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout02.mail.de (Postfix) with ESMTP id B4FF6C01A2;
        Mon,  8 Jun 2020 19:14:40 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
        by postfix01.mail.de (Postfix) with ESMTP id 9A78E801D1;
        Mon,  8 Jun 2020 19:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1591636480;
        bh=wZS8w6m4GjyNBwTm4WBKBYI3UIJsYTwrWypgl2A+xfs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Pna3ytJ7qjD93PXpcXb5cz2mynIqE14IiHAZMkGPyaXRDrYDaaRtc3ZH5BxI6nSzC
         HjaWgNBCTAffnygV8aqrF7STuvNSL9BXkyXcxNb9hZ/wkxbZz91Jbdo/Fl4qWvoIf/
         BFI7r7Ur3cqUIbOOPxp0HkXxPTRaR7KpF1xd7/yA=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp01.mail.de (Postfix) with ESMTPSA id 1DE5C1002C8;
        Mon,  8 Jun 2020 19:14:39 +0200 (CEST)
Subject: Re: Fetching a lot of repos
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Soni \"They/Them\" L." <fakedme@gmail.com>, git@vger.kernel.org
References: <ef6f2275-536b-f4dc-9012-0467b1a4134a@gmail.com>
 <20200607210344.GK6569@camp.crustytoothpaste.net>
From:   Stefan Moch <stefanmoch@mail.de>
Message-ID: <3540db7b-7175-18f8-fc5d-2b27c9298d14@mail.de>
Date:   Mon, 8 Jun 2020 19:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200607210344.GK6569@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 507
X-purgate-ID: 154282::1591636480-000036FF-2BB275E2/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* brian m. carlson wrote:
> In general, I wouldn't recommend fetching in parallel, but if you want
> to do it anyway, I'd suggest setting `receive.unpackLimit` to 1.  That
> will result in you keeping the packs you've fetched instead of exploding
> them into loose objects, which will help this case.  It may not help
> enough to solve the problem, though.

For fetch it should be `fetch.unpackLimit` (or
`transfer.unpackLimit`), as `receive.unpackLimit` configures this
limit for receive-pack.

