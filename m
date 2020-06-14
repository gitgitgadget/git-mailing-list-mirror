Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24179C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A5D20739
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhq3YlVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgFNTRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTRN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 15:17:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79200C08C5C2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:17:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c14so13745732qka.11
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Sa25OGJL2+mugO9p11YvDoNOWX29D6hgZjJC3VSeOvU=;
        b=Dhq3YlVo9+BN1ssq7ZY695/uK0LTdwQKrntNiNu2Omga5MkoEPtnVT8ZM3MYtBYmIG
         ZkIwTIy7laxZgcte71aUfGRb/3wM+Wvl7cPguAlcf8QkapZobw8Hd1h5tYh0WZajo4mn
         PkpMvQDCwmYLSgPaBzmAPItBht/vkqwY2jMon+VkEZFYbx5rywa8Kbva8ZufBumE4Vk4
         31+PZfPZC/HVWzHcSCAMjmUifSIXyNgk998FtS0G7NmoXqy8dMXSxsDJDfYR/sWWgIG2
         gI1Aj8Y0U3C8tNDNEVIWlffl8qesjF5/1TfiQqsR+baDp9kTD3dMK9c/W1np/LsRsw+H
         uWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Sa25OGJL2+mugO9p11YvDoNOWX29D6hgZjJC3VSeOvU=;
        b=HNIwXvrTHplxrFupj1Oc4teHgSto/x0Jggi7PPmmXSAAoYyCVJ2Um/aipP4rxCmQVP
         oQCcRir6Rterv/5RcYV7phwvdUYhS9TXbqzl1H+Cb6d5ceIiU4BDYsz0RJiRiqgaZKLE
         5OPXLmvvgcl3kRqCyTDiz8nKw0T5teSkV3JGbtkTr33trLs8XDnMd36E4l/6fKk3SSdA
         fDTvO4FvviOLVC3LQUY2l9vTZbNh8cqHAP+SbodfLGg/oaQ/BNsJeKWMKcANWICD1IOR
         GGorSZK5LBhRj4QowGy2V1f+AB7V3qM1PO76aGUMjQgsmboGJIKYZGzpUdVl7tXw1XR9
         bOhw==
X-Gm-Message-State: AOAM530YWlzhLFcVvNklCYakFmu25QMCQEMjJhs2Y3GOaHVFzkLPEH76
        phtWB2ii1gEY9k4QW0Uxv3Y=
X-Google-Smtp-Source: ABdhPJwLGHXL1QsS1woLpN/Zne8SrAS06jO5um+pa2BHEi8sTtCiMiLpivJvwDLA4NeVTiDtZEnqrA==
X-Received: by 2002:a37:c50:: with SMTP id 77mr12391609qkm.491.1592162231758;
        Sun, 14 Jun 2020 12:17:11 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id v59sm10030431qte.96.2020.06.14.12.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 12:17:10 -0700 (PDT)
To:     sandals@crustytoothpaste.net
Cc:     don@goodman-wilson.com, git@vger.kernel.org,
        sergio.a.vianna@gmail.com, simon@bocoup.com
References: <20200614190842.GC6531@camp.crustytoothpaste.net>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <f43e06be-f744-fcf2-95f3-848660a33c3d@gmail.com>
Date:   Sun, 14 Jun 2020 16:17:08 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200614190842.GC6531@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So tell me, how many people have to be offended for a change to be made? 
Because obviously you will never find a word that doesn't offend anyone. 
So where is the compromise? I know that the VAST MAJORITY of people 
wanting this change here are white, including the OP. I am POSITIVE 
their motivation is nothing beyond virtue signaling.


And on a second note, this is why COC are harmful. They are just a way 
to justify injecting agendas and coopting projects. There shouldn't be a 
mandate of "inclusive language" to begin with.

