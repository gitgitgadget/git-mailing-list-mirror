Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D14C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204A8613D6
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhENM2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhENM2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:28:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC410C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:27:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f8so17879928qth.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJBBcllilLZFIBIQzalyVEiMC855XYNJUMNzMdT+wk0=;
        b=CcFJAezA6eNVFceB/22q2sN6Ww6jRC6Dcil0Uq0jwePmMh5n61EObxklSmGhnUb+pP
         5EO6/tZ7LGicNzRrZe234ZU1qN/uri7Z50WBTnP3XDEU9I5bLpPW9pILfnIzn5ksPiI+
         47/x8c8S9Kdbf1dtZnLpKioAX53Kti8FZMgVi7q8gPtqnZdsJbxxKjxIYFag0oAt4Noy
         kL8OuF5mHzMadnwnLWeNrCZ8HXEZqYZeyia6P43Xp1TV/87tjSISWiCfyLwHM8W9fvSG
         xc4e4uH6JlfYzWe+iLzAtmaYnSUkie7TdOHfJrSWOcc27TlROtLLJmb7NuWNI6OQ9veM
         1Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJBBcllilLZFIBIQzalyVEiMC855XYNJUMNzMdT+wk0=;
        b=m6fPo1TbhORa8AzBd0F2w3uyL5AQgg/XvPLwF/wpmqATPm9QsV6W1WXeNwoHHTJicq
         z0i/i5oX85CNMIwvyaCkICov+L1WFNdgTmSp2913UgQlAzF3B12qkb6+MjUiTNRRUjsb
         CF3Sc+BS4P3UzG3/SPAlNrDcI7a/FsZkIw51Kc76Q8Wb6mFGsSbc8lmzhpVSbcJfhueN
         gz9g2lENXdMdwHuwbveDDa83iVNZYPtw4EtXFVDENES36ooFPLgv6RuTu6FN59N/iR2D
         ZxnDdb2C0WkVpYys2rcBEwYofcdBQREvoqe7snh9Eh49ftHyhn0OvpzfUjbrgTymOmlY
         TLtQ==
X-Gm-Message-State: AOAM530Fhp0iBCaTv55EbLHmR2QlqPOFV57WXPMzOkIjkk9bYsSW/SBa
        6uV2YaZDeZMh9ACpOOYQ/Wk=
X-Google-Smtp-Source: ABdhPJzbUVhzVXEfQNyewB7CWhK0FzWfqjjzt1bPjCWmL8hJ03R2CvEJ3RMPb3e0g/LV0Fc5Fs9t5g==
X-Received: by 2002:ac8:5855:: with SMTP id h21mr41973694qth.281.1620995250904;
        Fri, 14 May 2021 05:27:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6c05:727e:b905:fa7e? ([2600:1700:e72:80a0:6c05:727e:b905:fa7e])
        by smtp.gmail.com with ESMTPSA id y9sm4431986qki.66.2021.05.14.05.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 05:27:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] t1092: add tests for status/add and sparse files
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <3bac9edae7d82ef9fdabbe2f3959e574f79f1dd0.1619213665.git.gitgitgadget@gmail.com>
 <CAHd-oW7X07EU+bX7vZQ+6Jr6ghEQ8kQMuFFCFew6T3mYArBTKg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <289809a1-2956-f412-256e-ca92308ac3f5@gmail.com>
Date:   Fri, 14 May 2021 08:27:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7X07EU+bX7vZQ+6Jr6ghEQ8kQMuFFCFew6T3mYArBTKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/13/2021 8:40 AM, Matheus Tavares Bernardino wrote:
> On Fri, Apr 23, 2021 at 6:34 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Before moving to update 'git status' and 'git add' to work with sparse
>> indexes, add an explicit test that ensures the sparse-index works the
>> same as a normal sparse-checkout when the worktree contains directories
>> and files outside of the sparse cone.
>>
>> Specifically, 'folder1/a' is a file in our test repo, but 'folder1' is
>> not in the sparse cone. When 'folder1/a' is modified, the file
>> 'folder1/a' is shown as modified, but adding it fails.
> 
> Hmm, I might be doing something wrong, but I think `folder1/a` is not
> shown as modified.
> 
> $ git init test
> $ mkdir test/folder1
> $ echo original >test/folder1/a
> $ echo original >test/b
> $ git -C test add . && git -C test commit -m files
> $ git -C test sparse-checkout init --cone --sparse-index
> $ ls test
> b
> $ mkdir test/folder1 && echo modified >test/folder1/a
> $ git -C test status
> On branch master
> You are in a sparse checkout with 50% of tracked files present.
> nothing to commit, working tree clean

You are correct. This happens in both the sparse-index case and the
regular full-index case. The modifications outside of the sparse-checkout
definition are ignored, as long as they matched a tracked file.

I checked my latest code against this example and see that the sparse
index is not expanded to a full one. It _will_ be if we add an untracked
file outside of the sparse cone.

>> This is new
>> behavior as of a20f704 (add: warn when asked to update SKIP_WORKTREE
>> entries, 2021-04-08). Before that change, these adds would be silently
>> ignored.
>>
>> Untracked files are fine: adding new files both with 'git add .' and
>> 'git add folder1/' works just as in a full checkout. This may not be
>> entirely desirable, but we are not intending to change behavior at the
>> moment, only document it. A future change could alter the behavior to
>> be more sensible, and this test could be modified to satisfy the new
>> expected behavior.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 12e6c453024f..0ec487acd283 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -232,6 +232,46 @@ test_expect_success 'add, commit, checkout' '
>>         test_all_match git checkout -
>>  '
>>
>> +test_expect_success 'status/add: outside sparse cone' '
>> +       init_repos &&
> 
> A minor suggestion: before recreating folder1/a, we could also test
> that `git add folder1/a` will not remove the sparse entry from the
> index and will properly warn about it on both sparse repos. I.e.
> adding a:
> 
>         test_sparse_match test_must_fail git add folder1/a

Will do.

>> +       # folder1 is at HEAD, but outside the sparse cone
>> +       run_on_sparse mkdir folder1 &&
>> +       cp initial-repo/folder1/a sparse-checkout/folder1/a &&
>> +       cp initial-repo/folder1/a sparse-index/folder1/a &&
>> +
>> +       test_sparse_match git status &&
>> +
>> +       write_script edit-contents <<-\EOF &&
>> +       echo text >>$1
>> +       EOF
>> +       run_on_all ../edit-contents folder1/a &&
> 
> Hmm, we modify `folder1/a` in all repos, but we only try adding it on
> the sparse repos, and then we immediately restore it on the full repo.
> As we won't use the modified version on the full repo, could this
> perhaps be `run_on_sparse` instead? If so, we could also save the
> later `git -C full-checkout checkout HEAD -- folder1/a`.

Good idea.

>> +       run_on_all ../edit-contents folder1/new &&
>> +
>> +       test_sparse_match git status --porcelain=v2 &&
>> +
>> +       # This "git add folder1/a" is completely ignored
>> +       # by the sparse-checkout repos. It causes the
>> +       # full repo to have a different staged environment.
>> +       #
>> +       # This is not a desirable behavior, but this test
>> +       # ensures that the sparse-index is not the cause
>> +       # of a behavior change.
> 
> I'm not sure I understand what the undesirable behavior is in this
> sentence. Is it "git add folder1/a" erroring out and not updating
> `folder1/a`? Or the full repo having a different staged environment?

Perhaps this isn't actually undesirable, now that we are actually
returning an error. It's no longer silent, so maybe my comment is
stale from an earlier version.

Thanks,
-Stolee
