Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4711FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbcF2OOo (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:14:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:59110 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbcF2OOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:14:43 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M6P5z-1bWcHm3Ii3-00yQis; Wed, 29 Jun 2016 16:14:37
 +0200
Date:	Wed, 29 Jun 2016 16:14:37 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Use skip_blank_lines() for more commit messages
Message-ID: <cover.1467209576.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:C+bOu2Ydi50X+wrB4684thWSedUvxHFGQ4LAB4eevy2mrKotc2c
 BbOvzLJoofv5qD84LlzyMafLbUVGSxr+ghgp/aORyUDpEg+InSsnFgL+pOxE7U+xHoR9RGf
 ypraQoCDtQRwGzV7t/N+hDBI4UNAwrC3o5gOwYvTSqDhOAFnLBx7S0dggiplgOUIJIDMTDc
 A/7Xj+zKheZ8z5RF3B6DA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0zBgyETCEj8=:psFhmK/wCrKzq7GEWSpytp
 rzu99UmnNPnVvdBzEpnDXo85DBJqWrsYiWZsoHjKHlxnERdcnKZSmghBHpugwthFWCAcQ//hh
 bu+OOnjky4MKr3GNYKYMfl+IjJsR6P8B1sPXN3kkVFTbew2hyZcKo0/P4KOAM/DZsqnYNnTfm
 fWyixKumxR4nmbH1o5IaTEQIhhBOIvj6fJiwLdRiMXa+S5Rl/YsLvM87IcYmCNaGi4LBVS+P2
 o1wwZyYlHAK2H/0jdK9A3dQH6JNWdzT4MzC67lV61nJb2GXG2IHyAVV68BXEXmyEiY1RjRcvB
 WL4i4VJAP2vMwjEbKx87OdoTUpyru+H/6bT3WR0V6fA0RpOxeLIo9gOedgh9kIuhB66Qhuh7A
 3R8ua0e/3iOIfhgc27l4xszgOOSIU2AVgseeTbbfYi29LISN2jo6wSgvD/+Kxkugb3/IeGA/w
 MS9pxWTV2vYAOynKqyTF4EVm13boOmnH6OVZvf+47+jdwGtLT/2xcQdrmYNS79LdM8HW5sbi0
 f2g0nGzTcfrpFx+kyBShV/n5yRO+fT6pv7rq6S4LBCygWkNcnKPOmQ6YLj8FHMdoO/diqnbXV
 gKjakiksSwFQebLXDdljbe6JxfQTqemByrbltLydaSVO4zI3g1N+DTZ9ozY5MzFJVM5MqbCcM
 18udY+9XU9VH5n9Nd3LlcSUjjA33rxa1id9yLg0F0w+e+ePqv+iZNBhMm+UacQYzwLxMJQIjL
 AoaHLim+OYmi71cjOJNpWXH/psuROyVnxUtq5R+KjDeJpReXe1qCqw1okIhnx4LgBP7KbX/Er
 ru6cZll
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

These patches are on top of js/find-commit-subject-ignore-leading-blanks
(whether you want to put them into the same topic branch before merging
or put them into their own add-on topic branch does not really matter to
me).

It occurred to me that there might be more code locations where finding
the commit object's body is hand-rolled, and could benefit from using
the skip_blank_lines() function to handle not-quite-standard but
still-allowed objects from being processed correctly.

I found a couple of instances, and made them consistent with the
pretty-printing machinery.

I made fine-grained commits to allow for dropping contentious patches
more easily.

There are four more instances which I did *not* change:

- fast-export: I designed this command to be as faithful in exporting
  the commits as possible. As such, even non-standard commit objects
  should be kept as-are.

- fmt-merge-msg: when showing signed commit messages, it is better to
  show the commit messages verbatim rather than trimming them.

- when signing a commit, it is better to use the original commit message
  than a munged one.

- notes' messages are left alone. I do not know whether there might be
  an intentional use of leading blank lines, but I wanted to err on the
  safe side.

I also considered treating tag messages the same way, but tags are much
more likely to be signed, and I did not want to risk munging the tag
messages just before signing them.


Johannes Schindelin (5):
  commit -C: skip blank lines at the beginning of the message
  sequencer: use skip_blank_lines() to find the commit subject
  reset --hard: skip blank lines when reporting the commit subject
  commit -S: avoid invalid pointer with empty message
  Skip blank lines when matching <commit>^{/foo}

 builtin/commit.c | 2 +-
 builtin/reset.c  | 2 +-
 commit.c         | 6 +++++-
 sequencer.c      | 6 ++----
 sha1_name.c      | 3 ++-
 5 files changed, 11 insertions(+), 8 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/more-blank-line-skipping-v1
-- 
2.9.0.270.g810e421

base-commit: 38a2ea1900489a76d9840002bf60bd7ff29f07cd
