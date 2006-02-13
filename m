From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 01:11:23 -0800
Message-ID: <7virrj1v44.fsf@assigned-by-dhcp.cox.net>
References: <20060213002502.5c23122c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 10:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Zk2-0003y0-JD
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 10:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWBMJL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 04:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWBMJL1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 04:11:27 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61623 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751660AbWBMJL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 04:11:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060213090804.MTEV20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 04:08:04 -0500
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213002502.5c23122c.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 13 Feb 2006 00:25:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16055>

Andrew Morton <akpm@osdl.org> writes:

> I've been trying to locate an ipw2200 regression in Jeff's tree
> (git+ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL)
> and it ended up leading me to 
>
> 826eeb53a6f264842200d3311d69107d2eb25f5e is first bad commit
> diff-tree 826eeb53a6f264842200d3311d69107d2eb25f5e (from 33052057e3e2db7f37fc78aa3f25c98f7e989fae)
> Author: Linus Torvalds <torvalds@g5.osdl.org>
> Date:   Thu Feb 2 22:03:08 2006 -0800
>
>     Linux v2.6.16-rc2
>
> which wasn't very useful.
>
> I don't _think_ I screwed anything up.
>
> git-bisect start
> # good: [2664b25051f7ab96b22b199aa2f5ef6a949a4296] Linux v2.6.16-rc1
> git-bisect good 2664b25051f7ab96b22b199aa2f5ef6a949a4296
> # bad: [826eeb53a6f264842200d3311d69107d2eb25f5e] Linux v2.6.16-rc2
> git-bisect bad 826eeb53a6f264842200d3311d69107d2eb25f5e
> # good: [10379a25fee8ddc8698d2f6c54ccedd4664c2941] Merge master.kernel.org:/pub/scm/linux/kernel/git/davej/agpgart
> git-bisect good 10379a25fee8ddc8698d2f6c54ccedd4664c2941
> # good: [9a2dba4b4912b493070cbc170629fdbf440b01d7] slab: rename ac_data to cpu_cache_get
> git-bisect good 9a2dba4b4912b493070cbc170629fdbf440b01d7
> # good: [9ad11ab48b1ad618bf47076e9e579f267f5306c2] compat: fix compat_sys_openat and friends
> git-bisect good 9ad11ab48b1ad618bf47076e9e579f267f5306c2
> # good: [1494a92f4c2b1d5abdaa1f823dd19f797bb137de] [ALSA] hda-codec - Fix typos in alc882 model table
> git-bisect good 1494a92f4c2b1d5abdaa1f823dd19f797bb137de
> # good: [9fdb62af92c741addbea15545f214a6e89460865] [ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica asus fops pnpacpi branches into release
> git-bisect good 9fdb62af92c741addbea15545f214a6e89460865
> # good: [cf41f8ac386e8d62122e7e394b4c6b3e3ab30ede] Merge branch 'drm-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6
> git-bisect good cf41f8ac386e8d62122e7e394b4c6b3e3ab30ede

At this point, looking at "git bisect visualize" shows that
bisect point is at "SUNRPC: Remove obsolete rpcauth #defines",
and commits older than that are NFSv3, 4 SUNRPCs, 2 NLMs, and
stops at "[PATCH] kernel-doc: clean up the script (whitespace)".

> # good: [00b464debf0038b1628996065f0be564ccfbfd86] SUNRPC: Remove obsolete rpcauth #defines
> git-bisect good 00b464debf0038b1628996065f0be564ccfbfd86

And this is marked to be good -- it leaves:

       SUNPRC    good
   SUNRPC  NFSv3 00b464
  ...o---o---o---o---------o--------o
                          /         bad
     o---o---o---o---o---o          v2.6.16-rc2
 good  
 cf41f8  md  md  md  md  dm

> # good: [35849c75d7750a254119c1a4b88c90156919df2a] md: Add sysfs access to raid6 stripe cache size
> git-bisect good 35849c75d7750a254119c1a4b88c90156919df2a

Then you mark the rightmost md to be good.

                 good
                 00b464
                 o---------o--------o
                          /         bad
                     o---o          v2.6.16-rc2
                   good
                     md  dm

So at this point, assuming the bug is something that is
bisectable, there are still three suspects:

  (1) dm (device-mapper log bitset: fix big endian)
  (2) the merge was screwed up 
  (3) Linus did more than setting EXTRAVERSION in v2.6.16-rc2

> # good: [33052057e3e2db7f37fc78aa3f25c98f7e989fae] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> git-bisect good 33052057e3e2db7f37fc78aa3f25c98f7e989fae

And your test showed the merge one was good.

                          good
                          330520
                 o---------o--------o
                          /         bad
                     o---o          v2.6.16-rc2
                   good
                     md  dm

As humans, we can tell that it is not very plausible that the
EXTRAVERSION change caused whatever breakage you are chasing,
but sorry, from your log, I think bisect is doing the right
thing.

The last stretch of the md/dm track does not seem to have much
to do with ipw2200 (isn't that a wireless thing?), and the other
track does not look card specific even though NFS and SUNRPC
sounds networking related.  If I have to guess:

 (0) the bug is not really reproducible;

 (1) an earlier part of bisection misrecorded bad as good;

 (2) older commits on these two tracks have subtle interaction,
     and the problem does not surface without such interaction
     (but that is not plausible because your test on the final
     "merge" should have shown the problem if that is the case);
