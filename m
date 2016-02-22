From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [RFC/PATCH 0/1] Add an option to git-format-patch to record base tree info
Date: Mon, 22 Feb 2016 10:58:57 +0800
Message-ID: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 04:01:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgkL-0003K1-0r
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 04:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbcBVDBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 22:01:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:28267 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbcBVDBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 22:01:08 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP; 21 Feb 2016 19:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; 
   d="scan'208";a="920908220"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2016 19:01:07 -0800
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286873>

Hi, 

I am a developer of 0-Day kernel test infrastructure(It is a service and
test framework for automated regression-testing that intercepts linux kernel
development at its early stages [1]), and as proposed by developers in ksummit-discuss,
we have implemented a framework to test all patches sent to LKML, it could help
us to find out potential build/boot/regression errors as early as possible.

In order to test LKML patches on their correct trees, we need to know the
corresponding base tree info, such as git url, branch, base commit id, etc,
currently we did some guess works and it may apply patches to the wrong base
trees, leading to undesirable false positives.

The only clean solution is for the developers to include these base tree info in
their first [PATCH] email, so we propose to add an option "--base-tree-info" to
git-format-patch to record these info in cover letter or the first patch
(put it between the "---" marker line and the actual diff), we believe it would
also be useful for maintainers who use git to manage their projects.

The initial implementation only record the base(parent) commit SHA1 of the
first patch. Here is the example:

1) with cover letter

you could see the commit id at the bottom of the message.

2) without cover letter

	Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
	---
	 builtin/log.c | 17 +++++++++++++++++
	 diff.c        |  4 ++++
	 diff.h        |  3 ++-
	 revision.h    |  1 +
	 4 files changed, 24 insertions(+), 1 deletion(-)

	base commit: 0233b800c838ddda41db318ee396320b3c21a560

	diff --git a/builtin/log.c b/builtin/log.c
	index 0d738d6..49fe8c2 100644
	--- a/builtin/log.c
	+++ b/builtin/log.c


What do you think? Any review comments about this patch or any suggestions
to us would be greatly appreciated.

[1] https://01.org/lkp/documentation/0-day-test-service

Thanks,
Xiaolong.

Xiaolong Ye (1):
  format-patch: add an option to record base tree info

 builtin/log.c | 18 ++++++++++++++++++
 diff.c        |  4 ++++
 diff.h        |  3 ++-
 revision.h    |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

base commit: 0233b800c838ddda41db318ee396320b3c21a560

-- 
2.7.1.340.gf1cebb4
