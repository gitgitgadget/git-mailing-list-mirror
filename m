Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40583C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112946128E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhDLU1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhDLU1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 16:27:49 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A9C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 13:27:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f12so11037657qtf.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ketdPZMF2M86eEWiZcNebMZRpGtlGsIktb0KYLttsc=;
        b=RAEeP5lnIto2GAOhojuS2QHxj1ExAZF8E0+qlyphVHYe450aBW72OLS0S/QpeIXklp
         XNrK9FbhY2pkaExY98FXyFWQc4KWuX8kVM2vBEq4XcHLSwoa6t6iqcIPg9Ro8yRdBhvJ
         mEE2Tyk/CPvv6RsbzQHCzZRPK5zoO/IZNOTwc50FvFrylYxoeIZExDFKRVIs9J9uMo18
         WVqUt3ZpkGsXTaJbgoF74CLkX2aK+g4KuDg5eQEwMqP95S18FkezgkmqTZ5sYK6VNtbR
         JNLDJ43vjAdubhnFfCtfiX0z01tzpw4quzySAbFoi3d9P3g/9l/Fm8mtMZUk76d6cqke
         RCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ketdPZMF2M86eEWiZcNebMZRpGtlGsIktb0KYLttsc=;
        b=E0ep8RRwoRNZ2/Qyh2i7r2bV1vvqcV+rA8ycho4ZgGUXHaq/bEUcEX2vZw0q5N5Occ
         6PBOOAx7kLQC9SVRUk8b8QQfei2Sj3xgjmHEtdt/EQX/ijISQNU7RRRtElgZwqrQxRsv
         Qp4aOWAjTyLjuSrKTCGFv43ocQWWNLPs/BXIEAxSCbpdiE9gpy5f3znuFCy1HhGtzE55
         Wq3iLj2+mP5rnlIuDa1rLCCSEFV2Ut4NwktRhEI4unDEMgQMGLIiSBq0GaGilb6roFLR
         Tg68UF7Ht8FOxMVXpULrufEcW5aV3GIG5D2amXrv8sd/PjcXMxfWUo6MHSCXqHPB/dRt
         6LMA==
X-Gm-Message-State: AOAM530SwWWXtbfOnKRlFn0T+Rhbkg0gcsovPOnR/4UOBX6tj4fUNhjT
        MNcjH+GoNDysXu9xooMf2Ko9enClVyqzig==
X-Google-Smtp-Source: ABdhPJw7bMFYiJ1Pkg+ujVt2FpGLXcL41jE38UIhoQl7HKV4ldTaln4a/+uWowTzmoUMWGvwOZWt6w==
X-Received: by 2002:a05:622a:454:: with SMTP id o20mr26674604qtx.292.1618259247912;
        Mon, 12 Apr 2021 13:27:27 -0700 (PDT)
Received: from US0059EMPL003.northamerica.corp.microsoft.com ([2600:1700:e72:80a0:40c3:ffa7:673:48b6])
        by smtp.gmail.com with ESMTPSA id n143sm1140232qke.45.2021.04.12.13.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:27:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] maintenance: simplify prefetch logic
To:     Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <4c0e983ba56f030851370ef71887117db45e8479.1618020225.git.gitgitgadget@gmail.com>
 <20210412201308.teugitvky5cctcio@dhcp-10-154-186-72.vpn.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f4fa2b5-0d8b-b368-ab4d-411740595a4f@gmail.com>
Date:   Mon, 12 Apr 2021 16:27:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412201308.teugitvky5cctcio@dhcp-10-154-186-72.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/21 4:13 PM, Tom Saeger wrote:
> On Sat, Apr 10, 2021 at 02:03:43AM +0000, Derrick Stolee via GitGitGadget wrote:
>> -static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
>> +static int fetch_remote(struct remote *remote, void *cbdata)
>>  {
>> +	struct maintenance_run_opts *opts = cbdata;
>>  	struct child_process child = CHILD_PROCESS_INIT;
> 
> 
> I think this might be appropriate to add:
> 
> 
>        if (remote->skip_default_update)
>                return 0;
> 
> 
> maintenance prefetch is acting like `git fetch --all`
> So it should also skip remotes with configs `skipfetchall = true`
> Agree?

TIL about skipfetchall. I think that's a good idea to introduce.
It'll be a new patch, not added in this one.

Thanks,
-Stolee
