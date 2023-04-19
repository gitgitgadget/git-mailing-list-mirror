Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DDC77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 16:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjDSQut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDSQus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 12:50:48 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB266BB
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 09:50:45 -0700 (PDT)
Date:   Wed, 19 Apr 2023 16:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681923042; x=1682182242;
        bh=KYzlmw3k69YSFl8SuCiwJIPYpbhAF5BqNNbH5zDR33Q=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=O0by2WuTD9rP/c0IPiMnzND+Lb2Z08LY8nzrL2EgVch7SJH5GYNw2H5XNrtIhL/Ys
         /3ONRD6Ps0OnsFu18V14wgjmlKaS23HH8IQDGadTjy1JMNtdWmcun8HgtBW177Zjau
         jP8Cmdh7/5JMYPagvsrRtGWGKyDXDrlP770wGjkSty0O5UuMzjS70T2LfqWABhPTuI
         VY7KywyGGJiyZ0rdZQccncWwqkjypV4VBBRuJrj8Kzn+k6q5i1Uq0onG8CaQ0XQYrm
         tX/7eKRNJj2HOAmHYbqYIQs7f7Gkwvh1zFd3H0Blki7PlbNPp7Sc1CeuDuGEMRVxP/
         t53+38OIv7WyA==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
Message-ID: <hhuzqzxm7zjijrocghio3mwh7hyacsgz6d5adpxg2gy6on5vf2@u3h2hcuvfl5z>
In-Reply-To: <xmqqmt33angr.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230417093255.31079-3-jacobabel@nullpo.dev> <xmqq8reqkyfz.fsf@gitster.g> <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45> <xmqqsfcxdu9k.fsf@gitster.g> <zyuwfbx5e57ly4ybfbnapbzbkw4ib5xbreu3nawkd4f5srhgfe@pwp4gw3hbgap> <xmqqmt33angr.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/19 08:41AM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > [...]
>
> While I do not understand what you are trying to achieve here, if
> you expect both the standard output and error streams are quiet,
> then
>
> =09cmd >output 2>&1
>
> would store both to 'output' and test_must_be_empty can check what
> is in there.
>
> On the other hand,
>
> =09cmd 2>&1 >output
>
> would store the standard output of 'cmd' in 'output' while sending
> the standard error of 'cmd' to the standard output of the whole
> thing.

I thought it was redirecting to both actual and stdout (like a tee would)
and jumped the gun (replying to your message) before verifying that it
worked as I assumed.

The goal was to be able to capture stderr without suppressing it in the
output of `sh t2400-*.sh -x`. The original solution I had did it's job
while I was debugging an issue for the later patches in this set and I
suppose I could have always used `-i` and looked inside `actual` myself
after the git command failed.

Since the issues with the patchset I was having were resolved and there is
an alternate way to debug the tests in the event they fail, I'm just going
to drop these changes (and drop the `cat actual` changes).

