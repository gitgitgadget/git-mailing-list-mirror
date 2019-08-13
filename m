Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAE91F45D
	for <e@80x24.org>; Tue, 13 Aug 2019 22:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHMWGi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 18:06:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfHMWGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 18:06:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so51967719pgl.11
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 15:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iTfo6gqv867k1yLnE3+C3/LcEEav9BtFO3P2po1mbeM=;
        b=L6FQPKXXYC1BKnUXfQQJ8bC8Yb4QwnRCTnSJhF/vz7COGISyOLsq1xw15v0CfHAM4f
         rG8iwQe7sfQasv0q8nYCJc/QrgflljPDmyU//hE6nOgas3AIsEBBy10WX9M/21uPj2j/
         qGoJI3DGvCP3M3NYSJxYF288/ZBf7zk+b8egePlKQ9ehfCfAlsTJ+ytsgStbaw496D7n
         Drsng7ioZYGcfNfLdbXJ0uCr4bEkYoUNY/qR1GZQzX0gZSXus5M+cIpxBVUOTz/SKZdS
         RDk2poJtsTKLNHGknl30c1l39oaxIgAtiyyWK1SnctyGYqAhJzfLe22gy7zIpjtlG87Q
         NlFA==
X-Gm-Message-State: APjAAAVDs3ZjxGlhB2Vc1ORwsI2f2e/fCZ5bt5MqifYeS1r3QBGlaroe
        1VlFURyETcX1QyA9ZnIKfZy0dJpDiGs=
X-Google-Smtp-Source: APXvYqx7Q4XGXTTqTK0Z1Knt722fkHGOCzDVdvobHFD851ByhObWBy14+GsYfk4gAjXrm6laFFHCLg==
X-Received: by 2002:a05:6a00:c7:: with SMTP id e7mr43108644pfj.52.1565733996005;
        Tue, 13 Aug 2019 15:06:36 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j10sm81530686pfn.188.2019.08.13.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 15:06:35 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:06:35 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 15:05:14 PDT (-0700)
Subject:     Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
In-Reply-To: <nycvar.QRO.7.76.6.1908132212420.656@tvgsbejvaqbjf.bet>
CC:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, gitster@pobox.com,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Johannes.Schindelin@gmx.de
Message-ID: <mhng-0255a7a4-dc9c-4b61-91d7-f06776c734af@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Aug 2019 13:16:11 PDT (-0700), Johannes.Schindelin@gmx.de wrote:
> Hi,
>
>
> On Mon, 12 Aug 2019, Palmer Dabbelt wrote:
>
>> The existing --jobs argument was defined to control the number of jobs
>> used for submodule fetching, but it makes more sense to have this
>> argument control the number of jobs to be used when fetching from
>> multiple remotes as well.
>>
>> This patch simply changes the --jobs argument parsing code to set both
>> max_children_for_{submodules,fetch}, as well as noting this new behavior
>> in the documentation.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>
> I very much miss in this description a reflection of my analysis in
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1907191507420.47@tvgsbejvaqbjf.bet/
>
> Given that analysis, combined with the fact that the `--jobs` option
> tries to control both the `--multiple` and `--recursive-submodules` code
> paths in the end, anyway, I do doubt that it makes sense to even
> introduce the `--fetch-jobs` and the `--submodule-fetch-jobs` options;
> They are probably only confusing and do not add much benefit to the end
> user.

The cover letter at least attempts to describe this.  I figured I'd have to 
pick one option for a v2, so I went with the more complicated one under the 
assumption it would be easy to re-spin a v3 that drops the extra arguments.  
I'm happy to do so.

>
> Ciao,
> Johannes
>
>>  Documentation/fetch-options.txt |  4 ++++
>>  builtin/fetch.c                 | 21 ++++++++++++++++++---
>>  2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>> index 5836024f1934..0915fd4ed6d5 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -160,6 +160,10 @@ ifndef::git-pull[]
>>
>>  -j::
>>  --jobs=<n>::
>> +	Number of parallel children to be used for all forms of fetching.
>> +	This is the same as passing `--submodule-fetch-jobs=<n>` and
>> +	`--fetch-jobs=<n>`.
>> +
>>  --submodule-fetch-jobs=<n>::
>>  	Number of parallel children to be used for fetching submodules.
>>  	Each will fetch from different submodules, such that fetching many
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 67d001f3f78b..41498e9efb3b 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -114,6 +114,20 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>>  	return git_default_config(k, v, cb);
>>  }
>>
>> +static int parse_jobs_arg(const struct option *opt, const char *arg, int unset)
>> +{
>> +	int jobs;
>> +
>> +	jobs = atoi(arg);
>> +	if (jobs < 1)
>> +		die(_("There must be a positive number of jobs"));
>> +
>> +	max_children_for_submodules = jobs;
>> +	max_children_for_fetch = jobs;
>> +
>> +	return 0;
>> +}
>> +
>>  static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
>>  {
>>  	BUG_ON_OPT_NEG(unset);
>> @@ -142,12 +156,13 @@ static struct option builtin_fetch_options[] = {
>>  		    N_("fetch all tags and associated objects"), TAGS_SET),
>>  	OPT_SET_INT('n', NULL, &tags,
>>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
>> -	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
>> +	{ OPTION_CALLBACK, 'j', "jobs", NULL, N_("jobs"),
>> +		    N_("number of parallel tasks to run while fetching"),
>> +		    PARSE_OPT_OPTARG, &parse_jobs_arg },
>> +	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
>>  		    N_("number of submodules fetched in parallel")),
>>  	OPT_INTEGER(0, "fetch-jobs", &max_children_for_fetch,
>>  		    N_("number of remotes fetched in parallel")),
>> -	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
>> -		    N_("number of submodules fetched in parallel")),
>>  	OPT_BOOL('p', "prune", &prune,
>>  		 N_("prune remote-tracking branches no longer on remote")),
>>  	OPT_BOOL('P', "prune-tags", &prune_tags,
>> --
>> 2.21.0
>>
>>
