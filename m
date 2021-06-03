Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBCC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166F2613E4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCTYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:24:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCTYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:24:48 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03F7D1FD63;
        Thu,  3 Jun 2021 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622748183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf2iDdOm9TV9x3dv1ISZM9jiXGB1iQrIr2jBwgPqxCM=;
        b=c1PMx/CBX23xxI2cyebOA3vMcjzUd2h8bRXvg0XgNFCybF8ZIQ8zT4yibM/I95QvIQ9ODl
        E0tswxgOalbvzFeeSPfU2YpV92xxGTUomkGlwK5qjr1dUMzGuliAkCqlo19/NNgG8GyC3s
        i7nEXGEX6DRJmINvqkZw7PqRUYEfGRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622748183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf2iDdOm9TV9x3dv1ISZM9jiXGB1iQrIr2jBwgPqxCM=;
        b=jDJfuUbrQTFyNCHmxCBjNzG9XRTIOvWwDOPKkGVkj/pfRRXCEYx2gMq81h7csS4ubYrA4f
        7PaoSqkBZNe5SVAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DA476118DD;
        Thu,  3 Jun 2021 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622748182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf2iDdOm9TV9x3dv1ISZM9jiXGB1iQrIr2jBwgPqxCM=;
        b=Qix2RRnsspKzgyosHC6/Od/XwkGdM8oA6ePRHS8QKEoA1tjC9PQESLqOFbUYd7LEF2d/IH
        VswgS8NmsRpNiS6YhdALruatSaB4wbQEXsahJVKZl6HbfhU3tlE1YeQiKXYZsKMWNvDDrO
        0fybosB245ovrMlJ3ZXgGhBB6wTIqIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622748182;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf2iDdOm9TV9x3dv1ISZM9jiXGB1iQrIr2jBwgPqxCM=;
        b=yYG8oT3TUKpTK4DlvMEOh668tLq4cJ39fRaVrKxyzmi/JHSAYllzVTNlcebHvNUaWGlz66
        hagVNMPvKO1mSmAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id IZBbNBYsuWBmQQAALh3uQQ
        (envelope-from <msuchanek@suse.de>); Thu, 03 Jun 2021 19:23:02 +0000
Date:   Thu, 3 Jun 2021 21:23:01 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <20210603192301.GU8544@kitsune.suse.cz>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <20210603183220.47nx7f2aazk6wy33@nitro.local>
 <20210603190231.GT8544@kitsune.suse.cz>
 <20210603190756.ri5o4udl2bvusyhw@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603190756.ri5o4udl2bvusyhw@nitro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 03:07:56PM -0400, Konstantin Ryabitsev wrote:
> On Thu, Jun 03, 2021 at 09:02:31PM +0200, Michal Suchánek wrote:
> > > I'm not going to argue too much, but I'd say that someone who's looking for
> > > solution to use with git-send-email is *likely* going to have access to a
> > > smartphone. :)
> > 
> > I do have a smartphone. Due to the battery life of smartphones I don't
> > have access to it most of the time.
> 
> As a note, you wouldn't need to use it "all the time" -- just for the initial
> login via the browser. Once it's done and you set up the app passwords for
> SMTP/IMAP access, you would rarely ever need to access the TOTP token again.

I also avoid doing anything security sensitive on the smartphone. They
tend to run old vulnerable software because smarphonde vendors aren't
agile with fixes, and they are a rewarding target for hackers.

Given that your smartphone and our PC are typically connected to the
same network it is not difficult to correlate the two.

Thanks

Michal
