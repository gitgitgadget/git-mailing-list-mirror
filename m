Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE90C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C50E60C3D
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC2Ozn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhC2OzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 10:55:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A583C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:55:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m11so10001172pfc.11
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=huUQYifKB9yNk0x3uqShLGJN2ecySJN3KAv4o2M+JZU=;
        b=ehbx9cP3rv0pHqM4LrINR7VUQYQqJET/acKQXI73pBLJgd7nYD3to1thpDFn+baLyX
         d4uP1J5IZczqJuNrXMrjWOB6hp5iv56v3UymGftLSk1ghvQHcZxa/NhPGU5H5ig1L7Rf
         uSPb2MUXDGxXzcbeLBTYe9MaI7R2ZP4Z5y/s9Tjk3WaVmZelgFNdLIPDz7ZXKiUEJyY4
         8okOIQl+mO3dWQaVnAldx2nAz5vEsc5qHHCUDqEp4f0zqydAQ8fJIXwiLyc7S7Om6nrm
         BRwAULDkkXqDrxRO5tzVkif3/jxM+Vy/B7Qg28nxCx4cGmWLjrq20MhNbxHOJJg2+Tnu
         MXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=huUQYifKB9yNk0x3uqShLGJN2ecySJN3KAv4o2M+JZU=;
        b=kNxc9nK/3bE0Yzs2muMWRhGJJkXdYrEnXi3JCUr/+RU3axQj7s6m1kKQUMf2mkU+St
         iqUnybYwe/Qfpgz5oBUXM7vqLxoM2nG993qwc8/vwuR7owoibIA5s7+FpdAUXoXqf/zS
         XOLOO5GsJAReSDqBEYD79YEZJVDUdeTjBLHWZeWYjZztzo8Ae6aezPbuqaBpKutVvsoy
         D9vL0+/iecs1lJcGEkdp6bgAChtqUQbiodnTf7VlhCYjVoK90SRvFsfTaxFbSnFqmtZV
         vZRuLlacYjQ6UjkY9bF2lhUGOBsMwL8Xxvbx3z6V8IcM02WFS4eSfuFm+c1J4sBrGQsS
         /tyg==
X-Gm-Message-State: AOAM532SBYIxWlVfdjdjvg1rteG6NscBdjYVuDDt2WQN+cWei0yQduPu
        7mv4tYuGh3MdpYovclAd1rHmOtCjfu350Ctb
X-Google-Smtp-Source: ABdhPJyOBLS8iimBk5XoumlKP3etD8BJUkO9B07hkM75f/cSfZ16T65ogVGgBQ8Qt3sIpqaHzPU+aw==
X-Received: by 2002:a63:5c48:: with SMTP id n8mr24108063pgm.411.1617029721232;
        Mon, 29 Mar 2021 07:55:21 -0700 (PDT)
Received: from [192.168.10.22] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id x69sm17256703pfd.161.2021.03.29.07.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:55:20 -0700 (PDT)
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
 <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
 <6a9d24a9-6942-97fc-550f-6b9b61264a78@gmail.com>
 <98c196c4-31ff-4df1-9215-77d115771583@gmail.com>
 <5f69547a-723c-05d4-e00c-c7a5d6760315@gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <25198354-9d0a-4ba9-f0a0-13301432b3fa@gmail.com>
Date:   Mon, 29 Mar 2021 20:26:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <5f69547a-723c-05d4-e00c-c7a5d6760315@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/29/21 4:41 PM, Bagas Sanjaya wrote:
>
> Also, I asked to you: can I set --date to arbitrary date (like 09/29/2009
> 19:59)?


Sure you can use something like git commit --date='2009-09-29 19:59:00'

or git commit --date=`2 days ago`

