Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CE91F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbcHYPIe (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:08:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:64179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933706AbcHYPIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:08:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LpObx-1ay7li3Jgr-00fDWX; Thu, 25 Aug 2016 17:06:40
 +0200
Date:   Thu, 25 Aug 2016 17:06:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Pull out require_clean_work_tree() functionality from
 builtin/pull.c
Message-ID: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zjqmo5LVqiyfoz7ULzGqfYRXzsHdXZxzsvGwnQIA7fqSDAWHtry
 8ViYEfCDGcBcI74oDZl1FHySP+HmkYTH5HJkC760g5CyO+nhfSy7N0jNo1u899Fo+95Ozi1
 Sby/MhWnCXEEeq01nEW9LRd55JkpYNzxWF/xATGiuCXq0IYgeQQFq6mgogis+E1gjss0Hzv
 g3K9rbor3GLcAYsYclpvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wBamXjkb83Q=:6bQf1aIQdBqJdYUK8J/eVZ
 L8BjDQqLcv93LHT3OJ0xEKpLSN34gt1W/iakU96jKhnAcY+gJzkZ7fFa8C665lYkpEBbKp75R
 QRbrPuVf8d1r1HFMOe56Z88vdT2l0mz9in80zsUwv5NvLb2HVwX/bs9EzlgVARk1mXNd7aoRa
 oQ7hJOLzt5xRojD/0hJyb5V+rBTlOjsrftyknhqIeBGZjkUE2az1AeDyBqWPLS59irUdDDOmc
 V1klGiBbaGP3AJodpIRLUvzqVxsQa/YJ4hdzA7YkUHYJRHaLcgH9NVQgl3ST4FIyOx8aRW7NQ
 geP45FLZNTSme+HQDpdvoIEaUxbJhVXmIDWKvaeLToYHf/xCtcyAJKB8X5J9LSsJfUcfEs7b/
 Ly3v6ztjz4e2kfNDY7G3cfzCfc9VECjakGp/tcXDt5NOcDg0u7gOdDmEBZ3/F+9EJCFTd0Z37
 v4NoCM1xrgEpV9Us+8j/LUwXfFb8PCTR/bJ5zYqx74tiIOlidxYNqbNgz8uADqpdCXKGM02Xi
 b/KdmrivBycIi51mlpvOqOXMH0KIjoW7jR72QjBv7U8N4NJkF/r4JlRCIUgMxH5nXwHbyqsZ4
 Or98bIZs1GQUD5NNTG/auH/nLucQdWl5zcGi5J2GQTnpFTpHP1uDx88JHI2LhSSoyrxkDAdXe
 YPb4jhgTBvK1nzm/hlHUpXhgeicQ96Dz+jokb+yIDJJTm8+Dk/DoB44M/Kwmz70nkdUVPcvDn
 nm4+eoeDjmGRSrSwvziJdnYh2kx2Xd04tZcjcQ/BVNjNm8YuOWgDhM0a90RJZNDJBjc38W0W4
 zerTfJB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the 5th last patch series of my work to accelerate interactive
rebases in particular on Windows.

Basically, all it does is to make reusable some functions that were
ported over from git-pull.sh but made private to builtin/pull.c.

An earlier attempt included only the first patch, and somehow it failed
to convince our good Git maintainer without mentioning that it is part
of something much bigger:

http://public-inbox.org/git/974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de/

However, now that I have this big carrot (3x speedup on Linux, 4x
speedup on MacOSX and 5x speedup on Windows), it cannot possibly fail.
*thumbs-crossed*


Johannes Schindelin (6):
  pull: drop confusing prefix parameter of die_on_unclean_work_tree()
  pull: make code more similar to the shell script again
  Make the require_clean_work_tree() function truly reusable
  require_clean_work_tree: ensure that the index was read
  Export also the has_un{staged,committed}_changed() functions
  wt-status: teach has_{unstaged,uncommitted}_changes() about submodules

 builtin/pull.c | 71 +++----------------------------------------------
 wt-status.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  5 ++++
 3 files changed, 91 insertions(+), 68 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/require-clean-work-tree-v1
Fetch-It-Via: git fetch https://github.com/dscho/git require-clean-work-tree-v1

-- 
2.10.0.rc1.99.gcd66998

base-commit: 2632c897f74b1cc9b5533f467da459b9ec725538
