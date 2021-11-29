Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D44C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhK2Uu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhK2UsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 15:48:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E1C08EC1E
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:26:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so75037331eda.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAMz14SxHypnUUF8QTmcEyKbhC7yRBFxJkPYiJkrqaE=;
        b=KwsDjahBu2Z7B1qRvpiw1qhDlLpDTfMFAXDewdkqnapkWpPKEeF0J0d5YxPv/XA6Ec
         B6ehyZsrXAU1KCSAfZWMf/OGQ54gP8d/zCA4A5Bux8QwvZn/GPPD7nMZVX3OJ5vq2AxU
         eoSw8jw1Z2cKOjd2DZ+BIGfQQq5CA+YXn/b435jhZXzW85WafrZNT/yVceIKRppGiS36
         NXyCxcGNNDK+XOBthqqw2IejD/BQFJlml46E/anRkNpARNCi2nRHEwcBRPZ6ZbwJuwAz
         zBJWWgcdcXfrBl3eZldt3Zf3l7smAQwO+XejStIolLetxGoiUvfTSz08eto0oyTnX4mj
         TorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAMz14SxHypnUUF8QTmcEyKbhC7yRBFxJkPYiJkrqaE=;
        b=zQ3MlcmeOvlhydDxJ2Egz9+t0LCA+Fx6GOSSyy/MvA9qlO5zWnp+1qwz5hZ/rcot/H
         aaJ575syYkwi9K56t0B2K8+E6Mcw/+xspb/ewM4jM2MoUm3+NVXnzhuheXPFNcBGVHm7
         lS0SNyL+gS1tJ9/au1vwvy9Yjrns3xuKMdsAN2WaCgw4JuH6MdvkeXw3bWKX0n5uKkfF
         zT3ZUkVIBhO9ZNQo4YyfKiNLOHzqsmHXmJZe9REYi49ieRLwHW9IOPhk1+f06IlUE/rt
         5WjQLy9NOyOXRGUXMkERifQT8A6qKsUz8QZAs4bnXPrV3kVfTVrhKcYg21fCLaXYCUfc
         xWAg==
X-Gm-Message-State: AOAM531OikCukLFn6K7sTr8B8N35okoCi6EgRfQR6HhmQ/Ff5wIO9eXY
        INYjy2zzO5iAMfwMI7s153L2EzC2HkmZ4lZ2YXnVoOzG
X-Google-Smtp-Source: ABdhPJwvhW3cn5EXOuV5FVwxnjH/VGDCO4CfXM403ho9zyFwNTh26glknC/42Fhhrc7noPaojKkbcJhBf7NF01YFNqU=
X-Received: by 2002:aa7:c902:: with SMTP id b2mr74770335edt.320.1638206805661;
 Mon, 29 Nov 2021 09:26:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <e74975e83cc7a11b8f0378d59a8c2c4a97d3aa50.1637829556.git.gitgitgadget@gmail.com>
 <ac7e7241-d852-f0e7-d9c1-053adb242fee@gmail.com>
In-Reply-To: <ac7e7241-d852-f0e7-d9c1-053adb242fee@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 09:26:34 -0800
Message-ID: <CABPp-BHsH0TpsGziLBQW-i1W_XicxyxJUtJCTdu6AwdZvzkmbQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] unpack-trees: refuse to remove startup_info->original_cwd
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 6:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> > @@ -36,6 +36,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
> >       /* ERROR_NOT_UPTODATE_DIR */
> >       "Updating '%s' would lose untracked files in it",
> >
> > +     /* ERROR_CWD_IN_THE_WAY */
> > +     "Refusing to remove '%s' since it is the current working directory.",
> > +
> >       /* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
> >       "Untracked working tree file '%s' would be overwritten by merge.",
>
> Your new message includes a hard stop (".") which is non-standard. I
> see that the message after yours has one, but the preceding one does
> not. Since the file you are in is not consistent, I would choose to
> drop the hard stop here.

Seems pretty reasonable, but 9 out of 10 of the messages in that list
contain the hard stop.  True, that's still inconsistent, but adding
the hard stop feels more internally consistent.  I think I'd rather
have someone else post a subsequent cleanup to remove the hard stops
and lowercase the first letter and whatever else needs to be changed
with these messages.
