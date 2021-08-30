Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69824C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3E660C3F
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhH3NzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhH3NzC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:55:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0572C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:54:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bk29so15643886qkb.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+guyxJDrvad3aQgiNbTxA+nw/nKGg5zyLtKyUZ43tM0=;
        b=qVppf8+N2XvKUgKvDDrARlF2/EgTJxQXfqaH2Ycmh8z/oD8AlOW2g9QHyGWdflPhba
         1tooUanPpCxfj4MyX1WeRWkQWhYuS4WhLuKlwCT6ulzUZRiemYHO+rKPCbyGYOpLOIOH
         clZnxvIdp1ml6Nek4wsMnQnekDUMbb88a6oeOc5713vFiochRm7Qm/5Bhfprq5aHrfTF
         sVsKZe0dTsybQ6YtPRIn/8FHwgpFr3pZqAZM9uIH1+OshxrXOjMfyCCTyZa6UHA4aTSl
         yvj3zkCIqlQjYLal3XHiG5jiHhmNmwdF8gxDg6oVSHa9DMmDbPsWfiAl7f5EjLANZwFo
         HD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+guyxJDrvad3aQgiNbTxA+nw/nKGg5zyLtKyUZ43tM0=;
        b=ParG6SRPdKsRyZplgLi4ojJ4GG9I1nSRGg1mcqGAt/jP0cN8LPTvKj5y5QNpzA3Nxc
         U6jctu09mmIo6vYpPWSqrCoOOgNyJcmQ6viMYEYiKCA0f1smy3Q3qSTJVEFdBh/XY3Hy
         RZ+WyPfLAPu7K1ZJig4WNoDpPhNvIbELK9mbZo3u2wl2RtghTXL33KhziFH8S141bC7o
         usfgS9LI6iMFFLDqWGuy6DrKjEUBo2qMvsvfuPxSrJDYcbklbEhNSrRugjRM7q1aXizu
         3TQcGCPM4HXs/3JwXJoqyxnaWEJfnKYkR12bUcbw7JozmfMzoy62V9MLHehsX89oxRPF
         IXJQ==
X-Gm-Message-State: AOAM530+wM3Ji7Ul3WZOrL1KXSfHdU96NgEkMGDgjwKEqn540yOPPync
        1iqk4AGHOvRsKOrgIfrXKqU=
X-Google-Smtp-Source: ABdhPJz5vtZMzcHpCw9hzWGTnLcWLPXbx1EeZgYUKRdEFTi+kRw65lvVHLuU1NhBwG97x0raCdmmbg==
X-Received: by 2002:a37:b4d:: with SMTP id 74mr21716533qkl.92.1630331647571;
        Mon, 30 Aug 2021 06:54:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f479:1655:2af5:7e8e? ([2600:1700:e72:80a0:f479:1655:2af5:7e8e])
        by smtp.gmail.com with ESMTPSA id b13sm6276097qtp.26.2021.08.30.06.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 06:54:07 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] Sparse index: delete ignored files outside
 sparse cone
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
 <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d55363df-c2e9-3847-d98c-3d07e22d8a5d@gmail.com>
Date:   Mon, 30 Aug 2021 09:54:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 5:56 PM, Elijah Newren wrote:
> On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> UPDATE: I had to base this version on a merge of ds/add-with-sparse-index
>> and v2.33.0-rc1 because of some changes to dir.h that became important!
> 
> Isn't this stale (i.e. just copied from v2/v3)?

Sorry, yes. It was an update to the original cover letter, but was not
updated in later versions.

>>  * I split the commit that involves cache_tree_update(). I have not yet
>>    succeeded in creating tests to demonstrate why this is required outside
>>    of needing it in the Scalar functional tests, which includes a version of
>>    partial clone. I will continue to investigate recreating this scenario in
>>    the Git test suite, but I wanted to send this version out to get feedback
>>    on the things that have changed.
> 
> Are you talking about patch 3 or patch 4?

I'm talking about patches 3 and 4, which (at the time that I created
them a few months ago, before later merging them) they each had solved
some problems in the Scalar functional tests. The issue I'm seeing now
is that since so many commands have integrated with the sparse index,
those functional tests are not testing convert_to_sparse() as heavily,
so simply reverting each does not show the problem any more.

> For patch 4, as I commented on that patch, my guess would be that you
> start with a full tree, pick some directory that you will sparsify
> away, and before sparsifying it away, change some file under that
> directory and stage the change.  Then when you sparsify the directory
> away with cone mode, I think the cache_tree_update() will need to
> write the tree.  At least, some quick greps of cache_tree_update
> suggest there aren't that many codepaths that attempt to update it, so
> I don't think anything else would have written it yet at that point.
> 
> For patch 3, since it comes before patch 5, it would be triggerable
> with the same case.  Is it possible you originally found both patches
> based off similar initial conditions that just resulted in slightly
> different behavioral reports, and thus that patch 4 is good enough
> without patch 3?  Trying to ignore that possibility and looking at the
> cache_tree_update() code, the only other reasons for failure of
> cache_tree_update() that I can see are (a) someone having invalid
> hashes recorded in the index (e.g. someone using `git update-index
> --index-info` with some invalid hashes, or someone manually deleting
> some loose blobs from under their .git/ directory), or (b) disk being
> full or read-only so that writing new tree objects to the object store
> fail.

Just for full context:

* Patch 3 removes a warning and "return -1" when cache_tree_update()
  fails. This makes convert_to_sparse() resilient to any failure that
  might happen in cache_tree_update(), whatever it might be.

* Patch 4 adds the WRITE_TREE_MISSING_OK, which removes one possible
  reason that cache_tree_update() could fail (and removes an attempted
  promisor fetch in the case of partial clone).

So I could see that either of the two patches would be sufficient to
make tests pass in all normally-testable scenarios. However, patch 3
is valuable for possibly more complicated failure scenarios such as
corrupted data, while patch 4 is valuable for performance reasons in
a very specific environment.

>> base-commit: 80b8d6c56b8a5f5db1d5c2a0159fd808e8a7fc4f
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2Fderrickstolee%2Fsparse-index%2Fignored-files-v4
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derrickstolee/sparse-index/ignored-files-v4
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1009
> 
> A super micro nit:
> 
> It appears this is based on your other branches that have since been
> incorporated into master.  Not a big deal, but rebasing on master
> might make it easier for others to take a look at the series (I was
> confused at first why this series depended on other unmerged series,
> before realizing those other series had since merged down).  I know we
> normally don't like rebasing series, but I suspect it wouldn't change
> the range-diff (as I don't think others are touching these areas of
> the code), and thus be transparent to Junio.

The 'git add' integration only recently hit 'master', so I have not
had a chance to base on a version of that branch with the necessary
dependencies.

>>   6:  c9e100e68f8 !  7:  e496f3cee66 attr: be careful about sparse directories
>>      @@ attr.c: static struct attr_stack *read_attr_from_index(struct index_state *istat
>>                 return NULL;
>>
>>       + /*
>>      -+  * In the case of cone-mode sparse-checkout, getting the
>>      -+  * .gitattributes file from a directory is meaningless: all
>>      -+  * contained paths will be sparse if the .gitattributes is also
>>      -+  * sparse. In the case of a sparse index, it is critical that we
>>      -+  * don't go looking for one as it will expand the index.
>>      ++  * The .gitattributes file only applies to files within its
>>      ++  * parent directory. In the case of cone-mode sparse-checkout,
>>      ++  * the .gitattributes file is sparse if and only if all paths
>>      ++  * within that directory are also sparse. Thus, don't load the
>>      ++  * .gitattributes file since it will not matter.
>>      ++  *
>>      ++  * In the case of a sparse index, it is critical that we don't go
>>      ++  * looking for a .gitattributes file, as the index will expand.
> 
> This comment is better, and I appreciate the thought behind adding the
> second paragraph, but the wording seems fuzzy and potentially
> confusing to future readers.  Perhaps changing the wording to:
> 
> ...looking for a .gitattributes file, as doing so would cause the
> index to expand.

Thanks.

>>   8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked sparse dirs
>>      @@ Commit message
>>           the sparse directory. This depends on the indexed version of the file,
>>           so the sparse directory must be expanded.
>>
>>      +    We must take special care to look for untracked, non-ignored files in
>>      +    these directories before deleting them. We do not want to delete any
>>      +    meaningful work that the users were doing in those directories and
>>      +    perhaps forgot to add and commit before switching sparse-checkout
>>      +    definitions. Since those untracked files might be code files that
>>      +    generated ignored build output, also do not delete any ignored files
>>      +    from these directories in that case. The users can recover their state
>>      +    by resetting their sparse-checkout definition to include that directory
>>      +    and continue. Alternatively, they can see the warning that is presented
>>      +    and delete the directory themselves to regain the performance they
>>      +    expect.
>>      +
...
>>      ++When changing the sparse-checkout patterns in cone mode, Git will inspect each
>>      ++tracked directory that is not within the sparse-checkout cone to see if it
>>      ++contains any untracked files. If all of those files are ignored due to the
>>      ++`.gitignore` patterns, then the directory will be deleted. If any of the
>>      ++untracked files within that directory is not ignored, then no deletions will
>>      ++occur within that directory and a warning message will appear. If these files
>>      ++are important, then reset your sparse-checkout definition so they are included,
>>      ++use `git add` and `git commit` to store them, then remove any remaining files
>>      ++manually to ensure Git can behave optimally.
...
> Thanks for the extra explanations; those help.
> 
> You haven't yet addressed how this choice will interact with
> .gitignore files, though (as I commented on v3).  You alluded in patch
> 7 to how it was critical to avoid looking for .gitattributes files
> because doing so would require the index to expand, possibly
> recursively all the way down.  Don't .gitignore files have the same
> problem?  Nuking all the ignored files so that you can delete extra
> directories and thus not need to walk into them during operations
> helps, but does the fact that we sometimes avoid removing directories
> mean we have to walk into them anyway?  Do we only need to walk into
> such directories when they are (still? again?) present in the working
> copy?  Does there need to be some code added somewhere that checks for
> the presence of a directory in the working copy and unsparsifies
> sparse directory entries in the index when such directories are found?
> 
> Also, does non-cone mode sparsity paths have weird bugs around letting
> users specify patterns that would happen to also exclude .gitignore
> files from the working copy, but keep other sibling files within the
> same directory?  In particular, if the .gitignore files aren't
> present, does git add -A add a bunch of supposed-to-be-ignored files?
> (If so, that's an issue that's probably tangential to this series
> since it's not about cone mode or the sparse index, but it's certainly
> an interesting thought.)
> 
> Maybe the whole .gitignore situation with cone mode has a simple
> answer, but since this whole series is about gaining performance by
> avoiding recursing into directories corresponding to sparse directory
> entries, it feels the answers to how .gitignore will be handled should
> at least be addressed.

The goal of this series is to allow Git to operate as normal (respecting
.gitattributes and .gitignore files as part of that) without needing to
expand a sparse index. The way it achieves this is by deleting the
directories that leave the sparse-checkout cone. If those directories
don't exist, then we don't care about the .gitattributes or .gitignore
files in those locations. When the directory _does_ exist, then we need
to look for the .gitignore file which expands the index to full. This
is done naturally by Git using index_name_pos() for "<dir>/.gitignore"
which finds that "<dir>" (or one of its parent directories) is a
sparse directory, then expands the index and searches for
"<dir>/.gitignore" again, returning the position if it exists in the
fully-expanded index.

The difference between the .gitattributes and .gitignore files is that
we don't need to do anything with the .gitignore files to prevent Git
from accessing them with their contained directories don't exist. The
.gitattributes change in attr.c is reachable from some code path even
when the directory doesn't exist, so it needs special logic to avoid
that expansion.

When we don't succeed in deleting sparse directories, performance
suffers. That's the reason behind having a very-visible warnings to
users that something is blocking the removal. We will be monitoring
performance of users where it is _very clear_ when this happens. From
that experience, we might discover new ways to assist them to get
into a better state (perhaps a warning during "git status" would help?).

Thanks,
-Stolee
