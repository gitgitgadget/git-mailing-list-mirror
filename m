Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057AC77B7E
	for <git@archiver.kernel.org>; Thu, 25 May 2023 20:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbjEYUFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 16:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjEYUFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 16:05:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B69B
        for <git@vger.kernel.org>; Thu, 25 May 2023 13:05:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso103562276.3
        for <git@vger.kernel.org>; Thu, 25 May 2023 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685045129; x=1687637129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1sFWXYWdE8oE1Tr4ltfUfIwL1FAGalckXmzj4rx22j4=;
        b=H84JpXY3d14rUMyVt4qttFxliPZeBvRRawFSEbcuUXoMNjKrP5aeP83UR2dPRjg9wk
         94PzJOJ9XG3gjpMPlNSYBUtaNftpFkMqa7p3CxwJwVT1GYHn0z2rv5tP6XqxSWREnF3v
         MLCP6qFtVVUbpVQQCF5MNvlyJzBgzebYFNOKl0wL6KI6TDBzT+ytKKH4bqZ92B6NWytX
         LG7numoAQKqZZ0ooeZQS9bMv6qiSuJIuWHQEflYgzEu4pagDgRSwC+4UHWbrgxUwOpy3
         BAqD4fcZ/9Gq4EXHSIzyvW1Vcf4DWl2hk/FxFM9JCAMA9tPtsc0DPJxqXDHvQSNDw1SZ
         HLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045129; x=1687637129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sFWXYWdE8oE1Tr4ltfUfIwL1FAGalckXmzj4rx22j4=;
        b=MU5kVfsuTi/ypLfzPFhtiSpBb5A0m9rEFbIRKE2k3MNlWLvtRq1aO4mm0Jwf+nWKDZ
         aY1oZpRgu5fuLBCQq3gt51OhsbTkxxnuffk4KnGg4VNq5KhvQoKp0TXq/NegsAr710+X
         mGgiDhBBwqwIUv8KNZk3ZzBTAxqMgjNAIjwwNCAClAhr11qwHpOnjab0nf2nS9jPxMfF
         jq2SSTdFPWjrSGWQEGZwN/M4jrGyzhlzVTq7jVATrfA3Blncvjna22fzABRYsT8XSFAp
         VhveVSKPP11af27WEY6Iax25a5/+GOCI7bQQd0R001i1R+i0oIob3wsMOe52YCQoEld5
         ouFQ==
X-Gm-Message-State: AC+VfDwgdnGnNUU13zYNWzBdnppGj/I0rXbTQEGiqrEnRPwb6849p+2C
        ZXktzPEuUjznpjOZqimqxRFVbsZH/iXWfvqscw==
X-Google-Smtp-Source: ACHHUZ77xN7By9/lnEdSiayZHpd5T00Ic3OsXYult0dapzAyy6SIddumhu+rlnjwuDPpKoPBT1x3ag==
X-Received: by 2002:a25:34c4:0:b0:ba8:68b3:c67c with SMTP id b187-20020a2534c4000000b00ba868b3c67cmr4015012yba.34.1685045128994;
        Thu, 25 May 2023 13:05:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2c68:6384:8f43:adfe? ([2600:1700:e72:80a0:2c68:6384:8f43:adfe])
        by smtp.gmail.com with ESMTPSA id 63-20020a251142000000b00ba7cb887380sm540846ybr.14.2023.05.25.13.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:05:28 -0700 (PDT)
Message-ID: <2b52aac0-46c3-6780-9411-d35c819f3673@github.com>
Date:   Thu, 25 May 2023 16:05:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] config: use gitdir to get worktree config
To:     Glen Choo <chooglen@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <aead2fe1ce162949fb313a92fe960e5a64512f60.1684883872.git.gitgitgadget@gmail.com>
 <kl6ly1ldxlsv.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <kl6ly1ldxlsv.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2023 9:05 PM, Glen Choo wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Update 'do_git_config_sequence()' to read the worktree config from
>> 'config.worktree' in 'opts->git_dir' rather than the gitdir of
>> 'the_repository'.
> 
> Thanks for the patches! This makes sense. do_git_config_sequence() is
> eventually called by repo_config(), which is supposed to read config
> into a "struct repository", so any reliance on the_repository's settings
> is wrong.

>> +test_expect_success '--recurse-submodules parses submodule repo config' '
>> +	test_when_finished "git -C submodule config --unset feature.experimental" &&
>> +	git -C submodule config feature.experimental "invalid non-boolean value" &&
>> +	test_must_fail git ls-files --recurse-submodules 2>err &&
>> +	grep "bad boolean config value" err
>> +'
> 
> This test has a few bits that are important but non-obvious. It would be
> useful to capture them in either the commit message or a comment.
> 
> Firstly, we can't test this using "git config" because that only uses
> the_repository, and we specifically need to read config in-core into a
> "struct repository" that is a submodule, so we need a command that
> recurses into a submodule without using subprocesses. IIRC the only
> choices are "git grep" and "git ls-files".
> 
> Secondly, when we test that config is read from the submodule the choice
> of "feature.experimental" is quite important. The config is read quite
> indirectly: "git ls-files" reads from the submodule's index, which
> will call prepare_repo_settings() on the submodule, and eventually calls
> repo_config_get_bool() on "feature.experimental". Any of the configs in
> prepare_repo_settings() should do, though. A tiny suggestion would be to
> use "index.sparse" instead of "feature.experimental", since (I presume)
> we'll have to add sparse index + submodule tests for "git ls-files"
> eventually.

Some of the points you bring up are definitely subtle, like the choice
of config variable.

I appreciate that there are two tests here: one to verify the test
checks have a similar effect without using the worktree config, and
then a second test to show the same behavior with worktree config.

If I understand correctly, the first test would pass without this
code change, but it is a helpful one to help add confidence in the
second test.
 
> +test_expect_success '--recurse-submodules parses submodule worktree config' '
>> +	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&
> 
> I believe "test_config -C" will achieve the desired effect.

This should work, though it requires acting a bit strangely, at least
if we want to replace the 'git config --worktree' command.

test_config treats the positions of the arguments as special, so we
would need to write it as:

 test_config -C submodule feature.experimental --worktree "non boolean value"

and that's assuming that 'git -C submodule config feature.experimental
--worktree "non boolean value"' is parsed correctly to use the --worktree
argument. (I haven't tried it.) By using this order, that allows the
test_config helper to run the appropriate 'test_when_finished git config
--unset feature.experimental' command.

Thanks,
-Stolee
