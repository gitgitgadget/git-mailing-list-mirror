Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B57C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0FF22249
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="oIsyFM2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgJOKkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:40:00 -0400
Received: from forward500o.mail.yandex.net ([37.140.190.195]:52546 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgJOKkA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Oct 2020 06:40:00 -0400
X-Greylist: delayed 2679 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 06:39:58 EDT
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 4831660808;
        Thu, 15 Oct 2020 13:39:56 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id ZMVcmV4CaX-dtg8oFmx;
        Thu, 15 Oct 2020 13:39:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602758395;
        bh=OtB12msPfa7hNW8mrwE3S5XeI4UzosFhSQMQAU8v/a0=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=oIsyFM2flJtcLH6tJZOGG5hterYEpcdSdMg3SLaxZz1N/hARd4s29F0NVLSre8hYF
         apbqRsMryA7jegqCWWXTsMcfnSs98q34sRwOnULCpOBL4lFZMkM+YcLQB0OoEtG4Kc
         r5ef9pPTcWBDZTa6zmG7pCPw+FVZGa732z1ARhc8=
Authentication-Results: mxback11q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-fbefcb3b0074.qloud-c.yandex.net with HTTP;
        Thu, 15 Oct 2020 13:39:55 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Leam Hall <leamhall@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <d10fd33c-3d5a-c5ed-c21c-6e6eff1a6351@gmail.com>
References: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
         <2011231602755586@mail.yandex.ru> <d10fd33c-3d5a-c5ed-c21c-6e6eff1a6351@gmail.com>
Subject: Re: Branch Management questions
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 15 Oct 2020 13:39:55 +0300
Message-Id: <1434961602758006@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



15.10.2020, 13:30, "Leam Hall" <leamhall@gmail.com>:
> On 10/15/20 5:55 AM, Konstantin Tokarev wrote:
>>  15.10.2020, 12:51, "Leam Hall" <leamhall@gmail.com>:
>>>  1. Two developers.
>>>      Dev A is working on Branch A, off a release_candidate branch.
>>>      Dev B is working on Branch B, off the same release_candidate branch.
>>>      Branches usually run 1-4 weeks.
>>>      Dev A does some work that would help Branch B.
>>>      How does Dev A get the Branch B work that is needed, in a
>>>        way that does not confuse the merge process at the end
>>>        of the release cycle?
>>
>>  Avoid long-living branches and integrate atomic parts of work into base
>>  branch as soon as it's done and reviewed.
>
> Unfortunately, for some tasks 1-4 weeks is atomic. The review process is
> being improved as well. We still need a way to integrate the
> longer-lived branches cleanly. We've already had issues where attempts
> meant lost code.
>
>>>  2. One developer.
>>>      Working on Branch P, realizes that a new functionality X is
>>>        needed.
>>>      X isn't specific to Branch P, but critical to it.
>>>      What is the best way to deal with X, knowing that further work
>>>        on X will need to be done?
>>
>>  Rebase P to the top of parent branch after X is integrated (see above).
>
> Ah, so "Stop work on P, Resolve X, Rebase P from updated parent"? Let me
> go read up on that, it makes sense.

If there are two developers, first working on X and and second working on P it may
be possible to reduce or avoid stopping second developer at the cost of possible
additional conflict resolution later.

1. If X is close enough to finished state so it's API won't have big changes,
you cherry-pick X to P and continue work
2. When X is finished and merged to parent branch, rebase P to updated parent
3. If during rebase you hit conflict on patch X, just skip it (it's already in parent)
4. If you hit conflicts in patches following X, you resolve them according to changes
done to X after you cherry-picked its intermediate revision.


-- 
Regards,
Konstantin
