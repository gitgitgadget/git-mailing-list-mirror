Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8784C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C099860FED
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhIOQS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhIOQSz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:18:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19663C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:17:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g11so2807827qtk.5
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=igrX2UievSW68f/J0keC8jG4lQuNNdNI6auPpnrTbzQ=;
        b=pVLbuTCuegTLfZywnJ1pRMvh3VGtQvpRaID5e9E5Gf8U4u/kkBnq73L7POToB+7Ka+
         AHS/nmujll1PhRlPRpm9VDvN6VdXo6/iZDRNq1BP38/eBRJDpjYqUx39hqmhisE6Pc2+
         92xTHjtSy4VI8ZWX/wdqZFbIRwSTCYO21SLhZjdjOFn4MQl0X4slil+c1nr833W6RTEQ
         WsrdpwOG9XsSTN/oCVKOqwvxDOJu3cdnB6FgQrNqqvLk31fHKGNzPJyjRg9MTJd/pdrK
         5cQAmoFhHwVHhA9Jq8aVON2bL9X8mrnzc5Sy72WqJmzIjy7AVJlTnF4Kp6eSViE4SoCm
         qeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igrX2UievSW68f/J0keC8jG4lQuNNdNI6auPpnrTbzQ=;
        b=u7KWRgI3Mje7vxDnx2+RUAu6FRu94r/2hY3t8lr48//eB/9YRIMUn/XcWaGksbVgkA
         OHiATpoLwX9CnNLPnVbP0bHBO41nCnH+xXKTdiMbCDF6qDZffuW2YtyntS27UXG5ka3a
         hZnOymnqAWgt97i/NxhxV1gXwDdET0YbUWfWWjwlZO3/jyXnbdhPZI5VqZWBaQnbn24L
         G9costwvxJ7deu/g0Ns3GCRs4Yvv/ikYi89ocB6fP4FnQXi5Vd0sesZlvNEuABa78Vox
         cMwOFWQaahZrqhzd+iHZECzWTaGJTuU5l+aWxL+r4UQNGhWo0AWRnyNjgiQuu1DKrBzN
         qnEw==
X-Gm-Message-State: AOAM533JFC6NrOqlQbPFBeeQrsIlB6yCvmU3v6I5KdzG/andMMT678xN
        S/gxJxBiEKd4T8jgS5atljI=
X-Google-Smtp-Source: ABdhPJzmfyRKzM6MtHSyu85ffMsYfZJnT3ERuujVuZiJZqoh66Iup4p3q6KU8hSwwZVZW8wxbNnbXQ==
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr602762qty.145.1631722654108;
        Wed, 15 Sep 2021 09:17:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8cdb:119:9f7e:3e24? ([2600:1700:e72:80a0:8cdb:119:9f7e:3e24])
        by smtp.gmail.com with ESMTPSA id i67sm290731qkd.90.2021.09.15.09.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:17:33 -0700 (PDT)
Subject: Re: [PATCH v2 01/14] t3705: test that 'sparse_entry' is unstaged
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
 <CABPp-BF9rhAK47KQUJtZ9yDTkJ-qoeZ0Q7T4ycLcLSgLoxkzTw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba372f28-3b90-db30-72fd-0242c1c1c3b3@gmail.com>
Date:   Wed, 15 Sep 2021 12:17:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF9rhAK47KQUJtZ9yDTkJ-qoeZ0Q7T4ycLcLSgLoxkzTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2021 1:22 AM, Elijah Newren wrote:
> On Sun, Sep 12, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
>> behaves with paths outside the sparse-checkout definition. These
>> currently check to see if a given warning is present but not that the
>> index is not updated with the sparse entries. Add a new
>> 'test_sparse_entry_unstaged' helper to be sure 'git add' is behaving
>> correctly.
>>
>> We need to modify setup_sparse_entry to actually commit the sparse_entry
>> file so it exists at HEAD but is not already staged in the index.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t3705-add-sparse-checkout.sh | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
>> index 2b1fd0d0eef..af81b4b6846 100755
>> --- a/t/t3705-add-sparse-checkout.sh
>> +++ b/t/t3705-add-sparse-checkout.sh
>> @@ -19,6 +19,7 @@ setup_sparse_entry () {
>>         fi &&
>>         git add sparse_entry &&
>>         git update-index --skip-worktree sparse_entry &&
>> +       git commit --allow-empty -m "ensure sparse_entry exists at HEAD" &&
>>         SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
>>  }
>>
>> @@ -36,6 +37,11 @@ setup_gitignore () {
>>         EOF
>>  }
>>
>> +test_sparse_entry_unstaged () {
>> +       git status --porcelain >actual &&
>> +       ! grep "^M  sparse_entry\$" actual
> 
> Is there a reason this is ^M rather than ^D?  Granted, both would be
> bugs so I wouldn't expect either to appear, but the point of the check
> is looking for likely errors.  Wouldn't the more likely error case for
> a file not present in the working tree be that we stage the deletion
> of the file?

You are right that we should be checking for deletions or adds
_as well_ as modifications. The test_sparse_entry_unstaged helper
is used in a variety of situations that typically would trigger
a modification, but at least one instance in this test is a
possible deletion.

> 
>> +}
>> +
>>  test_expect_success 'setup' "
>>         cat >sparse_error_header <<-EOF &&
>>         The following pathspecs didn't match any eligible path, but they do match index
>> @@ -55,6 +61,7 @@ test_expect_success 'git add does not remove sparse entries' '
>>         setup_sparse_entry &&
>>         rm sparse_entry &&
>>         test_must_fail git add sparse_entry 2>stderr &&
>> +       test_sparse_entry_unstaged &&

Here, sparse_entry could be staged as a deletion.

>>         test_cmp error_and_hint stderr &&
>>         test_sparse_entry_unchanged
>>  '
>> @@ -73,6 +80,7 @@ test_expect_success 'git add . does not remove sparse entries' '
>>         rm sparse_entry &&
>>         setup_gitignore &&
>>         test_must_fail git add . 2>stderr &&
>> +       test_sparse_entry_unstaged &&

Deletion here.

>>         cat sparse_error_header >expect &&
>>         echo . >>expect &&
>> @@ -88,6 +96,7 @@ do
>>                 setup_sparse_entry &&
>>                 echo modified >sparse_entry &&
>>                 test_must_fail git add $opt sparse_entry 2>stderr &&
>> +               test_sparse_entry_unstaged &&

But here would be modified.

>>                 test_cmp error_and_hint stderr &&
>>                 test_sparse_entry_unchanged
>>         '
>> @@ -98,6 +107,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
>>         git ls-files --debug sparse_entry | grep mtime >before &&
>>         test-tool chmtime -60 sparse_entry &&
>>         test_must_fail git add --refresh sparse_entry 2>stderr &&
>> +       test_sparse_entry_unstaged &&

Same here.

>>         test_cmp error_and_hint stderr &&
>>         git ls-files --debug sparse_entry | grep mtime >after &&
>>         test_cmp before after
>> @@ -106,6 +116,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
>>  test_expect_success 'git add --chmod does not update sparse entries' '
>>         setup_sparse_entry &&
>>         test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
>> +       test_sparse_entry_unstaged &&

Here it would be modified with a mode change.

Using the pattern "^[MDARCU][M ] sparse_entry\$" seems to work while also
covering these other cases.

Thanks,
-Stolee
