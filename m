Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2682BC636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBHVzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjBHVy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:54:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05D28D26
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:54:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2579487wma.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQbKd8oR4v0KVf0iA8u2b1Z9HxaadwwWk33r1uIQdHE=;
        b=bUEC8MWkmw/Z9MiDe2xSNCybCCywgl6moa6QRokTH+bY1aJGSHo2qSefu4gtwjbA8w
         LghV2NkoTB+2x12rfSqUkC8/++HBTY5lDgwO3leAlXrQzrWhGt0KLyDdOSeiR/8k3+B8
         vFoWym8KxFNu9yc4TWiZVchCnmajqRDVmSf+BOEjbJcR8Tsna4Lq8UozctxJHek9zBDW
         dSJEjSLJDtvTgrODWZl5SgdLU4TdTc/g/8mqn12KVw51cjcoJcfBiD0xoqjG1DXm1+8z
         INED9j+42qwrnlknNR5Gn4oiXq+Oxds330I0SONRvA8Be8ZeZXdsdoEK/yC/Y/zGcQRg
         yCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQbKd8oR4v0KVf0iA8u2b1Z9HxaadwwWk33r1uIQdHE=;
        b=uSkd/i5CcgY3RPtHAidnetwJRy5IG76wJgRsmOQykX7k+11Or4WoVy7nmTlyFnb1Yz
         G9vjdlsGfze+mmmWDQuyX5R06IT6RZ8cFw77t2tphD6qJVpgeOfbnWNHmklxS1vXJwli
         Uxc8OmxH6qcvso7s1HXhmjxpMavWwDAzI+Xt1ont66jZvq64S3X3p1gfCB5Iqams4mHF
         0MjxAo5SrCbwArpX7qCDwIL4fp5ZbU899TOg5Mr2grx1sk1FedpcAGZlNfEP13SHit8U
         sse1sw4zXj/FnBb+39PVVBh3+u0g8+fI+RruyUo/pT6UuCklZ3X61Ta8o+gLDPhOAvIi
         c9XQ==
X-Gm-Message-State: AO0yUKWvXyARG/+1p0T05A42N6/F0rvg87OO1tvlhhSAa39y4l72L1Ic
        vFTCzBG3nUJSf0sL1+mCicE=
X-Google-Smtp-Source: AK7set9wRBm6JySB7zGeGDs/PjhYXCk4KZ98DVgDZpo+FbHQOyrGbA+vqdNnjH1a98DKZJfeWt5WiQ==
X-Received: by 2002:a05:600c:30d3:b0:3dc:19d1:3c1f with SMTP id h19-20020a05600c30d300b003dc19d13c1fmr7966302wmn.30.1675893295476;
        Wed, 08 Feb 2023 13:54:55 -0800 (PST)
Received: from [192.168.2.52] (141.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.141])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003e0238d9101sm3510735wms.31.2023.02.08.13.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 13:54:55 -0800 (PST)
Subject: Re: [PATCH v2] bisect: fix "reset" when branch is checked out
 elsewhere
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com> <xmqqwn4u2ztc.fsf@gitster.g>
 <eb086063-9e47-9fdb-3644-77a843733dcf@gmail.com> <xmqqo7q4vir8.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <d95d9505-db32-ebe6-1f23-05f7f00c2922@gmail.com>
Date:   Wed, 8 Feb 2023 22:54:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqo7q4vir8.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07-feb-2023 21:16:59, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > No problem.  I am sorry because I don't understand what's worrying you.
> >
> >> that the phrasing of this paragraph is misleading), but isn't it a
> >> good thing if in this sequence:
> >> 
> >>  - I checkout 'main' and start bisecting (BISECT_HEAD says 'main');
> >> 
> >>  - I then checkout 'main' in another worktree; I may even make a
> >>    commit or two, or even rename 'main' to 'master'.
> >> 
> >>  - I finish bisection and "bisect reset" tries to take me back to
> >>    'main', which may notice that 'main' is checked out in the other
> >>    worktree, and fail.
> >> 
> >> the last one failed?  After the above sequence, I now have two
> >> worktrees, both checking out 'main', and it is exactly the situation
> >> the safety valve tries to prevent from occuring, no?
> >
> > We are considering the initial branch (BISECT_START) as a branch checked
> > out _implicitly_ in the worktree that is bisecting.  Doesn't that
> > provide us and the user enough safety?
> 
> If that is a question, then the answer is no.  If that is
> rhetorical, then I just do not see how it gives us any safety.
> 
> In the end, if you allow "bisect reset" to check out 'main' in the
> worktree you used to run bisection, the 'main' branch is checked out
> twice, once there, and another checkout in the other worktree.  That
> is exactly what "git checkout 'main'" in one worktree while 'main'
> is already checked out in another would prevent from happening, no?

Yes, but I still don't understand what you are worried about.

If we compare with "rebase": "git rebase --abort" does checkout back to
the original branch too.  But as "git rebase" is in a more evolved
"builtin transition", and uses reset_head() instead of spawing a new Git
with "checkout", it avoids the "--ignore-other-worktrees".

The safety I'm considering with "git bisect reset" is that while a
branch is being bisected in a worktree, that branch cannot be (without
forcing): checked out in another worktree, deleted or renamed.

And this safety is enough, to me, to alleviate the user from having to
"git bisect reset" to a "safe" place and then "git checkout
--ignore-other-worktrees" to have the BISECT_START branch checked out
again.

Also, note that the aim of this patch is not to introduce a new behavior, but
fix how "git bisect reset" works with multiple worktrees.
