Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30EDC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7D620679
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXa3/Zlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgFOOju (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbgFOOjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 10:39:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:39:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 205so15914355qkg.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ow60wpTYvGORRPW/w93ihtZLMl4v9fi/QtxI0BE9foY=;
        b=SXa3/ZlrPDJj8U1hfyVOSXcGWEWWR+KOESSazT+Oq8GaLIjyivgR1D/eMFtryaQzlq
         tAMb4QBk3/omdrA9XOuIZll+V3dQBlmcR3Ny+iaA62Aa6M3drXp1rUd3Z5Yj0mtNdK/N
         TM3+I/dXzSmnWxI9+2goua3uiOVENgbZP5giQimVF7LDHq46IH/bcXNvqUfU1ERt/KLT
         GySfwmB0nEftIlSJxkay3LLkRRFclEVI6L2JZV24GqKDNIPm2UZf1WsKyLCbirAt1rbH
         KMDM7POSnkTrFY+SNp5dG0vThVmuxdCCSPodvCL08BW4DaLjleqy+NJzomGmrKr9OkxV
         KPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ow60wpTYvGORRPW/w93ihtZLMl4v9fi/QtxI0BE9foY=;
        b=KHuWDBdyv4dFYB3Njtyk0PPNMCxGqZkRUppmCyjh8Ki9AFvPy6VkIEzTJTQM+8L+b+
         qP+ORqe7RwHRzJR9po4Pnbu3tIc5t9AD4KwXiyxo5P/f5AjGOFpIHjSQUffN316CYfR6
         kwjlGAZP6t5XSHS+ROjetHiwfFNgS5FS6eSip0awuwa639elwExN1LD4UsRUTt6NIuTY
         KvpDUHBxMQjxcRG1jP47K9FGbeAhMCiNW2jCzgj/1rpQmnxeJDbyVj2RJAbCcdvGbcIZ
         vjXo6m1fS0o/Gwpy7e1dUgSq9zfpXrHOiGmnpzjz5skDUyuztjXZ+FLhWuCA99zdulJw
         a6Pw==
X-Gm-Message-State: AOAM531YzlyApoM6KpIAegf5tm+Uh2d8kYQG3kaqVw6EQspXWPosMcfI
        552djcOv2u+S4e+q0KE7ZIg+6jT4XFY=
X-Google-Smtp-Source: ABdhPJyDeU/L8iqe/uiGEMFC+VtOuwB0OhoTw/pjJw+P77PtlLTOWLG/H7qTQAe2oCpF2ppZA0rUog==
X-Received: by 2002:a05:620a:4e7:: with SMTP id b7mr15636258qkh.204.1592231988473;
        Mon, 15 Jun 2020 07:39:48 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id g47sm12433362qtk.53.2020.06.15.07.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:39:48 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <4c08e1a0-db64-5d7d-493f-54c68ee75470@gmail.com>
Date:   Mon, 15 Jun 2020 11:39:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems the developers made their mind, so I'll just leave some food 
for thought.

https://www.youtube.com/watch?v=KEU-t-ANpdY

