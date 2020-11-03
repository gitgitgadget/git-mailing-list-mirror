Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0DC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ED122370
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5udLAeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKCOvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgKCOuB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:50:01 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4A2C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 06:50:01 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j62so11771766qtd.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2zkMZdhtPlplul5v76/8PoV45FgWrSvHFTr+GVk4Y0Q=;
        b=M5udLAeXU79AnRQe2gg5NX3swQXuG4YKmdOnYXOKjqi9Q1Vc6xaPD7lfFCFSjT0CGr
         6Pv7FdFpVwDs76yIJaySFl6hvzolNgeuAVNdYOZeo9x4H+DPQV4m9T+KUjkqX84JK1SX
         F4xgo8iiNoTxttXkOswEV+Fhq1cQBAGc8SMC+VaYMXrut79y2RsrCzm5tHE3UiyLyFtC
         JQMWJw1OyDhyPMdBrtrCyiG1Rfx2jf7D5lNDHSndLTTn6CL7WzpUZjscES2QfcpZLfZ9
         qrhE1E848IANbklO8TsL2Lp29B3ASfHGCD46byfw7ScJGRNjrJ2qRe9rvbWpLz1IVsge
         ePOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2zkMZdhtPlplul5v76/8PoV45FgWrSvHFTr+GVk4Y0Q=;
        b=ebkjsLDEkYkgVvisiCjDhgrK4ySF5rkof5D4RV7zrYhj04ExbarjbNWoCdbeXr5VS5
         J9uz317272Fgbu0JwekdhC81RPipayKsylapiQPZt875pWXaAMosOQ3M+h7w2vBqHmAm
         bFNg0AHYqajW8HDjIDOYijKiSDx+elLxTqFEXs6yw6DEYGE0JwlOC/jXlCW31zuuFmqk
         vQecftONkAHXY7hwI2jH/VlCKAoEzRpPhahPTEp4kNFCRDBgPhiojHX0kOMKYv6KZAd8
         uhMsnTo52oMDC84b7ooklbm1eauC92zUSh+j1sW1Ti/UfiF5rmlbw/7Gilt17yNYBgw4
         NmPw==
X-Gm-Message-State: AOAM5332MvKKjMdwExQNY+nV/dKGRm2XxKlBOTFfTt8dJWZLBg0bMhHv
        0knxVFP3JI1ozq+jco1LWiFwsslrFrxc1w==
X-Google-Smtp-Source: ABdhPJzHdtoF3zHt//AbM3oi9yAPSvEFC+dqucNLhj6gh7bg6qjjac8XdWCgLc8ivdR0zaXwv9wVKQ==
X-Received: by 2002:ac8:4791:: with SMTP id k17mr20325538qtq.264.1604415000129;
        Tue, 03 Nov 2020 06:50:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id m6sm10453177qki.112.2020.11.03.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:49:59 -0800 (PST)
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
Date:   Tue, 3 Nov 2020 09:49:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> This series depends on a merge of en/strmap (after updating to v3) and
> en/merge-ort-api-null-impl.
> 
> As promised, here's the update of the series due to the strmap
> updates...and two other tiny updates.

Hi Elijah,

I'm sorry that I've been unavailable to read and review your series
on this topic. I'm very excited about the opportunities here, and I
wanted to take your topic and merge it with our microsoft/git fork
so I could test the performance in a Scalar-enabled monorepo. My
branch is available in my fork [1]

[1] https://github.com/derrickstolee/git/tree/merge-ort-vfs

However, I'm unable to discover how to trigger your ort strategy,
even for a simple rebase. Perhaps you could supply a recommended
command for testing?

Thanks,
-Stolee
