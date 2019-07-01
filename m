Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6641F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfGAOqB (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:46:01 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41489 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAOqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:46:01 -0400
Received: by mail-qt1-f201.google.com with SMTP id e39so13536733qte.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/e64JBKVFOqgVCrYxrVdCT1xh0yjDU9e3COYl4KIzy8=;
        b=QC+5chXcXtBzWXpUyx43uB5Bm1vtdkrY1AvOhs0y23XohKdErrPRiRaBAbr6GGxMJ1
         skN780KKUCMHhwGsr5OV6b0QM1aXk5tseE7OWVf0pvi/fySRqIPiwgowtOAJwvh6Lsnl
         dcq8SvpGtcUYmHb8DPkjbRIfkP6lB0zc4eyM2GL3ylu7cXM1Z2sg1NeFV3Rgq1ahZCe1
         jSY7w2Wjciw6iFEzhTYF0YIYflI2JWhKsME7qm2e6yrrlkHOwz4TQXpmIZMlUm0nFRYd
         iraNdGjj1tFDRzjn6Q1EZjDlzq0xumm8QhFB9omjoW5u5HJo9lBA/FJz4GVCJnf8y21f
         KSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/e64JBKVFOqgVCrYxrVdCT1xh0yjDU9e3COYl4KIzy8=;
        b=PKRa2sv2ZERbUGPwt1q/qBgNjh3eD8ECaIPi1uRX2tysJY9hq/8Epjt6vCHLo8yvTF
         ip++vc+A5eccrDRVruCMQ3UVG7/VfYMqnLrlq7bYK7wjF9WUZ2vxB40Cp4o0MpI5+zQU
         ASY6s5IU2iFM+4dtR8WLySlzQwjZt9PuFOhEIJWaOKIyKbaMxUESbymsuDgsOss5hvFT
         NnVbPymo/yZ7y2NLY/GiQWy4ejO4bvFWAq7JQtCnAjn5o9hx/pSpTqYj6jseNwG5Nw8d
         Ud6uH8r3m61Pu2ZY0XzFnQM+pHL0pevB1u2Z53X3YxFkc75lZ+R3Tm00rdKaJOoLXd0c
         rzbg==
X-Gm-Message-State: APjAAAWprA9tD8Vtc827n71FnQ4s/+3xjFhk6m788sUqfGQ3C9B+Nwgs
        iHYT33TpcPp6xbyQSS5Rkl0UWjqbsvMLHg+iPZ0EMu6YASvWviHFG90zT31f3xIrphIwAFSSGxe
        fcUML77tRXKKKuyx/WDptrIgaJaKWsokZeEkqKaWGCslvtzjsrH1u
X-Google-Smtp-Source: APXvYqwvCN0hw8v7VY4vMoHlZZajyp7vi+YytqwMVgIo07EXzhHf5zdmiX8BvOGQEcnoMF4xWFDNaNbE
X-Received: by 2002:a0c:8a23:: with SMTP id 32mr22113027qvt.231.1561992359940;
 Mon, 01 Jul 2019 07:45:59 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:45:39 -0400
Message-Id: <20190701144548.129635-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v10 0/9] blame: add the ability to ignore commits
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

v9 -> v10
v9: https://public-inbox.org/git/20190620163820.231316-1-brho@google.com
- Fixed left-over unused variables
- Removed unnecessary braces in t8014
- Rebased onto master

v8 -> v9
v8: https://public-inbox.org/git/20190610153014.42055-1-brho@google.com
- Fixed tests that had git-blame's output piped to another command
- Rebased onto master

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
 blame.c                         | 1015 +++++++++++++++++++++++++++++--
 blame.h                         |    6 +
 builtin/blame.c                 |   56 ++
 fsck.c                          |   37 +-
 oidset.c                        |   35 ++
 oidset.h                        |    8 +
 t/t5504-fetch-receive-strict.sh |   14 +-
 t/t8003-blame-corner-cases.sh   |   36 ++
 t/t8013-blame-ignore-revs.sh    |  274 +++++++++
 t/t8014-blame-ignore-fuzzy.sh   |  437 +++++++++++++
 13 files changed, 1855 insertions(+), 99 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh
 create mode 100755 t/t8014-blame-ignore-fuzzy.sh

-- 
2.22.0.410.gd8fdbe21b5-goog

