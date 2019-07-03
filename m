Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8FC1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 20:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCUGz (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 16:06:55 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:53612 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCUGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 16:06:55 -0400
X-Greylist: delayed 1990 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 16:06:54 EDT
Received: from [10.31.182.110] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1hil0h-0008J2-Ko
        for git@vger.kernel.org; Wed, 03 Jul 2019 15:33:43 -0400
Date:   Wed, 3 Jul 2019 15:33:05 -0400
From:   Yaroslav O Halchenko <debian@onerussian.com>
To:     git@vger.kernel.org
Message-ID: <20190703193305.GF21553@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 10.31.182.110
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: difference in behavior bw ls-files and ls-tree on paths in submodules
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git gurus,

A quick question on either such difference in behavior is intended or
ideally should be "fixed" by making it more consistent.

	# prep demo usecase with a submodule sub/ containing a file 123

	$> mkdir /tmp/testrepo; cd /tmp/testrepo; git init; touch 123; git add 123; git commit -m 123
	Initialized empty Git repository in /tmp/testrepo/.git/
	[master (root-commit) 00864cd] 123
	 1 file changed, 0 insertions(+), 0 deletions(-)
	  create mode 100644 123

	$> git submodule add $PWD ./sub && git commit -m 'added self as a submodule'
	Cloning into '/tmp/testrepo/sub'...                                         
	done.
	[master e92dd9a] added self as a submodule
	 2 files changed, 4 insertions(+)
	 create mode 100644 .gitmodules
	 create mode 160000 su

ls-tree provides information on the submodule if I point it to the file within
submodule (even without -r):

	$> git ls-tree HEAD -l sub/123                                              
	160000 commit 00864cd776e8c870feb89db28c5e9ad185ed2a8e       -	sub

whenever ls-files provides no output for a path within submodule and only if I
point to the submodule directory directly:

	$> git ls-files --stage sub/123
	$> git ls-files --stage sub/   
	160000 00864cd776e8c870feb89db28c5e9ad185ed2a8e 0	sub

I wonder 

- if that is somehow intended (so there is a good reason for such a
behavior)?

- is there a good/quick way to figure out "parent path as known to git"
similarly as ls-tree behaves, but for "ls-files" (i.e. a worktree, which might
have submodules renamed but not yet committed etc)?

Thank you in advance!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
