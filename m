Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA446ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 20:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiISUPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiISUPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 16:15:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A124951
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 13:15:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso343274pjd.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=8fbGp5TEvlae/oZ7xY7bHgsXZ8/07owxwv0Tp81bYdY=;
        b=R85xTw+DdpnSzQ392up9eGepUDeLvoX1l92P5HCBL04efxl3mGovEh0vZ9KnoV1X7c
         aU1QCCoJDQids7mhVTXrVgRHJkRBDw/92VuJoyGlOWUwCj8hgivPUpPpnw2TJbDlQFCM
         9C8nqPuWg2o6NTlwZx07H0HyiBFn5AJ/cTqSHZ8TsQzL4MSzg1yz7cTd/9xzs2qpwSOf
         NUZZYSHsEoex76sGwCzVEUwqpVxidGM4Q0xFsuES2+1mXV6RpQCwyEI9WZQ0DDCexB1O
         V57pXpmqGFy4OvQkbPg9R5OY+hA/ZJgYzQ4nfPPbmeXC4TQ9OnWqgw4IqfiJ4EMgfRbl
         I2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8fbGp5TEvlae/oZ7xY7bHgsXZ8/07owxwv0Tp81bYdY=;
        b=ZBY/s+0DCEzyHsYSDgHSAb6Vr/+c83a7q0w9gkZH35wJ7fqhLokm/usxxiHWsXl9gy
         HBtM+HxbLlan9a5kvQZHxvd1ljrimi+Kwp2EntgpDa0L2sFnlpjwpMf7qNpvaUguJzv5
         W8UHAS0UmxZzpLjLCpuKwHG/Pn7Xqm5OJ11OS/vk9Ad01J7Vzl6OrSvSwIAxt8ag2m+3
         XY+bwGWZGgqa2Wer9Qk3Oj9EA+cpr1U54QsrblmM1ZKcd4zhR3mq0zhykxBi4WQ04IHP
         eSf2gcsCCbS2gbeWQE1uizNWF03do7yvHf6kXk+e6yO6qiAq+OWCAoMbxZ8WnXuWHAA9
         x6wg==
X-Gm-Message-State: ACrzQf1ds0oY6zUaalWUZ5np0B9i6q0eyAvp00yAnMefVpFqhqjwUyEW
        r4+02EXfWnOnwQyV9UkiLhVTQA==
X-Google-Smtp-Source: AMsMyM5qYn2UdoS7isb06+YuGjnWurnQfebLjUMNGGBGzAN1g0sCdO1cNmrRLSaAQ48zzjVz7+RFuA==
X-Received: by 2002:a17:902:f546:b0:177:ed6b:4696 with SMTP id h6-20020a170902f54600b00177ed6b4696mr1371695plf.171.1663618508904;
        Mon, 19 Sep 2022 13:15:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2256:74b3:e7d0:31fb])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b0016b81679c1fsm21308919plg.216.2022.09.19.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:15:08 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:15:02 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] Documentation: add ReviewingGuidelines
Message-ID: <YyjNxlJEZ2WESP3C@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
 <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.09.19 19:12, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add a reviewing guidelines document including advice and common terminology
> used in Git mailing list reviews. The document is included in the
> 'TECH_DOCS' list in order to include it in Git's published documentation.
> 
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---

Looks great, thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
