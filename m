Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5011F453
	for <e@80x24.org>; Tue, 22 Jan 2019 22:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAVWQs (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 17:16:48 -0500
Received: from kitenet.net ([66.228.36.95]:48772 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfAVWQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 17:16:47 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 17:16:47 EST
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1548194835; bh=81M9SlTQQ20+/JGrcTCyfwli5lDDbcvBhMTm0rk+kJY=;
        h=Date:From:To:Subject:From;
        b=BjtZ8wjDLE9U+MgLrLvk20ct3SbH3N8C32P0EAIrz4POnZWH2KDaMLg17NW/wnIzs
         W6cLIK3T3VHjQgMZLWsPQ+tP3ivWsasccQjIb7pbU6COqP+jsYwRvyTt816OZEOYfA
         cTvOyqFRv6MGfOX3mkRhb3pI43XeVxQATgPRUW7E=
Date:   Tue, 22 Jan 2019 18:07:14 -0400
From:   Joey Hess <id@joeyh.name>
To:     git <git@vger.kernel.org>
Subject: git status OOM on mmap of large file
Message-ID: <20190122220714.GA6176@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

joey@darkstar:~/tmp/t> ls -l big-file
-rw-r--r-- 1 joey joey 11811160064 Jan 22 17:48 big-file
joey@darkstar:~/tmp/t> git status
fatal: Out of memory, realloc failed

This file is checked into git, but using a smudge/clean filter, so the actual
data checked into git is a hash. I did so using git-annex v7 mode, but I
suppose git lfs would cause the same problem.

[pid  6573] mmap(NULL, 11811164160, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)

Why status needs to mmap a large file that is not modified
and that is configured to pass through smudge/clean, I don't know.
It seems like it should be possible for status work in this situation.

-- 
see shy jo
