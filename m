Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE4C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiCWOre (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiCWOrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:47:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324D3506FD
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:46:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a8so3288273ejc.8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QaUrs4oqzSoUQqHFmD/J7fSFFi/KpZ5/oVpDhenE3sI=;
        b=QMDYi2Asx6D0coP1YMyd42LclVV9Nw/o2Ja7iTz4+OoPBwF7FahFqOkPgVIVa6XvqS
         K8yvQEX9+dDk5GYawoSU+jsUJE+qd5qzSPsHRnjfS7ll4YF5VpiNkMUOnN6nTqXWImva
         Zqr5/dXjQcpjAR6wu990m7OflYd1zDvKxQO+F5yY5NxO6FEB+LyP/a7XoLeHsyClDKcs
         bho4ZhP2YweSd0+hwsUwbom6Rba434EKywF1HYkJcnqUScxEkSYi23RDBbtkcR+VpjaX
         H+fp2HhAg1YOI4Rqehp5N5kwKw5eaFD+6dMLviqxV4JyhK4X7XycOfYTMc4tdvKFAYsQ
         C7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QaUrs4oqzSoUQqHFmD/J7fSFFi/KpZ5/oVpDhenE3sI=;
        b=qYb3J5DnfH0cXIfzbmjDex8g3Ex6khDJNkhNSQaBWJSZ/JMiYPK5i3SkTmX7ZmMkn8
         3uf11YAArdLLwbWbCqxV1oRoF2LPx5W9E9NKe0CYMt8ffqJEaxR5dOqrjka0ouuhtZnK
         ZTMZTHDxrWXfgIUqIYYHruRbk19Hzv6c7/UDtwHypCcQE/UkKtkwkkNNQ+4vuTRcx3Fc
         54PFkqFQ91bR3WMaSyNs3OInT35qB4xLCt2oKAoH9vsJyoiKZWnUuzQHL3qxCjaGlCSU
         ywf78ZaHg5IcLx0jGmviiNJ32tvX3twth+6ISmjkomN0heGXjSd/AnpcNCs6ru+x82tZ
         +uAA==
X-Gm-Message-State: AOAM530QYA4R//sXcJlR+PgOJ7dbBF5BtvDOD09xwW0QpbX7V9P5gdbC
        G4lvvUpSmhBA052ZTFdp3g8=
X-Google-Smtp-Source: ABdhPJxQaWvLjGfo2c5QFEfmCaC8IjQZotiRQZu0JnfzvZNjMEwHFKWZVqtVZsgVmbbYaoFPSoFrrg==
X-Received: by 2002:a17:906:99c2:b0:6df:8834:4f4c with SMTP id s2-20020a17090699c200b006df88344f4cmr322084ejn.496.1648046760433;
        Wed, 23 Mar 2022 07:46:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm89051eda.2.2022.03.23.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:45:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nX2FL-000qQ8-82;
        Wed, 23 Mar 2022 15:45:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     gitgitgadget@gmail.com, Johannes.Schindelin@gmx.de,
        bagasdotme@gmail.com, git@vger.kernel.org, neerajsi@microsoft.com,
        newren@gmail.com, ps@pks.im, rsbecker@nexbridge.com,
        sandals@crustytoothpaste.net
Subject: do we have too much fsync() configuration in 'next'? (was: [PATCH
 v7] core.fsync: documentation and user-friendly aggregate options)
Date:   Wed, 23 Mar 2022 15:20:52 +0100
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <20220315191245.17990-1-neerajsi@microsoft.com>
Message-ID: <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 15 2022, Neeraj Singh wrote:

I know this is probably 80% my fault by egging you on about initially
adding the wildmatch() based thing you didn't go for.

But having looked at this with fresh eyes quite deeply I really think
we're severely over-configuring things here:

> +core.fsync::
> +	A comma-separated list of components of the repository that
> +	should be hardened via the core.fsyncMethod when created or
> +	modified.  You can disable hardening of any component by
> +	prefixing it with a '-'.  Items that are not hardened may be
> +	lost in the event of an unclean	system shutdown. Unless you
> +	have special requirements, it is recommended that you leave
> +	this option empty or pick one of `committed`, `added`,
> +	or `all`.
> ++
> +When this configuration is encountered, the set of components starts with
> +the platform default value, disabled components are removed, and additional
> +components are added. `none` resets the state so that the platform default
> +is ignored.
> ++
> +The empty string resets the fsync configuration to the platform
> +default. The default on most platforms is equivalent to
> +`core.fsync=committed,-loose-object`, which has good performance,
> +but risks losing recent work in the event of an unclean system shutdown.
> ++
> +* `none` clears the set of fsynced components.
> +* `loose-object` hardens objects added to the repo in loose-object form.
> +* `pack` hardens objects added to the repo in packfile form.
> +* `pack-metadata` hardens packfile bitmaps and indexes.
> +* `commit-graph` hardens the commit graph file.
> +* `index` hardens the index when it is modified.
> +* `objects` is an aggregate option that is equivalent to
> +  `loose-object,pack`.
> +* `derived-metadata` is an aggregate option that is equivalent to
> +  `pack-metadata,commit-graph`.
> +* `committed` is an aggregate option that is currently equivalent to
> +  `objects`. This mode sacrifices some performance to ensure that work
> +  that is committed to the repository with `git commit` or similar commands
> +  is hardened.
> +* `added` is an aggregate option that is currently equivalent to
> +  `committed,index`. This mode sacrifices additional performance to
> +  ensure that the results of commands like `git add` and similar operations
> +  are hardened.
> +* `all` is an aggregate option that syncs all individual components above.
> +
>  core.fsyncMethod::
>  	A value indicating the strategy Git will use to harden repository data
>  	using fsync and related primitives.

On top of my
https://lore.kernel.org/git/RFC-patch-v2-7.7-a5951366c6e-20220323T140753Z-avarab@gmail.com/
which makes the tmp-objdir part of your not-in-next-just-seen follow-up
series configurable via "fsyncMethod.batch.quarantine" I really think we
should just go for something like the belwo patch (note that
misspelled/mistook "bulk" for "batch" in that linked-t patch, fixed
below.

I.e. I think we should just do our default fsync() of everything, and
probably SOON make the fsync-ing of loose objects the default. Those who
care about performance will have "batch" (or "writeout-only"), which we
can have OS-specific detections for.

But really, all of the rest of this is unduly boxing us into
overconfiguration that I think nobody really needs.

If someone really needs this level of detail they can LD_PRELOAD
something to have fsync intercept fd's and paths, and act appropriately.

Worse, as the RFC series I sent
(https://lore.kernel.org/git/RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com/)
shows we can and should "batch" up fsync() operations across these
configuration boundaries, which this level of configuration would seem
to preclude.

Or, we'd need to explain why "core.fsync=loose-object" won't *actually*
call fsync() on a single loose object's fd under "batch" as I had to do
on top of this in
https://lore.kernel.org/git/RFC-patch-v2-6.7-c20301d7967-20220323T140753Z-avarab@gmail.com/

The same is going to apply for almost all of the rest of these
configuration categories.

I.e. a natural follow-up to e.g. batching across objects & index as I'm
doing in
https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753Z-avarab@gmail.com/
is to do likewise for all the PACK-related stuff before we rename it
in-place. Or even have "git gc" issue only a single fsync() for all of
PACKs, their metadata files, commit-graph etc., and then rename() things
in-place as appropriate afterwards.

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 365a12dc7ae..536238e209b 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -548,49 +548,35 @@ core.whitespace::
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsync::
-	A comma-separated list of components of the repository that
-	should be hardened via the core.fsyncMethod when created or
-	modified.  You can disable hardening of any component by
-	prefixing it with a '-'.  Items that are not hardened may be
-	lost in the event of an unclean	system shutdown. Unless you
-	have special requirements, it is recommended that you leave
-	this option empty or pick one of `committed`, `added`,
-	or `all`.
-+
-When this configuration is encountered, the set of components starts with
-the platform default value, disabled components are removed, and additional
-components are added. `none` resets the state so that the platform default
-is ignored.
-+
-The empty string resets the fsync configuration to the platform
-default. The default on most platforms is equivalent to
-`core.fsync=committed,-loose-object`, which has good performance,
-but risks losing recent work in the event of an unclean system shutdown.
-+
-* `none` clears the set of fsynced components.
-* `loose-object` hardens objects added to the repo in loose-object form.
-* `pack` hardens objects added to the repo in packfile form.
-* `pack-metadata` hardens packfile bitmaps and indexes.
-* `commit-graph` hardens the commit graph file.
-* `index` hardens the index when it is modified.
-* `objects` is an aggregate option that is equivalent to
-  `loose-object,pack`.
-* `derived-metadata` is an aggregate option that is equivalent to
-  `pack-metadata,commit-graph`.
-* `committed` is an aggregate option that is currently equivalent to
-  `objects`. This mode sacrifices some performance to ensure that work
-  that is committed to the repository with `git commit` or similar commands
-  is hardened.
-* `added` is an aggregate option that is currently equivalent to
-  `committed,index`. This mode sacrifices additional performance to
-  ensure that the results of commands like `git add` and similar operations
-  are hardened.
-* `all` is an aggregate option that syncs all individual components above.
+	A boolen defaulting to `true`. To ensure data integrity git
+	will fsync() its objects, index and refu updates etc. This can
+	be set to `false` to disable `fsync()`-ing.
++
+Only set this to `false` if you know what you're doing, and are
+prepared to deal with data corruption. Valid use-cases include
+throwaway uses of repositories on ramdisks, one-off mass-imports
+followed by calling `sync(1)` etc.
++
+Note that the syncing of loose objects is currently excluded from
+`core.fsync=true`. To turn on all fsync-ing you'll need
+`core.fsync=true` and `core.fsyncObjectFiles=true`, but see
+`core.fsyncMethod=batch` below for a much faster alternative that's
+just as safe on various modern OS's.
++
+The default is in flux and may change in the future, in particular the
+equivalent of the already-deprecated `core.fsyncObjectFiles` setting
+might soon default to `true`, and `core.fsyncMethod`'s default of
+`fsync` might default to a setting deemed to be safe on the local OS,
+suc has `batch` or `writeout-only`
 
 core.fsyncMethod::
 	A value indicating the strategy Git will use to harden repository data
 	using fsync and related primitives.
 +
+Defaults to `fsync`, but as discussed for `core.fsync` above might
+change to use one of the values below taking advantage of
+platform-specific "faster `fsync()`".
++
 * `fsync` uses the fsync() system call or platform equivalents.
 * `writeout-only` issues pagecache writeback requests, but depending on the
   filesystem and storage hardware, data added to the repository may not be
@@ -680,8 +666,8 @@ backed up by any standard (e.g. POSIX), but worked in practice on some
 Linux setups.
 +
 Nowadays you should almost certainly want to use
-`core.fsync=loose-object` instead in combination with
-`core.fsyncMethod=bulk`, and possibly with
+`core.fsync=true` instead in combination with
+`core.fsyncMethod=batch`, and possibly with
 `fsyncMethod.batch.quarantine=true`, see above. On modern OS's (Linux,
 OSX, Windows) that gives you most of the performance benefit of
 `core.fsyncObjectFiles=false` with all of the safety of the old
