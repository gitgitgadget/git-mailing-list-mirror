From: Nix <nix@esperi.org.uk>
Subject: What *have* I done?
Date: Sat, 08 Jul 2006 23:48:22 +0100
Message-ID: <87u05ru30p.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 09 00:48:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzLb9-0001II-9V
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 00:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWGHWsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 18:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWGHWsY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 18:48:24 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:37649 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030411AbWGHWsY
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 18:48:24 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id k68MmM4S011391
	for <git@vger.kernel.org>; Sat, 8 Jul 2006 23:48:22 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id k68MmMUO010973;
	Sat, 8 Jul 2006 23:48:22 +0100
To: git@vger.kernel.org
X-Emacs: anything free is worth what you paid for it.
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23517>

I am just a git newbie, still reliant on cogito 0.17.3 for most things
(cogito has a couple of cherry-picked patches from the head for
faster cg-seek and for support of lightweight tags.)

I tried my first conflicted cherry-pick a while back; resolved the
conflict, committed, ran git-update-index over the conflicted file as
git-cherry-pick requested, yet now the branch the cherry-pick was done
to seems to be oddly `half-stuck'.

Here's an example:

loki 590 /usr/packages/linux/linux% cg-status -g
Heads:
  R 2.6.17-stable       4f9619cdd90ac846fa0ca6e9e8a9d87a0d6b4f57
    esperi-guest        764415bf7dc0388d9974218fb71b3c63f19f3828
    master              578997683c8d788f80f7a11fc27fcdf66ac8fd9f
  R origin              120bda20c6f64b32e8bfbdd7b34feafaa5f5332e
    v2.6.17             e519ad6612b8ab69cbf45b59dda45f88cada41f2
   >x86-host            e2a9e65e9d5f7e76dbe0a8fdd0f1356266146c22
loki 591 /usr/packages/linux/linux% cg-diff
loki 592 /usr/packages/linux/linux% cg-switch v2.6.17
Switching to branch v2.6.17...

Now one would expect that after switching, I'd have no uncommitted
changes, right, since I had none before switching and they shouldn't
appear out of thin air? You'd be wrong:

loki 593 /usr/packages/linux/linux% cg-diff | diffstat
 b/Makefile                     |    4 +-
 b/arch/sparc64/Makefile        |   15 +++----
 b/arch/sparc64/kernel/Makefile |    2 -
 b/arch/um/kernel/dyn.lds.S     |    1
 b/kernel/pid.c                 |    2 -
 b/scripts/kconfig/Makefile     |    7 ++-
 b/usr/gen_init_cpio.c          |    2 -
 usr/init                       |   79 -----------------------------------------
 usr/initramfs                  |   45 -----------------------
 9 files changed, 15 insertions(+), 142 deletions(-)

Those miraculously materialized uncommitted changes are the *reverse* of
every commit I made after that failed cherry-pick! (If I switch branches
back, or run `cg-seek', it tries to take these `uncommitted local
changes' with me, with amusing results.)

So, has it forgotten what the branch head is? No: cg-log reports correct
data, cg-reset works fine:

loki 594 /usr/packages/linux/linux% cg-reset
loki 595 /usr/packages/linux/linux% cg-diff
loki 596 /usr/packages/linux/linux%


So, um, what on earth has gone wrong and how do I fix it? (If you need
more info, just ask!)
