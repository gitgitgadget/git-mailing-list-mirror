From: "Luck, Tony" <tony.luck@intel.com>
Subject: git bisect and the merge from hell
Date: Fri, 3 Feb 2006 11:47:36 -0800
Message-ID: <200602031947.k13JlaDr003720@agluck-lia64.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 20:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F56vL-0007cZ-L5
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 20:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbWBCTrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 14:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWBCTrq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 14:47:46 -0500
Received: from fmr23.intel.com ([143.183.121.15]:49086 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1945925AbWBCTro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 14:47:44 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k13Jlbux028793;
	Fri, 3 Feb 2006 19:47:37 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k13Cwxsf022749;
	Fri, 3 Feb 2006 12:58:59 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id 3B9F919F63;
	Fri,  3 Feb 2006 11:47:37 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k13JlaDr003720;
	Fri, 3 Feb 2006 11:47:36 -0800
To: torvalds@osdl.org
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15542>

Sometime between -rc1 and -rc2 the ia64 kernel picked up a bug
that prevents booting a UP kernel on my workstation (I recycled
the serial cable to hook up a new machine, so I don't have the
OOPS).

So I thought I'd use git bisect to narrow it down.  A few iterations
in it picked the merge from hell, and two iterations after that it
appears to have wandered into the weeds and picked something from
before -rc1.

 $ git describe 3c5c363826e435cf4d54d917202567e5b57cae5f
 v2.6.15-g3c5c3638

Is this normal?

A couple of iterations down (with git bisect saying that we were into
the home stretch with only 5 commits to go) I ran into build problems,
so I haven't yet got to the bottom of the problem).

Here's the BISECT_LOG:
git-bisect start
# bad: [826eeb53a6f264842200d3311d69107d2eb25f5e] Linux v2.6.16-rc2
git-bisect bad 826eeb53a6f264842200d3311d69107d2eb25f5e
# good: [2664b25051f7ab96b22b199aa2f5ef6a949a4296] Linux v2.6.16-rc1
git-bisect good 2664b25051f7ab96b22b199aa2f5ef6a949a4296
# good: [10379a25fee8ddc8698d2f6c54ccedd4664c2941] Merge master.kernel.org:/pub/scm/linux/kernel/git/davej/agpgart
git-bisect good 10379a25fee8ddc8698d2f6c54ccedd4664c2941
# good: [9a2dba4b4912b493070cbc170629fdbf440b01d7] slab: rename ac_data to cpu_cache_get
git-bisect good 9a2dba4b4912b493070cbc170629fdbf440b01d7
# good: [9ad11ab48b1ad618bf47076e9e579f267f5306c2] compat: fix compat_sys_openat and friends
git-bisect good 9ad11ab48b1ad618bf47076e9e579f267f5306c2
# good: [1494a92f4c2b1d5abdaa1f823dd19f797bb137de] [ALSA] hda-codec - Fix typos in alc882 model table
git-bisect good 1494a92f4c2b1d5abdaa1f823dd19f797bb137de
# bad: [9fdb62af92c741addbea15545f214a6e89460865] [ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica asus fops pnpacpi branches into release
git-bisect bad 9fdb62af92c741addbea15545f214a6e89460865
# bad: [3c5c363826e435cf4d54d917202567e5b57cae5f] [ACPI] delete message "**** SET: Misaligned resource pointer:"
git-bisect bad 3c5c363826e435cf4d54d917202567e5b57cae5f
# bad: [c51a4de85de720670f2fbc592a6f8040af72ad87] [ACPI] ACPICA 20051117
git-bisect bad c51a4de85de720670f2fbc592a6f8040af72ad87

Git version is 1.1.4

-Tony
