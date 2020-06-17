Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E3C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BC72100A
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c174N4k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQIm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgFQIm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 04:42:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF47DC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:42:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so1420317wro.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95G7C7viJycddmve3cahJ3CucDcr+NySBwdGQb2ugMo=;
        b=c174N4k9EzddSGL9oWNhBRT2Cew4YfOWa1XfU5mx/zWCOv3JgyGBvdK/pmXMHOPv9I
         /gTsdSyKNxO4G4k9n8ips4j7UN46Tu3/Nkzbraulcla1KjRhit50mV22oQIVraPPWNl0
         W4S47JRyvS4WJOqyti0ZzVCPIlJ9k2k35ZWD+hHRisGjjseEnAPXBn+Smc9L6Q04jxCc
         NdK4LYCr2TRQHk1TUKHykkmuVUuF0m0xbQEGtKoHHCF9yIRLHQKyVuJCZLi4nNx8FHcY
         zEvy+rNkWi4xlUlH7WOafiTTFsbjYi+CkLY2MLKIW4sXqPjgvL6rNjrOWhMyG1J12BVn
         Sl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95G7C7viJycddmve3cahJ3CucDcr+NySBwdGQb2ugMo=;
        b=WuHe+R1D81ZZx/WA87rAUH++YAUQFAQcimxbL0EEkDx/pesD+gNyymSMIF6Y66G1fX
         1gFr/8NfTCRAWNu3lDlU9sfYmKwgkLronuFCOas+oOikRmSlPGzr1iDcmUU8kJk6oIdq
         wxDCLxOkmIuW8a3PHa/oDM5mPf2o86fy69rhInuqmchrz/NQ/qtFE05ipruvEae2l2LS
         X8kVY564qXyXNeKyrHsIbycaYDX+o/2RfZW4GjmSUaZSzMzfsO1q+3mb5V84ftuJUTtA
         pd+1TTMiC+fF4+KQsAkZVhRwlqjOuIg/BVjqCWNC9hTtPoJ8dTESvwQW4AWPYJwBJN1K
         MRHQ==
X-Gm-Message-State: AOAM5334yldIvXIutAwA1O76STggjb0hrGPR+0leua+REQgyNg6XYMux
        7mx5qIhbn4HcrdQvP1u/lELjnWEU
X-Google-Smtp-Source: ABdhPJxg2SxlsDWa/qSzC++pkr5ppXcOBusWOqWfd5Pw5nze/Nep8Tzc7sSuWJC3o6ZZKu6xDH6R+A==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr7155391wru.268.1592383347199;
        Wed, 17 Jun 2020 01:42:27 -0700 (PDT)
Received: from [192.168.101.24] (102-182-251-152.ip.afrihost.co.za. [102.182.251.152])
        by smtp.gmail.com with ESMTPSA id h29sm35346391wrc.78.2020.06.17.01.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 01:42:26 -0700 (PDT)
Subject: Re: filtering on git fetch?
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <f6c1377f-6945-b04f-07cf-887c4b7c9f76@gmail.com>
 <20200617083423.GA695303@coredump.intra.peff.net>
From:   Noel Grandin <noelgrandin@gmail.com>
Message-ID: <e3ec6fec-b872-b548-0eb0-d085ca36c99b@gmail.com>
Date:   Wed, 17 Jun 2020 10:42:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617083423.GA695303@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2020/06/17 10:34 am, Jeff King wrote:
> 
> The ref advertisement in the v0 protocol is unconditional and always
> complete. In v2, the client is able to specify which parts of the
> namespace it cares about.

Thanks

I tried (BTW my version is 2.26.2)

$ GIT_TRACE_PACKET=1 git -c protocol.version=2 pull -r

and the first few lines look like

10:35:59.323490 pkt-line.c:80           packet:        fetch< ad0351b84926075297fb74abbe9b31a0455782af HEAD\0 
include-tag multi_ack_detailed multi_ack o
fs-delta side-band side-band-64k thin-pack no-progress shallow agent=JGit/5.3.7.202002110540-r symref=HEAD:refs/heads/master
10:35:59.323583 pkt-line.c:80           packet:        fetch< baeb5486c43d39b063371f91cfaae8efc2c8700b 
refs/changes/00/1000/1
10:35:59.323592 pkt-line.c:80           packet:        fetch< c5fb3d3f110f652e3c4b3920f71b7f77c227028e 
refs/changes/00/1000/meta
10:35:59.323597 pkt-line.c:80           packet:        fetch< dfbfb3c4d4cc7d7f519c197ef5cfa250c30b584b 
refs/changes/00/10000/1
10:35:59.323602 pkt-line.c:80           packet:        fetch< 5955e7d66d9b0e87f93fd9746a85bff132da9794 
refs/changes/00/10000/2
10:35:59.323608 pkt-line.c:80           packet:        fetch< ae3baacef7926d9ce9ca4786176f404b7cf78cc1 
refs/changes/00/10000/meta

Is there something else I need to do on the client-side to make this work?

Noting that the git server at gerrit.libreoffice.org might be a JGit based thing, so maybe I need to log a feature 
request there to support v2?

