Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E55CC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 00:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38CF207EA
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJG1YxAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgJHANh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJHANg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 20:13:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41640C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 17:13:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s4so5157285qkf.7
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VCVe8SvMXfhxjP61C/BVWlhM/UR78O0eUN06yAwfwg0=;
        b=WJG1YxANXQH2rsB0H870GDOQG0ig5XSJ8ujtMuCR1n4cpFmydcPVM6A/Ox4BDDEh0Q
         M3/E22x3+kBmKgfBcLYud3SgB5dYXTiRUrZrWi2ztvhpmY/6FnrONxStY+sfuTC0UMa2
         DtjQiMAbK9QJg7cTcP1YnW81vIyfQRf4WUQO/5cQZefKX/CBoW2ztDeVmDwe9YzIA/LX
         2WAMuh9EdLP0wKLbQxoO7Lhmijh+enPv4T2RfTX5QKltuQ2UpeGWGW8OHKPNEvy8mIqG
         RnDUBtZFvBRSEVDszUP0TinVtOatV3QmcpNl5Y/QbkrUB3UPfrstQ1XHZbxDWhErtTWj
         3JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCVe8SvMXfhxjP61C/BVWlhM/UR78O0eUN06yAwfwg0=;
        b=pyg+ZPPVvD3PyuTxPZSir75y+uMQc00JFA/5ivXR1j09PmpIMT/DII7TScnC8qgOWJ
         fEnHx5p8QbHE++mpZa+W04M+GVL3YRFY2T9EZrMpPnmSf/aRosrF3S1/Gbec+LHDvaYW
         en6D6PjSGC/ivwUqMf4QYqxemheXnMSGzN9RRJUBafMNCOFExR0lg0tFYZnCi5AYBN/T
         RrGGoOnS9VFzwKGKEBojevGcgeg0MH0IDAxhsalhpbu3pAaopBCYFMRxIFmuRm/CWQSk
         EsZ1iDGgN9Ijgot/s7+OzCg3sIxQ3kPxx47YASV/gP2JDVRNuQZjUvtvgls1U0+ZEyGx
         43Sw==
X-Gm-Message-State: AOAM533q9v0651RDOx+6/D1BslSQbzTsN5EW5qVY9gR4EIkvJa/9JZdK
        XcNwtJXxAR6xesZXI5iPNEo=
X-Google-Smtp-Source: ABdhPJw51NcVTo+eJeURFhbtHfzFM24+MyN+LUp9XccHicCUm0LgNvA1Li3dN3JP9inTwirIKnQbrA==
X-Received: by 2002:a37:5ca:: with SMTP id 193mr5705413qkf.44.1602116013315;
        Wed, 07 Oct 2020 17:13:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:56e:1bd4:bf96:36ec? ([2600:1700:e72:80a0:56e:1bd4:bf96:36ec])
        by smtp.gmail.com with UTF8SMTPSA id 11sm1767188qkc.91.2020.10.07.17.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 17:13:32 -0700 (PDT)
Subject: Re: [PATCH] maintenance: test commit-graph auto condition
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.746.git.1602075317625.gitgitgadget@gmail.com>
 <xmqqblhd23dc.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b4918483-5ce6-b002-77dc-92d3049f2069@gmail.com>
Date:   Wed, 7 Oct 2020 20:13:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <xmqqblhd23dc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/2020 4:22 PM, Junio C Hamano wrote:
> Hmph.  Something in ds/maintenance-part-2 series does not seem to
> work well with this change.  I noticed it when testing today's first
> integration cycle of jch and seen branches, but even when applied to
> ds/maintenance-part-2 alone without any other topics in seen, it
> seems to break in an unexpected place.

Thank you for alerting me to this. I should have ran the tests after
merging with the other branches in progress.

It seems my issue is that I use "test_commit one" in two places now,
so the second complains that nothing is new to commit.

The simplest fix is to use "first", "second", and "third" in this
patch, so I'll send a v2 soon with that change.

Thanks,
-Stolee

