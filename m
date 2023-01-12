Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F45C46467
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjALCBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjALCBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:01:53 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2B637B
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:01:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s25so17912503lji.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwtVDIPDetoOe+uhVCuVIWFkgnrZlwXOSLU5eBGKj/M=;
        b=ZebXZ0Erm4ySM0+W51VOrj8arX8GxiqbzMiPu0obFu6Po/ZVagn99LS1SS/DbDiLDA
         Q2LJO8B3VYKO6VrzE3ARC+6kF0x5YNNXvhwVYlKU0079IkOH1E+H2ClxjBycWdKS6QCf
         3o9wfIeRB5xioho6ZYkbfryDC7BBrfzcWyYjzt/T0P2jF35SqjpRFHKxFaAcqdzEsBuo
         GMDdDfHqJkuyitRz8jq8/s211GWngA71k7nKqN/YVjIa3OUr+11cAb/nhV4Wt+YNBfRc
         S03SXSsEmoIBuu+k/jmtCmv74vS+wKDprMGABWmrbEodC9MaQNwLOhvnnvZcHH7zFqkZ
         m1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwtVDIPDetoOe+uhVCuVIWFkgnrZlwXOSLU5eBGKj/M=;
        b=vAwQNqmLCmBOYjsu65DVQbhN6fQnJl4Otck6SAU8unOPox/nqeWZ7mG2q3/nPOdk0M
         XrYwxM4rCwdB3olHAdjqzwiv5X/1atqn7gr34pRYrj3KIK3Jtkl64dvfYgOdvke4QuBZ
         sYK8SeRvK4Fj9yZXVxvhxaybWrTUzj7JgY0N4dPNC6GUDZH5M7IuKHhrTLV5Hlmxszpp
         a5IPkTsSako/50vxd4/UhEBFtJzWQ2GBa/rs99SsjO97QTYt/Eoif9Y3t/VhpFUEP+q1
         TMU1cxx9Seyq8ydu8LolzmC5UDsV/m0Rvi+kT7cb7wrYkB2AT1WVUw0SmRVRVVeqyB/O
         q82g==
X-Gm-Message-State: AFqh2kpDPV3syr860qYPM84k2iPgNjCbykpTTXRVUgdzq3WlGoNPw+jA
        Y/lx0YIp8zQdeFtZubos1nmNG1khltGSOKvrFO3INT+q
X-Google-Smtp-Source: AMrXdXthFz6JFN6RbWUajvgOWgwSQNAjCZ0/kG3glK/kbFDeTd1tbcgKrpPe5Qqk5IJCZSJKauIPwEwaFr5RWEsnYYU=
X-Received: by 2002:a2e:9ad7:0:b0:288:791b:71ee with SMTP id
 p23-20020a2e9ad7000000b00288791b71eemr335732ljj.521.1673488910399; Wed, 11
 Jan 2023 18:01:50 -0800 (PST)
MIME-Version: 1.0
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
 <PH7PR12MB7795ED45E989E2EDE2364049F1FF9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BGh17pH1DUgPOoaDKBcKay3NAyi4js-HnEKAAyYUBSoYQ@mail.gmail.com>
 <PH7PR12MB77959E90F52C59140ED662DBF1FC9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <PH7PR12MB779537896DF1C71188E0E683F1FD9@PH7PR12MB7795.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB779537896DF1C71188E0E683F1FD9@PH7PR12MB7795.namprd12.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jan 2023 18:01:38 -0800
Message-ID: <CABPp-BEKywBvsjDmawGkBMnp+n8A8Nc3DJ3F0ceuvMwh+NFKFA@mail.gmail.com>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
To:     fawaz ahmed0 <fawazahmed0@hotmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 5:54 PM fawaz ahmed0 <fawazahmed0@hotmail.com> wrote:
>
> Hi,
>
> I have checked the repository size at here: https://github.com/settings/repositories  and it got reduced from 4.7Gb to 3.3Gb.
>
> Thank you, have been trying to reduce the repo size from last 15 days.
>
> Regards,
> Fawaz Ahmed

Awesome, glad you got it squared away!
