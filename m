From: Alydis <alydis@august8.net>
Subject: Generating patches/Cherry Picking for a large number of commits
Date: Fri, 28 Aug 2009 14:26:43 -0500
Message-ID: <ae09c2a40908281226r744141bm3a5bf4161ddab3e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh766-0007xu-4p
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZH1T0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZH1T0n
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:26:43 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:32891 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbZH1T0n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 15:26:43 -0400
Received: by fxm17 with SMTP id 17so1753372fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 12:26:44 -0700 (PDT)
Received: by 10.239.139.76 with SMTP id s12mr143215hbs.78.1251487603761; Fri, 
	28 Aug 2009 12:26:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127340>

Hi,

Newly converted git user here.=A0 I've stopped working with Subversion
ever since working with the Linux kernel has introduced me to git, and
never looked back!

I am currently working on a project in which I'm trying to backport
the powerpc boot-wrapper and device tree handling from Linux 2.6.30
into Linux 2.6.21.=A0 We have some third party vendor code that is not
ready for the (new) completely fair scheduler just yet.=A0 Yet, our BSP
relies on cuImage and the DTS files.

The approach I'm taking is to try to cherry-pick any commits between
v2.6.21 and v2.6.30 on the Linux kernel git repository that touch any
file in the arch/powerpc/boot directory into a v2.6.21 branch (and
pray that the conflicts are manageable).

I've tried something along these lines:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-=
2.6
cd linux-2.6
git checkout -b mybranch v2.6.21
git format-patch -o patches v2.6.21..v2.6.30 arch/powerpc/boot
git am -3 patches/*

But, to my dismay, format-patch here tears apart the commits and
applies ONLY the hunks that apply to the arch/powerpc/boot directory.
What I'd much rather do is obtain a list of commits that apply to
arch/powerpc/boot; but, then apply the entire patch.

I'm a bit lost at how to proceed at this point?=A0 Do I need to write m=
y
own script that uses git-log to grab the commit hashes that I want,
then call format-patch (or diff/apply/etc) individually on each of
them?=A0 I realize I'll have to handle patch numbering myself, if I wer=
e
to do that (luckily, I believe format-patch allows you to specify the
starting number).=A0 I also know at some point, I'll have to drill down
into individual commits and do some more detailed cherry picking to
form the desired patch series.=A0 This script seems like a good deal of
work for me... so before I go off and start it, I was wondering if the
git gurus have any clever solutions for me?

Thanks,
Tommy Wang
