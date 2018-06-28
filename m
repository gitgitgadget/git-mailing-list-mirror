Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CE71F516
	for <e@80x24.org>; Thu, 28 Jun 2018 05:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbeF1FLn (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 01:11:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37011 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeF1FLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 01:11:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so2173455plc.4
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 22:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=onqN+nBU4wzCUI1qkEmlEPid5mkFGKhqNXe0xY2dWHE=;
        b=fZus9YHoKT1mBX76DMjol/4ESawUmf72hVjkMyRvPcXKsuL8R3gXOFXHjYmzCUieVn
         dhvX0sqlwcjwzDsayDzUdIhlc6z+4uLaikEaCUcu8XFqMIyFAwsrAsC8pURhQiK+gxbv
         YHtUtubOn2vcYXe5H5HPMbjrL9DDbWszj4dnVD7amWmEafBk5leCyqdnjWRgm5pj4VHU
         ruliabSmCPCBpQVFaDhDE3zk0YL9p+cRq0z3LwDjg7URiOJxDtIPqa59FBXGrY/th4WF
         4bza4GqB9+ZQCXjc+muNa3SweTxjv8csBxd4zWHQkkwXnX4FDuicV+pP2W/IgP/B9ACP
         rbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=onqN+nBU4wzCUI1qkEmlEPid5mkFGKhqNXe0xY2dWHE=;
        b=LdNrzeS1HepDF/V4EB1UWoB/OeqKAO9HxeV7wGQ7Nf6h2QAHvqQWg60Qtcg4jkX2BN
         /IIjzmHruWFyyaVbtUl4GRtjA6iw5sO+I+5S9AGS/xQGv4YB2Yvr+aqLNZvHOtmrdG8z
         C8mfpgobY7MuCNKpQIs8X2T/lVdgluJPbxQDAIO2W3yHkf1M1Jnx0tgZXVqjUJIcZOgi
         kOAOdAQr2+fPS1F/uhnVJNCaok0Hl6v8GA7RPHcDGUwhKZUVTyrbQtaTJRxtaZk3lu5U
         tgQEzLgsLLhUWoOmaRgLghqYdaKAH5eBG5oWRc/tUAmZ+tSxGzfzsR1RqZdxtiuehMe7
         /wOQ==
X-Gm-Message-State: APt69E28I9Nvkcqd2Sym6+9pUgQcQKf0Bgh3bozt9jIMI3kpo32xhgbb
        4mrQiUZtWM0T/1vHw/xLe09X//VVz8FG2PD6BZHWaT5W
X-Google-Smtp-Source: ADUXVKK2X9IFYKi1exdmM3CedgZW2VKICKNYM+4U4R461Au7nY8LtCLoAfiNg5gz9psiLKNGa94u+JCCt9pGBCQkrxQ=
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11-v6mr8809188plb.25.1530162699469;
 Wed, 27 Jun 2018 22:11:39 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Welch <gwelch925@gmail.com>
Date:   Wed, 27 Jun 2018 22:11:03 -0700
Message-ID: <CAMYKhtUi3nCmTjZ8pXbNCxaKa6h9+1OSD7YitTeip+807w7dJA@mail.gmail.com>
Subject: Inconsistencies in commit-graph technical docs.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently read the "Supercharging the Git Commit Graph" blog by
Derrick Stolee. I found the article interesting and wanted to verify
the performance numbers for myself. Then that led me to want to know
more about the implementation, so I read the technical design notes in
commit-graph.txt, and then I jumped into the format documentation in
commit-graph-format.txt.

Along the way, I noticed a few issues. They might just be errors in
the documentation, but I figured it was worth documenting my entire
process just to be sure.

"Supercharging the Git Commit Graph", by Derrick Stolee:
  https://blogs.msdn.microsoft.com/devops/2018/06/25/supercharging-the-git-commit-graph/

# TL;DR

I found a few discrepencies between the documentation in
commit-graph-format.txt and the results that I observed for myself.

1. The "Commit Data" chunk signature is documented to be 'CGET', but
it should be 'CDAT'.

commit-graph.c:18
  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */

2. The "no parent" value is documented to be 0xffffffff, but is
actually 0x70000000.

commit-graph.c:34
  #define GRAPH_PARENT_NONE 0x70000000

3. The "generation" field isn't set on any of the commits. (I don't
know what to make of this.)

# Documented Process

Just to follow along, here are the details about my local repo. I
don't have any local changes; I just track upstream.

repo:    git/git
remotes: git://git.kernel.org/pub/scm/git/git.git (origin)
branch:  master
commit:  ed843436dd4924c10669820cc73daf50f0b4dabd

os:      MacOS 10.11.6 (El Capitan)
git:     2.18.0

Just to be clear, I am following the details as described in:
  /Documentation/technical/commit-graph-format.txt

# Create the commit-graph File

As a setup step, I have to prepare the commit-graph file as described
in the blog post.

  $ git show-ref -s | git commit-graph write --stdin-commits

# Verify SHA1 Checksum

Starting at the end first because like most (all?) of git's binary
formats, there is a SHA1 checksum that verifies the integrity of the
file. Everything checks out fine.

  $ < .git/objects/info/commit-graph tail -c 20 | xxd -p
  35507183b1e9546f9e4844f0796d630daebc85d8

  $ < .git/objects/info/commit-graph wc -c
  3037156

  $ < .git/objects/info/commit-graph head -c $((3037156-20)) | sha1sum
  35507183b1e9546f9e4844f0796d630daebc85d8  -

# Header

The header looks good:
* signature:   CGPH
* version:     1
* hash:        1 (SHA1)
* "chunks":    4
* "reserved":  (ignored)

  $ < .git/objects/info/commit-graph xxd -l8
  00000000: 4347 5048 0101 0400                      CGPH....

# Chunk Lookup, Problem: CGET/CDAT

I have all of the documented "chunks". but it appears, that the
documentation is wrong for the "Commit Data" chunk. The document
signature is 'CGET', but I'm getting 'CDAT'.

* OIDF, Object ID Fanout:   0x44
* OIDL, Object ID Lookup:   0x444
* CDAT, Commit Data:        0x108f58
* EDGE, Large Edge List:    0x2e577c
*     , terminating label:  0x2e57d0

  $ < .git/objects/info/commit-graph xxd -s8 -l$(((4+1)*12)) -c12 -g4
  00000008: 4f494446 00000000 00000044  OIDF.......D
  00000014: 4f49444c 00000000 00000444  OIDL.......D
  00000020: 43444154 00000000 00108f58  CDAT.......X
  0000002c: 45444745 00000000 002e567c  EDGE......V|
  00000038: 00000000 00000000 002e57d0  ..........W.

# OID Fanout

Not much to tell here, but since it's important, I'll just show last
line so know how many commits are recorded in the file. Everything
checks out that I have 54209 commits in my local repo.

  $ < .git/objects/info/commit-graph xxd -s0x44 -l$((256*4)) -c4 -g4
  ...
  00000440: 0000d3c1

  $ echo $((0x0000d3c1))
  54209

  $ git rev-list --all | wc -l
    54209

# OID Lookup

Again, not much to see here; just an alphanumeric, sequential list off
all the commit ids.

  $ < .git/objects/info/commit-graph xxd -s0x444 -l$((54209*20)) -c20 -g20
  ...
  00108f44: fffe694d607ea683b5d08ee99a46d9b06cb74006  ..iM`~.......F..l.@.

  $ git cat-file -p fffe694d607ea683b5d08ee99a46d9b06cb74006
  tree 1241274386e9d5dabaf370477ff19ba0eb36c3c2
  parent 84dee6bbc9eb6dd8e613414ed0271d8290549e89
  author Eric Wong <normalperson@yhbt.net> 1168151155 -0800
  committer Junio C Hamano <junkio@cox.net> 1168152528 -0800
  ...

# Commit Data

This is where I start to see inconsistencies with the documented format.

  $ < .git/objects/info/commit-graph xxd -s0x108f58
-l$((54209*(20+16))) -c36 -g4
  ...
  002e5658: 12412743 86e9d5da baf37047 7ff19ba0 eb36c3c2 00006dea
70000000 00000000 45a097d0

From the above 'git cat-file' command, we can confirm the tree is correct.

tree:        1241274386e9d5dabaf370477ff19ba0eb36c3c2
parent1:     00006dea
parent2:     70000000
generation:  00000000
timestamp:   45a097d0

As does the timestamp.

  $ date --date @$((0x45a097d0)) +%s
  1168152528

Parent #1 looks good as well.

  < .git/objects/info/commit-graph xxd -s$((0x444+(0x00006dea*20)))
-l20 -c20 -g20
  00089a8c: 84dee6bbc9eb6dd8e613414ed0271d8290549e89

## Problem: Parent #2

Parent #2 (70000000), however appears to be a mystery value. The value
is way too high to actually be in the OID Lookup table. And, the only
documented magic numbers are 0xffffffff (no parent) and
0x80000000|0x??????? (octopus merge; see: Last Edge List).

## Problem: Generation

Also, none of these objects have their 'generation' field set.

  $ < .git/objects/info/commit-graph xxd -s0x108f58
-l$((54209*(20+16))) -c36 -g4 | grep 00000000 | wc -l
    54209

## Check Octopus Merges

The final "chunk", Large Edge List, is for handling the extra data
from octopus merge commits. Since I can't conceive of a fancy xxd
command to that could list them, I have to go the long way round to
find an example of one.

  $ git rev-list --all --min-parents=3 | wc -l
      35

  $ git rev-list --all --min-parents=3
  25bf951381a4880c43a3d1c65e6dce651e61148f
  ...

  $ < .git/objects/info/commit-graph xxd -s0x444 -l$((54209*20)) -c20
-g20 | grep 25bf951381a4880c43a3d1c65e6dce651e61148f
  0002706c: 25bf951381a4880c43a3d1c65e6dce651e61148f  %.......C...^m.e.a..

  $ echo $(((0x0002706c-0x444)/20))
  7938

  $ < .git/objects/info/commit-graph xxd -s$((0x444+(7938*20))) -l20 -c20 -g20
  0002706c: 25bf951381a4880c43a3d1c65e6dce651e61148f  %.......C...^m.e.a..

  $ < .git/objects/info/commit-graph xxd -s$((0x108f58+(7938*36))) -l36 -c36 -g4
  0014eba0: ce9488df 264bc29a 37b47932 0fad03c9 3a470db7 000004c7
80000011 00000000 594dbf30

  $ git dump 25bf951381a4880c43a3d1c65e6dce651e61148f
  tree ce9488df264bc29a37b479320fad03c93a470db7
  parent 05ec6e13aaf33b6a647e1321203a770e697eea9a
  parent a84f3e59ebde9e891275ef8325c432db6bdf950c
  parent dc8441fdb4598f54865a5c783d1f86c1e0bcb6dc
  author Junio C Hamano <gitster@pobox.com> 1498083644 -0700
  committer Junio C Hamano <gitster@pobox.com> 1498267440 -0700

  $ < .git/objects/info/commit-graph xxd -s$((0x444+(0x000004c7*20)))
-l20 -c20 -g20
  000063d0: 05ec6e13aaf33b6a647e1321203a770e697eea9a

In the above commands, I was able to find a merge commit with more
than 2 parents using git-rev-list. From there, I was able to find that
commit in the "OID Lookup" table and determine it's position. With
that position, I was able to find the "Commit Data" associated with
it. Finally, the git-cat-file confirms that the tree is correct and
that the first parent commit is correct (after performing another OID
lookup).

Now it's just a matter of reviewing the last chunk to learn more about 80000011.

## Naive Solution for Finding Octopus Merges

In a repo with very few octopus merges, I would expect this to work
100% of the time. However, I doubt that it will work for a repo like
linux/linux that have a lot of commits that are merged through octopus
merges.

This assumes that '80000' won't occur in the tree OID, parent1,
generation, nor the timestamp. Seems like a fair bet, but qualifies as
naive.

I tested using '8000', but it created too many false positives. For
git/git, '800000' works just as well as '80000', but would more likely
to under report elsewhere.

  $ < .git/objects/info/commit-graph xxd -s0x108f58
-l$((54209*(20+16))) -c36 -g4 | grep 80000 | wc -l
      35

  $ < .git/objects/info/commit-graph xxd -s0x108f58
-l$((54209*(20+16))) -c36 -g4 | grep 80000
  ...
  0014eba0: ce9488df 264bc29a 37b47932 0fad03c9 3a470db7 000004c7
80000011 00000000 594dbf30
  ...

# Last Edge List

Finally, I can get a list of all the commits that have been a
parent2-N on an octopus merge.

  $ < .git/objects/info/commit-graph xxd -s0x2e567c
-l$((0x2e57d0-0x2e567c)) -c4 -g4 | wc -l
      85

And, I should be able to confirm the other parents from the example
above. In the following command '0x11' comes from 80000011, '4' is the
number of "bytes" that are used to for OID Lookup, and '2' for the
number of N-1 parents that were on the octopus merge.

  $ < .git/objects/info/commit-graph xxd -s$((0x2e567c+0x11*4))
-l$((4*2)) -c4 -g4
  002e56c0: 00008ac3  ....
  002e56c4: 8000b603  ....

Which works out perfectly.

  $ < .git/objects/info/commit-graph xxd -s$((0x444+(0x00008ac0*20)))
-l20 -c20 -g20
  000adb44: a849d36cf2877a1890371851710382f463290978  .I.l..z..7.Qq...c).x

  $ < .git/objects/info/commit-graph xxd -s$((0x444+(0x0000b603*20)))
-l20 -c20 -g20
  000e3c80: dc8441fdb4598f54865a5c783d1f86c1e0bcb6dc  ..A..Y.T.Z\x=.......

# terminating label

With the 'terminating' chunk, we can see the SHA1 checksum which I
already covered at the beginning.

  $ < .git/objects/info/commit-graph xxd -s0x2e57d0 -g20 -c20
  002e57d0: 35507183b1e9546f9e4844f0796d630daebc85d


--
-grant welch
-gwelch925@gmail.com
