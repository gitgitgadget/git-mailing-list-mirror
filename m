Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E32C4320E
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FD260F4B
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 14:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhHBOer (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhHBOel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 10:34:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D48C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 07:34:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 190so16687805qkk.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IrHMrNVEuOk3vD+goUYaGPQbzFWcqFLvCEzogt3kzi0=;
        b=N6NrQvDBM+JdYxANALyUt4KetY2m8LbG7LsJp5077TUVznNMWPyCp7lBlJDxVi62Qy
         1TVCvEg6SDv8ikccDAbi7WKv+kMkfX1SgSlEWOf3DlUdx2hjwGmCzLZ1LcUA6k1s16BK
         qrX52hxMB5kja04psZGOQk+MPVgaHR4vFqXu4uAl96F+RYcGmw1vsDbfgivzPJz2E1Bb
         OwczAywvx2xD2SUbaXWe+m1XNsQmHgIg3xvZQiU6tCZ+lEGxY0xBNHfX6BzwiaFdQXS4
         ip9eGwqPMA6HGv3U3Uqs/Rw4t07Ux+2oim7KbTOVEEud7RqbVxUbjSG1YcJdMtdaDx9h
         pN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IrHMrNVEuOk3vD+goUYaGPQbzFWcqFLvCEzogt3kzi0=;
        b=kpWUtebTPE9HHEwryeh0FbtdbALFi1MXTAQGj6QafM7+pHl5G6yyKhNZV7Tvg/Tcrw
         ZLY6VF0vSUOdAlKxjIiyt7AGnm4vj4h1pMSlnYAdKnw2bqD4EvB8bS4Tq82e73plyc5z
         SWPx5Q1x1gaDH9xGp5wLCDfhhUCq3BYyokkTNzmcviSS94cKLzHI0MZ3iXyL+Kplob2l
         utH4UN3teAyJkdFQaOz26Rqgosok6Du6jqANafhOJitQIjD62iGN8lhfuCF8c5PClis2
         fLrB/SqknkC/zZRYazRSUNa9AMFnDQr3lZkp4X1gebUQmM2KGJYOR0conJH+Bbfm4PCo
         5nMw==
X-Gm-Message-State: AOAM533Ib8UfKyBZr0h/4yQHxSm2C3jGtSOpDYxOnnVSedfoLYQzsUr2
        66jQgyFTdlBtuUgviIgg6cc=
X-Google-Smtp-Source: ABdhPJxvGcSCr+dl2rbnWfRpZX37tr5R9MqI0p8VXKePD2kAVbg4yr1kRMo0vyp5z39Us0+3H6hqPg==
X-Received: by 2002:a37:a5ca:: with SMTP id o193mr16011973qke.352.1627914870560;
        Mon, 02 Aug 2021 07:34:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc? ([2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc])
        by smtp.gmail.com with ESMTPSA id o27sm6023216qkk.124.2021.08.02.07.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:34:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] sparse-checkout: clear tracked sparse dirs
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
 <CABPp-BGbRbyCYYS+NcYrC-T4hJf7BCoLE2HsXFM4K51A0wSgcg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <76639e16-204d-7812-d4c5-56c70e280bed@gmail.com>
Date:   Mon, 2 Aug 2021 10:34:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGbRbyCYYS+NcYrC-T4hJf7BCoLE2HsXFM4K51A0wSgcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2021 9:52 AM, Elijah Newren wrote:
> On Thu, Jul 29, 2021 at 11:27 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> Leaving these ignored files in the sparse directories makes it
>> impossible to gain performance benefits in the sparse index. When we
>> track into these directories, we need to know if the files are ignored
>> or not, which might depend on the _tracked_ .gitignore file(s) within
>> the sparse directory. This depends on the indexed version of the file,
>> so the sparse directory must be expanded.
> 
> Is this the issue I highlighted at
> https://lore.kernel.org/git/CABPp-BHsiLTtv6AuycRrQ5K6q0=ZTJe0kd7uTUL+UT=nxj66zA@mail.gmail.com/,
> the paragraph "...I thought the point of add_patterns()..." or is
> there more or other things involved here?

This is exactly that point. I'm not sure why I didn't pick up on your
earlier concerns as something to do _immediately_, but for some reason
I thought I could delay it until later.

>> If users depend on ignored files within the sparse directories, then
>> they have created a bad shape in their repository. Regardless, such
>> shapes would create risk that changing the behavior for all cone mode
>> users might be too risky to take on at the moment. Since this data shape
>> makes it impossible to get performance benefits using the sparse index,
>> we limit the change to only be enabled when the sparse index is enabled.
>> Users can opt out of this behavior by disabline the sparse index.
> 
> s/disabline/disabling/, otherwise, I fully agree with this paragraph.

Will fix. Thanks.
 
>> Depending on user feedback or real-world use, we might want to consider
>> expanding the behavior change to all of cone mode. Since we are
>> currently restricting to the sparse index case, we can use the existence
>> of sparse directory entries in the index as indicators of which
>> directories should be removed.
> 
> Let's just expand it to all of cone mode.

I'm open to that. I'll leave this version open for feedback a bit longer
before doing so.

>> +       /*
>> +        * NEEDSWORK: For now, only use this behavior when index.sparse
>> +        * is enabled. We may want this behavior enabled whenever using
>> +        * cone mode patterns.
>> +        */
>> +       prepare_repo_settings(r);
>> +       if (!r->worktree || !r->settings.sparse_index)
>> +               return;
> 
> s/may/do/  :-)

Maybe!
 
>> +
>> +       /*
>> +        * Since we now depend on the sparse index to enable this
>> +        * behavior, use it to our advantage. This process is more
>> +        * complicated without it.
>> +        */
> 
> Ah, the real reason why you limited this change to sparse-index comes out.  :-)
> 
>> +       convert_to_sparse(r->index);
>> +
>> +       strbuf_addstr(&path, r->worktree);
>> +       strbuf_complete(&path, '/');
>> +       pathlen = path.len;
>> +
>> +       for (i = 0; i < r->index->cache_nr; i++) {
>> +               struct cache_entry *ce = r->index->cache[i];
>> +
>> +               /*
>> +                * Is this a sparse directory? If so, then definitely
>> +                * include it. All contained content is outside of the
>> +                * patterns.
> 
> "include"?  I would have used the word "remove", but it gets confusing
> because the question is if we want to include it in our list of things
> to remove or remove it from the working directory.

This comment is a bit stale, sorry. Earlier I was populating a list of
the directories, but in this version I'm just deleting them immediately.

>> +                */
>> +               if (S_ISSPARSEDIR(ce->ce_mode) &&
>> +                   repo_file_exists(r, ce->name)) {
>> +                       strbuf_setlen(&path, pathlen);
>> +                       strbuf_addstr(&path, ce->name);
>> +
>> +                       /*
>> +                        * Removal is "best effort". If something blocks
>> +                        * the deletion, then continue with a warning.
>> +                        */
>> +                       if (remove_dir_recursively(&path, 0))
>> +                               warning(_("failed to remove directory '%s'"), path.buf);
> 
> Um, doesn't this delete untracked files that are not ignored as well
> as the ignored files?  If so, was that intentional?  I'm fully on
> board with removing the gitignore'd files, but I'm worried removing
> other untracked files is dangerous.

I believe that 'git sparse-checkout (set|add|reapply)' will fail before
reaching this method if there are untracked files that could potentially
be removed. I will double-check to ensure this is the case. It is
definitely my intention to protect any untracked, non-ignored files in
these directories by failing the sparse-checkout modification.

> My implementation of this concept (in an external tool) was more along
> the lines of
> 
>   * Get $LIST_OF_NON_SPARSE_DIRECTORIES by walking `git ls-files -t`
> output and finding common fully-sparse directories
>   * git clean -fX $LIST_OF_NON_SPARSE_DIRECTORIES

I initially was running 'git clean -dfx -- <dir> ...' but that also
requires parsing and expanding the index (or being very careful with
the sparse index).

> 
>> +               }
>> +       }
>> +
>> +       strbuf_release(&path);
>> +
>> +       /*
>> +        * This is temporary: the sparse-checkout builtin is not
>> +        * integrated with the sparse-index yet, so we need to keep
>> +        * it full during the process.
>> +        */
>> +       ensure_full_index(r->index);
>> +}
>> +
>>  static int update_working_directory(struct pattern_list *pl)
>>  {
>>         enum update_sparsity_result result;
>> @@ -141,6 +207,8 @@ static int update_working_directory(struct pattern_list *pl)
>>         else
>>                 rollback_lock_file(&lock_file);
>>
>> +       clean_tracked_sparse_directories(r);
>> +
>>         r->index->sparse_checkout_patterns = NULL;
>>         return result;
>>  }
> 
> (Adding a comment here just to separate the two blocks below.)
> 
>> @@ -540,8 +608,11 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>>  {
>>         int result;
>>         int changed_config = 0;
>> +       struct pattern_list *old_pl = xcalloc(1, sizeof(*old_pl));
>>         struct pattern_list *pl = xcalloc(1, sizeof(*pl));
>>
>> +       get_sparse_checkout_patterns(old_pl);
>> +
>>         switch (m) {
>>         case ADD:
>>                 if (core_sparse_checkout_cone)
>> @@ -567,7 +638,9 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>>                 set_config(MODE_NO_PATTERNS);
>>
>>         clear_pattern_list(pl);
>> +       clear_pattern_list(old_pl);
>>         free(pl);
>> +       free(old_pl);
>>         return result;
>>  }
> 
> You create an old_pl, populate it with get_sparse_checkout_patterns(),
> do nothing with it, then clear and free it?  I'm confused by the above
> two blocks.

Sorry that this is also stale. I should read my own patches more carefully.

I was originally going to focus only on the directories that were "leaving"
the sparse-checkout definition, but that did not catch the 'reapply' case
or cases where the user created the directories by other means.

Will delete these bits.
>> +       git -C repo sparse-checkout reapply &&
>> +       test_path_is_missing repo/folder1 &&
>> +       test_path_is_missing repo/deep/deeper2 &&
>> +       test_path_is_dir repo/obj &&
>> +       test_path_is_file repo/file.o &&
>> +
>> +       git -C repo status --porcelain=v2 >out &&
>> +       test_must_be_empty out &&
>> +
>> +       git -C repo sparse-checkout set deep/deeper2 &&
>> +       test_path_is_missing repo/deep/deeper1 &&
>> +       test_path_is_dir repo/deep/deeper2 &&
> 
> What's the expectation for repo/obj?

I will add

	test_path_is_dir repo/obj

because this ignored directory should not be removed. This is
simulating the build artifacts that might appear in ignored
directories whose parents are in the sparse-checkout definition.

Thanks,
-Stolee
