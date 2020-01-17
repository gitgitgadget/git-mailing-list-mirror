Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1407C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26EA2064C
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIu75gBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgAQPU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:20:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42122 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:20:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so22985928qkg.9
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 07:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zicKP2mTygS71vvhzpA5ErpSLvdM6IWv+CsGCmxp4/c=;
        b=DIu75gBsGeKx+p3fdxcSV2TjM3asOqykjhB/lVfSjsU9Wzw/l4fyAifRHYqvKW7BQz
         rtQ1IWL3y4CZArqIzeV7q8mX9TZq72E7D+zEzYrKy1NEzE/5J2+W+wSbmn9k9oLeOqDk
         T258wUSun7MPYgAb8jRe6Xa0oSWRswKkxBVuFHi/CAImd+s5NYiTRqw9a6iIbLXH/Ty6
         4elcO96pQ7JYZkz3vwpoqxMQvnrfeKVvD/jmjCLjy207tgRTRhx5l1NTnDRzqvEK0f17
         mEMNespZ6oPHQb3hvC5q4o3piHrEy00JBSbz2MFl4NTndvD3bmBnioVp/bYpP6aPRHql
         QF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zicKP2mTygS71vvhzpA5ErpSLvdM6IWv+CsGCmxp4/c=;
        b=NOxlmwXOPlx1e4Xj+YFjfEdnHwYi6fk2xNm+zAnrU/FekOaAzOf4BrpsnXtj0eSxHP
         VDDbxXShmkVxZQFqR/gtPZyS3iqrv5HpZD/RCaGaLfjCoxj1N5qstlyuG4zsTXW/g8r3
         gg/5/2HQgs7cehZTpDOW9n83oKQbTM4jzlH1wVpRsaXDYa8835WyM5SIW2k002BhN0Kh
         0xU8jdbqQfACBfz2DGuaq0ejyxan4tBiKWam0+vXpXmAZpDvskCxt85nmDquoySCdsLO
         wNRyOx/pe5IlZwzZqgunCUUxmedDp6gFG/sphIIMOVkDrqcSDjJ0vj7U5VjMbj7K0Qno
         m4Ug==
X-Gm-Message-State: APjAAAWWPjXaeJmQ11XZx7DN+J4hV83nPWsvvm8mRpaLLtO6yCv9utQV
        8PBtdNChyAO8b7p9Di/Y3L8=
X-Google-Smtp-Source: APXvYqyZwUyzdH1s34vs60jO/71GTRbjDbuQXnbHX2F8b6EkG/c2HQGWVeBPP1yPkDMeNAYKoLH0jg==
X-Received: by 2002:a37:4b93:: with SMTP id y141mr40387373qka.205.1579274427594;
        Fri, 17 Jan 2020 07:20:27 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:64d0:3701:c4c7:2368? ([2001:4898:a800:1012:1604:3701:c4c7:2368])
        by smtp.gmail.com with ESMTPSA id o6sm11661762qkk.53.2020.01.17.07.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:20:26 -0800 (PST)
Subject: Re: [PATCH v3 1/4] clean: demonstrate a bug with pathspecs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
 <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
 <9efed585ef7a1c09ed62998882236e7dbb58383a.1579206117.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <37815f50-35df-ef02-4def-ad857fd55520@gmail.com>
Date:   Fri, 17 Jan 2020 10:20:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <9efed585ef7a1c09ed62998882236e7dbb58383a.1579206117.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/16/2020 3:21 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> b9670c1f5e (dir: fix checks on common prefix directory, 2019-12-19)

Thanks for fixing my typo here.

> modified the way pathspecs are handled when handling a directory
> during "git clean -f <path>". While this improved the behavior for
> known test breakages, it also regressed in how the clean command
> handles cleaning a specified file.
> 
> Add a test case that demonstrates this behavior. This test passes
> before b9670c1f5e then fails after.
> 
> Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Do we need your sign-off here, too?

-Stolee

