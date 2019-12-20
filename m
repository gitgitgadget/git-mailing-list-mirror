Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C666C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631662064B
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLYvT3mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLTSOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39136 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTSOd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so5317582pga.6
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8I6eQFMtiHcH/F2QZsi4OiEUoYa6yruLPqm+XkBj6o=;
        b=JLYvT3mt5MgfTBKsi/pzjgSvez0Ogr3BaKkTM//C4Bmp+3dH+3rOWEDTh60EknLtxt
         IF0WnM9sPhLWuq+j3WWwtKuFV1CrASWt1YhfBSDNJ3eMmi/u0Ss43mlTyT7vJW0BWc3z
         xjIkZbBA3JU0OaH2ItR3S65OSUNAEH4bW3JKcHYDxGuaTeJDhbM/U287IK2q7vvncMaF
         MsTPK5TPdXlxovvoB1wfgPFAeJw+3V6PDjmZRW4gd5UEM3zrJGM87yZVLjZYIh49YpIF
         Ryu0+WpqPi1UI2yemd4f2gCPt9QTKxwgfnP7fF1vMOBnb4buUxYarCiRswCHgVZDQNqL
         LGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8I6eQFMtiHcH/F2QZsi4OiEUoYa6yruLPqm+XkBj6o=;
        b=F2RELPqBGlfde9AqkyXfLnGlRLRQqUaRfOPUl4PVob9OnN4cLJBgn6dfcyG9rYDFIh
         DB/2Fz6P3/6s6PaosSCZYXilgVxi0j1kOKze+aA3f4Emqm+sjAc/qpK8OxbgiGa8qKjL
         MOsJtK6XoYqQ/w6DdNjbw5O5AOwWLLj96e/k/SU7h3SQ9gjc9PiC5Ewu6zeQ1lcdVAmq
         VIKmnBvtRlYfRkWwNzdSqX6v3ZZ2gLkwiaGXmMSQFAl1qpU8UfAaeXYAXXoGD11bOLAe
         Fe3glGWrakwFBaxQFbymUQKlfhbjjpByZq8QTN5IjN4nndcMXOekK+35QQPVwJqKyuKM
         9Lsg==
X-Gm-Message-State: APjAAAVeKLpt90emUqMM6HNe4mGHmGaNqT5WxrbKd7QbBIs7y5huAVPw
        ZT6EB4EHystFpJjeI4sKZN5JijW/
X-Google-Smtp-Source: APXvYqwcpA/M9jOYd0SoRtWcwVmFLjJWz0mqe6IsSuQWb5RzdzpgpqKwEwLydcvSNzm2AkqqT5sDrA==
X-Received: by 2002:a63:f551:: with SMTP id e17mr16051580pgk.162.1576865671948;
        Fri, 20 Dec 2019 10:14:31 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:31 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/15] t: replace incorrect test_must_fail usage (part 1)
Date:   Fri, 20 Dec 2019 10:15:47 -0800
Message-Id: <cover.1576865663.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the first part. It focuses on t[01]*.sh and also t/lib-git-p4.

Changes since v2:

* Drop the inclusion of test_non_git_must_fail() and open code it
  instead

Changes since v1:

* Incorporate review comments by Junio, Eric and J6t

* Further cleanup of t1507 before inlining full_name() (since we didn't
  want to inline full_name() into a bad command substitution)

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2

Denton Liu (15):
  t/lib-git-p4: use test_path_is_missing()
  t0000: replace test_must_fail with run_sub_test_lib_test_err()
  t0003: use named parameters in attr_check()
  t0003: use test_must_be_empty()
  t0003: don't use `test_must_fail attr_check`
  t0020: don't use `test_must_fail has_cr`
  t0020: use ! check_packed_refs_marked
  t1306: convert `test_might_fail rm` to `rm -f`
  t1307: reorder `nongit test_must_fail`
  t1409: let sed open its own input file
  t1409: use test_path_is_missing()
  t1501: remove use of `test_might_fail cp`
  t1507: stop losing return codes of git commands
  t1507: run commands within test_expect_success
  t1507: inline full_name()

 t/lib-git-p4.sh               |   2 +-
 t/t0000-basic.sh              |  14 ++---
 t/t0003-attributes.sh         |  47 +++++++--------
 t/t0020-crlf.sh               |  18 +++---
 t/t1306-xdg-files.sh          |   8 +--
 t/t1307-config-blob.sh        |   2 +-
 t/t1409-avoid-packing-refs.sh |  16 +++---
 t/t1501-work-tree.sh          |   2 +-
 t/t1507-rev-parse-upstream.sh | 104 +++++++++++++++++++---------------
 9 files changed, 112 insertions(+), 101 deletions(-)

Range-diff against v2:
 1:  85cee92765 <  -:  ---------- test-lib-functions: introduce test_non_git_might_fail()
 2:  3d64837af1 =  1:  cf3dd04b8a t/lib-git-p4: use test_path_is_missing()
 3:  778ae9052b =  2:  51a2226726 t0000: replace test_must_fail with run_sub_test_lib_test_err()
 4:  dbc82d45c6 =  3:  9374fcd8db t0003: use named parameters in attr_check()
 5:  e06a06cff5 =  4:  7f8808a850 t0003: use test_must_be_empty()
 6:  219011f983 =  5:  b725d53dbe t0003: don't use `test_must_fail attr_check`
 7:  8da6c96b39 =  6:  f6ef6d245c t0020: don't use `test_must_fail has_cr`
 8:  27550eaae6 =  7:  fc32b8d584 t0020: use ! check_packed_refs_marked
 9:  c19f6344a4 =  8:  7e29b0154e t1306: convert `test_might_fail rm` to `rm -f`
10:  d6ea8a6df0 =  9:  cf43579d65 t1307: reorder `nongit test_must_fail`
11:  d57dfe95e2 = 10:  e2fe278bfa t1409: let sed open its own input file
12:  eacf4e0fb4 = 11:  1eef3f4bc5 t1409: use test_path_is_missing()
13:  83e47748bc ! 12:  fddd224225 t1501: remove use of `test_might_fail cp`
    @@ Commit message
     
         The test_must_fail() family of functions (including test_might_fail())
         should only be used on git commands. Replace test_might_fail() with
    -    test_non_git_might_fail().
    +    a compound command wrapping the old cp invocation that always returns 0.
     
         The `test_might_fail cp` line was introduced in 466e8d5d66 (t1501: fix
         test with split index, 2015-03-24). It is necessary because there might
         exist some index files in `repo.git/sharedindex.*` and, if they exist,
         we want to copy them over. However, if they don't exist, we don't want
         to error out because we expect that possibility. As a result, we want to
    -    keep the "might fail" semantics so we use test_non_git_might_fail().
    +    keep the "might fail" semantics so we always return 0, even if the
    +    underlying cp errors out.
     
      ## t/t1501-work-tree.sh ##
     @@ t/t1501-work-tree.sh: test_expect_success 'Multi-worktree setup' '
    @@ t/t1501-work-tree.sh: test_expect_success 'Multi-worktree setup' '
      	mkdir -p repo.git/repos/foo &&
      	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
     -	test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
    -+	test_non_git_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
    ++	{ cp repo.git/sharedindex.* repo.git/repos/foo || :; } &&
      	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
      '
      
14:  9e20865f94 = 13:  63ca18207d t1507: stop losing return codes of git commands
15:  7c61ac6b67 = 14:  44a410d57a t1507: run commands within test_expect_success
16:  d09370455f = 15:  4fe445279b t1507: inline full_name()
-- 
2.24.1.703.g2f499f1283

