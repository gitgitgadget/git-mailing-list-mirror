Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04506C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1738613B0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhDTJsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhDTJsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 05:48:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B4C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:48:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s22so5129309pgk.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7EEJGzptIUcbN8PUAZkA1xvud6fQLdNj2ugZnpa/ouc=;
        b=DP2FigCg0ZUf2inEPALXa05dNc6hYsrHRfcZHyKJnfWZo96Lnq4+jfMPUkC0d3GyrB
         I2HFOaQ/wAwfGSTZfv0AHURVS8Ba1eDkYdIIzS5YKAfZtO32xMHRkrraqjAyxWjUKYCP
         WTjZlOWlpUhdp+nhA3BtdJdklyeGQCoA38XJySvoBFMxpnsT1Ji7SzqZIyZksYqPsI44
         8QrUlIaf2PVsuJH1XDZWSSwKkF7jWUc4dOXscgQrYc7pnmGknPea7rsPJJwz1C8/1m4g
         bvb99axiEDQQdyJ6po5Eht3/7OudCH+8ZK37Ef1QQyELRAM29senyXWTLYWXwcOOcp33
         /VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7EEJGzptIUcbN8PUAZkA1xvud6fQLdNj2ugZnpa/ouc=;
        b=IhwnUHQJ9fGVNj/LLqkMGdezc5aTU8a9zn6qTB7+GGIqq2vBX1EL8BCeZBS6/uB2Cd
         xo6HICCkyX1ECYbj5uNsUi19joGJusQE0qBD3QhSvJpeVrh1oVG9fsbcEcx/BKA4yVvd
         AOG3QWiuKkltpqqHNd2Wm24d6/4qIBgnNa4nzM7lnxC9O4Es6yePXJYQ1XQJlTAyeSlo
         Fto+TYbbsasW/I8vTMknHEDvqSVR21qSRfMahI26b9qveZqOx+iiavoOzd8OP5tx1ERT
         ic2cAjVB9hwoO5OO3CCJorpiVRhUG1ZjJl9hR9P6WlLL3NUiphc0vyzeB5Y1t8q77m2J
         3uvQ==
X-Gm-Message-State: AOAM531dkQIsWSN9iAGoz7ay4KIukqiDvkHfFhLqxyMHoRoC54zMpclF
        liYjNW2KyXcnGdK6nYyayYBmfcRRw+NhqQ==
X-Google-Smtp-Source: ABdhPJw/x8JGG2y8jezKXTB3fAlwUM9ZnXRLmOBSilyWLSxl0BV51hUJ/b/ixO4eHcGn2RmwN66wqg==
X-Received: by 2002:a63:e903:: with SMTP id i3mr15975829pgh.374.1618912101479;
        Tue, 20 Apr 2021 02:48:21 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-42.three.co.id. [116.206.28.42])
        by smtp.gmail.com with ESMTPSA id o8sm2064420pjh.20.2021.04.20.02.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 02:48:20 -0700 (PDT)
Subject: Re: Random GitHub Actions added to git/git???
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
References: <xmqqmttt7q8f.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e4ed4046-6aa0-608f-896e-1c70715b81f3@gmail.com>
Date:   Tue, 20 Apr 2021 16:48:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqmttt7q8f.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04/21 07.29, Junio C Hamano wrote:
> I was browsing https://github.com/git/git/actions and noticed that
> there are many "workflows", even though what we have in our source
> tree in .github/workflows/ define only two of them (which I consider
> "officially sanctioned ones").
> 
> I suspect that these other ones come from "pull requests" random
> people threw at us that never hit our tree, with changes to the
> .github/workflows/ directory in these PR.

They are Actions jobs triggered by GitGitGadget PRs. For example,
job [1] corresponds to patchset [2].

[1]: https://github.com/git/git/actions/runs/763138085
[2]: https://lore.kernel.org/git/pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
