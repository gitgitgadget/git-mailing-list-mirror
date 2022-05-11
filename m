Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD9BC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 22:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbiEKWfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiEKWfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 18:35:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB366712EE
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:35:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h3so3122839qtn.4
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XGY9qgDzvfQ27lj+xji2VXY9q8j/kqUZ19IaNNM2TjE=;
        b=deUmHa3B+c4SGkAgewIpBNYENw4We40VzKSKWMQ0hCGUuUGwON0z4agifZMb3t/dSi
         vIyPzWy1GqKMtrLn5wt1aO+Cl96HkseKG8mGbrZI1Ftg/FahgUI7zcE7M5tKl8vXjwh+
         OOCZ8dwm66z7jLbj3UkMI3ipeOBuFDzcAmJ+beiPsrUnnPpBkNBmeJ1z7ltF87crIh+Q
         etDYaRl7gpZmgnpb8zCPZXenfxFGFagBHoFvRviXtKktaAnMnqxu72wSabHf75y1Oev6
         dStnIJ6yldX9Dg05NPH+JxXctzskugEdWsXzUZYw3WWrduVJo9aZTCEAeM846aSOPEjb
         aKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XGY9qgDzvfQ27lj+xji2VXY9q8j/kqUZ19IaNNM2TjE=;
        b=UeqzZQQIPzFOT7s5Z/y7CEy1yPg3EpruR4C7wKnN+yJlvpG9UVsigISDrEBDu7N+3u
         oL9YSt/C8mMCV0m9xcfLpOr/Bcg1YIU9KjQcb2uq3lXEO82QIeHU8eQZeF80InBnOQDH
         p3AMxyrH3QO0RuvMKzEePIS5YHCrsYvJ+a3S3+zvSjhWxZb1RQ31Xi39Fbr7e14Lm365
         vxYqpfzexV1QXSvl+g/1vB9suQesDwLRc9CZucSMjYKDeaanaieDKdNPt58RlOJFIjh0
         tr/yo5JGDgs3+Zb5qj12vgc/1NA4lgZaQRmT7yAk54GYF355whDrnLDVMjl5nRVa7NVC
         +LkA==
X-Gm-Message-State: AOAM530DdzYmEzhhSoq1aDfwkwGfT+RDhQBvdctev6/RsWLsaTKJLuu7
        h9jDO9MGgj3wp0XbWVDN/w5CnoFIko+QIg==
X-Google-Smtp-Source: ABdhPJw+Pbww+hFEC1Csdgwt5BJWX2VHyKBgQDFBdx/bfHf7xfTXL1dQEZEucWrrb2QJciJdnPoPww==
X-Received: by 2002:ac8:5812:0:b0:2f3:f380:f0fb with SMTP id g18-20020ac85812000000b002f3f380f0fbmr3717710qtg.367.1652308535678;
        Wed, 11 May 2022 15:35:35 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d188-20020a37b4c5000000b0069fc13ce204sm2036212qkf.53.2022.05.11.15.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 15:35:35 -0700 (PDT)
Subject: Re: [PATCH v2] pull: only pass '--recurse-submodules' to subcommands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
 <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
 <deafd5db-6303-46b3-a5d5-b4117ba16781@gmail.com> <xmqqzgjnhf5u.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6e59a82c-22cc-8f0c-f7f7-94da59e8da89@gmail.com>
Date:   Wed, 11 May 2022 18:35:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgjnhf5u.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2022-05-11 à 18:34, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>>     pull: only pass '--recurse-submodules' to subcommands
>>>     
>>>     Thanks for the debugging help :)
>>>     
>>>     Changes since v1:
>>>     
>>>      * add a test that actually tests the precedence of the config values
>>>        * I've kept the previous test; it has always worked, but it still
>>>          seems like a useful smoke test
>>>      * reworded the commit message slightly
>>
>> Thanks, this version looks good to me. I don't feel to strongly about the 
>> title either, so as you wish :)
> 
> Perhaps
> 
> 	pull: do not let submodule.recurse override fetch.recurseSubmodules
> 
> more clearly expresses what it wants to do (not passing the command
> line option is "how" we achieve that goal)?
> 

I like that title, yes.
