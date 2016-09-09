Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648F41F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbcIIKK5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:10:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:59874 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbcIIKKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:10:55 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LoVBq-1b6Drn1yqQ-00gUT3; Fri, 09 Sep 2016 12:10:41
 +0200
Date:   Fri, 9 Sep 2016 12:10:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] cat-file: optionally convert to worktree version
In-Reply-To: <cover.1472041389.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1473415827.git.johannes.schindelin@gmx.de>
References: <cover.1472041389.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IUUT2A82anKP5bY2trST6kYWgjDlHjqht9PeKc/mqf+B6DB6TPb
 13742AVbd0r/fs5wNCmYCYKAEy94KZd9FM9rspEta7medKPgupn3VvwJo7n8gwM9JM0a7N1
 YWpmoPaH0UjaI2WSbefYel/k/2TmPiiqRItvJYmZfeyCO6EKPpu7dXkF1D+8V28PK3ZSokD
 10do0fMJ50vTcErLWXTig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8i756fIGg+M=:tZrYxnlPiRWDolVov+q/Gd
 TpQwQxSN7lmGuVpOU8g71rlk2zQhMaRvHjU6tJAlo6DNANfWvkrUighgQVj7MmQ0qtbAnbEOM
 x5041kGdCW1WWlaSrLmPqG5An8H86iSJkokAKC4SEna8uR981lm18Gh98lniGtGPodPD588Yz
 mvL4ID62N6OyHMYa6wOff1EtWZzD5manz3uIKTTWgXVFNgpXqwwuRJd6hOcUNhHAuJYbbbP1S
 UyrZ2W9nhLG9e5fIOWM8GksuRbVulR0npmugz48VDL9WQ0Bk7c8JxC8kNEJx9Dk8ZxmFO5klB
 aGouEHy3q+Pz987uMEIx1XHlniEleJaVmDN/EQpRJsVw3XnajZkV2K4MEb60tP3+fQwjqc7wf
 X7mGCSN0Oj8XB2zbNwEVEtu2OO0H2XVb1eT841C/O/ibxd/zqz0gfhlkH3oHjvBE0acPwyAMC
 xpTb3wf/LNGTDVgpSKyn7XsrI0KBte7j/rjsCHbdGVwOe/0edkfGruPcP233nIF2mkZRGVELw
 ee0xMcZC/id8cq1F/+a5U2c4QOksXh5sdhlrpTlpJVFrOYwB2cXqEmrAdlliddvqVYY9bkIXs
 QFHwxoUxPjjAX0ZGl3U+wMcbqrkTvwXkgeLX+FPPjmmT3TkgUg1uC1hMotgR5PcHTqJWiZrak
 GD6UmmkT5sgvwrgpSvJrVGtij92ibHM1PMuq6gy65t4+uTEbCaQJ2ESNBAxQZmbT/W2sCcmx0
 yYmVE7E4buztVyFqPEmkKUVBI9AMCs6FShLGIbNITgmIwraHEWqv9BZ10EH8/KkwP67CDvnXl
 zCLkfwf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Changes vs v2:

- always override unknown mode to imply 0100644, even if the user did
  not specify the --path option.


Johannes Schindelin (4):
  cat-file: fix a grammo in the man page
  cat-file: introduce the --filters option
  cat-file --textconv/--filters: allow specifying the path separately
  cat-file: support --textconv/--filters in batch mode

 Documentation/git-cat-file.txt |  40 +++++++++++----
 builtin/cat-file.c             | 110 ++++++++++++++++++++++++++++++++++++++---
 t/t8010-cat-file-filters.sh    |  64 ++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 18 deletions(-)
 create mode 100755 t/t8010-cat-file-filters.sh

Published-As: https://github.com/dscho/git/releases/tag/cat-file-filters-v3
Fetch-It-Via: git fetch https://github.com/dscho/git cat-file-filters-v3

Interdiff vs v2:

 diff --git a/builtin/cat-file.c b/builtin/cat-file.c
 index f8a3a08..4461153 100644
 --- a/builtin/cat-file.c
 +++ b/builtin/cat-file.c
 @@ -71,7 +71,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
  
  	if (!path)
  		path = obj_context.path;
 -	else if (obj_context.mode == S_IFINVALID)
 +	if (obj_context.mode == S_IFINVALID)
  		obj_context.mode = 0100644;
  
  	buf = NULL;

-- 
2.10.0.windows.1.10.g803177d

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
