Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5CFC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875D620772
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 11:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYHuJqrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGILOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgGILOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 07:14:43 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F748C061A0B
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 04:14:43 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dm12so734142qvb.9
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yvyAsvVi92h87cmWIRddvQIrGngCrsc3V1We/8lZRLA=;
        b=vYHuJqrBPn3UajCHjP8hEO7c9uLEkIBQJIa2kOugbfCQ6UDvD4YskCv+mwpJWV7WlY
         jZRjDy370rW7Hzx/dPcfrBHLbtSX8SDp2LCExj6gq2LDX5Oo3wuUyU4d8aCKeNHy5hqm
         HrI1sujBFCdVewO8kzq9xEfYh0mFB7yGGTNLwKaOXonZzsDbKMkDcYFEKZPvsVGQ3wlf
         KR8CSlZtLiOmGOLAVlByi7yt4S4CJIaHp4N2+5LZ++Y92mN9UTlYB3OGkmXSyP4TSB7W
         ESlYYhfwHJmIGr2M9w6dCUKtMj8aDbzz/8u3wiSzWmtQq6Hwba2iAdswpMqctNJIofxm
         Y/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yvyAsvVi92h87cmWIRddvQIrGngCrsc3V1We/8lZRLA=;
        b=EUAhGCWEAaO7H3EoZ7mGARQD0oFtXQdkmm4n7DhheoV+dUUHEPxAcOAMySTbOlt8kh
         2nJaJpNv57rRsBQO/u+SNOFwStkDk/9isSRtanLZRbw0+NfVKBm9f0kM+LbgfHGI5+Xt
         d4Ee2ZJfI05DCl1vVhEpd+EBuA69ugbst924va6iv2T6OZ/A1cR97DGMk8ZNBYVxRgdI
         NexYttZ6t9clvKtYKhRRxA9JPHOxnNJhAtsE/vYwmBkT1GnF1uggvh8uJe+tiHi22ne0
         6m+RCCYjHvJpsWmnkJYMI7jWc1oUOS5m01Vxd1kXbdN69Kzt+5zDZKFpa8ryCpvnzrDW
         H3PA==
X-Gm-Message-State: AOAM531ybY2eVwGrhcg8V5MrYHfE+HfWCgJ9AoAN3G7YVf4tO7zaoLiY
        bTgE78RJwN7COofTewKzqAIF/0pSZG/MYw==
X-Google-Smtp-Source: ABdhPJzuL3Sx5e+d0cHQ7bx45uW9DdaIYMCgh3KYFYFB4qK7kQQ1zSNQ6XlHqu/iL//y3HIrbKaq7g==
X-Received: by 2002:ad4:44a6:: with SMTP id n6mr58678008qvt.113.1594293282311;
        Thu, 09 Jul 2020 04:14:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m4sm3524991qtf.43.2020.07.09.04.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:14:41 -0700 (PDT)
Subject: Re: [PATCH 09/21] maintenance: add commit-graph task
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com
References: <c8fbd14d41093e12905027ff628b98652cd931d0.1594131695.git.gitgitgadget@gmail.com>
 <20200709022942.39848-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8dacf017-c445-578c-c82c-f6d6f93469c9@gmail.com>
Date:   Thu, 9 Jul 2020 07:14:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200709022942.39848-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2020 10:29 PM, Jonathan Tan wrote:
>> +static int run_write_commit_graph(struct repository *r)
>> +{
>> +	int result;
>> +	struct argv_array cmd = ARGV_ARRAY_INIT;
>> +
>> +	argv_array_pushl(&cmd, "-C", r->worktree,
>> +			 "commit-graph", "write",
>> +			 "--split", "--reachable",
>> +			 NULL);
> 
> As mentioned in my reply to an earlier patch (sent a few minutes ago),
> this won't work if there are environment variables like GIT_DIR present.

Do we not pass GIT_DIR to the subcommand? Or does using "-C" override
the GIT_DIR?

Thanks,
-Stolee

