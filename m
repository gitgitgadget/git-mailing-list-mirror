From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: git bisect result off by 1 commit
Date: Fri, 08 Feb 2013 17:54:13 -0800
Message-ID: <1360374853.17632.182.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: ak <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 02:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3zeD-0002Xs-6B
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 02:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760477Ab3BIByK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 20:54:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:51321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760434Ab3BIByI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 20:54:08 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 08 Feb 2013 17:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,632,1355126400"; 
   d="scan'208";a="260099293"
Received: from schen9-desk.jf.intel.com (HELO [10.7.199.63]) ([10.7.199.63])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2013 17:54:08 -0800
X-Mailer: Evolution 2.32.3 (2.32.3-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215842>

When I am doing a git bisect to track down a problem commit on the Linux 
kernel tree, I found that git bisect actually led me to a patch that's one
before the problem commit.

In particular,

$ git bisect replay bisectlog 
Previous HEAD position was d54b1a9... perf script: Remove use of die/exit
HEAD is now at a0d271c... Linux 3.6
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[d54b1a9e0eaca92cde678d19bd82b9594ed00450] perf script: Remove use of die/exit

However, the patch that is problematic is the one before the one git bisect indicated.
[commit 8d3eca20b9f31cf10088e283d704f6a71b9a4ee2].

I am running git 1.7.11.7.

Tim


The bisect record is as follow:

------------bisectlog-----------------
git bisect start
# good: [a0d271cbfed1dd50278c6b06bead3d00ba0a88f9] Linux 3.6
git bisect good a0d271cbfed1dd50278c6b06bead3d00ba0a88f9
# bad: [ddffeb8c4d0331609ef2581d84de4d763607bd37] Linux 3.7-rc1
git bisect bad ddffeb8c4d0331609ef2581d84de4d763607bd37
# bad: [24d7b40a60cf19008334bcbcbd98da374d4d9c64] ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS
git bisect bad 24d7b40a60cf19008334bcbcbd98da374d4d9c64
# bad: [d9a807461fc8cc0d6ba589ea0730d139122af012] Merge tag 'usb-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad d9a807461fc8cc0d6ba589ea0730d139122af012
# bad: [06d2fe153b9b35e57221e35831a26918f462db68] Merge tag 'driver-core-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect bad 06d2fe153b9b35e57221e35831a26918f462db68
# bad: [7e92daaefa68e5ef1e1732e45231e73adbb724e7] Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 7e92daaefa68e5ef1e1732e45231e73adbb724e7
# good: [620e77533f29796df7aff861e79bd72e08554ebb] Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 620e77533f29796df7aff861e79bd72e08554ebb
# bad: [8ad7013b252ba683055df19e657eb03d98f4f312] perf test: Add round trip test for sw and hw event names
git bisect bad 8ad7013b252ba683055df19e657eb03d98f4f312
# good: [f47b58b75f5e2a424834eb15f7565a7458a12f44] perf symbols: Fix builds with NO_LIBELF set
git bisect good f47b58b75f5e2a424834eb15f7565a7458a12f44
# good: [e1aa7c30c599e99b4544f9e5b4c275c8a5325bdc] tools lib traceevent: Fix strerror_r() use in pevent_strerror
git bisect good e1aa7c30c599e99b4544f9e5b4c275c8a5325bdc
# good: [ff1a70e75fd005821ab5f2211312a8aa13bbf959] tools lib traceevent: Modify header to work in C++ programs
git bisect good ff1a70e75fd005821ab5f2211312a8aa13bbf959
# bad: [4592281403e74dc4401d5803ec9948d43bbee7ae] perf tools: Remove the node from rblist in strlist__remove
git bisect bad 4592281403e74dc4401d5803ec9948d43bbee7ae
# good: [cc58482133296f52873be909a2795f6d934ecec9] perf help: Remove use of die and handle errors
git bisect good cc58482133296f52873be909a2795f6d934ecec9
# bad: [8d3eca20b9f31cf10088e283d704f6a71b9a4ee2] perf record: Remove use of die/exit
git bisect bad 8d3eca20b9f31cf10088e283d704f6a71b9a4ee2
