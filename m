Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFDAC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC4B221E5
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rECeS5+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgIKVoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKVoC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 17:44:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251ECC061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 14:44:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so12808709wrs.5
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TXIO5H4cEE+flKxxpwz5vfjB0FGl9tyO6sB1AmQzUZ4=;
        b=rECeS5+baWcJv9iphIUVLYfAPFDKdQirDgkf07UhVtTOchdDMhYIXDi6v5YtYsc5hs
         /3ACViwCwXZU1DQ7p8uK2UeSTb6H+syGyjVo7BSW+9IIJatCQhUz/3Y3a1jWacUA6MRv
         hRgQ179p/dMr8IvLsiz6XBIx7uTaYk9wB5RmVrywodlj0aImfZd3FB1ChGbrKf+ipQfQ
         k9WRTE+nYCeYGxygrMFnN9ELsLCz55bT6yXiqs9vdpkikpG7yFMEeiYce4i/FixaDIQP
         zT0fm/tSWGtCu6WO0QdB8fdBrPdJOQVSHZI3GBB4liASZdQV3fgaxAbwdHWn4Os13f3p
         w2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TXIO5H4cEE+flKxxpwz5vfjB0FGl9tyO6sB1AmQzUZ4=;
        b=jDBxHVDbQFhnP1Nv4DxvzGi9epgc8w6HmsNRU9nOflyKZfMPwkO/19VhOX7FuQUeBj
         PnLNY9aP1O6TZ0wLPkpZ3TL8+P863LXUDAeAtmBoDBMNdcjdRplf4G6FjcumvO4WSFhj
         BTOBVeU67M8UaJu4gsODcNu1xxHq7bDY4fIGVexHr0LxNMnz4DMREB8muYti08ndwDay
         s9msUgIpVH6qKnCxPsnRlAkK9aomF0OazCSJm4xNAw+aGY3xQFnaJLYulEjvdyR3ObEw
         +8JKxXvIPwZtR1CDmDoUNdugUt+2hK1S56qzuay5JhVPtYoAZkt+hIa02YWy7MjR71sf
         WbPw==
X-Gm-Message-State: AOAM533UL6rE65kowjRXTei7gTP1CiNFAh96K/U0dQ9nfaB3SKiB0EK6
        3ikXUXqaXDE5pImxuiLdv6rco9oFzRyT7xkydSw=
X-Google-Smtp-Source: ABdhPJy0zrGMJKj6o2JQg4dxTlCe/nulOURmlqO4bBt72RogFVJisZNcw8GkvITztoAYnorzYyEJJQ==
X-Received: by 2002:adf:e34e:: with SMTP id n14mr3942556wrj.91.1599860640754;
        Fri, 11 Sep 2020 14:44:00 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id z7sm6717418wrw.93.2020.09.11.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:44:00 -0700 (PDT)
Date:   Fri, 11 Sep 2020 23:43:58 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200911214358.acl3hy2e763begoo@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 11 Sep 2020 23:11:58 +0200
References: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200416150355.635436-1-damien.olivier.robert+git@gmail.com>
 <20200416152145.wp2zeibxmuyas6y6@feanor>
 <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

From Junio C Hamano, Thu 03 Sep 2020 at 15:01:10 (-0700) :
> Anything new on this topic?

Unfortunately no, work keep stacking up faster than I can unstack it...

> No rush, but I'd hate to see a basically good topic to be left in the stalled state too long.

Hum, what about migrating the version that was in next to master? I am not
fond of it because the series is not perfect and I am not satisfied with a
patch series that is not as good as I would like it to be. So that was why
I was arguing against merging it back then.

On the other hand it does correct existing bugs, and the bugs it leaves
remaining (apart from the memory leak) happens only in exotic cases. So I
would not want my sense of perfection to prevent this series from graduating
too long.

And unfortunately I cannot give you an ETA for a fully satisfying series as
I envision it.

So I guess it is your call. If you think the version that was in next is
good enough to graduate, I can send one last reroll with a commit message
explaining the remaining kinks, and iron them out later.

Or more precisely, we can:
- only use this patch (v8) without the triangular workflow fixes
- use this patch (v8) + the triangular workflow fixes from https://public-inbox.org/git/20200406175648.25737-2-damien.olivier.robert+git@gmail.com/

The 'bug' that remains is that it detects a triangular setup, when
1) a branch has a pushRemote but no remote and
2) pushRemote=foobar and origin does not exists
while 'git push' treat this as a non triangular workflow.

IMHO 'git push' is wrong here and in my ideal perfect series it would be
fixed there, but maybe meanwhile we can live with this small discrepancy.

What do you think?

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
