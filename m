Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE6B20248
	for <e@80x24.org>; Wed, 10 Apr 2019 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfDJQY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 12:24:26 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:54823 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfDJQY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 12:24:26 -0400
Received: by mail-vs1-f74.google.com with SMTP id t85so613575vsc.21
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V0P4WLssVQpJsofDa92CJHrPQBMOdHeHemR19nRyp88=;
        b=IvWp6MbJUCLDzkMuAmgf27+D8gDdtMioAUqHxoLXHS2pNrE3NbGayXEvENvdCOS22Z
         res4RwOLfM3HCKTik1pOceLc0t2zdmWYM6HVNX4oMK18UwD8EeKJQD9yaEjQ8WovRbpz
         rKFXDqFv5+/mAowTEEu7PpeiSREINAoOK9cdVOeR2YOuhGjny068+NN0mYEGRNk+gBX1
         Ya+4sFIr8F7no5UdmXWdLWNqV8ynCaiioyo8PPtPRe+qLdQLAVDXCdWE0J9zox43i0Ap
         f0ddLzfQ8zMolmhPI1v8Fd1PyHyVMLrfMrTICRWY7fuVlBAE6oXXgwcYZvga8VSTi/7k
         otrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V0P4WLssVQpJsofDa92CJHrPQBMOdHeHemR19nRyp88=;
        b=ke0QAnOkLB3W+efDvk5wR4ILD4/Swo11xdyktuZWKHkJm7PoKhSACsYI1DecSmj6tE
         osRsY3hDEbVqE01U0sykE5cg5dRoDvcSI7aFBniZ9lJGwew1GyyChq5eD8JNErsO8VZa
         YxCS00sF29zd8E62J07LYpgHXorlTjpN2peJb1qM4Sy0Rvo23HxlajXDYowR34BQOIrx
         jNaQeM1ocwNIdikc3LZER5ore2sNuI1PoWBtWoqyFxP3VUbHvDxXzW2Hlk68QxtwurVn
         jEfqSolBn5EUWMp2EoJ5yD20NIcAOS4UxSy+o6KX4LE/cWetsvs+ZUW+T4uB2WTHVuUl
         F7/Q==
X-Gm-Message-State: APjAAAVkx57D6eVErtu2YC1azxw5KffbT08UqmC9+xbpsFwopI0i7sme
        HXczevP1XuPdOMp9H1ifMvp0uGGCbm1OnMc+aE/uW1uS1xWSPB7q1qObDOjSv5IJVkuQ4Yv6yes
        zsHpKCz5BN3zdiM9C/PrzUjVKndxmcMAD2UPOpbdLyFQkw15XPFqV
X-Google-Smtp-Source: APXvYqxklBK3GeU3CnUy373IEHMGcAmiHI42/WNYN/8ANpyCqFeSlCgBgsvAG86Vu/9XwqC5f8zBsdpA
X-Received: by 2002:a67:8797:: with SMTP id j145mr5049100vsd.12.1554913464335;
 Wed, 10 Apr 2019 09:24:24 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:24:03 -0400
Message-Id: <20190410162409.117264-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6 0/6] blame: add the ability to ignore commits
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

The last patch in the series changes the heuristic by which ignored
lines are attributed to specific lines in the parent commit.  This
increases the likelihood of blaming the 'right' commit, where 'right' is
subjective.  Perhaps we want another algorithm.  I'm using a relatively
simple one that uses the basics of Michael's fingerprinting code, but he
has another algorithm.

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


Barret Rhoden (6):
  Move init_skiplist() outside of fsck
  blame: use a helper function in blame_chunk()
  blame: add the ability to ignore commits and their changes
  blame: add config options to handle output for ignored lines
  blame: optionally track line fingerprints during fill_blame_origin()
  blame: use a fingerprint heuristic to match ignored lines

 Documentation/blame-options.txt |  18 ++
 Documentation/config/blame.txt  |  16 ++
 Documentation/git-blame.txt     |   1 +
 blame.c                         | 446 ++++++++++++++++++++++++++++----
 blame.h                         |   6 +
 builtin/blame.c                 |  56 ++++
 fsck.c                          |  37 +--
 oidset.c                        |  35 +++
 oidset.h                        |   8 +
 t/t5504-fetch-receive-strict.sh |  14 +-
 t/t8013-blame-ignore-revs.sh    | 202 +++++++++++++++
 11 files changed, 740 insertions(+), 99 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh

-- 
2.21.0.392.gf8f6787159e-goog

