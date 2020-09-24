Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83E1C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 13:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B84F206CD
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 13:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osEShlh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIXNvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgIXNvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 09:51:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE32C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 06:51:11 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u126so3654803oif.13
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YxNUe/lQNoBycy2wuC0kveAMifVsRA9X5qH0YopvmK8=;
        b=osEShlh1ggqTBs8Yim10DGwdjVvFCLQuVwlPCfmZiXt9YrLJIQYTU9KqrZADS9Fgi/
         //lbPiP7elsKqOMsuz45bbSAeU7Hs0WfPh3V9XfsPrnoeD8TI/Fex4sLxkkVbIJNHL1t
         QipV39k880eoDKOi7SvbbvnTydpfnZY5xGsdueAq/1gD060PEPQ1ONYmyCggVLpTH0/i
         aiLK+PtkTTybLzQzqjvCCLbuzyW+e5mN8/0IuBodNNksrpWGp9+lkrDmOJ/8+XYCehOi
         lUN7z+plu8JMA3l+rwpAHuUCplA+AfHgCJuLJTFqebbBdipvCY4z3jAAA9/f677hgZYA
         L7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YxNUe/lQNoBycy2wuC0kveAMifVsRA9X5qH0YopvmK8=;
        b=ElqR+hEwBh3G2aZxBl2bdVROMaS+pcrhP2odPAstIMZxnm8hm+QlWRkG6Dn18aV+1o
         1hNYhg4XDySDktJDmXveH9nPLGuBQHdhidjysgVG1LQaafjpPZzTWsdp5rWLk7cYDGCX
         f/gRRnTza4eEtlTMju8hZ7ZUsaynzeWp4mUvAMagIgH7S68kgwoj8gOQT1kRPta2U9Nv
         yOEO/kv7BuJMKOPmtFWCmpXB8ZDfv0w6NfoDUxajD4JDK4+LBkLtABgWLr1ryHrSyeqZ
         2jTzpw+rMZRgvgdsIq3dl+Xigvnjqc+J/QMo57LvxzQzqV5JdVIDcRhHrgmiZrYcAblx
         wGQA==
X-Gm-Message-State: AOAM530AfoMxR/xVlFBV4HIp1nG9b+Ih160sCqKOr2Yc+QnnfZRbXnJt
        tXzc6ezVfoLf2QsrYEoplkM=
X-Google-Smtp-Source: ABdhPJx178I/PnO4Bh7FvA82Fk0rYHLo/oXc36luBLM2USbwHKT9TQ7nbXF9us/ArpCCtACsv8HPxQ==
X-Received: by 2002:a54:440b:: with SMTP id k11mr2570386oiw.137.1600955470434;
        Thu, 24 Sep 2020 06:51:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79a4:d6bb:a424:ecd4? ([2600:1700:e72:80a0:79a4:d6bb:a424:ecd4])
        by smtp.gmail.com with ESMTPSA id r21sm652009oie.15.2020.09.24.06.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 06:51:09 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] maintenance: create auto condition for
 loose-objects
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <d6e382c43effe063fb1137659f616d414ee52682.1598380599.git.gitgitgadget@gmail.com>
 <20200922231501.908887-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07500c68-9fe9-008d-41e7-51a4a1ef4650@gmail.com>
Date:   Thu, 24 Sep 2020 09:51:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200922231501.908887-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2020 7:15 PM, Jonathan Tan wrote:
>> +test_expect_success 'maintenance.loose-objects.auto' '
>> +	git repack -adk &&
>> +	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
>> +		git -c maintenance.loose-objects.auto=1 maintenance \
>> +		run --auto --task=loose-objects 2>/dev/null &&
>> +	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
>> +	for i in 1 2
> 
> Any reason why this is run twice?

I think the original reason was to demonstrate how two runs interact,
but then that was done in the middle of the loop body so the loop is
not necessary.

Thanks,
-Stolee

