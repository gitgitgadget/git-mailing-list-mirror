Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218901F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 02:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdFJCKO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 22:10:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33216 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdFJCKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 22:10:13 -0400
Received: by mail-pf0-f181.google.com with SMTP id 83so33848283pfr.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 19:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n2gt8XcYTPdn8HIPvchINmmqE5JL8mTIXNTH4y/kkZ4=;
        b=KffvrEtpHSXZrojLwYnFimuSvq/4QWA+nVigSlQURmDcG5dO8GJmmnMQA2d+0YmaU0
         WsX+HWYakoCUktbs2+xDaWttifM8hmgW+gUr1jqEkZ7R8OCAxBFa+N+o8G7TKBTB6dgN
         hH49W+3+F+Q81KEqK2kWPayIQan4nmFzvdMsabK+RruFNFbYLnm6NZKQv0pOCCszRLY+
         fdR8rQ77ZgCDESpKJGJYYD9e9kF1AFC3upEvl3j/T0LjJxh/L3nuyC4+O2IVb9Kv+Yfa
         2WBsno8Uallm5CI77FTW6+4We7hGa61w5aL52XOw1Ou0pzIWLccP3jyRJaJG8R2auSdN
         /VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n2gt8XcYTPdn8HIPvchINmmqE5JL8mTIXNTH4y/kkZ4=;
        b=jrMthwTQwsZSfFn14y9JNA+1t1OxwA/uxKbehhjnzvigwHhntXD0wQ6Z+Lx9ilsdAJ
         E6r4ANzorfcghuEMp+YOS7F5nhxGwBc3PCTdSbhkpBgoSbrPxyu6r/az7Fmz+jx0KtuE
         VkHS0MC4PBzndgDDft7/rC67vy61+VOfv5sMfsY4IL774lZjUAeBKrkqQ1cpkwduA/w3
         p2cF3CU/SzhCBs9fskqt5uYFteeqF45fdiNdWtOCOkzAsMZw2W6KcROlWw5+Ro+0P7QQ
         DX94nMRHWyoRl2PXTWNArl/q7usYcTjC7VXyQ13mmAs0MnBb5rTDJjDXnGKK2hQ+9BfM
         Gd5g==
X-Gm-Message-State: AODbwcA8ufpFGkupZD26tY0n0i8RKOQWYgKuPcAG4GxeBjNcjwsmWW23
        WBlI07filsFFbg==
X-Received: by 10.99.60.6 with SMTP id j6mr46966649pga.18.1497060613118;
        Fri, 09 Jun 2017 19:10:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id l63sm5374010pfb.68.2017.06.09.19.10.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 19:10:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive clone
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
        <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
        <20170606181024.GA189073@google.com>
        <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
        <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net>
Date:   Sat, 10 Jun 2017 11:10:11 +0900
In-Reply-To: <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Jun 2017 19:19:35 -0400")
Message-ID: <xmqqbmpw4mpo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In an ideal world the user do:
>
>   git submodule add git://host/repo.git path
>
> which adds the gitlink and the .gitmodules entry. But it doesn't seem
> unreasonable for somebody unfamiliar with submodules to do:
>
>   git clone git://host/repo.git path
>   git add path
>
> This does add the entry as a gitlink, but doesn't write any sort of
> .gitmodules entry.

I actually would think that is a perfectly valid state.  In that
original repository pair (i.e. the superproject with a submodule
without an entry in .gitmodules), as long as the configuration in
the submodule repository "path/.git/config" has necessary remote
definitions, "git push/fetch --recursive" etc., should also be able
to work without having to consult .gitmodules at the top-level
superproject, I would think.

> With the old code, cloning the repository (either by
> another user, or in our case during a Pages build), a recursive clone or
> submodule init would complain loudly. But now it's just quietly ignored.
> Which seems unfortunate.

Of course, if such an original superproject gets pushed to a
publishing location and then the result is cloned, without an entry
in .gitmodules, no information "git submodule" can use to work on
that "path" exists in that clone.  I would say it is OK to leave it
as-is when going "--recursive" (what you called "inactive because
it does not even have a .gitmodules entry).

But even in such a clone, once the user who cloned learns where the
submodule commit that is recorded in the superproject's tree can be
obtained out-of-band and makes a clone at "path" manually (which
replicates the state the original repository pair), things that only
need to look at "path/.git/config" should be able to work (e.g. "git
fetch --recursive"), I'd say.


