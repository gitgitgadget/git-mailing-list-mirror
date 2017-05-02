Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8D21F790
	for <e@80x24.org>; Tue,  2 May 2017 12:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbdEBMaH (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:30:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:64457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbdEBMaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:30:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO77c-1dB17b2nci-005XpJ; Tue, 02
 May 2017 14:29:59 +0200
Date:   Tue, 2 May 2017 14:29:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Abide by our own rules regarding line endings
Message-ID: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hfBxRwTdcVWJobi8RwwlFIAUD1jQR7SCG5zqFA9eBP9wRlrMDMh
 5nFJbqEZGpPT5eF3TTcQYlHnkwymj0mLyR1UNzd5Ngyw2wbMPXS1cccWSdRKDP4ewzlf5Ao
 ONHgPagbL89jnredpuwXYURODo4AvQWeGUNF0S23qRMemGujTbEGlOlPe3AFofTF6vbOsyU
 U0sH72T312QdCfpM+7JVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:twQvhoOmw8g=:NirQ/c9O4Q9a55Rtb4VhXB
 GTFJaUD2Ju8Knm+x5WzbDq5lm/BHblzTZn/zTBr9LmWaQTxqnJQNKTaf1/QgUWK6co8FregcY
 64IRZ4iA0sz8jNBziMfulwg8IzLz0F+wQumC0JuuJ0jFShEAvEiB7GjGaY7yET1OYxKAofJMl
 3gWY6He8x6esW5EVSkv9Y71ukCvUeV0SlctpFCe0qlLfbMLJV2zTLI+PhOqiBS8Wv4pV5u30B
 46GVo9/718m4Q8FcE28Q2hP11LowM7BAPYcgPhNk1yNEtMWWyfD8ClB/qTi/mc2L4EKZBQyru
 8G3b52YsReDN1IDGOmi/Qamaagnu+W8tNH+/2qxZxi4+dJrE2P7psgH4Tt1FqWjHiYBKe0q38
 Is+mqDOCj5y06JAAx1LWWXgEXIAvkGLfSmnKwQ03Qc0pr1OoLypSpNPkoGuZ60ar9ytOtIXGD
 6Y3sCnm50iej6gUzdzWookKyglhI1qTOTWN1i7+NKExSfis3YkgZV8bn+Yov20AkZtuiTD4y3
 M3aSliaoRpjjmMbplsC3SsHU7vplMaPCtkrsEIPdWiSle9GOYI0XbzEqNMApffxcssoburIH3
 P4hB/B9UU3eLzV8B7rZiHMhYPPlOrZFi7tgpbJupQzwRQWSYv+9//lE1JAUhbttiJ6bkheJ0K
 a9ScLx30Nm2G7F/EV3nA4Ewa3abZzYOEXcnjbJ6GuKecITuJxTdHQGyRiFK9DK6eVCgPe5jKf
 VRkLaojwLW/8lZGsHKgzeHTdNgHENGe/M9+n2KVJlDd0sgJqSr1WTRe48wOxUpuy1SrnwI0jP
 xTejANX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over the past decade, there have been a couple of attempts to remedy the
situation regarding line endings (Windows/DOS line endings are
traditionally CR/LF even if many current applications can handle LF,
too, Linux/MacOSX/*BSD/Unix uses LF-only line handlings, and old MacOS
software used to use CR-only line endings).

The current idea seems to be that the default line endings differ
depending on the platform, and for files that should be exempt from that
default, we strongly recommend using .gitattributes to define what the
source code requires.

It is time to heed our own recommendation and mark the files that
require LF-only line endings in our very own .gitattributes.

For starters, those files include shell scripts: the most prevalent
shell interpreter in use (and certainly used in Git for Windows) is
Bash, and Bash does not handle CR/LF line endings gracefully.

There are even two shell scripts that are used in the test suite even if
they are not technically supposed to be part of core Git, as indicated
by their habitat inside contrib/: git-new-workdir and
git-completion.bash.

Related to shell scripts: when generating common-cmds.h, we use tools
that generally operate on the assumption that input and output
deliminate their lines using LF-only line endings. Consequently, they
would happily copy the CR byte verbatim into the strings in
common-cmds.h, which in turn makes the C preprocessor barf (that
interprets them as MacOS-style line endings).

Further, the most obvious required fixes concern tests' support files
committed verbatim, to be compared to Git's output, which is always
LF-only.

There are a few SVN dump files, too, supporting the Subversion-related
tests, requiring LF-only line endings.

Finally, the test suite makes use of text files that are not obviously
supporting tests, such as t/README, comparing them to LF-only versions
(and consequently failing if the files have been checked out with CR/LF
line endings). Therefore we need to mark those as LF-only in the
.gitattributes, too.

Without these fixes, Git will fail to build and pass the test suite, as
can be verified even on Linux using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make DEVELOPER=1 -j15 test

Note: I separated out the change marking t/t4051/* as LF-only into an
individual commit for one reason: it would appear that the test passes
if checked out using core.autocrlf=true on Linux, but on Windows the
test fails. In that respect, this test is special, as the other changes
can be easily validated even without using Windows.


Johannes Schindelin (5):
  Fix build with core.autocrlf=true
  git-new-workdir: mark script as LF-only
  completion: mark bash script as LF-only
  Fix the remaining tests that failed with core.autocrlf=true
  t4051: mark supporting files as requiring LF-only line endings

 .gitattributes                    |  8 +++++++-
 contrib/completion/.gitattributes |  1 +
 contrib/workdir/.gitattributes    |  1 +
 git-gui/.gitattributes            |  1 +
 t/.gitattributes                  | 29 ++++++++++++++++++++++++++++-
 5 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 contrib/completion/.gitattributes
 create mode 100644 contrib/workdir/.gitattributes


base-commit: d2bbb7c2bcf6e77ebfcabf4e12110fe6d5c91de6
Published-As: https://github.com/dscho/git/releases/tag/lf-attrs-v1
Fetch-It-Via: git fetch https://github.com/dscho/git lf-attrs-v1

-- 
2.12.2.windows.2.800.gede8f145e06

