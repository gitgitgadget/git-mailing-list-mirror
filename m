Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79CF1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390266AbfFJPaY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:30:24 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:38997 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389786AbfFJPaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:23 -0400
Received: by mail-vk1-f202.google.com with SMTP id d14so613452vka.6
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JJ6lkZUu1p9Q7dPwsrMUKF1fuMHfJXqRvKRS0BvdamM=;
        b=hdyYiW5NJMYS8TvGUohKGtPd08ReqhF0XWg4KsgyHskhUhbvoNqjEqZsvBnLuCwID/
         pNf99e8dUC4zSHvLK6OaW2oCNauLJAFMNCX5jhDvOY1baF1aTUUrTQv0sYgX0hqpe/R5
         D41rHuEh3rbpDU4CW4ZQ/iYoMiY0Bz9Qw66fpI4vjjwc2fyc657WAmJaFuPmuhsd9uWi
         SRtxr8iSn/fM9m8vLBs+H4A9+OOTwqZ9CuZzF2A9HBgsnqRz3LaDLS3n/X8RbP+HyT5N
         GP5ewuydr+cjq7Wd2vZ1rxQHKlC7Do48uubdqgBvflc/zHh3de96r4vDuv4P3AQ8Uar1
         EkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JJ6lkZUu1p9Q7dPwsrMUKF1fuMHfJXqRvKRS0BvdamM=;
        b=sk1aZScWX7EtKMCVv/gx6drqL5E8yFePVGj++IfrmjF4LELikAnRxjVQTbn5fyl2i2
         RkKi30S9tcZj/Vr4cxtK9R8xuvdr9/PX4oBeCbL4GtZDdV5Kwzm1AENWK/BtRuPb5cuq
         w+6Hnu8eErbTHvKxe16uCy4bSqtzLFEm8qHHGHkkU+sibZeMhVnTZT/6p6iGrmMcb6NI
         4jP8yadr4ejxcnX05/bSlrS1Pt3q4gEholVDij3ABT/+fWjEzESzX8XyojjAJ3bRKPX4
         dRobJDsxYVlGmUdkZIysAWcTWZRXdLEq7GZR8df27OcRO6oavk9FJzZl5us9/6QzMzyC
         /Grw==
X-Gm-Message-State: APjAAAXy8pCTh8Qd5SBarz8+R+K2bQ0ocP9c8X/PkQ+keR0SYP4Gi/kF
        0hSDM/fiLlDqozEpF8JqTIzWbXznu7JzpO1e/TonC/PM1qhNyP9ezpWqNyuqC+olR3YBjEC/j1K
        NtZSW+odzF26lMfu3Z46cpwZ51BCHhD3CvsFHV8XCO7iRNYQQyGLN
X-Google-Smtp-Source: APXvYqzlqMsNT+seKdnA0BJ1w43Oqv6Yr0hf8eItTyijn/5Czds32birU9LG5MNsFgnEaCCNzSBx6BhE
X-Received: by 2002:a67:6485:: with SMTP id y127mr8793642vsb.19.1560180622240;
 Mon, 10 Jun 2019 08:30:22 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:30:05 -0400
Message-Id: <20190610153014.42055-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v8 0/9] blame: add the ability to ignore commits
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set adds the ability to ignore a set of commits and their
changes when blaming.  This can be used to ignore a commit deemed 'not
interesting,' such as reformatting.

The main changes to this patchset from previous versions are in the area
of test portability and coverage.

v7 -> v8
v7: https://public-inbox.org/git/20190515214503.77162-1-brho@google.com
- Added Junio's fixes for test portability.
- Removed unreachable code exposed by Derrick's test coverage report.
- Added a test to ensure blame_coalesce() is covered.
- Rebased onto master.

v6 -> v7
v6: https://public-inbox.org/git/20190410162409.117264-1-brho@google.com
- Split the init_skiplist commit into two commits: "change variable
  names" then "move the function".
- Fixed the test's usage of grep, from grep "\+" to grep -E "+".
- Fixed comments related to fsck.skipList, added them to
  config/blame.txt
- A line in the blame output is either "ignored" or "unblamable", not
  both.
- Changed the way we mark lines.  In particular, we don't zero-out the
  hash anymore for unblamables, since all zeros already had a meaning.
  We also distinguish between ignored and unblamable.  Here's the new
  style:
	? for ignored
	* for unblamable
  Both of those markings are controlled by config vars; the discussion
  on the list shows that no default style works for everyone:
        if blame.markIgnoredLines
	    Line was attributed to a commit that was not the most recent
	    to change it (i.e. the ignored commit) and will be marked
	    with '?'.  Lines touched by an ignored commit that we could
	    not blame on another are unmarked.
        if blame.markUnblamableLines
	    Lines touched by an ignored commit that we could not blame
	    on another are marked with *.  I wanted to differentiate
	    between Ignored and Unblamable, so a single ? isn't enough.
- Added Michael's fuzzy fingerprinting code.
- We guess_line_blames() for an entire chunk, instead of per-blame
  entry.  A diff chunk can be made up of more than one blame_entry,
  which made the job of the heuristic unnecessarily difficult.
- Rebased onto master.

v5 -> v6
v5: https://public-inbox.org/git/20190403160207.149174-1-brho@google.com/
- The "guess" heuristic can now look anywhere in the parent file for a
  matching line, instead of just looking in the parent chunk.  The
  chunks passed to blame_chunk() are smaller than you'd expect: they are
  just adjacent '-' and '+' sections.  Any diff 'context' is a chunk
  boundary.
- Fixed the parent_len calculation.  I had been basing it off of
  e->num_lines, and treating the blame entry as if it was the target
  chunk, but the individual blame entries are subsets of the chunk.  I
  just pass the parent chunk info all the way through now.
- Use Michael's newest fingerprinting code, which is a large speedup.
- Made a config option to zero the hash for an ignored line when the
  heuristic could not find a line in the parent to blame.  Previously,
  this was always 'on'.
- Moved the for loop variable declarations out of the for ().
- Rebased on master.

v4 -> v5
v4: https://public-inbox.org/git/20190226170648.211847-1-brho@google.com/
- Changed the handling of blame_entries from ignored commits so that you
  can use any algorithm you want to map lines from the diff chunk to
  different parts of the parent commit.
- fill_origin_blob() optionally can track the offsets of the start of
  every line, similar to what we do in the scoreboard for the final
  file.  This can be used by the matching algorithm.  It has no effect
  if you are not ignoring commits.
- RFC of a fuzzy/fingerprinting heuristic, based on Michael Platings RFC
  at https://public-inbox.org/git/20190324235020.49706-2-michael@platin.gs/
- Made the tests that detect unblamable entries more resilient to
  different heuristics.
- Fixed a few bugs:
	- tests were not grepping the line number from --line-porcelain
	  correctly.
	- In the old version, when I passed the "upper" part of the
	  blame entry to the target and marked unblamable, the suspect
	  was incorrectly marked as the parent.  The s_lno was also in
	  the parent's address space.

v3 -> v4
v3: https://public-inbox.org/git/20190212222722.240676-1-brho@google.com/
- Cleaned up the tests, especially removing usage of sed -i.
- Squashed the 'tests' commit into the other blame commits.  Let me know
  if you'd like further squashing.

v2 -> v3
v2: https://public-inbox.org/git/20190117202919.157326-1-brho@google.com/
- SHA-1 -> "object name", and fixed other comments
- Changed error string for oidset_parse_file()
- Adjusted existing fsck tests to handle those string changes
- Return hash of all zeros for lines we know we cannot identify
- Allow repeated options for blame.ignoreRevsFile and
  --ignore-revs-file.  An empty file name resets the list.  Config
  options are parsed before the command line options.
- Rebased to master
- Added regression tests

v1 -> v2
v1: https://public-inbox.org/git/20190107213013.231514-1-brho@google.com/
- extracted the skiplist from fsck to avoid duplicating code
- overhauled the interface and options
- split out markIgnoredFiles
- handled merges


Barret Rhoden (8):
  fsck: rename and touch up init_skiplist()
  Move oidset_parse_file() to oidset.c
  blame: use a helper function in blame_chunk()
  blame: add the ability to ignore commits and their changes
  blame: add config options for the output of ignored or unblamable
    lines
  blame: optionally track line fingerprints during fill_blame_origin()
  blame: use the fingerprint heuristic to match ignored lines
  blame: add a test to cover blame_coalesce()

Michael Platings (1):
  blame: add a fingerprint heuristic to match ignored lines

 Documentation/blame-options.txt |   19 +
 Documentation/config/blame.txt  |   16 +
 Documentation/git-blame.txt     |    1 +
 blame.c                         | 1016 +++++++++++++++++++++++++++++--
 blame.h                         |    6 +
 builtin/blame.c                 |   56 ++
 fsck.c                          |   37 +-
 oidset.c                        |   35 ++
 oidset.h                        |    8 +
 t/t5504-fetch-receive-strict.sh |   14 +-
 t/t8003-blame-corner-cases.sh   |   36 ++
 t/t8013-blame-ignore-revs.sh    |  274 +++++++++
 t/t8014-blame-ignore-fuzzy.sh   |  432 +++++++++++++
 13 files changed, 1851 insertions(+), 99 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh
 create mode 100755 t/t8014-blame-ignore-fuzzy.sh

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

