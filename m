From: "Luck, Tony" <tony.luck@intel.com>
Subject: GIT maintenance on ia64 test tree
Date: Thu, 10 Nov 2005 16:59:31 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04EE77E4@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Andrew Morton" <akpm@osdl.org>
X-From: linux-ia64-owner@vger.kernel.org Fri Nov 11 02:00:57 2005
Return-path: <linux-ia64-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaNGY-0001LB-Ul
	for glpi-linux-ia64-2@gmane.org; Fri, 11 Nov 2005 01:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVKKA7l (ORCPT <rfc822;glpi-linux-ia64-2@m.gmane.org>);
	Thu, 10 Nov 2005 19:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVKKA7l
	(ORCPT <rfc822;linux-ia64-outgoing>);
	Thu, 10 Nov 2005 19:59:41 -0500
Received: from fmr22.intel.com ([143.183.121.14]:21922 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932298AbVKKA7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ia64@vger.kernel.org>); Thu, 10 Nov 2005 19:59:40 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jAB0xYL2004509;
	Fri, 11 Nov 2005 00:59:34 GMT
Received: from scsmsxvs040.sc.intel.com (scsmsxvs040.sc.intel.com [10.3.90.8])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jAAI9tbk000918;
	Thu, 10 Nov 2005 18:10:10 GMT
Received: from scsmsx332.amr.corp.intel.com ([10.3.90.6])
 by scsmsxvs040.sc.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005111016593304784
 ; Thu, 10 Nov 2005 16:59:33 -0800
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 10 Nov 2005 16:59:33 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GIT maintenance on ia64 test tree
Thread-Index: AcXmWyyP+F0dxCaeRX6CCzMa21y+Tw==
To: <linux-ia64@vger.kernel.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 11 Nov 2005 00:59:33.0765 (UTC) FILETIME=[2DF94350:01C5E65B]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: linux-ia64-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ia64@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11546>

The way that I'm using GIT to maintain my test/release
trees results in the test tree building a history of
extra fluff (lots of auto-updates from Linus, plus all
the merge-commits to bring in each of the patch-sets, plus
some mistakes from when I goofed with GIT).

So, I'm going to periodically blow away the test branch
and re-create a clean version.  This mail is advance
notice that I'm going to do this when Linus releases
2.6.15-rc1 (a convenient point since I just sent everything
that was cooking in test to Linus ... so the test tree is
currently empty).

What this means is that the new "test" branch won't have
any connection to the old "test" branch.  So a "git pull"
or "git fetch" will fail.  To fix this in native git I *think*
you need to run (git list copied in the hope that if this is
tragically wrong, or overly complex, someone will take pity
and explain how it should be done):

 $ git checkout
{any-branch-other-than-the-one-you-track-my-test-tree-with}
 $ git branch -D test
 $ git branch test v2.6.15-rc1

Note that this will orphan all the objects relating to the
history of the test branch.  You can clean up with:

 $ git prune

BUT, this will also throw away any other orphaned stuff too, so
only do this if you are ok with ditching this.  You could run

 $ git fsck-objects

before any of the above to see whether you have any orphans.

Cogito users ... I have no idea.  First one to figure it out
please post a recipe.

-Tony
