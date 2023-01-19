Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7EFC678D6
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjASXUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjASXT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:19:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A110E
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:18:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so2798376wms.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI9EjiOl/AN4ZxWiMvGsAqCkxcP8elNL9EwFV5Ug/ps=;
        b=LmywGx5iBxzlIMnkoTZ7Xyve/rRyuLjzDQ+vJen4Jf5ZkPrpvStGjUhvIMFa2uLAqr
         ntMRlJIk7+7rLmYAr2wZNv9EBzGoFlafzd9ALzf9uwg/RCo8fVh+TJDPgM0OLVw7Nh5P
         CTgnFqJdo1h3xo1DVQnHWmpNnGX5DTrXCdl5wL9WfJ3z7Vy83iXDANv33zbJ8BaJgKWt
         LKh1VK3W35IOC5Ss0sU992XX+1x/KfzUHN+/62OzIda2ny9ORHPDx807GhfxsK0WBZeD
         tkKDhJJxGPgrP2ZStyObgH7P56Ld6Cl7Frv3lUt1x8u2vTOpAIFg3+KRXsmzVzomw6k7
         jktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI9EjiOl/AN4ZxWiMvGsAqCkxcP8elNL9EwFV5Ug/ps=;
        b=IkTQzHco/RAQyptAOTvTC8UG3yLX8GNQOaSvxMx39HYLzEoH9xtUBB3mIjK3/zreVd
         IMQEXuyjQVxit1PDe01SoY/SSGTqRrZoLkISVMv2KlU5WKNll8vS7KQh6UFoBajqPCP9
         7yergrYoFv4Mh4h2gX4V86icV6tThnmAKGOe9CPPvW8FGbYjOqQrLWfe29MZrS/F+Dy/
         UuhwI+q3tBJUbXcLsdCaf+vCkGm6Hqt23qxGhC8AvPJAzA2gR9pTKLcoEe43ljKbDaWm
         k1sdrxYJ6IZcejmW8/YaeEYIl+mCg4EkSgoCjlVpxyz+swc7ydYPK6fWPpTW7omV0HsF
         kI4A==
X-Gm-Message-State: AFqh2kqfT7wEQBXCg7+21bdQfeirBIWgBJ2FwKo2AykQ2GZNCdI0ycvU
        4EZRa0bR1vHURcM29+euK4c=
X-Google-Smtp-Source: AMrXdXv4G2KzEXDzPO0Ivpbw+Dn8puf2w4PyJodBRlTAimn98wjjHNXe3BkTzoki+1iHw/au8+vPOA==
X-Received: by 2002:a05:600c:2206:b0:3d2:2a72:2577 with SMTP id z6-20020a05600c220600b003d22a722577mr11978473wml.27.1674170304968;
        Thu, 19 Jan 2023 15:18:24 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id p25-20020a1c7419000000b003d9f14e9085sm503283wmc.17.2023.01.19.15.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:18:24 -0800 (PST)
Subject: Re: [PATCH] worktree: teach find_shared_symref to ignore current
 worktree
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <xmqqilh491y6.fsf@gitster.g> <f209958f-e824-181b-f9d5-6e4bc8e53646@gmail.com>
 <cedc93ec-aa6f-65bf-65be-0dca3d4d0186@dunelm.org.uk>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <71a7b8d3-3c53-3407-56f0-b805f7cccc1f@gmail.com>
Date:   Fri, 20 Jan 2023 00:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cedc93ec-aa6f-65bf-65be-0dca3d4d0186@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-ene-2023 10:48:27, Phillip Wood wrote:

> I'm afraid I'm still not totally clear from this message exactly what the
> problem is. Having looked at die_if_checked_out() I think it maybe the

I'm going to reroll, I hope it makes sense then.

> If that is the problem you're trying to solve I think it would be better to
> keep the signature of find_shared_symref() the same and add a helper
> function that is called by die_if_checked_out() and find_shared_symref()

OK.

> which can optionally ignore the current worktree. The commit message for
> such a patch should explain you're fixing a bug rather than trying to change
> the existing behavior.
> 

Yes, the message is not clear that the commit is fixing a bug.  I'll add
that.

Thank you. 
