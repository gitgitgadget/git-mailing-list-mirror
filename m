Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB1C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhK2WhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhK2Wg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:36:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D1AC21A26F
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:48:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so77307097edx.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7TDBAsS1TR/AHTNFwjcpY7HZbDtK9Su8QZ9BfK6MQgg=;
        b=cqBCNCF55TWr0+8S5RDNIgmPZgX218uNwLhihAus3wLpri4M5S4OR0FXozbnGUFJpF
         f1YramR/u8nlLJJn/ElqMOPSZdAvhGGZUkvDtBAkny5V9vZi6CJgkNe6QvczwTdtQmEN
         kNSJCHyqn5hheXyiTtXCScgxknqx26RNv3l4Iy8iAmWGctFnc272CMFTDHlG3NE18Zh5
         lf0hBaybAIpOQX9lDsRXT2DuRtdBf9mu2cIE69Y+1e8gR9tYyriNEkvbe4IIWfW/jtOh
         S1bVeUt3O7Ko+LeHQqtEFqfFdViv5P3qvn1c4K6DYcd6PWZ/KxBHAionJD+MyqCF4Myp
         qS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7TDBAsS1TR/AHTNFwjcpY7HZbDtK9Su8QZ9BfK6MQgg=;
        b=XTmN7woLicI7adHd3JWDE0Qwq34y19FmAV7o1dBaKIyQ+bS5mAvXh0vfSqF6tBFj0L
         Gx+GZa7nhjZFucdnMINjALr+rYxoDU3/vMpKOu095ZvyqvT7NHdwPS6xY5j+U2MWWgCG
         i9O2aBhjRUN81LdwRxOUKNcBPoKrKOEIF+TcIf1uvzf/zB3tbo3i5yDdV6EIrmmmFDYo
         vXYzAgvnjp9O+h7M99pEhmS62C01V7NNy6WGOuXYor6x49kAe+B86D8qqlYxpypV9ZaD
         Sb3dEoQ/aj7xiNVKCJoi/KOXc10qcLnZ1bk4hjQwMUeIVnsV3b4GZBE+p8LKXBPjw7pp
         6y6w==
X-Gm-Message-State: AOAM533dQUWdc+8Dgzkcce1VmO/kkxw/pd+uo9MTMpiywKPEzZhgEfnJ
        8nzwg1L2eHgcdhKHd6/1VymXgRDlPZ249w==
X-Google-Smtp-Source: ABdhPJw/nNCmM4XAUrDSLZsxEwwcQgCNLBXHCOocIFArHUg/r8VgdVQGL9dMzagLTIhvoeJTepBzNw==
X-Received: by 2002:a05:6402:34cf:: with SMTP id w15mr76037227edc.63.1638218924818;
        Mon, 29 Nov 2021 12:48:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w23sm9874674edr.19.2021.11.29.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:48:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrnZr-000rYT-Vo;
        Mon, 29 Nov 2021 21:48:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com
Subject: Re: [PATCH v4 0/2] Conditional config includes based on remote URL
Date:   Mon, 29 Nov 2021 21:48:16 +0100
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1638217387.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <cover.1638217387.git.jonathantanmy@google.com>
Message-ID: <211129.864k7ug02c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Jonathan Tan wrote:

> Thanks everyone for your comments. Here's an update.

Just from skimming this (minor) feedback on v3 still applies:
https://lore.kernel.org/git/211123.86pmqrwtf2.gmgdl@evledraar.gmail.com/

I.e. s/hasremoteurl/hasRemoteURL/ etc. in appropriate places.
