Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D33AC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B77F2075A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFoSBtWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgHDIu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgHDIu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 04:50:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B598C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 01:50:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s15so10185809pgc.8
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wouhRjdWKgYRGsCV++kmigQI0+q6ePrg54pmCNTuHYk=;
        b=sFoSBtWxkolsnyuKcJ8m7nr5hBnIBGI7lqYxkkHX3P2VyOyr2UyykRvCihkTXVzo4b
         uJKSYPsV9MCKExBSkGIJcvG7xOlMNYOCPBjhIv/sEbw75zZHGG6c2D3feaRP7RDL81u1
         SgyILdxJnMU8EhhXGzofXEjAvCD3rjX66Kg8D95OipLST5V+VAd0+0o7K3Q/2G+TPXD9
         YN5zGG0Fu5g3iRfr3cSOQNQJLZz90n+1OtWU+CDJyoLbImJSV0q7QA+sVAxr957iXA6l
         79v1R5VKSdX1LBvLvZGVARbJxzjTgtFgPY6I0RZeNYBAVQVJSga/+kvziVmSVlqgXQag
         IC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wouhRjdWKgYRGsCV++kmigQI0+q6ePrg54pmCNTuHYk=;
        b=b02bj/8z1sGKDux1HTzDZzExif8MJB9/V2qXXb1DsdGAxlOxVpbEvviPxyMwPfUepy
         brFoMa7Kv5PegYiKd75oGQeT1hXLIztnqz+DS5HPpdfkMiPqIuFOhGqeD5FinaSFWZxS
         3W3J3P4GFPURbcXPVOnZ9dauJDEC+DzssDu1098oBQphgQ0aeDOISypr/EQhuQrdJHQN
         WA5Ctzqtfz/3exxZ4XOCYwSSJp39v9SB05Rdk3w2MOkO1aYJZ1JGHh8HfDkDQL9zY7Uz
         uufmLaWjruzXg2Bf2wfAWHGu7myzog7BTr59xqV56QyKykZs3B2Bwjih3LYi3VzV9ayN
         Agpw==
X-Gm-Message-State: AOAM530N+MXU45bIOVtzMYCc6bhZRHdd5lCmhufPNMRKMs6GH5wkDyFj
        fwSxYbVhPeLxow6NWXuzIhaqL2sm
X-Google-Smtp-Source: ABdhPJynu1YQSPWvZJvMov7DSTiRDXd91GM1cKkyFxpLZUDEzCKb822ym0D30IV8Al+k+UhvHwkmNQ==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr17753970pgr.214.1596531058345;
        Tue, 04 Aug 2020 01:50:58 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.138.94])
        by smtp.gmail.com with ESMTPSA id k29sm22158632pfp.142.2020.08.04.01.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 01:50:57 -0700 (PDT)
Subject: Re: Renaming the "master" branch without breaking existing clones
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
 <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
 <c014fe87-9663-3ff4-9527-bf60ff30d0d9@gmail.com>
 <xmqqtuxjva6w.fsf@gitster.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <90305e1e-c161-42f3-ab3b-92fc423d17c6@gmail.com>
Date:   Tue, 4 Aug 2020 14:20:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuxjva6w.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-08-2020 00:17, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>>
>> Of course. Though, having a symbolic ref of 'pu/seen' to 'seen' would
>> hopefully not defeat the plan while being a little helpful ;)
> 
> How would that be helpful?  After all, I do want to allow us accept
> a topic about 'seen' from author 'pu', and that pu/seen branch
> should be different from the "not yet ready for 'next' but at least
> the maintainer acknowledges that he has seen them" integration
> branch whose name is 'seen'.
> 

I thought 'seen' was blunt for a topic name in the sense that it doesn't
convey what the topic does about 'seen'. So, having a symbolic ref of
'pu/seen' to 'seen' might be a good allusion to the fact that 'pu' has
been renamed to 'seen' just by looking at the list of remote branches.

-- 
Sivaraam
