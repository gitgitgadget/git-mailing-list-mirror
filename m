Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D669D1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbdCXXYu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:24:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:49241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932803AbdCXXYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLj5z-1crpYV1FBb-000pZg; Sat, 25
 Mar 2017 00:24:44 +0100
Date:   Sat, 25 Mar 2017 00:24:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
Message-ID: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wkrBovCuaPG3Ng40ILP93FVvgYZJcBAwgoFMCdiyIJgzmKtuvEq
 1Lzq5V6tnQ6QGOP8r/i1RqrkXnVwEFkeqZD37B4jqytNFUqyX+SwKIxwt55PjY6r/nMriMp
 L7t0t7PMZNrgLVWHQhQY+C3AnjA35LKmWFCy/QVtPNk2pinlW35sqYI4OD4IJ3ZuPwuLIKW
 jbAmiJrmoOWLObi+f4oTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HezSlcficEM=:OPbTmpplebaAnx0VJoq7mr
 LmWtwFtH5vMEmon+0kN8d6Go0Xvuu6i04ZZV3H5+U3AMQHOKCf4S/hCzX5GPp7TBy682fV4Uo
 V8OD+YyDWO5hD/s2sFYEDtN4J5sjSaFTmH98x4Gsf2/0EMt4NILyQLV1OmTe+ykCkP9yNMZS8
 JKpX1E75f7FV4XiW+PnjBvFgnbiFnYoLunzfyqXdWXt1kg21gReAcC472CSZmSODpUGqjgbSg
 Hl5cSvHFsBGxPEy+XaxChGMeG8uln6G+tvnxUiZDll+gUtp55dNbotlY5qq4Gjuq8YO4+EnMx
 XlbyFgoT59FJr0qhHu/AU0hkHMtJYVxGh9aOMPI7mwHVqDCZl/eMLPkE1Lw72xuLJzCPvErsH
 BDBDqpxZxvRz/5OMtVWS0vfCSinM9OxJXA3oU2PeGPE1yRRdtHIdkJtZWvnImz92XfwIRHwb7
 3VNtX0xyT71wCIf5FOM8kxL8RE9Xh6NpYTgrITXGXFcIMH7RpsldUZ73IGcReSTOhU2WIbzCV
 J3WOmc12z+1g0IW0VVs+8k8OoSgEjpZj+CZ0Su+70AEBFZs26dpYCgIfAYr8iJy9lsqc/nwPH
 ZnuSWvEV90bLVTgjXZRKnNWdEEI8gQNDM2U80N2jfjrPUr9ePl0lPOH4rv4EZCe9+w2yFXJ0H
 Qgd17GAL6fVH+8Fn9aR6MdSZPE6OffPY/liR8fQFUcO07bOT9DnPEvKu/tCAdoYNVh6bcUavy
 h9HXHytMlVopFiJjv62w1WiSpG+wrnnfdnVYgPHZGOXtZFcat/7qiCE6u5SDDiYkHLDyFEpoS
 h7BTkW9AUh+tQjIER3n4jHI/+uLxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I pointed out several times in the past, the performance hit of
enabling SHA1DC globally is not acceptable. This patch series not only
demonstrates that clearly in the perf test it adds (it is the last patch
in the current series, and its commit message has some numbers), it also
shows an early glimpse of what I will be proposing to fix the situation.

Obviously, this patch series is not complete yet:

- the first patch is an obvious bug fix that I sent out separately, but
  it is needed to unbreak almost all tests on Windows.

- the most important part will be the patch turning core.enableSHA1DC
  into a tristate: "externalOnly" or "smart" or "auto" or something
  indicating that it switches on collision detection only for commands
  that accept objects from an outside source into the local repository,
  such as fetch, fast-import, etc


Johannes Schindelin (7):
  sha1dc: safeguard against outside definitions of BIGENDIAN
  Makefile: optionally compile with both SHA1DC and SHA1_OPENSSL
  config: add the core.enablesha1dc setting
  t0013: do not skip the entire file wholesale without DC_SHA1
  t0013: test DC_AND_OPENSSL_SHA1, too
  mingw: enable DC_AND_OPENSSL_SHA1 by default
  p0013: new test to compare SHA1DC vs OpenSSL

 Makefile               | 13 +++++++++++++
 config.c               |  8 ++++++++
 config.mak.uname       |  1 +
 hash.h                 |  2 +-
 sha1dc/sha1.c          | 23 ++++++++++++++++++++++-
 sha1dc/sha1.h          | 16 ++++++++++++++++
 t/helper/test-sha1.c   | 10 ++++++++++
 t/perf/p0013-sha1dc.sh | 23 +++++++++++++++++++++++
 t/t0013-sha1dc.sh      | 18 ++++++++++++------
 9 files changed, 106 insertions(+), 8 deletions(-)
 create mode 100644 t/perf/p0013-sha1dc.sh


base-commit: 063fe858b89ef8ee27965115fd6b1ed12e42e793
Published-As: https://github.com/dscho/git/releases/tag/sha1dc-knob-v1
Fetch-It-Via: git fetch https://github.com/dscho/git sha1dc-knob-v1

-- 
2.12.1.windows.1

