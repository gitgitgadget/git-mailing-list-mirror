Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566B21F424
	for <e@80x24.org>; Fri, 27 Apr 2018 22:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932432AbeD0WaN (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 18:30:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:35323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753569AbeD0WaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 18:30:12 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MaZWz-1ewavs0r1t-00KCQc; Sat, 28 Apr 2018 00:30:05 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH 0/6] Let the sequencer handle `git rebase -i --root`
Date:   Sat, 28 Apr 2018 00:29:26 +0200
Message-Id: <cover.1524868165.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:D21jVWXkNJVR5h2iBCLtJ2uPgpSwHTJlfdbJgeh1wFqyTy4kPgw
 OEYXbY840GrkiMnAYcJkTSKWBDujMN+xzK5E7E01fUN6wJE3BUf2oi4BE7UvoP6jAkUt3uB
 YCPPilXDaZhXq90FISMlX71Vic/3CM81KO2GcDQigFbayimSMjHBUCLRUK6K65R4lKSuC+u
 Wjm6hB3tP93UCbjF/NPGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMJL3WVCsqY=:NP0EtbfCOc73z4tG5lNF5i
 Fis3pciZ+u3lasyGVJUE0bnvy/Kw+ufJMzZersS5gGdNtFuLJJJ5e7wWeoTIobIQuMVKh9Dwv
 IatEM30O+DN3PY78cANRxLxlDFLhnTZ4Cjfac+boUUxAgV93Cql54Wx31a08ZOKylU7LNEIxz
 myHGpGOQbQ3EKgYvuzftM5LtudPbB6mNTArvUw2fuNStl6dIY7uwf1nYCFQ9YBPTwcQ/LWMG8
 PgXG3+8mEeTb1J/mp5IWqHoFi+RxqNY3hean6ZlypQ5k8wp0oJK7PuibLtwKJqVLttnV4H6SK
 WUu4HAszLG8WjkdW59w0M58GYqdXuzg1UKVnEJcO+v9CziraKsSL/CX/y6N/Ml7qLDkz1M/3t
 CPMk+Zz3fgqT6kAiOXcj37JjZKWWI2yK3xfwTyP1XcsGRq6JbM89yg7qwh1aBe2cfOIgnilbV
 TIPE0gtsC5thR05IllXMOs7YEPqDBPrMrVMsJ3GBWfETI2nhZGJ0V1tQVXpHkkuK9QKBnrHj+
 0+hkfpeqQwCAoc06v3gghEcLtNtm3VbQq7GJIuICROrROV/ISLQGVsrX6eTnu7X31QrD5p0zD
 s+ohr5tL1sZQXbxnAtMur37xrJWUSvSMFWQm7Gy5Dr302S5icSSB6v0mB8uuGN7JCLvc1DhfW
 OErICl3U1iEAUlZ1ZrvNqKLKylh9Wx+FpeBnwOaH97eCjfOyel53i7hq8oCRrp3HctonLQZNC
 lIJ2+CwhIBDze7P/YMzhQsQzfIDstX8JHSEjszglb2/ItDRQSe6KGyflMI5GNmaXpWTGFYqhM
 NX8SPaO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I reimplemented the most performance-critical bits of the
interactive rebase in the sequencer, to speed up `git rebase -i`
particularly on Windows (even if the benefits are still quite notable on
Linux or macOS), I punted on the --root part.

I had always hoped that some other contributor (or I myself) would come
back later to address the --root part in the sequencer, too, with the
idea that this would move the last remaining complicated code from
git-rebase--interactive.sh into sequencer.c, to facilitate converting
the rest of git-rebase--interactive.sh.

When I say "the last remaining complicated code", of course I neglect
the --preserve-merges code, but as I worked hard on the --rebase-merges
patch series with the intention to eventually deprecate and maybe even
remove the --preserve-merges mode, I always implicitly assume that the
--preserve-merges code will be moved into its own shell script
(git-rebase--preserve-merges.sh, maybe?) and never be converted.

So here goes: the patches to move the handling of --root into the
sequencer. After two preparatory patches, the real conversion takes
place in the third patch. After that, we take care of the --root related
concerns that arise in conjunction with the --rebase-merges mode.

As the --rebase-merges/--root patches overlap quite a bit (not so much
in the code itself as in philosophical considerations such as "what
should happen if you try to merge a branch into a new root", or the
fact that the label/reset/merge commands make it desirable to be able to
create a new root commit in the middle of a todo list), I had to
consider in which order to contribute them. In the end, I decided to go
with --rebase-merges first, so the --root patches are based on the
--rebase-merges patch series.

I consider this patch series a critical prerequisite for Alban's Google
Summer of Code project to convert rebase -i into a builtin.


Johannes Schindelin (6):
  sequencer: extract helper to update active_cache_tree
  sequencer: learn about the special "fake root commit" handling
  rebase -i --root: let the sequencer handle even the initial part
  sequencer: allow introducing new root commits
  rebase --rebase-merges: a "merge" into a new root is a fast-forward
  rebase --rebase-merges: root commits can be cousins, too

 git-rebase--interactive.sh        |   4 +-
 sequencer.c                       | 186 ++++++++++++++++++++++++++----
 sequencer.h                       |   4 +
 t/t3404-rebase-interactive.sh     |  19 ++-
 t/t3421-rebase-topology-linear.sh |   6 +-
 t/t3430-rebase-merges.sh          |  72 ++++++++++++
 6 files changed, 256 insertions(+), 35 deletions(-)


base-commit: 673fb9cb8b5c7d57cb560b6ade45e419c8dd09fc
Based-On: recreate-merges at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git recreate-merges
Published-As: https://github.com/dscho/git/releases/tag/sequencer-and-root-commits-v1
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-and-root-commits-v1
-- 
2.17.0.windows.1.33.gfcbb1fa0445

