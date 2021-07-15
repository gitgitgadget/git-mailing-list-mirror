Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C1C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABB0613CF
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 00:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGOAsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhGOAsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:48:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0316C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so4958524wmb.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4G93HvUbypxL40PZTxO9azNfHX/zr6GJiPxepeTZg2A=;
        b=K3fAIzlS1dTaHdh1N/0lp+Gom6yQYTH1TJWi1iZoZCiCMN9xEmg5/WNn/qKya+czJ4
         ECpiWrA70qByP4807dX3XRwxqzQqVzrEpDyl9d/seDXEYhCxbAZvTh1a0RyK8ZIdHqfz
         vpYgOGKtMe89YUDtU+6KRHrLBQnZyNfEBfW1jC+esHZTyGUQubngvMBQzcgwk9zUiMZC
         E8zKFg5S2doVGsigd9nsDYbrx6HQXWR/Sjeg0gxCTirsiCHtRQ+I37dNHHmo+3NAofAK
         xzjMNO2w5ZhJzMN2aCnXfd79N4X0cnHpf63ualChetq+3rbTWcnRRZhJj2g8ZGI9grbz
         WEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4G93HvUbypxL40PZTxO9azNfHX/zr6GJiPxepeTZg2A=;
        b=evpl9PwVNd5dDTVw43ZYpeyZSfPk4KuHkoKiM1t1c3o3TaCjdYZ7whFzJdCxtG5iEO
         zKz7ntpPCQG/9UhqOFpWOBlcZxNIWESSyFAUdXCItABHpwPwQE57uIpB0UzEA+8yscgU
         eJuIiHNrNe9Z64n41QH3mr747Ebwh7BEDXz2XTWsrWU6mYC/am7dyW49jwChKxeIoR55
         dfOTA5bBMr9+6/ndBFDwv3anepN5tT8a2qdrST6izGqGoNeIqwZ41ZY9QMS+24hUHIfv
         nancVVZcBCDb6AylbbhaSvt+TXy/1cVLWrgOrhqDfsNZgjcvO/ITOrtE0iKpiAc75EY6
         zeeQ==
X-Gm-Message-State: AOAM531SE5CwaIAa3e329MwmSGnGBOirvav4BN4bemtsnKQoega+rWfS
        Wi2vihmMDCEiNrDyGIK0gW8UHQCO9JU=
X-Google-Smtp-Source: ABdhPJwDYpNndWfUPT/aynjqJzrvA20bXpSDm3vhVpd/nztmt1x/dibsAeuym+dsPa8/MLgXVDHxoA==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr3627028wms.165.1626309928242;
        Wed, 14 Jul 2021 17:45:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm4371713wru.6.2021.07.14.17.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 17:45:27 -0700 (PDT)
Message-Id: <b41278b6680f8b1f59e73c4eab24595a33f2f3c5.1626309924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
        <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 00:45:24 +0000
Subject: [PATCH v3 4/4] Bump rename limit defaults (yet again)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These were last bumped in commit 92c57e5c1d29 (bump rename limit
defaults (again), 2011-02-19), and were bumped both because processors
had gotten faster, and because people were getting ugly merges that
caused problems and reporting it to the mailing list (suggesting that
folks were willing to spend more time waiting).

Since that time:
  * Linus has continued recommending kernel folks to set
    diff.renameLimit=0 (maps to 32767, currently)
  * Folks with repositories with lots of renames were happy to set
    merge.renameLimit above 32767, once the code supported that, to
    get correct cherry-picks
  * Processors have gotten faster
  * It has been discovered that the timing methodology used last time
    probably used too large example files.

The last point is probably worth explaining a bit more:

  * The "average" file size used appears to have been average blob size
    in the linux kernel history at the time (probably v2.6.25 or
    something close to it).
  * Since bigger files are modified more frequently, such a computation
    weights towards larger files.
  * Larger files may be more likely to be modified over time, but are
    not more likely to be renamed -- the mean and median blob size
    within a tree are a bit higher than the mean and median of blob
    sizes in the history leading up to that version for the linux
    kernel.
  * The mean blob size in v2.6.25 was half the average blob size in
    history leading to that point
  * The median blob size in v2.6.25 was about 40% of the mean blob size
    in v2.6.25.
  * Since the mean blob size is more than double the median blob size,
    any file as big as the mean will not be compared to any files of
    median size or less (because they'd be more than 50% dissimilar).
  * Since it is the number of files compared that provides the O(n^2)
    behavior, median-sized files should matter more than mean-sized
    ones.

The combined effect of the above is that the file size used in past
calculations was likely about 5x too large.  Combine that with a CPU
performance improvement of ~30%, and we can increase the limits by
a factor of sqrt(5/(1-.3)) = 2.67, while keeping the original stated
time limits.

Keeping the same approximate time limit probably makes sense for
diff.renameLimit (there is no progress feedback in e.g. git log -p),
but the experience above suggests merge.renameLimit could be extended
significantly.  In fact, it probably would make sense to have an
unlimited default setting for merge.renameLimit, but that would
likely need to be coupled with changes to how progress is displayed.
(See https://lore.kernel.org/git/YOx+Ok%2FEYvLqRMzJ@coredump.intra.peff.net/
for details in that area.)  For now, let's just bump the approximate
time limit from 10s to 1m.

(Note: We do not want to use actual time limits, because getting results
that depend on how loaded your system is that day feels bad, and because
we don't discover that we won't get all the renames until after we've
put in a lot of work rather than just upfront telling the user there are
too many files involved.)

Using the original time limit of 2s for diff.renameLimit, and bumping
merge.renameLimit from 10s to 60s, I found the following timings using
the simple script at the end of this commit message (on an AWS c5.xlarge
which reports as "Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz"):

      N   Timing
   1300    1.995s
   7100   59.973s

So let's round down to nice even numbers and bump the limits from
400->1000, and from 1000->7000.

Here is the measure_rename_perf script (adapted from
https://lore.kernel.org/git/20080211113516.GB6344@coredump.intra.peff.net/
in particular to avoid triggering the linear handling from
basename-guided rename detection):

    #!/bin/bash

    n=$1; shift

    rm -rf repo
    mkdir repo && cd repo
    git init -q -b main

    mkdata() {
      mkdir $1
      for i in `seq 1 $2`; do
        (sed "s/^/$i /" <../sample
         echo tag: $1
        ) >$1/$i
      done
    }

    mkdata initial $n
    git add .
    git commit -q -m initial

    mkdata new $n
    git add .
    cd new
    for i in *; do git mv $i $i.renamed; done
    cd ..
    git rm -q -rf initial
    git commit -q -m new

    time git diff-tree -M -l0 --summary HEAD^ HEAD

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/diff.txt  | 2 +-
 Documentation/config/merge.txt | 2 +-
 diff.c                         | 2 +-
 merge-ort.c                    | 2 +-
 merge-recursive.c              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index d1b5cfa3542..32f84838ac1 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -120,7 +120,7 @@ diff.orderFile::
 diff.renameLimit::
 	The number of files to consider in the exhaustive portion of
 	copy/rename detection; equivalent to the 'git diff' option
-	`-l`.  If not set, the default value is currently 400.  This
+	`-l`.  If not set, the default value is currently 1000.  This
 	setting has no effect if rename detection is turned off.
 
 diff.renames::
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 7cd6d7883b6..e27cc639447 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -37,7 +37,7 @@ merge.renameLimit::
 	rename detection during a merge.  If not specified, defaults
 	to the value of diff.renameLimit.  If neither
 	merge.renameLimit nor diff.renameLimit are specified,
-	currently defaults to 1000.  This setting has no effect if
+	currently defaults to 7000.  This setting has no effect if
 	rename detection is turned off.
 
 merge.renames::
diff --git a/diff.c b/diff.c
index 2454e34cf6d..0244a371d32 100644
--- a/diff.c
+++ b/diff.c
@@ -35,7 +35,7 @@
 
 static int diff_detect_rename_default;
 static int diff_indent_heuristic = 1;
-static int diff_rename_limit_default = 400;
+static int diff_rename_limit_default = 1000;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static int diff_color_moved_default;
diff --git a/merge-ort.c b/merge-ort.c
index b954f7184a5..8a84375e940 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2558,7 +2558,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.rename_limit = opt->rename_limit;
 	if (opt->rename_limit <= 0)
-		diff_opts.rename_limit = 1000;
+		diff_opts.rename_limit = 7000;
 	diff_opts.rename_score = opt->rename_score;
 	diff_opts.show_rename_progress = opt->show_rename_progress;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/merge-recursive.c b/merge-recursive.c
index 4327e0cfa33..f19f8cc37bd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1879,7 +1879,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	 */
 	if (opts.detect_rename > DIFF_DETECT_RENAME)
 		opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = (opt->rename_limit >= 0) ? opt->rename_limit : 1000;
+	opts.rename_limit = (opt->rename_limit >= 0) ? opt->rename_limit : 7000;
 	opts.rename_score = opt->rename_score;
 	opts.show_rename_progress = opt->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
gitgitgadget
