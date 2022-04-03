Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6652C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350848AbiDCNCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiDCNCW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:02:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0521E0D
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:00:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m30so10657598wrb.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ncASUml5jdZf9RxN1SdlNe+ynS5uRpd/CmVI6+quiyM=;
        b=RFjQ85MUBUS0jynUl6ZwbdCyWi7xQPWpueK1iCwq2A7ZE9SCRHbHLtcJLv4IEGFV6R
         dFd6P+C6MyP/6f6itTJLb2V3gi8434j9gzlccye8XhYJoKIq2wxchQx3L2X6mx4yw2hw
         upXPINBma9kmCUqyHhpPLTUywMBKALyTmMFrdqu7EFVh0gakwL1pljE/OdbqSCYRY9/j
         zNWIeifiLnAX3mNwRiB15MtafZAQywARsJDbvelzEk7X6+o4FyB+qqIyX3yVq3NFNrzd
         nfGV6thYzvnfmAWKS+B3WThEKJcLCUYRAKDw2UqH9cEl5MKTqzaqTfHzZ3NRIJU11JVo
         6N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ncASUml5jdZf9RxN1SdlNe+ynS5uRpd/CmVI6+quiyM=;
        b=bgRMLHAvx6uasPAm1ozrH6fKlW74MQ7TMwB+n7lOBdO1d4Kr8TnI/suHxoEEO7l3tl
         /dwmdmc0J1PrSizaW8sLOutJlDF6EBLokF8Rs+EOJHnzcrnG33bPLP3HeHqASb7P9etc
         hnGODQ+/EBgwIDVJP40PoGVIGXiYhavs1xAnx1qyT6VfCNRe90aAXPmonKM0kGk9SQhB
         M/CBgsFs3EgbHuurPxcEQ9RiNsjrHZkACK0ajeEbuPwMzLK+Ec0ghswgqxZ+VsCdemGM
         kmM9MTDgjGwtaah0i2m0LvoyHefGFZ8NAPKLTW3v35we+45EE7z88ZssDk7ZEnmhAOTt
         rc+w==
X-Gm-Message-State: AOAM532isdDBcn1q7m7Pi8lWrPOuwy9iC8IJ65eN1725aB3b+6NGRUse
        Le1ScehtvXSRh6QLfz3ICHRearIN2/k=
X-Google-Smtp-Source: ABdhPJwRXfj41DBmJOQ/weHHZfYWrnfsbGF4fH+N3TTFEyJDSNjcDyA/lvUlKF/avZ9qhNPF3DSOeg==
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id u13-20020adfdd4d000000b00203f178b78bmr13834490wrm.93.1648990826500;
        Sun, 03 Apr 2022 06:00:26 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm23660810wmq.27.2022.04.03.06.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 06:00:26 -0700 (PDT)
Message-ID: <5b93870c-39eb-39eb-e6a5-92b4e1cf8f12@gmail.com>
Date:   Sun, 3 Apr 2022 14:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 24/27] revisions API: call diff_free(&revs->pruning) in
 revisions_release()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-24.27-c7f3e92a8d1-20220402T102002Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v5-24.27-c7f3e92a8d1-20220402T102002Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 02/04/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
> Call diff_free() on the "pruning" member of "struct rev_info".  Doing
> so makes several tests pass under SANITIZE=leak.
> 
> This was also the last missing piece that allows us to remove the
> UNLEAK() in "cmd_diff" and "cmd_diff_index", which allows us to use
> those commands as a canary for general leaks in the revisions API. See
> [1] for further rationale, and 886e1084d78 (builtin/: add UNLEAKs,
> 2017-10-01) for the commit that added the UNLEAK() there.

Oh is the the answer to my confusion about patch 14? I wonder if the 
change could come earlier so we can remove the UNLEAK()s all at once?

Best Wishes

Phillip

> 1. https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/diff-index.c                | 1 -
>   builtin/diff.c                      | 1 -
>   revision.c                          | 1 +
>   t/t1001-read-tree-m-2way.sh         | 1 +
>   t/t1002-read-tree-m-u-2way.sh       | 1 +
>   t/t2200-add-update.sh               | 1 +
>   t/t4039-diff-assume-unchanged.sh    | 1 +
>   t/t4206-log-follow-harder-copies.sh | 2 ++
>   t/t6131-pathspec-icase.sh           | 2 ++
>   9 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index 3a83183c312..7d158af6b6d 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -70,7 +70,6 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>   		return -1;
>   	}
>   	result = run_diff_index(&rev, option);
> -	UNLEAK(rev);
>   	result = diff_result_code(&rev.diffopt, result);
>   	release_revisions(&rev);
>   	return result;
> diff --git a/builtin/diff.c b/builtin/diff.c
> index dd48336da56..f539132ac68 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -594,7 +594,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>   	result = diff_result_code(&rev.diffopt, result);
>   	if (1 < rev.diffopt.skip_stat_unmatch)
>   		refresh_index_quietly();
> -	UNLEAK(rev);
>   	release_revisions(&rev);
>   	UNLEAK(ent);
>   	UNLEAK(blob);
> diff --git a/revision.c b/revision.c
> index e972addd8fc..8bc777da828 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2955,6 +2955,7 @@ void release_revisions(struct rev_info *revs)
>   	clear_pathspec(&revs->prune_data);
>   	release_revisions_mailmap(revs->mailmap);
>   	free_grep_patterns(&revs->grep_filter);
> +	diff_free(&revs->pruning);
>   	reflog_walk_info_release(revs->reflog_info);
>   }
>   
> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
> index 0710b1fb1e9..516a6112fdc 100755
> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -21,6 +21,7 @@ In the test, these paths are used:
>   	yomin   - not in H or M
>   '
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-read-tree.sh
>   
> diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
> index 46cbd5514a6..bd5313caec9 100755
> --- a/t/t1002-read-tree-m-u-2way.sh
> +++ b/t/t1002-read-tree-m-u-2way.sh
> @@ -9,6 +9,7 @@ This is identical to t1001, but uses -u to update the work tree as well.
>   
>   '
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-read-tree.sh
>   
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index 0c38f8e3569..be394f1131a 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -14,6 +14,7 @@ only the updates to dir/sub.
>   Also tested are "git add -u" without limiting, and "git add -u"
>   without contents changes, and other conditions'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
> index 0eb0314a8b3..78090e6852d 100755
> --- a/t/t4039-diff-assume-unchanged.sh
> +++ b/t/t4039-diff-assume-unchanged.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='diff with assume-unchanged entries'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   # external diff has been tested in t4020-diff-external.sh
> diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
> index 4871a5dc92f..33ecf82c7f9 100755
> --- a/t/t4206-log-follow-harder-copies.sh
> +++ b/t/t4206-log-follow-harder-copies.sh
> @@ -6,6 +6,8 @@
>   test_description='Test --follow should always find copies hard in git log.
>   
>   '
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-diff.sh
>   
> diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
> index 39fc3f6769b..770cce026cb 100755
> --- a/t/t6131-pathspec-icase.sh
> +++ b/t/t6131-pathspec-icase.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='test case insensitive pathspec limiting'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   if test_have_prereq CASE_INSENSITIVE_FS
