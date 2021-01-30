Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CFBC433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4977464DE2
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhA3Jnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhA3JnP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:43:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4F5C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 01:42:35 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a10so16563233ejg.10
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 01:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=8xBi1DweHBwLZSxjq6lKdLOr1oLwg3Qgj86PZb9eEIc=;
        b=Ggng4RGnosmAlECbWj8gwfC0RzewgUhICVq0lUc7Vlc2SjI8bqHpuH/6TC2F8D+lId
         HcXM/96P7O6gYoec5Th9xpjPk/3+o76qocyZzPi6R5ObTkTfvwvbtIs5XvczJDuO+xR3
         5/7s1i1i18/DZ6rvoFbgGHZjZ2lBDzwXXmGQOMvflHdc+KISNKsAMaxSZCnNBcNtavTT
         b22TdE2UPvznHEbesYnFgnrW9xy35CT3+mb7WsSZA0A32h++C1lq4GE7Vl5LYUmQFb4w
         SIAfvAmkxj6C1Z8ZldW4x7QmW8X0Vp1/Md6Mxn2Ti2O4O/FT9AAW7p/dNlecYmkaFCJF
         uK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=8xBi1DweHBwLZSxjq6lKdLOr1oLwg3Qgj86PZb9eEIc=;
        b=SQomWijDuOD9pim9uVycrL8Gyx2+4fwalZkexSyKHDATHcAJuB/Ih4DqLlnbRoyImV
         SGgrfMgQWzUaE0BzhVrE2cCH50yKL15IBG1OZXttPFoH9o+kbmRdN6ArP3vgJA+iyZMW
         3izvG/+1o0/nPoJaQk/qp6q6TiJTPAu6OgvlEehaOGvGbd+9a5wKAoKBf2CvtjrFio7T
         MUxuCWcyJyODL2QxxSm4oC8CS6PFxzNcibWum80/0wjJUSK9kLjdCmHLeaaXeVTHxWVG
         kzzH0x17Wwcwhlq/6+GGjqf/HzX/r8NzZdJPl/9/U8VvZzub9L/X2F+ZsMBAgsjyZRT+
         /2gw==
X-Gm-Message-State: AOAM53304Kg4ASbGBqxZUH36QWgxFILR079gRjKPLeMv/miIAeSHr61h
        20sZHPUmMIx8CNbVPDSaWpY=
X-Google-Smtp-Source: ABdhPJz7WVxJFEmx3j87r8QQzqxC8ArjaXZ/iBTfBhFkSjAxMcjY8EZ1wo7pu+hm2iLIYc6LA8wYGA==
X-Received: by 2002:a17:907:7295:: with SMTP id dt21mr8506546ejc.518.1611999753293;
        Sat, 30 Jan 2021 01:42:33 -0800 (PST)
Received: from cpm12071.fritz.box ([212.86.35.190])
        by smtp.gmail.com with ESMTPSA id h19sm5050453ejl.26.2021.01.30.01.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 01:42:32 -0800 (PST)
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable
 annotations
In-reply-to: <CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com>
Message-ID: <gohp6k4kiykbga.fsf@cpm12071.fritz.box>
Date:   Sat, 30 Jan 2021 10:42:31 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 27, 2021 at 3:03 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Changes in v4
>>  * Added documentation to explain that the lock reason is quoted with
>>    the same rules as described for `core.quotePath`.
>>  * The `worktree unlock` issued in the test cleanup is splitted and
>>    executed after each `worktree lock` to ensure the unlock is only
>>    done after we know each locked command was successful.
>>  * Fix a couple of grammos in the [4/7] commit message.
>
> I just gave v4 a complete read-through and it looks great. All review
> comments on previous rounds have been addressed, and I didn't find
> anything important to comment on in v4. Very nicely done.
>
> Please consider this entire series:
>
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>

Thanks for the review and for all the insightful comments.

> Junio: Perhaps the summary of this series in the merge message can be
> refined a bit, as it only talks about verbose mode, but this series
> does a bit more than that. Heres a proposal:
>
>     `git worktree list` now annotates worktrees as prunable, shows
>     locked and prunable attributes in --porcelain mode, and gained
>     a --verbose option.

I believe this message summarize nicely all the changes implemented by
this series.

-- 
Thanks
Rafael
