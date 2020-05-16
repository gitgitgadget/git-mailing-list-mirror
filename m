Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1E4C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D61E206D4
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIquntiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEPKkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgEPKkX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:40:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E50C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:40:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so2137531pjb.1
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dn7lUYMxXW3hDFpSf78cYVeuTKtOy3L+wjCVtiAPvXM=;
        b=tIquntiTtA3NF/VDm0k+lmA4Td0QOiQNqOlW6s4GqQ2hwJNb8JzoJAhpLk58dJdJe6
         AaAZ5t7M5gMIcjZa09qUpRgkD08qQmOre5jGR8LV4sszZQpd+zKvYsd+X8WcMS66Z5WY
         fdPfgLjYu0PsHkrUNZbAtDsSZ3ikKL2eXYRUjnX9+hNhD2WIKzadVd+FCBtOooG5FAN5
         yxRhwrVHvX2QljImFNBrWD6bY6ID6GvlDMmD7AoyX0jhiJ//EbqO+pOAFDfrieJLt77m
         fG0wnXWVkpU0qfZk1jgGb/3D1Br/Fck+O+GNqCPJJD8L5U3C0iK0jbguWemOwxj2D6fY
         eyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dn7lUYMxXW3hDFpSf78cYVeuTKtOy3L+wjCVtiAPvXM=;
        b=rRHFA6vv8UoxtQdHXMF40c5tR0+8jQAgyyHkTNOOwYExxdpUuPuW8IyVQ2N5p5jhUe
         676QfSUW5Uz9MBczk9KvZPHNKwAvYxYEg1zsVwaKmnzYtV4gg8U6eKHbVdPBLOd+PVW4
         HJhdbnMCCvYbs07rOOL6Fi5jrnyXJ599ps/Z5kFBc8UY2FMsAEz/HzMjqa69QaJCupa1
         8ev9QpnRiYmTn4qNk+CcJ6GA0IK/4CDzHy6NjiRPdOaJNoxXoyhn75op1upJ52hpQJLJ
         tjc5BCAaEPMMZifptPFibuydJfTkp/p73lYadfbxlBzFgHtbn9vyEfjE2PwDMHfLeXOh
         neXg==
X-Gm-Message-State: AOAM531euyJr2v4nLW0ezjasEAyJX7VX95lAN22kGRyZ80qUlPR3/jzh
        aordYpKYRQzqJiEzQiMf7+s=
X-Google-Smtp-Source: ABdhPJzk/u6W0oumwu/skri6Y/kRBy9kGWVzKj3R3Dz6dZ2svwzyyoTt0jPu2QYYvLI/wsbA0Gye8w==
X-Received: by 2002:a17:902:5988:: with SMTP id p8mr7691423pli.146.1589625622909;
        Sat, 16 May 2020 03:40:22 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id z6sm3638360pgu.85.2020.05.16.03.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 03:40:22 -0700 (PDT)
Date:   Sat, 16 May 2020 16:10:15 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] submodule: Add 'quiet' option in subcommand
 'set-branch'
Message-ID: <20200516104015.GB25211@konoha>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200513201737.55778-2-shouryashukla.oo@gmail.com>
 <20200514101534.GB28018@generichostname>
 <20200516055016.GB3296@konoha>
 <20200516085642.GA16726@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516085642.GA16726@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/05 04:56, Denton Liu wrote:
> I would argue that it's unnecessary to print anything. If a user
> provides an invalid option, then an error message will be printed. If no
> error is provided, then a user would assume that the command succeeded.
> Take, for example, `git submodule set-url` which behaves similarly. It's
> silent on success. Printing on success would just be noise.

Okay, I have dropped the commit. When exactly is printing on success not
deemed as noise?
