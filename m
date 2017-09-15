Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E879220281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdIOUns (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:43:48 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:54302 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdIOUnr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:43:47 -0400
Received: by mail-pg0-f42.google.com with SMTP id c137so2138289pga.11
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=vZFgbAWWEy89XM8GVjB/ZPe+N/rq8vueMOmpeGRTBlk=;
        b=Lyv/kYAxYPA9WEmXTgTrZ4oGGofIfmdlG2p2/BvSa2xhnSPh0XgC9+tLh+sqKPZPhl
         W42xKBLSTPTdXnCdyJbhEnz5BWCIy2134iBYhVI3R6t4O574WWHwE5xvSj2QGNDrMWYo
         NW0rEE/GsZedheJR9undifz8T7hBz4XQS72PNmfqU0l5AN+2F9jvyeq7V4eyXvTQ8iEO
         XlHcm3vylvf2ckGMuHKThzQA4B0Bt1XK5CQc6MkGKC0Ch4j6f2q1F7nxmQY4W0KenP6T
         b9ixrzGd7HDzkblwULk2qnUZx7gwgbPSGgjqp3L8sJHvANOc2WKrbD31wzeUXNoNOa0r
         XgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=vZFgbAWWEy89XM8GVjB/ZPe+N/rq8vueMOmpeGRTBlk=;
        b=r3WNLmc2KVMD9ByMwseQCS0rvxjKAqpzcClu2+9nbyO+NqWgKkrM8vuMKRYJa+ipaE
         54qBWpDkWxhQ7ZF7q6yqKDzV7a0UWsgVqzIPRZY7K0YmL54lbWISGFeqzGpl9NWry67N
         ma11MU8dl35TEQtENus7E+Rsfy6h7ToXzE+OxEjPYfsSrTukGF0iDbQ15bTo+O8FOvOn
         stRsU5+SE8ehDV5UNV73VPGVLCm/zxhWCtQev+6bqdmeR+Qs5kfXVeR32lnJ2yd69Rcm
         tCZyNgdiIjEHEo1aQ90+ozJ6ng1qZPIlVHLqFFITHr9BBQP8JxnDRj82hw1PZ+ojWMlm
         p5uA==
X-Gm-Message-State: AHPjjUgPLzfHxiQx/80/PZw0jgg7qmvBVTxl5F8AZ8aPdmA7FQEZHvH+
        KO63fF70qUwKsUvSFHs5wQ==
X-Google-Smtp-Source: ADKCNb6JicFluDzJbmyC4QZx+g2iFU8v2/Ps2PQy3dOZlz7vUZL8a268wdJTovyQPDwSIlKxEt+B7A==
X-Received: by 10.84.131.103 with SMTP id 94mr22037210pld.302.1505508226467;
        Fri, 15 Sep 2017 13:43:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:48c5:a795:146c:44c6])
        by smtp.gmail.com with ESMTPSA id m6sm3387146pfm.103.2017.09.15.13.43.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 13:43:46 -0700 (PDT)
Date:   Fri, 15 Sep 2017 13:43:43 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     peartben@gmail.com, Christian Couder <christian.couder@gmail.com>,
        git@jeffhostetler.com
Subject: RFC: Design and code of partial clones (now, missing commits and
 trees OK)
Message-ID: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For those interested in partial clones and/or missing objects in repos,
I've updated my original partialclone patches to not require an explicit
list of promises. Fetch/clone still only permits exclusion of blobs, but
the infrastructure is there for a local repo to support missing trees
and commits as well.

They can be found here:

https://github.com/jonathantanmy/git/tree/partialclone2

To make the number of patches more manageable, I have omitted support
for a custom fetching hook (but it can be readded in fetch-object.c),
and only support promisor packfiles for now (but I don't have any
objection to supporting promisor loose objects in the future).

Let me know what you think of the overall approach. In particular, I'm
still wondering if there is a better approach than to toggle
"fetch_if_missing" whenever we need lazy fetching (or need to suppress
it).

Also, if there any patches that you think might be useful to others, let
me know and I'll send them to this mailing list for review.

A demo and an overview of the design (also available from that
repository's README):

Demo
====

Obtain a repository.

    $ make prefix=$HOME/local install
    $ cd $HOME/tmp
    $ git clone https://github.com/git/git

Make it advertise the new feature and allow requests for arbitrary blobs.

    $ git -C git config uploadpack.advertiseblobmaxbytes 1
    $ git -C git config uploadpack.allowanysha1inwant 1

Perform the partial clone and check that it is indeed smaller. Specify
"file://" in order to test the partial clone mechanism. (If not, Git will
perform a local clone, which unselectively copies every object.)

    $ git clone --blob-max-bytes=100000 "file://$(pwd)/git" git2
    $ git clone "file://$(pwd)/git" git3
    $ du -sh git2 git3
    116M	git2
    129M	git3

Observe that the new repo is automatically configured to fetch missing objects
from the original repo. Subsequent fetches will also be partial.

    $ cat git2/.git/config
    [core]
    	repositoryformatversion = 1
    	filemode = true
    	bare = false
    	logallrefupdates = true
    [remote "origin"]
    	url = [snip]
    	fetch = +refs/heads/*:refs/remotes/origin/*
    	blobmaxbytes = 100000
    [extensions]
    	partialclone = origin
    [branch "master"]
    	remote = origin
    	merge = refs/heads/master

Unlike in an older version of this code (see the `partialclone` branch), this
also works with the HTTP/HTTPS protocols.

Design
======

Local repository layout
-----------------------

A repository declares its dependence on a *promisor remote* (a remote that
declares that it can serve certain objects when requested) by a repository
extension "partialclone". `extensions.partialclone` must be set to the name of
the remote ("origin" in the demo above).

A packfile can be annotated as originating from the promisor remote by the
existence of a "(packfile name).promisor" file with arbitrary contents (similar
to the ".keep" file). Whenever a promisor remote sends an object, it declares
that it can serve every object directly or indirectly referenced by the sent
object.

A promisor packfile is a packfile annotated with the ".promisor" file. A
promisor object is an object in a promisor packfile. A promised object is an
object directly referenced by a promisor object.

(In the future, we might need to add ".promisor" support to loose objects.)

Connectivity check and gc
-------------------------

The object walk done by the connectivity check (as used by fsck and fetch) stops
at all promisor objects and promised objects.

The object walk done by gc also stops at all promisor objects and promised
objects. Only non-promisor packfiles are deleted (if pack deletion is
requested); promisor packfiles are left alone. This maintains the distinction
between promisor packfiles and non-promisor packfiles. (In the future, we might
need to do something more sophisticated with promisor packfiles.)

Fetching of promised objects
----------------------------

When `sha1_object_info_extended()` (or similar) is invoked, it will
automatically attempt to fetch a missing object from the promisor remote if that
object is not in the local repository. For efficiency, no check is made as to
whether that object is a promised object or not.

This automatic fetching can be toggled on and off by the `fetch_if_missing`
global variable, and it is on by default.

The actual fetch is done through the fetch-pack/upload-pack protocol. Right now,
this uses the fact that upload-pack allows blob and tree "want"s, and this
incurs the overhead of the unnecessary ref advertisement. I hope that protocol
v2 will allow us to declare that blob and tree "want"s are allowed, and allow
the client to declare that it does not want the ref advertisement. All packfiles
downloaded in this way are annotated with ".promisor".

Fetching with `git fetch`
-------------------------

The fetch-pack/upload-pack protocol has also been extended to support omission
of blobs above a certain size. The client only allows this when fetching from
the promisor remote, and will annotate any packs received from the promisor
remote with ".promisor".

