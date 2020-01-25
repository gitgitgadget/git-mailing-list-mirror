Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0EC35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 08:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348E92071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 08:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ0gz7Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAYIbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 03:31:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40433 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYIbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 03:31:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so1794067wmi.5
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 00:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Giqf39MPs9szC4RoCpTso0VAuDvWSqbuWvdrIKUyDzk=;
        b=FJ0gz7Hyf0MyMhhhQ6p1Aq/I7GwgJ1a3oAh5YCT6mgBmyQ4bKhCAa7YDPeE5WpCclH
         5LbDNdZk0bBMZLjbHJmx1treYeesLWqxyztxWsF9kmZVdHHGsmBPZRcSLifTDdnwNm6/
         gE4YYFvKAQYUOy4DurWS/TqLX3YWwLWmMgVtnMKCigJFh8OFpsowsnCkd1EggYcBEJoW
         GVJWCcRLytOYN0ccg6BrSoI6vFDFginBS6NwFFgEHED9MzWR5DFkEPXOuPw8N7HDBAT9
         NUQFY4dmqsmHmuRHlByOxGvinY7iE6yx2qtJ9jXR3v31TmxWiDk9qpXN25AqjIj0Xnba
         yZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Giqf39MPs9szC4RoCpTso0VAuDvWSqbuWvdrIKUyDzk=;
        b=hcskoETPkrt8LswDPUe90vSxoR9FFP8BHBg53lX4t3EbmRBkiNBR+37MhF5gSHwlRI
         tS3hibGnHnVUx1m192D1mBhzvhx5fEgp4bv8f7py41h8rOZvWykGgWzoEDOUV1LnrCsr
         tAkETpg3vxu/YY96IBgNgvHbLmJcdLM+MrHF8z8MU+MSJwx6ed34G+J4LsJ5bHzps5Lr
         G8Ot1OljfPBd5n6un1FAVMxFcg9RaQM3z9o9Yx43cMP0FKjqOsGXIXpavFbbBt14sD5G
         FB0OALFFwp8w4Qpsz+Mlq6d7JFpEhAT3e5cHU938V+LYaR2Q4I4f8sBxVIxV2zrXRjS/
         ozUA==
X-Gm-Message-State: APjAAAWbwrjf4Nd4qFUjuzoIIKMiM9CTR1Z6ftFHyTsg9rjY7FaEyhht
        +z0RjZL8GgAxFxfIEf2iZ9U=
X-Google-Smtp-Source: APXvYqzkatxOlOuQH0AX8pcBXMk5QfsnCiV7zlzci8BfEqJgR+jJAHMNFrlgE2y/XJIjjlcBKdIPOQ==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr3259233wmj.36.1579941065555;
        Sat, 25 Jan 2020 00:31:05 -0800 (PST)
Received: from szeder.dev (x4dbd6367.dyn.telefonica.de. [77.189.99.103])
        by smtp.gmail.com with ESMTPSA id u188sm10061614wme.10.2020.01.25.00.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 00:31:04 -0800 (PST)
Date:   Sat, 25 Jan 2020 09:31:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200125083102.GK6837@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
 <20200123141626.GB6837@szeder.dev>
 <20200123175645.GF6837@szeder.dev>
 <xmqq8slx51zu.fsf@gitster-ct.c.googlers.com>
 <CABvFv3+OfzK_2Wo97dusaj5nomSJTNghJHJa3=+HKH=-Sw12qQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001250112171.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2001250112171.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 01:13:52AM +0100, Johannes Schindelin wrote:
> > I've done a new rebase on master, did the CI change as discussed, and
> > pushed the changes to the GitHub PR
> > (https://github.com/git/git/pull/673). osx-gcc test seems to have
> > failed something unrelated to these changes, but everything else still
> > passes.
> 
> This is our good old friend, the flaky test case
> 
> 	t5516.81 deny fetch unreachable SHA1, allowtipsha1inwant=false
> 
> It has been discussed before, and it seems that Gábor has a patch that
> works, but that he is not completely happy with, yet.

Hehh.  Do I have a what?! :)

This is what you mean?

  https://public-inbox.org/git/20190830121005.GI8571@szeder.dev/

Gah, this is not how I wanted to start my Saturday morning ;)

