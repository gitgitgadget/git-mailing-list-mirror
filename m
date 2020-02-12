Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F13CC2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE3D20873
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 13:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpEaq6op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLNvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:51:38 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34071 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLNvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 08:51:38 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so886837ywc.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bRaVf1CABNOv0qaBN0PDThbpi19/iSdZiW+bymmIbMg=;
        b=JpEaq6opfSY+XTK8pkh6e3SXBsAFpCH89DEhLMKDOhlzeylqTPdQ+mJvwFMVdifSnM
         2Gcd6bRPzpHAXfKydi4J31gm4Y/Dec8EBEOG0BkaXMK7ZUQHh1DLw6gMWYaWdLqG5h/u
         hrOyZ0dUI8L1lRO4JM1M2Nz13M0ht7Dc5taVqIRsTQpt2WWAZW9neqp2ImaiugP8dpZI
         jkRG639ZpHaEAQvtWU+cbIrUNq1NLbQ9uwO4MLZtDpMhqsPtGPT5Xx5r5PhQSV/M/Sud
         5FcwT9jdXa0+Cm7Ml0kz1uRC/MAhWbL90p4iz1mU8zC4mnAX2uhBt6RYr/Gm2bLcVkfw
         5CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bRaVf1CABNOv0qaBN0PDThbpi19/iSdZiW+bymmIbMg=;
        b=GUuZfyhs4rBThmFh6/5/q4LdAp7sPNlfiEn666lFPbGc+k0cfjNW/Pf3EpCBuwNtx+
         JgXtcRnbTckosgb+KchFsDkjrYcCkclZcCk61Eu0DXU/DXsCkGEGPhAulanHFt1lYVk4
         utO+t7WCyhP8Xz/XdwWm3j1nXM9+pYubeAbprplA/y5rvrndzNFQ89mzJdhIz4R5kPyz
         2DMoPkkIZJ7abOz4zkmNKO+fgkzd1qD468MF8b4a4f6oq0hMmNvE1azoaYCOi3JIregi
         gHrAyYVoDFuMkYE/M2vqljSQ8KZflAN37Vd0EK5xy9HNJ6/umDCGroLJwREFfSI0tEwb
         xcmA==
X-Gm-Message-State: APjAAAWW2dkRlJ/VJjlLsvliaoSlErwnVxOgXtCtgjAWLyTrfyJ61xEL
        IWZTPaw7qJYTDpWg+IBk/sU=
X-Google-Smtp-Source: APXvYqzNsDUhtAuQQNqoBa8earrHHzDbA0aPgkNwXAnc18f3iaSQ3JoTcl+dgqLcX4cfS/oGH2ql/Q==
X-Received: by 2002:a0d:d602:: with SMTP id y2mr9624846ywd.441.1581515496852;
        Wed, 12 Feb 2020 05:51:36 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d199sm176503ywh.83.2020.02.12.05.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 05:51:36 -0800 (PST)
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Kevin.Willford@microsoft.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@jeffhostetler.com, Garima Singh <garimasigit@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: [ANNOUNCE] Scalar
Message-ID: <b25ebb55-a533-4c5a-43cc-667bf88bc1d5@gmail.com>
Date:   Wed, 12 Feb 2020 08:51:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Git contributors!

Today, we (the Git Ecosystem team at Microsoft) announced our latest
project: Scalar [1]. Scalar is a .NET Core application with installers
available for Windows and macOS. We are considering a Linux port [2].

[1] https://github.com/microsoft/scalar
[2] https://github.com/microsoft/scalar/issues/323

Scalar helps manage Git repositories from the client side. It enables
optional features like `fsmonitor` using some config settings and hooks,
then performs background operations to reduce foreground computations.
These work on any Git repository, but we also have a mode to create a
repository using the GVFS protocol which only works with Azure Repos.
That's how we plan to support the Microsoft Office monorepo. If you want
to read more about Scalar, we put out a blog post about it [3].

[3] https://devblogs.microsoft.com/devops/introducing-scalar/

However, we think that there are more repositories that just need an extra
boost from Scalar. Running "scalar register" in a Git repository will
alert Scalar to start watching it and keep it maintained. We hope that
this mode of Scalar is short-lived: there are a few features that we could
contribute to Git to make this use of Scalar somewhat obsolete.

In this message, I want to share the important ways we are using existing
Git features and hope to contribute more to Git in the future. Most of
these will be suggested as topics for the contributors summit on March 5th.

Current Git features used by Scalar
-----------------------------------

We've been using the following features as critical components.

Sparse-checkout:
The "scalar clone" command creates a repo using the GVFS protocol, but
also uses "git sparse-checkout init --cone" to initialize the repo in cone
mode. Users then set the directories they need, which triggers
pack-file downloads of the missing blobs at HEAD. This was the major
motivation for our interest in the sparse-checkout builtin and performance
recently. Before cone mode, the Office repository could not function with
its 3 million index entries and ~1,200 sparse-checkout patterns. Without
cone mode, it takes 2,800 seconds to update the cache entries compared to
1-2 seconds in cone mode.

Filesystem monitor:
Kevin Willford has been contributing stability updates to the fsmonitor
feature due in part to how we now depend on it. VFS for Git used its own
version of the fsmonitor hook, and it has a connection to a filesystem
driver to get every filesystem event. Tools like Watchman perform similar
tasks, but not quite to the same precision. Kevin's work to update the
hook to v2 helps eliminate race conditions by using Watchman's token
instead of a numerical timestamp.

Partial clone:
The Git client can now handle missing reachable objects! This is huge. The
service-side support is still lacking, especially for Azure Repos, so we
still need to use the GVFS protocol for now. However, Jeff Hostetler
created the `git-gvfs-helper` [4] which is a native process that speaks
the GVFS protocol (a set of REST APIs with `gvfs/` in the route). He
inserted logic to use that instead of the HTTPS transport in Git, and
hooked into the logic for partial clone. The logic for batching the
missing objects into a single pack download when using partial clone can
now speak the GVFS protocol to find those objects. While we don't expect
the Git community to be interested in such a tool upstream, we do expect
that we will find ways to improve our use of it by modifying the partial
clone logic, and those we can contribute upstream to help everyone!

[4] https://github.com/microsoft/git/pull/191


Potential Git features to replace Scalar
--------------------------------------

Parallel checkout:
VFS for Git could get away with a lot by faking that the working directory
was updated. When using actual file updates, we cannot rely on that
behavior, so we need to improve the throughput of workdir updates. Jeff
Hostetler is currently building a parallel version of 'git checkout' and
will have more concrete things to say about it at the summit.

Git-aware/Git-native filesystem monitor:
We are using the 'fsmonitor' hook with Facebook's Watchman [5] tool. While
this is mostly serving our needs, it is slow to start up and slow after
Git changes lots of files in the working directory. It also fails to work
efficiently when directories are excluded by the `.gitignore` file. Kevin
Willford and Johannes Schindelin are working on building a filesystem
watcher as part of Git, or at least very close to Git. They are working
right now on a Windows version since we believe the largest gains can be
found there.

[5] https://github.com/facebook/watchman

`fetch-object` URLs:
VFS for Git and the GVFS protocol have a notion of "cache server" that
provides a different place to acquire objects than the origin remote. This
allows geo-distributed servers to provide Git objects at lower latency and
higher throughput than any one server could do. I believe that we could
provide this functionality in Git by extending the existing `fetch` and
`push` URLs for remotes with a new `fetch-object` URL. We would still use
the `fetch` URL to acquire refs (there are too many race conditions for
the cache servers to duplicate that endpoint) but the `upload-pack`
request would go to the `fetch-object` URL. I hope to discuss this at the
summit, and I will be working on a prototype before then.

Background maintenance:
Git relies on auto-GC for most of its maintenance. An expert user could
determine what alternate maintenance they want and create cron jobs or
schedule background maintenance by other means. We need this to be as
painless as possible for users who don't want to design their own system.
We built Scalar with our opinionated mechanisms for repository
maintenance:

 * Fetch in the background to reduce object transfer in a foreground
   fetch. Background fetch was recently discussed on-list [6]. We use an
   alternate refspec to create refs in refs/scalar/hidden/<remote>/.

[6] https://lore.kernel.org/git/pull.532.v2.git.1579570692766.gitgitgadget@gmail.com/

 * We disable 'fetch.writeCommitGraph' so foreground fetches do not write
   a commit-graph file, but instead update the commit-graph in the
   background. By using the --reachable option, we gather the latest
   commits from the background fetch. We use the incremental commit-graph
   using --size-multiple=4.

 * Clean up loose objects non-destructively. This is less of an
   issue on non-Windows platforms, but it is important that we do not try
   to delete a file that a concurrent Git process could have a handle to,
   or would try to open. For that reason, we perform the following steps
   to clean up loose objects:

   1. git prune-packed
   2. git pack-objects <loose-objects-batch

   where "loose-objects-patch" is a stream of loose objects we find from
   scanning the loose object directories. By running in this order, we
   only delete loose objects that were previously in a pack-file, but not
   the objects that we just put in a pack-file. We run this pair of steps
   once every 24 hours, which is enough time to expect all Git processes
   started before one step to end before the start of the next.

 * Clean up pack-files non-destructively using a similar pair of steps:

   1. git multi-pack-index expire
   2. git multi-pack-index repack --batch-size=X

   By using the multi-pack-index to expire packs with no referenced
   objects, we can be sure that no Git process will attempt to read that
   pack. By repacking a batch of pack-files (our default --batch-size is
   2GB), we can still collect a large number of small packs into a small
   number of larger packs. While this is overall less space-efficient than
   repacking carefully into a single pack-file, the enormous repositories
   would take too long to repack that way and take too many user resources
   in the process.

While I expect that the Git community will have different opinions on what
background maintenance steps we would find valuable, I do think it is
worth considering if background maintenance is at all viable. This is the
part that seems so much different than the expected model for Git, so I'd
be interested in how we could achieve similar results in core Git. Of
course, such maintenance would be highly configurable in both type of
maintenance and frequency.

Thanks for your time. I look forward to any discussions this may start.

Thanks,
-Stolee
