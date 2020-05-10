Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DEAC38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3900B2082E
	for <git@archiver.kernel.org>; Sun, 10 May 2020 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwPtarAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEJSvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgEJSvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 14:51:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF606C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 11:51:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so2967619plr.3
        for <git@vger.kernel.org>; Sun, 10 May 2020 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ufeL4Lc6xtGtq3WjOu+rVUjgnFJaBFfuoqDFUihKS7A=;
        b=qwPtarAb7VWj0ZgEA7v2IThBnl4vKrjbmZQlmj9Uq+7x0JSlJN3P2/GtyySzRoKahe
         6Madq/qjQbbBHGPm2pRa/m7KhIrpTsRUAlSuj/2Q1Iu5AgsfYy5Va69F1YeQQnr24u4o
         2ys9r1gk3XeFHTS1Yjhp9WLk72O6ZVusH2mccYIuw2NvmlwUVLyP4RgJEonMizzP+/kV
         MJRFHjZ4WaNv1DrIDyzZENgZ1sBYc0BOwbe+yJ9sSS5IIqv7P+wQ8/Ga3CVyQqfjRQfG
         N5RzOVvN93iYowzD8gh8P9KGjVxxIk/mPSIEYvvl8wzNEzncSE2HTRct2IsJM5z7Ki8W
         LkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ufeL4Lc6xtGtq3WjOu+rVUjgnFJaBFfuoqDFUihKS7A=;
        b=RfPfv+za1ZlCZU2RvE9DtQyqDj5+FXC6+ZoXojeN3TE1GxRHWBYeshUExmB0vUQtR0
         Xfvm+pZArol5nr4TMxyKSXLs47lbKpraam9+pOXuRrPUAmSk+g0ni3U8zOqD7pMR1kUp
         UctWtnt12LiNmbz1hxckwEXjEUT5ShRe0JDyMGtBU55D5mUp8YasBrd2SS4Q1VrWtI0m
         64K2LfOeIv1kCJ3zmgKCEbxYJXYARfk4VIuJ1ZSM8atEcfqko7y62kWW/M8zLkiKIzhr
         xETRDXN8TxNmIcLoz+5UewEzrGMTzFe0aGlwS2psMkGwK458ovojcj2G+dHdJ5MbcWz9
         Xs5w==
X-Gm-Message-State: AGi0PuaDeRXjrP+DyW5PZJfHAZI1wWSR+eMBckSx2sKnRGmCZyaSLHuR
        GQ01oKlZBC1WAkh4DcVn9kg=
X-Google-Smtp-Source: APiQypIowc1KPWvdE/jkhrIZ4Nv2/GrSe0FHYUOWwS9G9nQK78KhRAv3ZGeMh6TCkpdIWXjNclLlUg==
X-Received: by 2002:a17:90a:3f8e:: with SMTP id m14mr18691290pjc.92.1589136676286;
        Sun, 10 May 2020 11:51:16 -0700 (PDT)
Received: from [192.168.206.103] ([117.209.235.186])
        by smtp.gmail.com with ESMTPSA id f99sm8313677pjg.22.2020.05.10.11.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 11:51:15 -0700 (PDT)
Subject: Re: [ANNOUNCE] GSoC 2020 Students and Projects
To:     philipoakley@iee.email
Cc:     =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>,
        Johannes.Schindelin@gmx.de, abhishekkumar8222@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        hariom18599@gmail.com, heba.waly@gmail.com, jnareb@gmail.com,
        peff@peff.net, shouryashukla.oo@gmail.com, stolee@gmail.com,
        sttaylor@google.com
References: <AM0PR04MB47710F0BED399BA85C5DEC89A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
 <AM0PR04MB477183F214CD69F0A510BED9A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <999d4480-7d72-3ca1-f3ba-e3b08c5089a6@gmail.com>
Date:   Mon, 11 May 2020 00:21:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB477183F214CD69F0A510BED9A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

You can find more details about the proposals in the the final draft 
which were sent to the mailing list. You can find the links to 
corresponding mailing list e-mails, inline.

On 10-05-2020 15:39, Matthias Aßhauer wrote:
> Since my mail client mangled the previous mail badly I'm sending
> it again with slight changes to hopefully prevent the mangling.
> 
> These modified links should be accessible without any login.
> 
> "Implement Generation Number v2" from Abhishek Kumar will be
> co-mentored by Jakub Narebski and Derrick Stolee.
> 
> https://summerofcode.withgoogle.com/projects/#6140278689234944
>

https://lore.kernel.org/git/20200326101520.GA19326@Abhishek-Arch/

> "Unify ref-filter formats with other --pretty formats"
> from Hariom Verma will be co-mentored by Heba Waly and
> Christian Couder.
> 
> https://summerofcode.withgoogle.com/projects/#4593212745842688
>
https://lore.kernel.org/git/CA+CkUQ966swTrR7D2vxgQ2ZA3E=Le=u8yvEAopOsphoCWGgDeg@mail.gmail.com/

> "Convert submodule to builtin" from Shourya Shukla will be
> co-mentored by Kaartic Sivaraam and Christian Couder.
> 
> https://summerofcode.withgoogle.com/projects/#6451304047575040
>

https://lore.kernel.org/git/20200325185053.10274-1-shouryashukla.oo@gmail.com/

-- 
Sivaraam
