Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A9C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8430610A8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCTET (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:04:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTES (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:04:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA7B821A03;
        Thu,  3 Jun 2021 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622746952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XThc26DiDvLCTKGWDSmAQUpfklOFxkdvTyZGuAAkzso=;
        b=GOfA3pMUH25yWITdL9WZ/TqBZU2MuIE2rsK/tsfmFIeHjJy/trM7LWLe6mcI6F0bYjiZ6G
        N0tA7fPY1Mx7U/n8v5EgLrgu1o/ZFjR8iVayamtnReNfRS1I74Pg30io3WNV6aa2qqKABL
        1e8xRRCuV7SS7QiVMpbX7ALw/GgxJYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622746952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XThc26DiDvLCTKGWDSmAQUpfklOFxkdvTyZGuAAkzso=;
        b=NAxIPchgAU2S95aXiXzGh8oKBFMNuCfH9EjAVfxHqoUupJcVE7GRgx8PVbpUZWpDs0pEHn
        dVN02GlcrtpaInDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C98DB118DD;
        Thu,  3 Jun 2021 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622746952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XThc26DiDvLCTKGWDSmAQUpfklOFxkdvTyZGuAAkzso=;
        b=GOfA3pMUH25yWITdL9WZ/TqBZU2MuIE2rsK/tsfmFIeHjJy/trM7LWLe6mcI6F0bYjiZ6G
        N0tA7fPY1Mx7U/n8v5EgLrgu1o/ZFjR8iVayamtnReNfRS1I74Pg30io3WNV6aa2qqKABL
        1e8xRRCuV7SS7QiVMpbX7ALw/GgxJYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622746952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XThc26DiDvLCTKGWDSmAQUpfklOFxkdvTyZGuAAkzso=;
        b=NAxIPchgAU2S95aXiXzGh8oKBFMNuCfH9EjAVfxHqoUupJcVE7GRgx8PVbpUZWpDs0pEHn
        dVN02GlcrtpaInDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id NVAfMEgnuWAVOgAALh3uQQ
        (envelope-from <msuchanek@suse.de>); Thu, 03 Jun 2021 19:02:32 +0000
Date:   Thu, 3 Jun 2021 21:02:31 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <20210603190231.GT8544@kitsune.suse.cz>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <20210603183220.47nx7f2aazk6wy33@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603183220.47nx7f2aazk6wy33@nitro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 02:32:20PM -0400, Konstantin Ryabitsev wrote:
> On Thu, Jun 03, 2021 at 02:25:42PM -0400, Eric Sunshine wrote:
> > > The fact that Gmail forces folks to enable 2fa for app passwords is an added
> > > bonus in my book. :)
> > 
> > The 2fa requirement is a problem for those of us who don't have
> > smartphones or SMS. (I see now that they also offer 8-digit backup
> > codes to print out for 2fa; perhaps that might be a workable option,
> > though I haven't tested it.)
> 
> I'm not going to argue too much, but I'd say that someone who's looking for
> solution to use with git-send-email is *likely* going to have access to a
> smartphone. :)

I do have a smartphone. Due to the battery life of smartphones I don't
have access to it most of the time.

> 
> It's also possible to use TOTP without a smartphone (e.g. via a desktop app),
> though this would largely defeat the purpose.

There are also TOTP hardware tokens but I haven't tried one. I think
that the U2F tokens are better supported anyway.

If you want some sort of real security I would avoid smartphones and go
for hardware tokens. If you want to fulfill arbitrary requiremens
workarounds that emulate a smartphone well enough exist. For TOTP you
don't even need an emulator, only a QR code reader (in case the site
insists on using QR code and does not show the plaintext) and a desktop
TOTP application.

Thanks

Michal
