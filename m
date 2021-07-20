Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFE2C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F1C61106
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhGTM6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbhGTM4N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 08:56:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFBC0617A6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 06:36:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z9so23912408iob.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QyGP90nIHfYy/JbMITS5XnNRZWOIyTl2yzN5lFI538s=;
        b=gxE3sbEAUF3+/HxGDymUfIAgBJ8IDZQu0OIp419yPMyxXx1ERrjNVApia4RrgJsYrf
         K9Tkg1CbwK1x3QJsfvbZ21OiltICT5mp8LEBqFBIJ25LaXh2rT71AB2glZcleqMdsiJC
         ivvgD4RlXivZzhF+QZitTkf8uovco+Nw5TIiJ0ZNHuITlhGZvSSH9dZUNpfIEJFz6w55
         ++GWcLw8tNCFtqjq/5wuWryu7JZy9qv4WpxXzkEPrJXZ6eYXl/raf5zPF3Is7OGJtDRZ
         dK/VsXLSAaHS83ug3z6lwXUK0fKyxtc4i5Ox6wWT9Vx5MZLbFW9PDdugRduHqqg3wax6
         mB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyGP90nIHfYy/JbMITS5XnNRZWOIyTl2yzN5lFI538s=;
        b=DlMsK1Hg+BI0xJh+9XhDp6WAzM4ml9v8NlyltPqoce/yzusPrBsjqJ+RszHuUggy68
         LZwRYlVfJMX9IL4hEGvq1dgh5gSITCQm5xm8n3heWWFLrquaI+6U+HDD5wRlBLmHAYzi
         tjA138bwO0qBAIWo8Pp0+wbvluv+L5NsALdYmshtlaaAMNtIbTkEkX5qaiYqs/1UM28P
         xff5BeDIOhjdWW1WOnopq+m0j6dFSSkyvXLLuJDqA3nYrLvYIudg4IVY+LWUnyTzNuSy
         JgXAdg2ZEdcrxqEn3KimjEDtk8jXbtCk7fwbK2OFYgOLF4vLTGTMO7FIFhDywYq+KMPz
         pOhg==
X-Gm-Message-State: AOAM530tw7JXsSQ4m5sxzYaglo+lPzGp8QXbAHXR/PxvBNzWz9gv6wqP
        1Ftfr66kU+8BIDPFPEuu9uJjzjkIXGG9Lg==
X-Google-Smtp-Source: ABdhPJyB2ca9NQicEEoSubLWL0ZhphZOO7SIWOyfJWS61tfO7Uv4BQUCgpfV2cIQz5ay4BHjfq8XBg==
X-Received: by 2002:a6b:1406:: with SMTP id 6mr23072048iou.25.1626788181706;
        Tue, 20 Jul 2021 06:36:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:edd1:69f6:c801:b756? ([2600:1700:e72:80a0:edd1:69f6:c801:b756])
        by smtp.gmail.com with ESMTPSA id h13sm10585403ila.44.2021.07.20.06.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 06:36:21 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2021, #04; Mon, 19)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqq4kcqko6g.fsf@gitster.g>
 <CABPp-BFXcNquqrwQ6nZSPy611oaosSbs74FdKWkrvGabnHSpgg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f7a6cd8-1c44-d2f1-4b76-8d6a2729eec1@gmail.com>
Date:   Tue, 20 Jul 2021 09:36:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFXcNquqrwQ6nZSPy611oaosSbs74FdKWkrvGabnHSpgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2021 9:52 PM, Elijah Newren wrote:
...
>> * en/ort-perf-batch-14 (2021-07-13) 7 commits
>>  - merge-ort: restart merge with cached renames to reduce process entry cost
>>  - merge-ort: avoid recursing into directories when we don't need to
>>  - merge-ort: defer recursing into directories when merge base is matched
>>  - merge-ort: add a handle_deferred_entries() helper function
>>  - merge-ort: add data structures for allowable trivial directory resolves
>>  - merge-ort: add some more explanations in collect_merge_info_callback()
>>  - merge-ort: resolve paths early when we have sufficient information
>>
>>  Further optimization on "merge -sort" backend.
>>
>>  Reviews?
> 
> Stolee reviewed it; he posted numerous comments and helpful
> suggestions throughout the series.  I sent in a new series
> incorporating all his suggestions, though I'm still waiting to hear
> back if that addresses things sufficiently for him.

I just looked at v3 and like it. I wanted to look closely at the new struct,
but it translates rather well from the previous version so there are no
surprises. I mentioned on the v3, but that version LGTM.

>> * ds/commit-and-checkout-with-sparse-index (2021-07-14) 5 commits
>>  - checkout: stop expanding sparse indexes
>>  - sparse-index: recompute cache-tree
>>  - commit: integrate with sparse-index
>>  - p2000: compress repo names
>>  - p2000: add 'git checkout -' test and decrease depth
>>  (this branch uses ds/status-with-sparse-index.)
>>
>>  "git checkout" and "git commit" learn to work without unnecessarily
>>  expanding sparse indexes.
>>
>>  Will merge to 'next'.
> 
> Please wait; he's going to post some fixes.  See
> https://lore.kernel.org/git/91b81577-3ff8-3845-75d1-c47e8a42406e@gmail.com/.

Yes, please wait. I spent longer than expected working out the details of
that patch that we were debating. It turns out to be important, and I have
a new organization of patches that demonstrates this more clearly, along
with tests demonstrating how directory/file conflicts are currently broken
in the non-sparse case.

I got distracted thinking about the original design of the df_conflict_entry
and wandered through several code moves into ee6566e ([PATCH] Rewrite read-tree,
2005-09-05), which was not particularly illuminating. I'm giving myself the
day to see if I can figure this out enough to fix the full-checkout case, but
I'm not optimistic. Expect a v2 soon that describes the trade-offs of the
current implementation.

>> * ds/status-with-sparse-index (2021-07-14) 16 commits
>>  - t1092: document bad sparse-checkout behavior
>>  - fsmonitor: integrate with sparse index
>>  - wt-status: expand added sparse directory entries
>>  - status: use sparse-index throughout
>>  - status: skip sparse-checkout percentage with sparse-index
>>  - diff-lib: handle index diffs with sparse dirs
>>  - dir.c: accept a directory as part of cone-mode patterns
>>  - unpack-trees: unpack sparse directory entries
>>  - unpack-trees: rename unpack_nondirectories()
>>  - unpack-trees: compare sparse directories correctly
>>  - unpack-trees: preserve cache_bottom
>>  - t1092: add tests for status/add and sparse files
>>  - t1092: expand repository data shape
>>  - t1092: replace incorrect 'echo' with 'cat'
>>  - sparse-index: include EXTENDED flag when expanding
>>  - sparse-index: skip indexes with unmerged entries
>>  (this branch is used by ds/commit-and-checkout-with-sparse-index.)
>>
>>  "git status" codepath learned to work with sparsely populated index
>>  without hydrating it fully.
>>
>>  Will merge to 'next'.
> 
> Yep, sounds good; thanks.

Thanks!

-Stolee
