Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E11C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhK2W3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhK2W2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:25 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E7C096768
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:07 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m5so19034654ilh.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cC2BNVpbewKrGx1Gmtmu0NyYyBD/lH/03FqfYaU6lnM=;
        b=wzfPSHRp4tr0uVxKxZ/dGbCakd0Osphp/+pSd5dTSQUL4PFM2mD9QMt+wp6fsackCD
         9nMoD3ixglHd15IFpOeKGs6pk2iVZwg6kcM+F0i2Zm7x+B2L2jIeRIDPsFP8Hk4oc95l
         mKSuDD1BGqKHtR6lq9Sa2kkQFqhx6IU0b3hN/Z9UcmZGX1L6U2bBwRH9nK0bm+uvj4rN
         akxbZo+wmFQihlmkaSmwO1rFIxxqd/BRf/NiCcqn9kfn//soE53OGZzpo9KgoM2DMiku
         opeYm0fNn4kA3LawukpmAULU52Yb6ao8WGzEdPDcq8k49d53QOJom0e27M95geIJgnff
         9R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cC2BNVpbewKrGx1Gmtmu0NyYyBD/lH/03FqfYaU6lnM=;
        b=0vGsWWpNeewfk24KWF05QDVmw0ZWwE0oyQ3aoZN+EJJuZUYusHnje7y94fzGrjBH/5
         2Ax5uCAibHam7qTEfQ5mu13BBv7ocJy1EYftq8q4WyeeCp2+kbdEmajH9LR4bH+YRPbO
         koWlBaYFFaddmqo5nmlHSLSzlMSk/oC7Dv9jHep0Gj/J2fp/Amlxpb1hkhGAAUBCt2xz
         M5jSpbsDoCwIi3RvE/XRP4776m+YFUYl3a4psnbgpvS6eNqMbfCparxazMRgMPCZZcAX
         PMTa0t8c/bJWMuqyx5I0WeXUNgIwqLi4qM86uva3HID9n8rq6rSdmS4yrwV/r/oFFPbi
         ej6A==
X-Gm-Message-State: AOAM5332BhSxaBqt2hP8XfBdhXWGlXbFC9vN59bcFF9gxR0cvbQfab5M
        5jxSExQ0XdGzWCWBpWCTo97sb/EsHjOgF4qk
X-Google-Smtp-Source: ABdhPJx8z2Oa+XC7B/Ym40H06xIzoOBtZxvjhb0F3AVsvTIQCQb8kWFC4wYtgkWiREwziPLyYTSXNQ==
X-Received: by 2002:a05:6e02:1a2d:: with SMTP id g13mr59233901ile.134.1638224706455;
        Mon, 29 Nov 2021 14:25:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d4sm2900741ilq.53.2021.11.29.14.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:06 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a technical document to explain cruft packs. It contains a brief
overview of the problem, some background, details on the implementation,
and a couple of alternative approaches not considered here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/Makefile                  |  1 +
 Documentation/technical/cruft-packs.txt | 95 +++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/technical/cruft-packs.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae..0b01c9408e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -91,6 +91,7 @@ TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += technical/bundle-format
+TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/technical/cruft-packs.txt
new file mode 100644
index 0000000000..bb54cce1b1
--- /dev/null
+++ b/Documentation/technical/cruft-packs.txt
@@ -0,0 +1,95 @@
+= Cruft packs
+
+Cruft packs offer an alternative to Git's traditional mechanism of removing
+unreachable objects. This document provides an overview of Git's pruning
+mechanism, and how cruft packs can be used instead to accomplish the same.
+
+== Background
+
+To remove unreachable objects from your repository, Git offers `git repack -Ad`
+(see linkgit:git-repack[1]). Quoting from the documentation:
+
+[quote]
+[...] unreachable objects in a previous pack become loose, unpacked objects,
+instead of being left in the old pack. [...] loose unreachable objects will be
+pruned according to normal expiry rules with the next 'git gc' invocation.
+
+Unreachable objects aren't removed immediately, since doing so could race with
+an incoming push which may reference an object which is about to be deleted.
+Instead, those unreachable objects are stored as loose object and stay that way
+until they are older than the expiration window, at which point they are removed
+by linkgit:git-prune[1].
+
+Git must store these unreachable objects loose in order to keep track of their
+per-object mtimes. If these unreachable objects were written into one big pack,
+then either freshening that pack (because an object contained within it was
+re-written) or creating a new pack of unreachable objects would cause the pack's
+mtime to get updated, and the objects within it would never leave the expiration
+window. Instead, objects are stored loose in order to keep track of the
+individual object mtimes and avoid a situation where all cruft objects are
+freshened at once.
+
+This can lead to undesirable situations when a repository contains many
+unreachable objects which have not yet left the grace period. Having large
+directories in the shards of `.git/objects` can lead to decreased performance in
+the repository. But given enough unreachable objects, this can lead to inode
+starvation and degrade the performance of the whole system. Since we
+can never pack those objects, these repositories often take up a large amount of
+disk space, since we can only zlib compress them, but not store them in delta
+chains.
+
+== Cruft packs
+
+Cruft packs are designed to eliminate the need for storing unreachable objects
+in a loose state by including the per-object mtimes in a separate file alongside
+a single pack containing all loose objects.
+
+A cruft pack is written by `git repack --cruft` when generating a new pack.
+linkgit:git-pack-objects[1]'s `--cruft` option. Note that `git repack --cruft`
+is a classic all-into-one repack, meaning that everything in the resulting pack is
+reachable, and everything else is unreachable. Once written, the `--cruft`
+option instructs `git repack` to generate another pack containing only objects
+not packed in the previous step (which equates to packing all unreachable
+objects together). This progresses as follows:
+
+  1. Enumerate every object, marking any object which is (a) not contained in a
+     kept-pack, and (b) whose mtime is within the grace period as a traversal
+     tip.
+
+  2. Perform a reachability traversal based on the tips gathered in the previous
+     step, adding every object along the way to the pack.
+
+  3. Write the pack out, along with a `.mtimes` file that records the per-object
+     timestamps.
+
+This mode is invoked internally by linkgit:git-repack[1] when instructed to
+write a cruft pack. Crucially, the set of in-core kept packs is exactly the set
+of packs which will not be deleted by the repack; in other words, they contain
+all of the repository's reachable objects.
+
+When a repository already has a cruft pack, `git repack --cruft` typically only
+adds objects to it. An exception to this is when `git repack` is given the
+`--cruft-expiration` option, which allows the generated cruft pack to omit
+expired objects instead of waiting for linkgit:git-gc[1] to expire those objects
+later on.
+
+It is linkgit:git-gc[1] that is typically responsible for removing expired
+unreachable objects.
+
+== Alternatives
+
+Notable alternatives to this design include:
+
+  - The location of the per-object mtime data, and
+  - Whether cruft packs should be incremental or not.
+
+On the location of mtime data, a new auxiliary file tied to the pack was chosen
+to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
+support for optional chunks of data, it may make sense to consolidate the
+`.mtimes` format into the `.idx` itself.
+
+Incremental cruft packs (i.e., where each time a repository is repacked a new
+cruft pack is generated containing only the unreachable objects introduced since
+the last time a cruft pack was written) are significantly more complicated to
+construct, and so aren't pursued here. The obvious drawback to the current
+implementation is that the entire cruft pack must be re-written from scratch.
-- 
2.34.1.25.gb3157a20e6

