Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E1C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7D620737
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 13:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tffZjDWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCZNN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:13:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39465 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 09:13:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id d63so5392044oig.6
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=83fjBDeJRJsQcYpGsnjAuB/G1/pAYGr1km0m9Yjjofg=;
        b=tffZjDWjw8Mj/w9mX2dcukS2fclQoF8uiqSwTJQLGWoRr//vXOZGcTa2t+q8GPYnMD
         OHzkJwa9G+AAGuQxE+Qhq9D1qHouZqxIaOhcM7G503b1PPYF+1P5KmOTiH8/3BUdkljg
         S9kBuTV3nTwCx3B6dTMjLlbH+SSyGvlY+tOO5DtbUHHqEgw41Ldk9GKEyGKYEaZVDoEu
         OdVg+qGXK5MVwFyqwT7jrHUg371+RCCZx4vOqoqfeSXuT6A6tbLzoPM5KfmExM3zomL/
         1cx/bbTnOZjqLAib+VzqeXgjH/ylv7+L72CC+rOyBWm/EkOwZcFysv3Jh7fqmoHk5+l2
         FK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=83fjBDeJRJsQcYpGsnjAuB/G1/pAYGr1km0m9Yjjofg=;
        b=AUNdI3nNTKeNlH+1Cvs77ZXF6YcsPyyRQlVNvU0Qxwep09pUZxCyDSIW2d5ZxUdacn
         ddp89/T2XG7Aa2elDkmcxIWDuspXiHDSh9XTztJJJen/uoYOzl7ufAOXf/Ife9QvWdZj
         rZa9iWzoD6lUqc4PhMkFfOVG1GB6mxtm7bGna8upW9pTcWDZfsKrOSbuHj/J7tTP56Sq
         AdyoTUv7BN954g95Nw3TbItvmXpkIK60BQUKKiOvHHDZDGxDj+yvfsGUqNbpQ1kd0qtO
         NCALfz8xtfBWPgIKpdNbIuAU/VY4024DCU7jUV13Fe8hbmrqMNKgblQxW1Pl9L1rzfR6
         ZaVA==
X-Gm-Message-State: ANhLgQ23SN/W3wjwdxlkqP+pjeW0UHwbS8Ul7/kYDfChE5lGM/x1GOkK
        CYlBi+MSmw7sW3Mwl72reFQ=
X-Google-Smtp-Source: ADFU+vtX5/3R3x5iYejG2VilgldtkiYJqcCMLbgKeMP8yXCoDQuZcB2OBtEvRvuLNxp5TZIdcUsyiA==
X-Received: by 2002:aca:abcd:: with SMTP id u196mr1730742oie.86.1585228434162;
        Thu, 26 Mar 2020 06:13:54 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 46sm570229otl.12.2020.03.26.06.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 06:13:53 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] dir: replace exponential algorithm with a linear
 one, fix untracked cache
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
 <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
 <6cfca619e2c5bc37d1847d49496d1be42f4061ce.1585164718.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a81cb70f-1a3a-6f0f-1500-66e63138a848@gmail.com>
Date:   Thu, 26 Mar 2020 09:13:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <6cfca619e2c5bc37d1847d49496d1be42f4061ce.1585164718.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2020 3:31 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> dir's read_directory_recursive() naturally operates recursively in order
> to walk the directory tree.  Treating of directories is sometimes weird
> because there are so many different permutations about how to handle
> directories.  Some examples:
> 
>    * 'git ls-files -o --directory' only needs to know that a directory
>      itself is untracked; it doesn't need to recurse into it to see what
>      is underneath.
> 
>    * 'git status' needs to recurse into an untracked directory, but only
>      to determine whether or not it is empty.  If there are no files
>      underneath, the directory itself will be omitted from the output.
>      If it is not empty, only the directory will be listed.
> 
>    * 'git status --ignored' needs to recurse into untracked directories
>      and report all the ignored entries and then report the directory as
>      untracked -- UNLESS all the entries under the directory are
>      ignored, in which case we don't print any of the entries under the
>      directory and just report the directory itself as ignored.  (Note
>      that although this forces us to walk all untracked files underneath
>      the directory as well, we strip them from the output, except for
>      users like 'git clean' who also set DIR_KEEP_TRACKED_CONTENTS.)
> 
>    * For 'git clean', we may need to recurse into a directory that
>      doesn't match any specified pathspecs, if it's possible that there
>      is an entry underneath the directory that can match one of the
>      pathspecs.  In such a case, we need to be careful to omit the
>      directory itself from the list of paths (see commit 404ebceda01c
>      ("dir: also check directories for matching pathspecs", 2019-09-17))
> 
> Part of the tension noted above is that the treatment of a directory can
> change based on the files within it, and based on the various settings
> in dir->flags.  Trying to keep this in mind while reading over the code,
> it is easy to think in terms of "treat_directory() tells us what to do
> with a directory, and read_directory_recursive() is the thing that
> recurses".  Since we need to look into a directory to know how to treat
> it, though, it is quite easy to decide to (also) recurse into the
> directory from treat_directory() by adding a read_directory_recursive()
> call.  Adding such a call is actually fine, IF we make sure that
> read_directory_recursive() does not also recurse into that same
> directory.
> 
> Unfortunately, commit df5bcdf83aeb ("dir: recurse into untracked dirs
> for ignored files", 2017-05-18), added exactly such a case to the code,
> meaning we'd have two calls to read_directory_recursive() for an
> untracked directory.  So, if we had a file named
>    one/two/three/four/five/somefile.txt
> and nothing in one/ was tracked, then 'git status --ignored' would
> call read_directory_recursive() twice on the directory 'one/', and
> each of those would call read_directory_recursive() twice on the
> directory 'one/two/', and so on until read_directory_recursive() was
> called 2^5 times for 'one/two/three/four/five/'.
> 
> Avoid calling read_directory_recursive() twice per level by moving a
> lot of the special logic into treat_directory().
> 
> Since dir.c is somewhat complex, extra cruft built up around this over
> time.  While trying to unravel it, I noticed several instances where the
> first call to read_directory_recursive() would return e.g.
> path_untracked for some directory and a later one would return e.g.
> path_none, despite the fact that the directory clearly should have been
> considered untracked.  The code happened to work due to the side-effect
> from the first invocation of adding untracked entries to dir->entries;
> this allowed it to get the correct output despite the supposed override
> in return value by the later call.
> 
> I am somewhat concerned that there are still bugs and maybe even
> testcases with the wrong expectation.

For my part, I recently set up draft PRs to test the 'next' branch in
Scalar [1] and VFS for Git [2]. I'll create a Git installer using these
patches as well so I can run our functional test suite for a little extra
check of the behavior here.

[1] https://github.com/microsoft/scalar/pull/354/files
[2] https://github.com/microsoft/VFSForGit/pull/1645

>  I have tried to carefully
> document treat_directory() since it becomes more complex after this
> change (though much of this complexity came from elsewhere that probably
> deserved better comments to begin with).

I do enjoy your warning comments.

> However, much of my work felt
> more like a game of whackamole while attempting to make the code match
> the existing regression tests than an attempt to create an
> implementation that matched some clear design.  That seems wrong to me,
> but the rules of existing behavior had so many special cases that I had
> a hard time coming up with some overarching rules about what correct
> behavior is for all cases, forcing me to hope that the regression tests
> are correct and sufficient.  Such a hope seems likely to be ill-founded,
> given my experience with dir.c-related testcases in the last few months:
> 
>   Examples where the documentation was hard to parse or even just wrong:
>    * 3aca58045f4f (git-clean.txt: do not claim we will delete files with
>                    -n/--dry-run, 2019-09-17)
>    * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
>                    repository, 2019-09-17)
>    * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
>   Examples where testcases were declared wrong and changed:
>    * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
>                    repository, 2019-09-17)
>    * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
>    * a2b13367fe55 (Revert "dir.c: make 'git-status --ignored' work within
>                    leading directories", 2019-12-10)
>   Examples where testcases were clearly inadequate:
>    * 502c386ff944 (t7300-clean: demonstrate deleting nested repo with an
>                    ignored file breakage, 2019-08-25)
>    * 7541cc530239 (t7300: add testcases showing failure to clean specified
>                    pathspecs, 2019-09-17)
>    * a5e916c7453b (dir: fix off-by-one error in match_pathspec_item,
>                    2019-09-17)
>    * 404ebceda01c (dir: also check directories for matching pathspecs,
>                    2019-09-17)
>    * 09487f2cbad3 (clean: avoid removing untracked files in a nested git
>                    repository, 2019-09-17)
>    * e86bbcf987fa (clean: disambiguate the definition of -d, 2019-09-17)
>    * 452efd11fbf6 (t3011: demonstrate directory traversal failures,
>                    2019-12-10)
>    * b9670c1f5e6b (dir: fix checks on common prefix directory, 2019-12-19)
>   Examples where "correct behavior" was unclear to everyone:
>     https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
>   Other commits of note:
>    * 902b90cf42bc (clean: fix theoretical path corruption, 2019-09-17)

Thanks for all of these pointers. These will be helpful if we ever do find
a regression that bisects to this patch.

> However, on the positive side, it does make the code much faster.  For
> the following simple shell loop in an empty repository:
> 
>   for depth in $(seq 10 25)
>   do
>     dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
>     rm -rf dir
>     mkdir -p $dirs
>     >$dirs/untracked-file
>     /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
>   done
> 
> I saw the following timings, in seconds (note that the numbers are a
> little noisy from run-to-run, but the trend is very clear with every
> run):
> 
>     10: 0.03
>     11: 0.05
>     12: 0.08
>     13: 0.19
>     14: 0.29
>     15: 0.50
>     16: 1.05
>     17: 2.11
>     18: 4.11
>     19: 8.60
>     20: 17.55
>     21: 33.87
>     22: 68.71
>     23: 140.05
>     24: 274.45
>     25: 551.15

These are still impressive.

> For the above run, using strace I can look for the number of untracked
> directories opened and can verify that it matches the expected
> 2^($depth+1)-2 (the sum of 2^1 + 2^2 + 2^3 + ... + 2^$depth).
> 
> After this fix, with strace I can verify that the number of untracked
> directories that are opened drops to just $depth, and the timings all
> drop to 0.00.  In fact, it isn't until a depth of 190 nested directories
> that it sometimes starts reporting a time of 0.01 seconds and doesn't
> consistently report 0.01 seconds until there are 240 nested directories.
> The previous code would have taken
>   17.55 * 2^220 / (60*60*24*365) = 9.4 * 10^59 YEARS
> to have completed the 240 nested directories case.  It's not often
> that you get to speed something up by a factor of 3*10^69.
> 
> Finally, this also fixes the untracked cache, as noted by the test fixes
> in t7063.  Unfortunately, it does so by passing stop_at_first_file to
> close_cached_dir() in order to disable the caching of whether
> directories were empty (this caching was only relevant for directories
> that we knew we didn't need to walk all the entries under but just
> needed to know whether the directory had any entries within it in order
> to know if the directory itself should be marked as path_none or
> path_untracked).  I'm not convinced that disabling the is-the-dir-empty
> check is necessary; there is probably some way to still cache that and
> not get erroneous results.  However, I have not figured out how to do
> so.  If I revert the change to close_cached_dir() in this patch (thus
> continuing to cache cases where stop_at_first_file is true meaning we
> continue to cache whether directories are empty), then the untracked
> cache breakage in t7063 becomes more prevalant.  With my change to
> close_cached_dir() and the other changes to avoid traversing directories
> 2^n times in this patch, I not only avoid making the untracked_cache
> breakage in t7063 worse but actually fix the existing breakage.  Update
> the test results in t7063 to no longer expect check_only cache entries,
> to reflect that we have to do a bit more work in terms of how many
> directories we have to open, and to reflect that we fixed the 1/3 of
> tests that were broken in that testsuite.

We use the untracked cache in Scalar, so we should get some coverage
of that, too.

I'll let you know when the tests are done, and then do a review.

-Stolee
