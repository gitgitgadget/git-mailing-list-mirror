Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0256AC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6A4206CD
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 15:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acz3kg78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIAPAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAPAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 11:00:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2EC061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 08:00:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v69so1208919qkb.7
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AAnJNStTDHv8k395sagL9T9eBKmU/KV2KTohT5f4Ct0=;
        b=Acz3kg78y481gi+SkC7Xkn241P2H66XQ5g3DtLtnq13pOn4behhQtRVeKmRHrud3ZQ
         /RbpU/Nv5wYWwGerZxlF3aetOuQ32egz5eqaiuB3T9vR69JIawTNc/n9/WtsVeidgfDi
         rc9eq+e6Ghil4+mS4vXof2twWEFsZD3UshykbqUG21vZ7Cz1jACotu2ALhw4oaHdcpIw
         NqIpPNz4//uyr1HlMrS58RWwCPvV3X+SlsJagb7CsHP4HQevIReM1RgvsWacEZKY0/nf
         t1QOK3tKUZsFRZkdIauiHr9J7Z6UhTSxyoF1q/K4o5IlhxW7DFlQXqgNcqrm1MIsGMkg
         3hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AAnJNStTDHv8k395sagL9T9eBKmU/KV2KTohT5f4Ct0=;
        b=PLD724k2hbP2+o06ySWztadHtK8eRUal0Ovz3aPslvsl6GYyD9YLwmu/N8ZtuwYFXH
         NDTtbSw3p/fqHHcMTR3RQsrFWmlOObRWmAJpGSL+vOgdSla1lfiRo9Pm5+0+jMWthDe/
         MYG8Ndwso9AbFX7QznUlSb518yziKKRWXd2vAeGvj1Mjn6J/CIqldJ5+iB5yZUsf04iU
         zkHU41dVx58A+E8pNr7Pv+DOfZQnX6SSrWqVKUMZbvrDuw9CAdKEXat2E7WZv6Q1LZkN
         ZryP+w5NQlnN4hXoXN2ArTkp6YI+kJqVd+9uTOElqMuHOzSOSVyiTVBRJN41dpuSnxOy
         v9YA==
X-Gm-Message-State: AOAM531CdX0ETJh6IY6CDfK0acWLz9kiSdqFfO5eFjfjOCjdCjEao7SF
        Z4fQkdsPWZYWleP5Bmc/nAY=
X-Google-Smtp-Source: ABdhPJyo9TickN+mL1ZEAbmCAXoCfstaVDDlS74+N45ws2sFocaDXOEx+nJvgyGMO6kPn2zv0UKbsA==
X-Received: by 2002:a05:620a:200d:: with SMTP id c13mr2211081qka.499.1598972399130;
        Tue, 01 Sep 2020 07:59:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:95ff:3ea8:b521:d74f? ([2600:1700:e72:80a0:95ff:3ea8:b521:d74f])
        by smtp.gmail.com with ESMTPSA id a52sm1756831qtc.22.2020.09.01.07.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:59:58 -0700 (PDT)
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20200901074355.GA4498@dcvr>
 <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
 <20200901144323.GA14554@dcvr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cbbc6d40-7126-cf28-aeb5-46b72b7e6d08@gmail.com>
Date:   Tue, 1 Sep 2020 10:59:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200901144323.GA14554@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2020 10:43 AM, Eric Wong wrote:
> Derrick Stolee <stolee@gmail.com> wrote:
>> After we decide on the word, this patch needs:
>>
>> * Updates to Documentation/config/core.txt
> 
> Will do.

Thanks.

>> * A test that works with both hash versions.
> 
> Will do, though not too sure where the tests for this should be.

t3404-rebase-interactive.sh seems to already test the
core.abbrev config value. Could be a good place to provide
an extra check.

t4205-log-pretty-formats.sh could also use some references
to core.abbrev.

Thanks,
-Stolee
