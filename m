Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC41C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 09:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiBQJO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:14:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiBQJOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 04:14:17 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC45279097
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:14:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qx21so5536132ejb.13
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=A4JktxGrT3/Nf80nwTMxLcXn2cLR/iQH8pVwVuWRMtM=;
        b=VG57jQhfPoNhG6mUehbsezdHYZ77zkdv+dy+uAb26G5GY8kOwFDRcAdHlgQZubeuHM
         dwdCDB6OHcU0P5knciRi8UsXGPbQlG473xwWULc58uxhn/MU+8eDj61itBDe/CqIyDnB
         OFBvzAbgRSm3Wy8AKIM0+Oe4M14X+jK6tGI4v09wwLDUMsNEtTSnqa4rBBgLmwoJHY4Q
         0puaVsXdDzlNuRUKr0SoDKLUFGhCSFoG2li25ZSLvyrn8mYvVGuG+YIsOzGkrRzHvPx4
         yeQqFyfjFKCQ1XrKrW5sT49liDfgENoPVxNjgCk8bSCewAF2rSNF+OFPllfnzk7nQn+r
         HHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=A4JktxGrT3/Nf80nwTMxLcXn2cLR/iQH8pVwVuWRMtM=;
        b=TXGId8vJTAs0xbvPbJVvFX8gxnspXkzXiJP0mpjTRDJEVeGKTKPuJyPyhbNfDuSlwP
         YXSVj3b7+vVDAqep0uOAfvjqUjRbNpgqcA8xw+cEr8OFb1ppMejwhM3vLrSh7K0TSieB
         +2fQ+NzOsTf2X40+lTBg/HiVEXAhMhsDXRi70ALiorycISFVr1HvasA4i/woY4s3efoB
         JnlLNjB/AtLw5gC7x4gumA9F3xcJoG/VukCUrL6Pqagkunl+vYBnfy5YVypBgT9vvkAB
         MHJIDTwHqtNT6ibP2Er3EhsWg3SGfgAWL0FV754QQPz+7k3gXkH0sgcwQ8SZLyEDnjVA
         GeMg==
X-Gm-Message-State: AOAM532y2NF6PX8w1NbBONDtFwDGUU3bE8RiVuOkxv8/7qFxCPaTHorG
        HA+CtxrINsaPxSG8hiNmo+ZR++kxx8RoCw==
X-Google-Smtp-Source: ABdhPJxmN+VsYCRh5zKoKbbq/QioTPN4GePB2gOMG7q3hx7kIHPqmP3QmOLBXOWfMqOAgq/3ypnl8w==
X-Received: by 2002:a17:906:249b:b0:6ce:98d3:9d65 with SMTP id e27-20020a170906249b00b006ce98d39d65mr1534101ejb.601.1645089241655;
        Thu, 17 Feb 2022 01:14:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y11sm926155ejk.210.2022.02.17.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:14:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKcrQ-003fD5-Gq;
        Thu, 17 Feb 2022 10:14:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 0/5] sparse checkout: fix a few bugs and check
 argument validity for set/add
Date:   Thu, 17 Feb 2022 10:13:36 +0100
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
 <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
Message-ID: <220217.86v8xdj1nr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Elijah Newren via GitGitGadget wrote:

> Changes since v3:
>
>  * Use strpbrk() instead of multiple strchr(), fix commit message relative
>    to backslashes.

I read this v4, and then left a couple of replies on the v2 by mistake,
but they apply to the code in v4. Sorry about the mix-up.
