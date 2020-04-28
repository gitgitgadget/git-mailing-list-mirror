Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334DC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 12:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1F0206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQnX/CQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD1MtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgD1MtC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 08:49:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B6C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 05:49:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w6so20127621ilg.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WvjMPihIAHechV/R25Am3HcX9HFGS8fuSsMMzfJiC2w=;
        b=GQnX/CQEBAE93zw2LdLSGQn0rztREaZPYuz/z6bes1ui2UqNIwQqwSpIgtVvO/C5am
         LigbK4I78JV1QEn/Ne62s2jiXfqJxKQKmdhJrljds6WaBtwVGaF+NN4TcgkVTcFN8rbz
         LnDbuVnX2SxckGk+y6na0NXrxxEzYiDkP9/aSGv9pmFllVmLapzMdRAwcKlvJQ65QenL
         XMPE44uG0ZHHn8LQezW4lUK5CZpcbtZhBcLnOWTMEC4k/TyvYLiWx7HBz1IcUEfTwLRg
         f0kquE0LyM32FsOyqdPNLO9hOM1k4YS32wcV4CTUMpYhzMO6rF8Q8JpKhCWxPqzP38bZ
         EU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WvjMPihIAHechV/R25Am3HcX9HFGS8fuSsMMzfJiC2w=;
        b=jyIRfFJUUyl9ZkUSgx6jT/NKq63n/debwxhzEWmoJeuevBn//t+Ix0y2kly4s6R0q4
         RwglkJx2vE8vh9ohkdQ5AD5hnDN1XkxARgswHv7mxRw25NwYScAHwH17RZRVu7GROV21
         hFZcN4vaTW2Cw/8ulXaUrqG+BkiqlbESUgZMZ3fPsvFWpPGxYppzoPZb8BVtMJZ3mljH
         etD5QqG9QDiT/B3ezOt5JPSxa12grM1RwGWPhQWY94TZCrOsJlYuqx6/+9o/iEaAEIgq
         pXdGPyJ6N778aLlr1rqIiJUbvoCpPjof5+UZGt9R7EXsDFWK/jsDIBxq5y0ouPqUG9MJ
         UHXQ==
X-Gm-Message-State: AGi0PuYE2mwQS0bx5RNRVW/DaZ9U4FqugzHSENlkOHYJKdh5vMxj6XMe
        Hybxz/FO75E31j1E1jGqhdVIrLDR
X-Google-Smtp-Source: APiQypId4i/Sh0GYfXERGYBcMtp70FzcognWzGFeooKNXn9hrjDaTB9AYL/ppbzq5PNdk8/ZCind7A==
X-Received: by 2002:a92:5a5c:: with SMTP id o89mr26217316ilb.47.1588078141623;
        Tue, 28 Apr 2020 05:49:01 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:6545:71b9:a2ce:487e? ([2601:8c0:37f:6012:6545:71b9:a2ce:487e])
        by smtp.gmail.com with ESMTPSA id n138sm5839562iod.21.2020.04.28.05.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 05:49:01 -0700 (PDT)
Subject: Re: [PATCH] Teach git-rev-list --simplify-forks
To:     Derrick Stolee <stolee@gmail.com>, git-ml <git@vger.kernel.org>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <4ee983f6-402f-85bb-25a8-75b39f07cabb@gmail.com>
From:   Antonio Russo <antonio.e.russo@gmail.com>
Message-ID: <070c07f6-5b36-89e7-a9fe-9bd321fcb97e@gmail.com>
Date:   Tue, 28 Apr 2020 06:49:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4ee983f6-402f-85bb-25a8-75b39f07cabb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/27/20 4:55 AM, Derrick Stolee wrote:
> 
> This is probably because the tests run a second round with GIT_TEST_COMMIT_GRAPH=1, which enables the commit-graph feature. This triggers a different set of logic for the topo-order, which ignores the logic the way you inserted it here.
> 

Thank you for pointing me at this.  If I now understand correctly, the commit information
is not yet necessarily loaded for all commits at this point, and therefore the logic here
will need to be called later on (and makes it more complicated).

Am I correct that this loading of parents happens during traverse_commit_list_filtered
(for the case of rev-list)?  Also, am I correct that there are not yet any hooks to
filter out edges (of the graph of commits)?

Thank you,
Antonio
