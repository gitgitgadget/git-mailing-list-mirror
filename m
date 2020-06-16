Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1789C433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911EE207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8V6dpMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbgFPPtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbgFPPth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 11:49:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E81BC06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:49:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so21327721wro.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWhUPNygVVU+TOqFGVC96LtImPLn3u2Pd6ySJjnS9OM=;
        b=C8V6dpMXaYF1ew9rMheXeCfXrXa4vFbl+Z0ir2dDoEyRD1Ic3dXL5bG62jW6dh7lfz
         uefFXiCwVEwz8JcFWmtfqc6nENax1YZpEDKxyJYd2kFoSzB59V5B5ACva6cxJT4pU6gB
         NYjDpl3mcj9wocySEs/pbJSIqgCtiM+UMOkHnq3RZhCx9Wog14HyEttNaWLlk6On7Gyc
         +N6xj/3folJE2IAJV47ARj9w37x1kdJzHBvGwX0ZeL+pys2cptBc9CvXhdupmOIANdZl
         aQ5VS8I1OWjEBgtrIor5s7F/MZssq0WE8rlbBQyjBUE7C7Cf07JWs6m4Ma7BlAVsPWfe
         4miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IWhUPNygVVU+TOqFGVC96LtImPLn3u2Pd6ySJjnS9OM=;
        b=CZgaZPKRW2zTi0SVVdYg4lIhZRUJtcvqS1aNEveL/qy/3unuti4c0rap2CxQCX+tEm
         PV+CY3bc+2Q69o18kAk9v6d3UM9exGCIKyhFsNyv1SzNRWzfhE2yX2KDFAMyDzVQB4gQ
         B1PcawWymRdo6wu5DLqQxVZiPxO7OlCsyuN29pZ1aR9vDWtYUGHPYyw3OVWKOxd760vC
         JTJxyqmNgW/LzNNtjy36IDYtDPEGR+4jlti41/cQQifxytnnFW2vVaPMmIw9RVj6IZKq
         IvKt3pMmxBXJhvVo8WQSG/x3TcBwjXPrpRxb4lYTdhtp00HCSKVTTUkYO6ntKxpxlMA2
         65qA==
X-Gm-Message-State: AOAM532q/mb4UvBG4cXJviyQY58urilu6ZQViVjcSDemT5Ib5Gi0loml
        RZDQ2U5Qpzz0wN2zoV9p15E=
X-Google-Smtp-Source: ABdhPJybtzwBCgzjPigonbvl9xP2Crv24ewFkmcZ3oxS82JmEPQXk6ogzlzHYG4evfzNkdasp4wsUg==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr3806662wrt.350.1592322576230;
        Tue, 16 Jun 2020 08:49:36 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id r7sm4273839wmh.46.2020.06.16.08.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 08:49:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 05/12] fast-export: handle overridden main branch names
 correctly
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
 <a0982afb-8c44-aeff-1839-6e0aa897fcf2@gmail.com>
 <20200616131039.GG666057@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8c65ab94-3b38-f8fc-c969-2d5eeff91ef1@gmail.com>
Date:   Tue, 16 Jun 2020 16:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616131039.GG666057@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 16/06/2020 14:10, Jeff King wrote:
> On Mon, Jun 15, 2020 at 04:05:52PM +0100, Phillip Wood wrote:
> 
>>> @@ -515,14 +515,23 @@ static const char *anonymize_refname(const char *refname)
>>>    	};
>>>    	static struct hashmap refs;
>>>    	static struct strbuf anon = STRBUF_INIT;
>>> +	static char *main_branch;
>> [...]
>>> -	if (!strcmp(refname, "refs/heads/master"))
>>> +	if (!main_branch)
>>> +		main_branch = git_main_branch_name(MAIN_BRANCH_FULL_NAME);
>>> +
>>> +	if (!strcmp(refname, main_branch))
>>>    		return "refs/heads/ref0";
>>
>> This leaks main_branch if it came from git_main_branch_name()
> 
> It's a static that's used over and over, so I think it's intentional to
> essentially memoize it for the life of the program 

Oh you're right, I completely misread the patch

Thanks

Phillip

> (at which point we
> could free it, but don't bother to do so, letting the process exit take
> care of it, and trusting in leak detectors to be aware that it's still
> reachable, as we do for lots of other process-lifetime allocations).
> 
> -Peff
> 
