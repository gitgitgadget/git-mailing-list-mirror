Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A2C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1469B2080C
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 22:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YqPsZmKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgCaWKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:10:46 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:60692 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728428AbgCaWKq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Mar 2020 18:10:46 -0400
Received: from mxback2g.mail.yandex.net (mxback2g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:163])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 22C2660419;
        Wed,  1 Apr 2020 01:10:42 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2g.mail.yandex.net (mxback/Yandex) with ESMTP id XEVswqWs5R-Afa45fOY;
        Wed, 01 Apr 2020 01:10:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1585692641;
        bh=bAPdET03yB+pG8/JL0gPAsK0foC16nZ/LNfNMSWASQA=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=YqPsZmKOsFdI6pWce5tblCXvTO3lZDbkmyX6u4CEPJIV7AR6H+IdtfecUrdKGp37H
         NykqiIeeVji5iFwwzo0H2K+Xn4w+iB1aiot3ESRZfxkMSkoPcm9yr8whuLwlDOIWyu
         5ig5PqBBgdkkSJ+7/MZCgcuBbSesBebtGlGLn2AM=
Authentication-Results: mxback2g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-d12e6d6cc867.qloud-c.yandex.net with HTTP;
        Wed, 01 Apr 2020 01:10:41 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
         <20200328144023.GB1198080@coredump.intra.peff.net> <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
Subject: Re: Inefficiency of partial shallow clone vs shallow clone + "old-style" sparse checkout
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 01 Apr 2020 01:10:41 +0300
Message-Id: <8919571585692069@vla5-e043431e7e8d.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



28.03.2020, 19:58, "Derrick Stolee" <stolee@gmail.com>:
> On 3/28/2020 10:40 AM, Jeff King wrote:
>>  On Sat, Mar 28, 2020 at 12:08:17AM +0300, Konstantin Tokarev wrote:
>>
>>>  Is it a known thing that addition of --filter=blob:none to workflow
>>>  with shalow clone (e.g. --depth=1) and following sparse checkout may
>>>  significantly slow down process and result in much larger .git
>>>  repository?
>
> In general, I would recommend not using shallow clones in conjunction
> with partial clone. The blob:none filter will get you what you really
> want from shallow clone without any of the downsides of shallow clone.

Is it really so?

As you can see from my measurements [1], in my case simple shallow clone (1)
runs faster than simple partial clone (2) and produces slightly smaller .git,
from which I can infer that (2) downloads some data which is not downloaded
in (1).

To be clear, use case which I'm interested right now is checking out sources in
cloud CI system like GitHub Actions for one shot build. Right now checkout usually
takes 1-2 minutes and my hope was that someday in the future it would be possible\
to make it faster.

[1] https://gist.github.com/annulen/835ac561e22bedd7138d13392a7a53be

-- 
Regards,
Konstantin

