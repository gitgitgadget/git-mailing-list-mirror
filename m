Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8389FC2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABEF20724
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzlHgmli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCMMnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:43:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40736 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMMnv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:43:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so12148050qka.7
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8qHq7/XOdXp88TTkGS/MvVojX4RkOVOo87diiD9U7qk=;
        b=hzlHgmligTmm5rBouthu7/CxkdkrxKSRYtX4aZiKc1dj5Jt9/rwLtoSShMqaxHwcK/
         wjDfvB3OPlwPtCTneAZ+4z9TW11L4PRXdsFQZAR5bThYAIHgDywwjB29f1ESWLr6bCNH
         tY32Nc/q1S0351EgXa+Bciy6lUgObdydRyUAaecRWp+Gz8ixry4WId4/cVVH717siAP/
         0OtX9zRwLEEnSB5GgAU2iixxtekvez7gFKrVFIQizd/GHhHCnet2WTPg+OLmF+4/BfGt
         PazJji8gPHB2iPV/2lzvSRFV5PUnuWukiH1VY21OCGFANPbQz9vcIeqohCHED7GML04d
         k1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qHq7/XOdXp88TTkGS/MvVojX4RkOVOo87diiD9U7qk=;
        b=TkrnpJAXnE6wgB2NlgUNAWCMichTKZOCTMXM6QLEbNPzmu2doojHszl5H7mkZK7KUV
         Tsl4f7HRB3ZXalD8QWVv+yxPOwEESZ3Be/4ktWxDFrjZ97BkxAw9ao6cTDrITAV9q/j8
         dEOrh8YXSeiZ6ORsaSey9HuTcUGelRyA/65cfvsat7o67xgPZyCLyU6h+GvP9zfrdWFw
         V/kF+P74OTzgGZphGCfyWAmI2Nygxl6DfE2JFxc+kaXeEvjyAx6X43siX/owyhnNCTcn
         y6fottE4+20p/suWTFr8XNfMVPTHybcVaWi1OQYcTPbLvxR1PHcXrjZ5uIpiHIyKlkZx
         FbXg==
X-Gm-Message-State: ANhLgQ0GiWPMPyFFbVebdEs/JKYt9QAycNsI2Ar8qWpg/nlbosjNgh8G
        DJzu+NaD2FU0QkQUSIXjoy4=
X-Google-Smtp-Source: ADFU+vtxt2HbYZomBex38u9XYDAasEXJzx+ROwcMIoLKrQiogZyxqogXShrt2ghLt+y75TVlhNDXlA==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr12856973qke.494.1584103430603;
        Fri, 13 Mar 2020 05:43:50 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m11sm26142677qkh.31.2020.03.13.05.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:43:49 -0700 (PDT)
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <xmqqzhcle23x.fsf@gitster.c.googlers.com>
 <20200312211638.GA872402@coredump.intra.peff.net>
 <20200312212613.GB872402@coredump.intra.peff.net>
 <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com>
 <20200313023034.GA900007@coredump.intra.peff.net>
 <20200313023427.GB900007@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8eb7c0f3-0667-2eb7-7101-5790bcff784c@gmail.com>
Date:   Fri, 13 Mar 2020 08:43:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <20200313023427.GB900007@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2020 10:34 PM, Jeff King wrote:
> On Thu, Mar 12, 2020 at 10:30:34PM -0400, Jeff King wrote:
> 
>> So that would actually argue that your patch is putting it in the right
>> place. It's _not_ fetch's responsibility to reprepare_packed_git(). It's
>> the loop in check_connected() that is skipping the usual reprepare
>> logic, and shouldn't.
>>
>> And one fix (which you did) is to just preemptively reprepare right
>> above that loop. Some other solutions are:
> 
> I know I've now suggested that your patch is both wrong and right. :)
> 
> Just to be clear, at this point I think I'd be OK with either solution.
> 
> If it's going into check_connected(), the commit message should argue
> that the loop there is at fault for not doing the usual fallback, and a
> single explicit reprepare() is cheap enough to cover the case we care
> about (and that we don't have to worry about racing with somebody else
> repacking because the point of that flag is that we're in a brand new
> repo).

Thank you for bringing extra clarity here. We don't need to put the
reprepare in the fetch logic because _most_ kinds of object lookups will
reprepare when failing to find an expected object. This loop is special
in that it is restricted to search the promisor packs. And, because it
only happens when a special mode (opt->check_refs_are_promisor_objects_only)
it is reasonable to assume that we are specifically in the case that a
pack was added recently.

We could save some work in most cases by repreparing only after failing
to find the object, but that also makes the code more complicated for
low value. At least, that is my opinion.
 
> Repreparing earlier in the transport-helper code _could_ still protect
> against other similar loops, which is an argument for putting it there.
> But I'd be inclined to say those other loops should be corrected.

Right. We should make it the responsibility of the code that is scanning
pack-files that they should be able to reprepare when failing to find
"expected" objects. This also handles the concurrent repack case that
Junio mentioned.

Taking a quick glance at the callers of get_all_packs(), I see this is
the only such loop that both has an ability to "fail" based on an
expected object and doesn't have a fallback to reprepare.

Thanks,
-Stolee
