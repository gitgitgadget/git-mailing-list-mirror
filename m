Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A133C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbhLUSFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhLUSFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F4C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2285501wmj.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GTmGoCtrINbyEJQ8Z0xLQykqqx04NIXxgt6F/0wHyiE=;
        b=UmqLqgDUvHAgX6lJhGfLBnTcv/iXzPzXP2bBsteFgvfLQfVGjBFUfwspu6V9LghgFS
         jf9d75UECTM98aFeOlUyCGEt0YSvdIl4ztXPDrWpoZT0hWGKdsRpf3wgZUTA0CzmoFjA
         r7qS6xnzbdz5YOEartzeM21MSDThxW8A+qbP+gu1CZoJrSgOhcR08Mpa3MSK+LF8qoVU
         5Giz9+W88k9P5p1ZWw9XkF77SA5RCJabEfZvf+sUj0SY1GH3QC1OycMLZ45e2cMF0mID
         c6eRy9KQyG/dohHnRfeDiDiCrh7BBOGhJSJQTDlwaBuG767M7D+fuh6s9OFI8rD8kwRv
         A5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GTmGoCtrINbyEJQ8Z0xLQykqqx04NIXxgt6F/0wHyiE=;
        b=JjQzRsfivXB6n2JWQvVjzqDwyMdeUPeB4XIgBFxxahYfcBV46pigXsdTlVkwf9L8F8
         IA1iNtbp4YCzt7a1KQS48lcRnNEDSvdgJQtkq8FtQ92X1zp5u73hfQAKLWqOXGcHaBIp
         oMUn0JzGvtrV2ZdK2Jr/tUIPdXpn2jL5hkMu2UXPwNyLG2eBbGy3IdT2SyVPCsUzZmg2
         fEuoSD93r1sMJYR3RLcgO/Cj/oUjJTYT+cLYhVw7JI9UtXGTAJMFf9/WDZAM5Q5Vd+vq
         /ThcDjIqQFUK1NddWctX6eSpMKr/GGLbaV6WJI514nOcolJ9BVkRUULrURP17ucjW7ff
         5HwQ==
X-Gm-Message-State: AOAM5322r1+qndLbgsvD2xWJ+eEnui8+7WowezcD2WnLNmoazhjThVwb
        6Go2KS6kROQ74l136LB3uUY6BK/By/Q=
X-Google-Smtp-Source: ABdhPJySqwmaeMcPYCf+meL4mmlXylckm8png9aCw1wlCo8PCplDd5VcFkWNA3GlIqs3qXRYd6DiJg==
X-Received: by 2002:a05:600c:1f18:: with SMTP id bd24mr3793201wmb.174.1640109950178;
        Tue, 21 Dec 2021 10:05:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm15898932wro.58.2021.12.21.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:49 -0800 (PST)
Message-Id: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:39 +0000
Subject: [PATCH 0/9] Add a new --remerge-diff capability to show & log
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some patches to add a --remerge-diff capability to show & log,
which works by comparing merge commits to an automatic remerge (note that
the automatic remerge tree can contain files with conflict markers).

Changes since original submission[1]:

 * Rebased on top of the version of ns/tmp-objdir that Neeraj submitted
   (Neeraj's patches were based on v2.34, but ns/tmp-objdir got applied on
   an old commit and does not even build because of that).
 * Modify ll-merge API to return a status, instead of printing "Cannot merge
   binary files" on stdout[2] (as suggested by Peff)
 * Make conflict messages and other such warnings into diff headers of the
   subsequent remerge-diff rather than appearing in the diff as file content
   of some funny looking filenames (as suggested by Peff[3] and Junio[4])
 * Sergey ack'ed the diff-merges.c portion of the patches, but that wasn't
   limited to one patch so not sure where to record that ack.

[1]
https://lore.kernel.org/git/pull.1080.git.git.1630376800.gitgitgadget@gmail.com/;
GitHub wouldn't let me change the target branch for the PR, so I had to
create a new one with the new base and thus the reason for not sending this
as v2 even though it is. [2]
https://lore.kernel.org/git/YVOZRhWttzF18Xql@coredump.intra.peff.net/,
https://lore.kernel.org/git/YVOZty9D7NRbzhE5@coredump.intra.peff.net/ [3]
https://lore.kernel.org/git/YVOXPTjsp9lrxmS6@coredump.intra.peff.net/ [4]
https://lore.kernel.org/git/xmqqr1d7e4ug.fsf@gitster.g/

=== FURTHER BACKGROUND (original cover letter material) ==

Here are some example commits you can try this out on (with git show
--remerge-diff $COMMIT):

 * git.git conflicted merge: 07601b5b36
 * git.git non-conflicted change: bf04590ecd
 * linux.git conflicted merge: eab3540562fb
 * linux.git non-conflicted change: 223cea6a4f05

Many more can be found by just running git log --merges --remerge-diff in
your repository of choice and searching for diffs (most merges tend to be
clean and unmodified and thus produce no diff but a search of '^diff' in the
log output tends to find the examples nicely).

Some basic high level details about this new option:

 * This option is most naturally compared to --cc, though the output seems
   to be much more understandable to most users than --cc output.
 * Since merges are often clean and unmodified, this new option results in
   an empty diff for most merges.
 * This new option shows things like the removal of conflict markers, which
   hunks users picked from the various conflicted sides to keep or remove,
   and shows changes made outside of conflict markers (which might reflect
   changes needed to resolve semantic conflicts or cleanups of e.g.
   compilation warnings or other additional changes an integrator felt
   belonged in the merged result).
 * This new option does not (currently) work for octopus merges, since
   merge-ort is specific to two-parent merges[1].
 * This option will not work on a read-only or full filesystem[2].
 * We discussed this capability at Git Merge 2020, and one of the
   suggestions was doing a periodic git gc --auto during the operation (due
   to potential new blobs and trees created during the operation). I found a
   way to avoid that; see [2].
 * This option is faster than you'd probably expect; it handles 33.5 merge
   commits per second in linux.git on my computer; see below.

In regards to the performance point above, the timing for running the
following command:

time git log --min-parents=2 --max-parents=2 $DIFF_FLAG | wc -l


in linux.git (with v5.4 checked out, since my copy of linux is very out of
date) is as follows:

DIFF_FLAG=--cc:            71m 31.536s
DIFF_FLAG=--remerge-diff:  31m  3.170s


Note that there are 62476 merges in this history. Also, output size is:

DIFF_FLAG=--cc:            2169111 lines
DIFF_FLAG=--remerge-diff:  2458020 lines


So roughly the same amount of output as --cc, as you'd expect.

As a side note: git log --remerge-diff, when run in various repositories and
allowed to run all the way back to the beginning(s) of history, is a nice
stress test of sorts for merge-ort. Especially when users run it for you on
their repositories they are working on, whether intentionally or via a bug
in a tool triggering that command to be run unexpectedly. Long story short,
such a bug in an internal tool existed last December and this command was
run on an internal repository and found a platform-specific bug in merge-ort
on some really old merge commit from that repo. I fixed that bug (a
STABLE_QSORT thing) while upstreaming all the merge-ort patches in the mean
time, but it was nice getting extra testing. Having more folks run this on
their repositories might be useful extra testing of the new merge strategy.

Also, I previously mentioned --remerge-diff-only (a flag to show how
cherry-picks or reverts differ from an automatic cherry-pick or revert, in
addition to showing how merges differ from an automatic merge). This series
does not include the patches to introduce that option; I'll submit them
later.

Two other things that might be interesting but are not included and which I
haven't investigated:

 * some mechanism for passing extra merge options through (e.g.
   -Xignore-space-change)
 * a capability to compare the automatic merge to a second automatic merge
   done with different merge options. (Not sure if this would be of interest
   to end users, but might be interesting while developing new a
   --strategy-option, or maybe checking how changing some default in the
   merge algorithm would affect historical merges in various repositories).

[1] I have nebulous ideas of how an Octopus-centric ORT strategy could be
written -- basically, just repeatedly invoking ort and trying to make sure
nested conflicts can be differentiated. For now, though, a simple warning is
printed that octopus merges are not handled and no diff will be shown. [2]
New blobs/trees can be written by the three-way merging step. These are
written to a temporary area (via tmp-objdir.c) under the git object store
that is cleaned up at the end of the operation, with the new loose objects
from the remerge being cleaned up after each individual merge.

Elijah Newren (9):
  tmp_objdir: add a helper function for discarding all contained objects
  ll-merge: make callers responsible for showing warnings
  merge-ort: capture and print ll-merge warnings in our preferred
    fashion
  merge-ort: mark a few more conflict messages as omittable
  merge-ort: make path_messages available to external callers
  diff: add ability to insert additional headers for paths
  merge-ort: format messages slightly different for use in headers
  show, log: provide a --remerge-diff capability
  doc/diff-options: explain the new --remerge-diff option

 Documentation/diff-options.txt |  8 ++++
 apply.c                        |  5 ++-
 builtin/checkout.c             | 12 ++++--
 builtin/log.c                  | 16 ++++++++
 diff-merges.c                  | 12 ++++++
 diff.c                         | 34 ++++++++++++++++-
 diff.h                         |  1 +
 ll-merge.c                     | 40 ++++++++++---------
 ll-merge.h                     |  9 ++++-
 log-tree.c                     | 70 ++++++++++++++++++++++++++++++++++
 merge-blobs.c                  |  5 ++-
 merge-ort.c                    | 49 +++++++++++++++++++++---
 merge-ort.h                    | 10 +++++
 merge-recursive.c              |  8 +++-
 merge-recursive.h              |  1 +
 notes-merge.c                  |  5 ++-
 rerere.c                       | 10 +++--
 revision.h                     |  6 ++-
 t/t6404-recursive-merge.sh     |  9 ++++-
 t/t6406-merge-attr.sh          |  9 ++++-
 tmp-objdir.c                   |  5 +++
 tmp-objdir.h                   |  6 +++
 22 files changed, 288 insertions(+), 42 deletions(-)


base-commit: 4e44121c2d7bced65e25eb7ec5156290132bec94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1103%2Fnewren%2Fremerge-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1103/newren/remerge-diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1103
-- 
gitgitgadget
