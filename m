Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AC821845
	for <e@80x24.org>; Tue,  1 May 2018 11:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeEALw3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:52:29 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46529 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEALw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:52:28 -0400
Received: by mail-qt0-f195.google.com with SMTP id m16-v6so14253579qtg.13
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p0rSmPjXznROi1gg5FNUlgPd/eKk+f+pZwQ5TL5ve5U=;
        b=twa2YGatMfS4g4A44OxLsYTFgYO4GkGHPicraL8Cq+YaDnSj1rMT7cp6AooS51dQaI
         JlX+LA11jKZcQbu9SfexIdQcwQryfq9ttBYhiCXFITXYiOCseQZLyMFGNaaF0UExzM0m
         lEGRnzvaYj+3QE4kirCt5a9kLGWbvaQplpODvv+n91ZpJJO5G5PItu47dlza9GQ9UMiN
         A0+BBJ76tbHOAgbyqFCpR3o3k07uvfQqzumOrj/4S2ezU0spk9Zh7qC8xovmMBB2ZwxE
         j3pMOKhwWTklvMs4dgbQCya8XFbp3AINBtoJfGXKu2c7etylLQuMyAkrdSqETiKkn4Ts
         Cz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p0rSmPjXznROi1gg5FNUlgPd/eKk+f+pZwQ5TL5ve5U=;
        b=gBGfAboOvFmbwuZwbOnO9Tb/KvaKCfjVa1bQ9xp2s/G+afC1d46TDQQQ8++I2WImlJ
         5lbYwWnRvrWWNgYEMToBNf88OTjF5bv+TPyApAhhI+ThvophYEYxvmQQSvydx1zkZ5ir
         1MTSal5zsYkYP9/Dbeb+7v9hxahBUGtQdh9/H3NbV7wW3znYTiAH7X0XwxMKIx7m1E0Q
         mujUv27LZxorjAbeYHTiodOaQGWs69G1nmaLVzYNUzXR/9fmtNhluF3DItCIWeI1OYe1
         E2p+OmHWfVp4sb2d1ZRm7KMBJip+5wgLIZiUwJLsHXm/zHaldzlNd49/4STrWr+VhA6/
         mE6A==
X-Gm-Message-State: ALQs6tC3eafyP6R6+x0CM7zjTlu811Z4v8LbKvek18E8BVE6UFbJQVpq
        DieiKEIZHaugcV+v+9NB3q8=
X-Google-Smtp-Source: AB8JxZoGxWbgYOduRxLAR30cNwP86xeJaAkY0x/tY0OYwWZWzmfA44zaPnt+fMzxkrrp5JRk3seToA==
X-Received: by 2002:ac8:7217:: with SMTP id a23-v6mr12823158qtp.243.1525175547926;
        Tue, 01 May 2018 04:52:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u42-v6sm8240932qtb.54.2018.05.01.04.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:52:27 -0700 (PDT)
Subject: Re: [PATCH v4 09/10] merge: check config before loading commits
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-10-dstolee@microsoft.com> <86po2gfgpp.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <214dea35-a89c-4115-a51a-5110c4e53314@gmail.com>
Date:   Tue, 1 May 2018 07:52:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86po2gfgpp.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2018 6:54 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Now that we use generation numbers from the commit-graph, we must
>> ensure that all commits that exist in the commit-graph are loaded
>> from that file instead of from the object database. Since the
>> commit-graph file is only checked if core.commitGraph is true, we
>> must check the default config before we load any commits.
>>
>> In the merge builtin, the config was checked after loading the HEAD
>> commit. This was due to the use of the global 'branch' when checking
>> merge-specific config settings.
>>
>> Move the config load to be between the initialization of 'branch' and
>> the commit lookup.
> Sidenote: I wonder why reading config was postponed to later in the
> command lifetime... I guess it was to avoid having to read config if
> HEAD was invalid.

The 'branch' does need to be loaded before the call to git_config (as I 
found out after moving the config call too early), so I suppose it was 
natural to pair that with resolving head_commit.

>
>> Without this change, a fast-forward merge would hit a BUG("bad
>> generation skip") statement in commit.c during paint_down_to_common().
>> This is because the HEAD commit would be loaded with "infinite"
>> generation but then reached by commits with "finite" generation
>> numbers.
> I guess this is because we avoid re-parsing objects at all costs; we
> want to avoid re-reading commit graph too.
>
>> Add a test to t5318-commit-graph.sh that exercises this code path to
>> prevent a regression.
> I would prefer if this commit was put earlier in the series, to avoid
> having broken Git (and thus a possibility of problems when bisecting) in
> between those two commits.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   builtin/merge.c         | 7 ++++---
>>   t/t5318-commit-graph.sh | 9 +++++++++
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 5e5e4497e3..b819756946 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -1148,14 +1148,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>>   	branch = branch_to_free = resolve_refdup("HEAD", 0, &head_oid, NULL);
>>   	if (branch)
>>   		skip_prefix(branch, "refs/heads/", &branch);
>> +
>> +	init_diff_ui_defaults();
>> +	git_config(git_merge_config, NULL);
>> +
>>   	if (!branch || is_null_oid(&head_oid))
>>   		head_commit = NULL;
>>   	else
>>   		head_commit = lookup_commit_or_die(&head_oid, "HEAD");
>>   
>> -	init_diff_ui_defaults();
>> -	git_config(git_merge_config, NULL);
>> -
> Good.
>
>>   	if (branch_mergeoptions)
>>   		parse_branch_merge_options(branch_mergeoptions);
>>   	argc = parse_options(argc, argv, prefix, builtin_merge_options,
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index a380419b65..77d85aefe7 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -221,4 +221,13 @@ test_expect_success 'write graph in bare repo' '
>>   graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
>>   graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commits/8 merge/2
>>   
>> +test_expect_success 'perform fast-forward merge in full repo' '
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	git checkout -b merge-5-to-8 commits/5 &&
>> +	git merge commits/8 &&
>> +	git show-ref -s merge-5-to-8 >output &&
>> +	git show-ref -s commits/8 >expect &&
>> +	test_cmp expect output
>> +'
> All right.  (though I wonder if this tests catches all problems where
> BUG("bad generation skip") could have been encountered.

We will never know until we have this series running in the wild (and 
even then, some features are very obscure) and enough people turn on the 
config setting.

One goal of the "fsck and gc" series is to get this feature running 
during the rest of the test suite as much as possible, so we can get 
additional coverage. Also to get more experience from the community 
dogfooding the feature.

>
>> +
>>   test_done
> Best,

