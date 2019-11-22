Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB76C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 01:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7120692
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 01:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnBz+zHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVB5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:57:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34541 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKVB5K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 20:57:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id i17so6096435qtq.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 17:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vC38JiLlsm9yYbSyQ5Nv+nwTQFF8KGuz0va4eZQ/8s0=;
        b=HnBz+zHaFh0hA9Oh1xXigUI7v+aovvrUe+WZaKtHzweSmTYcUxmYaSECnHUrtqXSCL
         ibl3tJW0Yg5hBWFTh+CtlcuM+VGrVka0vILUnoUza1NAGUc3EVtHCnnRU4aOI4NLUo2X
         zSzG/oXzGQgBVNmhl4wtsrVr8Y7uKL6uHGLbDn+V7RIC/+kd+dJYfB2pmVfPa4vYwKzJ
         NASMoy9rI8KZIlX8gF1Trypkj1zUMTs99xmW/be71+AYUk0vIOOJAk8MJGWavRapx1JM
         hIO8XwvCCSY/bldK8eo+eNosOMSO+Ykub4NLunjVGO9vf/TjX8THUVhDYjOOPRyHoaZt
         /K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vC38JiLlsm9yYbSyQ5Nv+nwTQFF8KGuz0va4eZQ/8s0=;
        b=lxmqBN3dOAGR+Oj+QfsczMbKlmtlKIeBaRHrWPy03VVi7rvLD9eWIQea8iuCmH87fr
         xbc6pjKPacqlfEE7mlq9Mi8ziutgkAmQPOrpL8+7rXsDE9vmWuJVkFl9O9yWb349q0eJ
         rcCKQEq4LVlJJOeDIwi3CFO+A0tplOrvUSm8dnS2pttNwQ1wx7cBbre9+Ua/XQIE7QHi
         SfEsIswse85nAZ7r92qvN96SCKRigqyoz20pS/YWOLEFWBBav4AuyuYUxj9PVgBdisBf
         1Z4brYxSY7SLU57VRpCiwxPH7hDZqXtxvhaylJZLzOxXydYf+vz3vP3hBoMRQnTP1tcm
         KWoQ==
X-Gm-Message-State: APjAAAWhv1cuuf2Fp/arz0Jvp1I1Tyoe/fc6JEQ7ECyDVeRN5/CYefEk
        GI3PSxb501nS9LXGzHuHDoY=
X-Google-Smtp-Source: APXvYqzKVCPA2k87rOpyKI+/+Di74UKt3ftaHKg8G7bgl+unoD3R4Xb0Xi17eHrqK31LBUxjUToQvw==
X-Received: by 2002:ac8:2ddc:: with SMTP id q28mr3677731qta.88.1574387829347;
        Thu, 21 Nov 2019 17:57:09 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id c25sm2330239qkl.23.2019.11.21.17.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 17:57:08 -0800 (PST)
Subject: Re: [PATCH 01/11] fsmonitor: disable in a bare repo
To:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <9bf5a803e6d44ce1ff03225e57933c97c8841327.1574374826.git.gitgitgadget@gmail.com>
 <20191121231818.GA22688@generichostname>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <837dca23-1681-2111-efaf-e38d603ea3f6@gmail.com>
Date:   Thu, 21 Nov 2019 20:57:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191121231818.GA22688@generichostname>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2019 6:18 PM, Denton Liu wrote:
> Hi Stolee,
> 
> On Thu, Nov 21, 2019 at 10:20:16PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> t0003-attributes.sh
> 
> Patches 1 and 2 have this line in the commit message. I assume it's a
> typo?
> 
> Also, for the patches with empty commit message bodies, it would be nice
> if they were filled in with detail for _why_ the change is being made.
> For example, in this patch, a future reader might wonder why having
> fsmonitor enabled in a bare repo causes problems.

Thanks for pointing that out. I forgot to clean up these messages, and
what I left in them right now is sometimes just the first test script that
was failing without the change.

Thanks,
-Stolee
