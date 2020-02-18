Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A9EC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC120679
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 17:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9SdgzpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBRR6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:58:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35898 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBRR6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 12:58:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so11039998pfv.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ffT7mcRr5b/8t2iSvez+fkTueVTwWNvSJzA+iZoDSLo=;
        b=C9SdgzpXwNp4d/+D36Lk34OXGl1QrXFluF13j8uDJkE+FG3NbMi7tQ9IQB7pvz2xrG
         yVl81GPN2uqonv7VLxGl2VMHtUJZNMn+jA1dFDX/Hm+fxKM7JJmPLedQojb+37WtIk9a
         xf2yXST+JlDcCTZepOd+nsWqcb3YW0u64nH7V8lUXDL7tOHTMXAkkPgTaZbTYh02QqJO
         WYzhvtmzIMPSiVUwN34h9XCXmdcRDHu7u7bVgK4zuw1Tf+m7zf8+/zNS+RUv0QpQhQpF
         5viG2qAp5Ik7d6uFPgwoDUeB0QHCItB+H31oinb/ZHvZrwWMO+N9fQ23SpIl4Olb5JKZ
         xQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ffT7mcRr5b/8t2iSvez+fkTueVTwWNvSJzA+iZoDSLo=;
        b=OgitFAWwP4AqZ6swRnFjKK4jEEmJKaq4xYU8pzC08V393z1GysFP/k6je78lqTvCfw
         Gq/88ziqZ1Fyrj7RVgvCQPth6qPVW/Z8KUirrohiHeOoObdgdJslLbg1Z7b3THvFqPYL
         gOFfVsfijaoUWbenzlIGIw4Gsti0NODqlfDpGeqi88RkbvLSe/4qBtn3Fs3yh3hpB5mh
         h6DgMKqLL0g9R+rHcs0gWrb76jPEzIa3LkgX3fEFTJ2yWYHNVeZDj5Ls8d7P0WO+Jd7B
         BEd7Y6mmUibCGo9pdaIT1J0jgaseFEGYj+QiskMCLlx1/jkbFr9yWsP147yde62DWPsf
         oZ3w==
X-Gm-Message-State: APjAAAVi5ooM9EL3ZS9AXFM6q94lm1WtT6H1mLu8p2A7+dGd/0mvqpC9
        PaFnfXXfnkgUF+apnvRmHug=
X-Google-Smtp-Source: APXvYqwLvuB9paV0p23Kvw7v0K8dP8yR2+/de6SSTx0kfSETMCa/JqsFMrXtRvYE3uhmLM1VfK80EQ==
X-Received: by 2002:a63:7213:: with SMTP id n19mr18025218pgc.162.1582048694202;
        Tue, 18 Feb 2020 09:58:14 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:493e:b22e:e9c8:d09a? ([2001:4898:e008:1:d27a:b22e:e9c8:d09a])
        by smtp.gmail.com with ESMTPSA id x10sm5043100pfi.180.2020.02.18.09.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 09:58:13 -0800 (PST)
Subject: Re: [PATCH v2 02/15] pack-bitmap: fix leak of haves/wants object
 lists
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182211.GB150965@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28c2f199-e9eb-4405-9044-92a0af7632ec@gmail.com>
Date:   Tue, 18 Feb 2020 12:58:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200214182211.GB150965@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2020 1:22 PM, Jeff King wrote:
> When we do a bitmap-aware revision traversal, we create an object_list
> for each of the "haves" and "wants" tips. After creating the result
> bitmaps these are no longer needed or used, but we never free the list
> memory.

It's surprising that we got away with this for so long. Is it
possible that this loop of freeing memory could provide significant
performance drawbacks? I'm assuming that the free() loop is much
faster than the malloc() loop, so the impact is negligible.

Thanks,
-Stolee
