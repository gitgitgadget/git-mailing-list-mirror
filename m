Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B794C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB963206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 12:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzzOX6pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFNMU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgFNMU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 08:20:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDCC05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 05:20:26 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c12so10518516qtq.11
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PG2JtuWFhi9EVPE9T21XeCyYmuk0Wj3pleWvacQgGk0=;
        b=TzzOX6pCTIPlUUhM5iz6oOCqV/Y2zarnYA/y6KrcesZVeycTpNNvMgZCXr796bBrgE
         9RTskPkyUZ7ritk49wI6lPsZIMhAxcSPepBOEQKmqzCjC7Rm/GmRlwZEL5EqYsesnjKR
         qFcR2AF2+WJ2SHpfwlVWgxInw726ERPW8fpX20JOdVrTxg4BY0cfKNtZxLno8RwqQKcM
         k2LQm/wa59bof9pDdEvlrMDbVNJrhEGDawNNb2skurmlMNUDGQV2DZSx1i5N3MGUyGXR
         houZbokW8OFh/RXVbIwS8OnOezrNLcOx416OPr/J3HI20fdX2waKWyxxED0Z/dsc0ON9
         7qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PG2JtuWFhi9EVPE9T21XeCyYmuk0Wj3pleWvacQgGk0=;
        b=JElhvgpdlo+0CaF4mouLOzMz5CHGBKk/Y25Us9HRao0MNVa4Z/x2aGCONS06a5K3D6
         tgt0h7+b4etMoFGTf9ZHSpMtnfsgk3ofZfnXGnyJHnYPjmhuqqGEwzOT+yGK09OHagSQ
         CUeu3LPpr9SgfWXNguas6+hTibVggYtfXKOWuW72FYrenVy1vd952Va2JewxChewcX0I
         ZZmuCdc19rgReM2ZcBqKUr/KoK0Y3RbtZshlasAlbuQCq6J1pqVNj6yIFdnzPUSQ+WJJ
         7lt4qyp+6XA7UcRQ9tzD4vQrRYM2sq+37jCre3WlzLlzBg6heSTn/LJ/6GvcGV1ok8Bd
         C8rA==
X-Gm-Message-State: AOAM530PULFeGWxFcmBzeX+9FWQ7WyAKHzRrVN3PpWvfO5P0HyEcSyah
        VBD7AuxVAUv6J0v9KHjK7J8=
X-Google-Smtp-Source: ABdhPJyYLm4iQrG8bJOoKoDcy4Yefp1dre8iRObHI5llmpX1u0vkU0fmA24SjWFG0kwUiuhFp/YU+A==
X-Received: by 2002:aed:396a:: with SMTP id l97mr10932343qte.10.1592137224807;
        Sun, 14 Jun 2020 05:20:24 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id c34sm10137308qte.41.2020.06.14.05.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 05:20:24 -0700 (PDT)
To:     philipoakley@iee.email
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        sandals@crustytoothpaste.net, simon@bocoup.com, stolee@gmail.com
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com>
Date:   Sun, 14 Jun 2020 09:20:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's nothing to be resolved because there is no problem. If someone 
reads "master" and gets triggered because all they can think of is 
racism, that person needs therapy.

