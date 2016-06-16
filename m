Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	T_TVD_MIME_EPI shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5541FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 13:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbcFPNAM (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 09:00:12 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:39059 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbcFPNAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 09:00:11 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jun 2016 09:00:11 EDT
DKIM-Signature:	v=1; a=rsa-sha256; c=simple; d=trippelsdorf.de; h=date
	:from:to:subject:message-id:mime-version:content-type; s=k1; bh=
	BEmb5Fb14YzL347ADwqrvHDfVH9xJpKf8rdnYezSNv4=; b=OP0yfE+zH6r7Abun
	/euckTTrDV12Zk7zL/3MrBc4HAU8XPhBoyZosmFP2Fl1zqHvcSbU3E9NiRmTEbXj
	INQ/2OY0KtpfK3tOtMpVSkSn9+/d12rA5ZGgX5aOr1tAseIiCmwDwFTXYNRV3d2t
	0TJnd2Mb8DAmAbsryCYranNhFxQ=
Received: (qmail 22527 invoked from network); 16 Jun 2016 14:53:26 +0200
Received: from ip5b41f88a.dynamic.kabel-deutschland.de (HELO x4) (ud10?360p3@91.65.248.138)
  by mail.ud10.udmedia.de with ESMTPSA (ECDHE-RSA-AES256-SHA encrypted, authenticated); 16 Jun 2016 14:53:26 +0200
Date:	Thu, 16 Jun 2016 14:53:26 +0200
From:	Markus Trippelsdorf <markus@trippelsdorf.de>
To:	git@vger.kernel.org
Subject: final git bisect step leads to: "fatal: you want to use way too much
 memory"
Message-ID: <20160616125326.GA314@x4>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To reproduce the issue, just run:

markus@x4 ~ % git clone git://gcc.gnu.org/git/gcc.git
markus@x4 gcc % git checkout -b gcc-6 origin/gcc-6-branch 
markus@x4 gcc % git bisect bad 23240454adf1
You need to start by "git bisect start"
Do you want me to do it for you [Y/n]? y
markus@x4 gcc % git bisect good 558525d0cf3
Bisecting: 45 revisions left to test after this (roughly 6 steps)
[c4727bc59ecad9e8879aed135624781fabae16b5]      PR c++/71372    *
cp-gimplify.c (cp_fold): For INDIRECT_REF, if the folded expression   is
INDIRECT_REF or MEM_REF, copy over TREE_READONLY, TREE_SIDE_EFFECTS
and TREE_THIS_VOLATILE flags.  For ARRAY_REF and ARRAY_RANGE_REF, copy
over TREE_READONLY, TREE_SIDE_EFFECTS and TREE_THIS_VOLATILE flags
to the newly built tree.
markus@x4 gcc % git bisect bad
Bisecting: 22 revisions left to test after this (roughly 5 steps)
[6935372a7f032acccf7876e7f54ddf494e101e5e] 2016-05-31  Richard Biener
<rguenther@suse.de>
markus@x4 gcc % git bisect bad
Bisecting: 10 revisions left to test after this (roughly 4 steps)
[909ed6a89604db5baa55b62ad253a9bcd5d89c03] backport "Remove assert in
get_def_bb_for_const"
markus@x4 gcc % git bisect bad
Bisecting: 5 revisions left to test after this (roughly 3 steps)
[f216419e5c4c41df70dbe00a6ea1faea46484dc8] gcc/
markus@x4 gcc % git bisect bad
Bisecting: 2 revisions left to test after this (roughly 1 step)
[745d4ecd59a3430f7c7b3bf33db1083d529a018b] libstdc++/70762 fix fallback
implementation of nonexistent_path
markus@x4 gcc % git bisect good 
Bisecting: 0 revisions left to test after this (roughly 1 step)
[a64301f7ac47b9d8f4f816c5e935cda4c92716b7] 2016-05-26  Jerry DeLisle
<jvdelisle@gcc.gnu.org>
markus@x4 gcc % git bisect good
f216419e5c4c41df70dbe00a6ea1faea46484dc8 is the first bad commit
commit f216419e5c4c41df70dbe00a6ea1faea46484dc8
fatal: you want to use way too much memory
markus@x4 gcc % 

-- 
Markus

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bisect_log

git bisect start
# bad: [23240454adf160862453a3a850451a304867c29b] 	Backported from mainline 	2016-06-04  Jakub Jelinek  <jakub@redhat.com>
git bisect bad 23240454adf160862453a3a850451a304867c29b
# good: [558525d0cf372a48ae12b1dc27201dd47ab7878c] Daily bump.
git bisect good 558525d0cf372a48ae12b1dc27201dd47ab7878c
# bad: [c4727bc59ecad9e8879aed135624781fabae16b5] 	PR c++/71372 	* cp-gimplify.c (cp_fold): For INDIRECT_REF, if the folded expression 	is INDIRECT_REF or MEM_REF, copy over TREE_READONLY, TREE_SIDE_EFFECTS 	and TREE_THIS_VOLATILE flags.  For ARRAY_REF and ARRAY_RANGE_REF, copy 	over TREE_READONLY, TREE_SIDE_EFFECTS and TREE_THIS_VOLATILE flags 	to the newly built tree.
git bisect bad c4727bc59ecad9e8879aed135624781fabae16b5
# bad: [6935372a7f032acccf7876e7f54ddf494e101e5e] 2016-05-31  Richard Biener  <rguenther@suse.de>
git bisect bad 6935372a7f032acccf7876e7f54ddf494e101e5e
# bad: [909ed6a89604db5baa55b62ad253a9bcd5d89c03] backport "Remove assert in get_def_bb_for_const"
git bisect bad 909ed6a89604db5baa55b62ad253a9bcd5d89c03
# bad: [f216419e5c4c41df70dbe00a6ea1faea46484dc8] gcc/
git bisect bad f216419e5c4c41df70dbe00a6ea1faea46484dc8
# good: [745d4ecd59a3430f7c7b3bf33db1083d529a018b] libstdc++/70762 fix fallback implementation of nonexistent_path
git bisect good 745d4ecd59a3430f7c7b3bf33db1083d529a018b
# good: [a64301f7ac47b9d8f4f816c5e935cda4c92716b7] 2016-05-26  Jerry DeLisle  <jvdelisle@gcc.gnu.org>
git bisect good a64301f7ac47b9d8f4f816c5e935cda4c92716b7

--AqsLC8rIMeq19msA--
