From: "Olsen, Alan R" <alan.r.olsen@intel.com>
Subject: Bugs in Gitosis
Date: Thu, 28 Oct 2010 13:58:11 -0700
Message-ID: <26E9B811E137AB4B95200FD4C950886BA9665D70@orsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 28 22:58:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZYC-0002CV-0p
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933754Ab0J1U6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:58:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:15786 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933674Ab0J1U6I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 16:58:08 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 28 Oct 2010 13:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.58,254,1286175600"; 
   d="scan'208";a="852028189"
Received: from orsmsx602.amr.corp.intel.com ([10.22.226.211])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2010 13:58:08 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.226.10) by
 orsmsx602.amr.corp.intel.com (10.22.226.211) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 28 Oct 2010 13:58:08 -0700
Received: from orsmsx507.amr.corp.intel.com ([10.22.226.41]) by
 orsmsx605.amr.corp.intel.com ([10.22.226.10]) with mapi; Thu, 28 Oct 2010
 13:58:07 -0700
Thread-Topic: Bugs in Gitosis
Thread-Index: Act24tTeyA9L9hqPQrCv9DMOLG3ewA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160226>

[Sorry this has taken so long. Work was been eating my time.]

Here is my list of current outstanding issues with Gitosis.  I do not have fixes for these at the moment, but people and web indexes should be aware of the problems. The author of Gitosis seems to have been taken off-line. (The list may not be complete. I may have forgotten something.)

1. Multiple duplicate keys parsing problem

This can happen when you have multiple people administering a repository. (Especially when those people are responsible for separate projects on the same server.

You have a.pub and b.pub. These are both the public key for "Bob". (The same exact key in two files.)  Any group that a.pub is added to Bob will have access to. Any group that b.pub is added to that does not contain a.pub Bob will not have access to.  (It seems to sort the keys and only sees the first occurrence of the key, not all occurrences. 

2. Trees with working directories kills Gitosis

If any of the repositories in the repository have a working directory, Gitosis will fail on a push to gitosis-admin with a bunch of Python barfage.  (I don't have an example at hand, but if you look at the code, it is looking at ".git".) This usually happens when someone tries to shortcut the process by cloning code into the repo on the local machine.

3. Gitosis needs to have access to everything.

If your mount point for the repository is /repo you have to create a directory under this, else /repo/lost+found prevents Gitosis for initializing correctly. It is a permissions issue.

4. Typos are deadly.

If you push a gitosis.conf file to gitosis-admin that has a non-parseable typo, gitosis will have problems. The immediate effect is that the authorized-keys file does not get updated. (New keys do not get added to the file, but existing ones work up except for the typo areas.) The only way to fix this is to hand-correct the copy on the server. Rerunning the gitosis-init script on the server will fix a lot of problems and does not overwrite existing configs.

Those are the ones I can remember at the moment.  As soon as I send this I will remember more.

Hope this helps.
