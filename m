Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6FC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 09:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDJJIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 05:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDJJIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 05:08:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A02107
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e22so3828861wra.6
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681117729;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJMdwwT6zJxqWFsLxxmyVtK+/GcPLQtdsTryeFIvrMk=;
        b=JPaTM129eb6SlOnr9q4lSOiRVH+ANSJVXWbcsiyjkxdFH71onjVMp1qNujcyiPHzCA
         wUUXy7iPXMIxnqSVnO5iq5PK6AP1Pvu2ZP8h/N/Rgu67KlKzETWN7M2UT2BGK1vY9MKQ
         NMqM3m/WKoNVVXBhk15RlySc29MaPKffV42wNRYiql2xob0SBSqf5/lZ9Isv2bxfB52Z
         eOu8JNlSha7sTATfQemrQRZt/PUtxZnhF/EbCPMUuhiPjtW9TKdXmr9CbSW6kht3nz6t
         D199lWgxZTDPHsa4BSwWxjEPdbRMA7vCDHzcm30zIu2JG2StbB5ntVx4Kvu3p25doW+L
         /2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117729;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJMdwwT6zJxqWFsLxxmyVtK+/GcPLQtdsTryeFIvrMk=;
        b=sMuwTMbmZ6R/ELuwOX14MmNt0hJ/1BVnbClOpsue3nxBmXvK7Xn66LqvHlCnEn6t44
         jtlQYzKFcOM8ozZXxGkbmnbiBvW/mTHAcUFwYVM//S5b194bnS0PeuvLjAHo32rDzKsx
         gPEcgtK8teQ5o+IjYPXLrSxrUDeETTUZ9VYrqVEBgQZ5iuTyY8JdniddQ+0v50YPjI4u
         CUqDQM7RqIdToBHJJTAHdnISgDeyxxPU71qB0k7O/9eXiScWxA9RzTDYJRZVrSt3bBYJ
         iQHIEbeVQRWpPM24MutcMMW23YgpV6V7pdt1avk5x1AxnkKOAJmT7kj3ZMnI58/zfRDG
         YM2g==
X-Gm-Message-State: AAQBX9db7aNVilvv/qYM0T49TRUtbWMYbFwxDCKf+kddP4aoFxGeVLqy
        BRXMdQnhmfjtQOxa4ZLLRNYdf0YwsEI=
X-Google-Smtp-Source: AKy350Zd3t2LqOaL/OPW3WSylw4l5kn0mMX1/HMNGZCExlSlgq/5vyW4QlZSBX/luayFCnv/tk2C6g==
X-Received: by 2002:adf:e9c1:0:b0:2f2:7a0a:e4a5 with SMTP id l1-20020adfe9c1000000b002f27a0ae4a5mr389340wrn.7.1681117729175;
        Mon, 10 Apr 2023 02:08:49 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003f034c76e85sm17232568wmg.38.2023.04.10.02.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:08:48 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 0/5] rebase: cleanup merge strategy option handling
Date:   Mon, 10 Apr 2023 10:08:26 +0100
Message-Id: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.672.gbd2d2ac924
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Cleanup the handling of --strategy-option now that we no longer need to
support "--preserve-merges" and properly quote the argument when saving
it to disc.

A hopefully final re-roll to fix a memory leak I spotted in V3.

Changes since V3:
 - Fixed a memory leak added in V3. The array returned by
   split_cmdline() is allocated on the heap so we need to fee it. The
   array elements come from the string passed to split_cmdline() so do
   not need to be individually freed.

Changes since V2:

 - Added Elijah's Reviewed-by: trailer.
 - Fixed a typo in patch 4 spotted by Elijah.

Changes since V1:

I've rebased these patches onto 'master' to avoid conflicts with
'sg/parse-options-h-initializers' in the new patch 2 (this series
depends on 'ab/fix-strategy-opts-parsing' but that has now been merged
to master).

Patch 1 - Unchanged.

Patch 2 - New patch to store the merge strategy options in an "struct
          strvec". This patch also introduces a new macro OPT_STRVEC()
          to collect options into an "struct strvec".

Patch 3 - Small simplification due to the changes in patch 2.

Patch 4 - Moved the code to quote a list so it can split by
          split_cmdline() into a new function quote_cmdline() as
	  suggested by Elijah.

Patch 5 - Reworded the commit message as suggested by Elijah.


Base-Commit: 140b9478dad5d19543c1cb4fd293ccec228f1240
Published-As: https://github.com/phillipwood/git/releases/tag/sequencer-merge-strategy-options%2Fv4
View-Changes-At: https://github.com/phillipwood/git/compare/140b9478d...7de1aa101
Fetch-It-Via: git fetch https://github.com/phillipwood/git sequencer-merge-strategy-options/v4

Phillip Wood (5):
  rebase: stop reading and writing unnecessary strategy state
  sequencer: use struct strvec to store merge strategy options
  rebase -m: cleanup --strategy-option handling
  rebase -m: fix serialization of strategy options
  rebase: remove a couple of redundant strategy tests

 alias.c                        | 18 +++++++
 alias.h                        |  3 ++
 builtin/rebase.c               | 54 ++++-----------------
 builtin/revert.c               | 20 ++------
 parse-options-cb.c             | 16 +++++++
 parse-options.h                | 10 ++++
 sequencer.c                    | 58 ++++++++++------------
 sequencer.h                    | 12 +++--
 t/t3402-rebase-merge.sh        | 21 --------
 t/t3418-rebase-continue.sh     | 88 +++++++++++++---------------------
 t/t3436-rebase-more-options.sh | 18 -------
 11 files changed, 127 insertions(+), 191 deletions(-)

Range-diff against v3:
1:  882b403423 = 1:  882b403423 rebase: stop reading and writing unnecessary strategy state
2:  1d8e59aa16 ! 2:  4b288e883d sequencer: use struct strvec to store merge strategy options
    @@ sequencer.c: void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
     -		opts->xopts[i] = xstrdup(arg);
     +		strvec_push(&opts->xopts, arg);
      	}
    ++	free(argv);
      }
      
    + static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
     @@ sequencer.c: static void write_strategy_opts(struct replay_opts *opts)
      	int i;
      	struct strbuf buf = STRBUF_INIT;
3:  e98ef5ce8c = 3:  4e040c1214 rebase -m: cleanup --strategy-option handling
4:  a5e940e2d0 = 4:  671ee03503 rebase -m: fix serialization of strategy options
5:  2d1d328110 = 5:  7de1aa1016 rebase: remove a couple of redundant strategy tests
-- 
2.40.0.672.gbd2d2ac924

