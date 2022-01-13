Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A465C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 07:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiAMHHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiAMHHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 02:07:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F8C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 23:07:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so19522369edd.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/VJk7sL+wYsR4JQDDsx6RMaf0BY81LknJkDeJ8rK6Gk=;
        b=iVa+bmYfl/PWNFmzW4oNSd9LxPyBQKobSbkd/TNDEuJmbKES00/XqGAiHje9aJFyc6
         Dlz6TDCYnlCXNk4BS4MLmzt81dtcsC5QXEDtJFV5xfs/EMo8p6nb4Qpg7CtBJqeTNnRf
         w0w3VYFdAd7O3PW1GyTHSyPhz92fsKmkGkyK6tCtcO7Swt+We9pUNHbys40r2HNec63b
         qsyDf9EyfBDeO/g3DA0GkCKQeuD5qpyaMDLu5XQDiDIf+HgWtI763zAl2PVckqjx5F9D
         /+sJpn2JJrwC2iCWU7Pt3uHmn1IWxuiQNS0JM1OOgkvL8Y8rFrA3UjcJQrFOzk9Dr4s5
         yCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/VJk7sL+wYsR4JQDDsx6RMaf0BY81LknJkDeJ8rK6Gk=;
        b=HwZc8Axc/piEpsdxsJwQleQwgpdqKlQa2xe9H9reSIBO9XzXsBfyg7J5PdfLl5WUvR
         g1OTjjSfw1gxNklsTp4NBNYfCZAtjW/1ob36dc0iUVhnIksb5Y5h5uOG+Q0F61kvKIfX
         q+eBTz7S0R9rcFwB1at7HKHvU7K8rYm9BBo/inB1yXZbnChtfXPjvh/lyTfqNwswTuqp
         AuSaVOvIgN7HYQjXQQuPUbqX6JpZzCegkabmbOUcDnh5+fB8duLZU/mqkfDBx+iG6sYO
         vqXeFfNYObj1773q76hGM5CJ9cybihiTYbLn6sZbLx14s4PPNYjlRqbu054ymZtWf2xL
         N1hw==
X-Gm-Message-State: AOAM530T8bV2CbPze+KK6hivgsPZhoWfH/7HK/ys1EVgERvkxdd6DfKe
        yOQVUM1RNzTCF/KZWKr6EyY=
X-Google-Smtp-Source: ABdhPJw1dKdeXK36AY2Xirwcs4D4VTo2CY6nKcBs+odYK2ZNJmOZ3d7pO1wRhq0uN9s9XzyOcn1EtA==
X-Received: by 2002:a17:906:74d2:: with SMTP id z18mr2554064ejl.528.1642057627865;
        Wed, 12 Jan 2022 23:07:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z11sm775083edr.72.2022.01.12.23.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 23:07:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7uCQ-000mPS-Uq;
        Thu, 13 Jan 2022 08:07:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: Re: [PATCH v10 7/9] ls-tree.c: introduce struct "show_tree_data"
Date:   Thu, 13 Jan 2022 08:03:02 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <3ddffa10278b5814123a5bcd2fd3a531def3ecdc.1641978175.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3ddffa10278b5814123a5bcd2fd3a531def3ecdc.1641978175.git.dyroneteng@gmail.com>
Message-ID: <220113.86sftsw1ut.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Teng Long wrote:

> "show_tree_data" is a struct that packages the necessary fields for
> "show_tree()". This commit is a pre-prepared commit for supporting
> "--format" option and it does not affect any existing functionality.

Is the only reason this is split off from 9/9 because you're injecting a
8/9 commit for the coccinelle rule change, and wanted to find some
logical cut-off between the two?

> Signed-off-by: Teng Long <dyroneteng@gmail.com>

For both this & 9/9 this seems to mostly/substantially be code I wrote
and submitted as part of
https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com;

The convention we use in such cases is to retain the "Author" header and
just add your own Signed-off-by to patches you're modifying/splitting
up.
