Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1469EC10DAA
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90D0208FE
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEK0RHZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIISdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIISdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 14:33:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F6C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 11:33:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so3375684qke.12
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gaB5PhimwU+z31/0b0NozEmimmGSK5JPb08M0RZu7Ro=;
        b=XEK0RHZCXOCeBBrcTMZrLLg3S7Ub0FM5aIuaf2hKHz5XPLCnHbatYzel6Fcop8Cic1
         eeslAFSn8Zb/aGwUxpFamd8z4ISH+ZolUAh7rSVdK9NQG18UUp4qIyPKOjvo9Q5/C80L
         IDl5EgjiSVofb7h4ggAueW02e6CkW8/YMn3Txu+klFXEHswDRXjvH9pj///qJcjUi3PA
         EmJuOwBKGwOgErKV6z1I4/XASm46YHlU/Ci9wCSu9FN1JKBTuk4v1aSCUV+RUeRm5fYM
         tKm0lpLOH34vO69GwclcMgsrjL62K3CMU4XMyVyKep6haL3q2pnGjWt+rCr9YoHdbQm4
         pNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gaB5PhimwU+z31/0b0NozEmimmGSK5JPb08M0RZu7Ro=;
        b=YdPqQnn9GmwrM1ji7LWF5VNczWttGIMAjYbX/tBPi6WoSgBVKBDdDILks7HsJDtYVN
         f4lo510KLuirjFKXkBtQB7GlgBX3eSunIE0AjpZ0pIs7iF0VCdnBEglwuupRF0KBVysI
         0rVHifRjmHe1Q7E3X6YM7Pa36TYqU/ZVoHUkWXRyRrclOQxBVJvDxeCCT8/ZKVnCW3M6
         1kYfjVGKWAEE4/1cxeXaic0AozI1q+Ma4Vrt125dXE/u08JbvCKEB1p54+Ws0bUOsZ1M
         L0QWEmve1zX6zp8ur3nMRiV61CMLmf3Cd1pnXAHuE+fhuYGB8OYCKWXRjVA1yMdeIXgX
         PskQ==
X-Gm-Message-State: AOAM533oCGvWKLMesZi2+G43+cVMFc8YLlebovkqrTPtGxRBi/JNSXCp
        F6s1A2bqHOThD5yrxsOkBO0=
X-Google-Smtp-Source: ABdhPJy5m5tMMjdmOumNmULGgiKiGc2WjJyxDtVMEVA8TbLV2CSxFWynbr5sh2WfUu4cPCGfobHAbQ==
X-Received: by 2002:a37:a00d:: with SMTP id j13mr4623341qke.349.1599676415640;
        Wed, 09 Sep 2020 11:33:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:495f:b5b2:ee15:2605? ([2600:1700:e72:80a0:495f:b5b2:ee15:2605])
        by smtp.gmail.com with ESMTPSA id k63sm3470865qkf.33.2020.09.09.11.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 11:33:35 -0700 (PDT)
Subject: Re: [PATCH v3] blame.c: replace instance of !oidcmp for oideq
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        dstolee@microsoft.com, git@vger.kernel.org, peff@peff.net
References: <20200909131550.826462-1-eantoranz@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c9dd960-b15e-b942-fc35-c1ae82b7549f@gmail.com>
Date:   Wed, 9 Sep 2020 14:33:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200909131550.826462-1-eantoranz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2020 9:15 AM, Edmundo Carmona Antoranz wrote:
> 0906ac2b (blame: use changed-path Bloom filters, 2020-04-16)
> introduced a call to oidcmp() that should be replaced with oideq()
> defined in 14438c4 (introduce hasheq() and oideq(), 2018-08-28)

LGTM. Thanks.

-Stolee
