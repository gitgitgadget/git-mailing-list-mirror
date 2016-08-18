Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABC41F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946979AbcHRNDf (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:03:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:61295 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbcHRNDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:03:33 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M2nfO-1bI8s31CVS-00sffL; Thu, 18 Aug 2016 14:46:09
 +0200
Date:	Thu, 18 Aug 2016 14:46:08 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] cat-file: optionally convert to worktree version
Message-ID: <cover.1471524357.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CY2qVRLRX+Hb4YgjzfBPKUwoJXp/r8cBy1AybCS8/goGkldGFL5
 rqaYr7Nzj4fQcSUlilq21H1uK+LUJg0T2WJvB5K2vzcgkJV49sNoQbHL3QLOJgSB/iYXJQo
 TZpLwI87jLOHOSc/MhCJ69CUku6N4xKDsKaBQtfvmWXK2Sw0bpkZcuPj3rxjX2TSd1HqgA3
 7ZKXZig7d0muAnSHEPadA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2cTyAJgHY6g=:D5PSH5hnrrtMnmxXKyDHpf
 E47rD044iuqlLNaX8fg00G5qDPYUufJNsQNSNV5xU7v5Q0+Z9x3ZQYvUKE1jfIJjFll9hipv1
 4rTaZWNjKdYZLu5PyRxTFAZQmhiv80/CLj/0wOpPjRLSYYx7bNQb63SfRfDbr/brJJuvU9BA4
 iJ0+aqoX+hkRmlEMiT1j/yzDnj6gAz3ZZU5aBlaQ5+WvBp6/PU+ZQpRRm2GmCDEJLSFyD/+1M
 bIO6BpC+TjFLQ+LkbehvJ8SsYQiPYaHwKHBQZH2FG3lnQSwbWdd7jfOIrwBxzCz3d8qCImgET
 A6SrUignfgHAi4OhPmLWjHI2ox7yoDQpFXQJln1xlWm2zSbcQJOxeybUAZ0VXNrPCvEfr9dd5
 Aup6LS2t5TOGFjjvUtQFgO7ubeqvAcOmwuJCTFkb7CK4BtOhQ8p8sgkjA/t1Fu6B6B35399eW
 cOwYvaoP7KHytJfSHgGnnkPaUfmwKQ27EMV+w0XQiFw12Jj2d0QJDIJTmXGukKdv+S8fiWT5k
 UqGrP/6jmtO7hTs4bGH2U+EnF0YxOY/zBGNWE2+RMvmHY7th389WN/Q6mvc5tvMF+rEsmjfsX
 Dht10mUbfMskvvgBlWR3syiybQJW9YmvIOJh12ArPStXBr5O+DSkXyM0Re8rawKfdyg1tiRde
 vpw1ZnR7/jxYWC69tDLrWu1hJeuSLH+zZSWX5MKtevIRPknIjdhuY4WvoTY+VMHK5udg6anfh
 XthT+2P8WDI6reKIVSwn8h8iXk6MQ8V6MMAGgZpWabeBsSTiz3wiCwuS35lYJJtsqAX9nlLyu
 u28dhLr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When third-party tools need to access to contents of blobs in the
database, they might be more interested in the worktree version than in
the "clean" version of said contents.

This branch introduces the --filters option to make that happen, the
--use-path option to provide the path separately if the blob name rather
than the tree name is availale, and offers batch support in which case
it expects the object names and the path on its input lines, separated
by white space.

The new --filters option is an obvious sibling of --textconv, and shares
the peculiar feature that the drivers (and end-of-line convention) are
determined from the current worktree, not from the attributes stored in
the revision that may have been part of the object name.

As --textconv is so similar to --filters, it was taught to understand
the --use-path option and it was made compatible with batch mode, too.

I briefly considered teaching the batch mode to extract the path from
object names if they are specified as <tree-ish>:<path>. The changes
would be quite intrusive, though, and uglify the code substanitially. So
I decided against that.


Johannes Schindelin (4):
  cat-file: fix a grammo in the man page
  cat-file: introduce the --filters option
  cat-file --textconv/--filters: allow specifying the path separately
  cat-file: support --textconv/--filters in batch mode

 Documentation/git-cat-file.txt |  40 ++++++++++++----
 builtin/cat-file.c             | 106 +++++++++++++++++++++++++++++++++++++----
 t/t8010-cat-file-filters.sh    |  57 ++++++++++++++++++++++
 3 files changed, 185 insertions(+), 18 deletions(-)
 create mode 100755 t/t8010-cat-file-filters.sh

Published-As: https://github.com/dscho/git/releases/tag/cat-file-filters-v1
Fetch-It-Via: git fetch https://github.com/dscho/git cat-file-filters-v1

-- 
2.9.2.691.g78954f3

base-commit: d63263a4dee8fc7da9b97bbdedf9c0d1f33024d4
