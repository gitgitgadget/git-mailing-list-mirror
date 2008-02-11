From: Nix <nix@esperi.org.uk>
Subject: Re: warning: no common commits - slow pull
Date: Mon, 11 Feb 2008 21:13:51 +0000
Message-ID: <87ir0vxkkw.fsf@hades.wkstn.nix>
References: <200802102007.38838.lenb@kernel.org>
	<877ihbcwu5.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOg9r-0003QO-JZ
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbYBKVZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYBKVZI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:25:08 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:52839 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYBKVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:25:07 -0500
X-Greylist: delayed 661 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2008 16:25:06 EST
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id m1BLDq3V021329;
	Mon, 11 Feb 2008 21:13:52 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id m1BLDppf024890;
	Mon, 11 Feb 2008 21:13:51 GMT
Emacs: Lovecraft was an optimist.
In-Reply-To: <877ihbcwu5.fsf@mid.deneb.enyo.de> (Florian Weimer's message of "Mon, 11 Feb 2008 16:54:42 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-Rhyolite-Metrics: hades 104; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73589>

On 11 Feb 2008, Florian Weimer spake thusly:

> * Len Brown:
>
>> But this second pull seems to have re-downloaded 172MB,
>> when it should have only needed the last few commits.
>
> I've got a linux-2.6 tree which is reasonable up to date, but which has
> been created by some acient GIT version.  I see the same behavior from
> time to time.  The second pull, after I've canceled the first one,
> usually downloads just the expected data.

I just saw it as well, doing a big update (most of the way from 2.6.23
to current tip):

loki 214 /usr/packages/linux/linux% git pull
remote: Counting objects: 118487, done.
remote: Compressing objects: 100% (22411/22411), done.
remote: Total 102959 (delta 85610), reused 97521 (delta 80449)
Receiving objects: 100% (102959/102959), 26.41 MiB | 70 KiB/s, done.
Resolving deltas: 100% (85610/85610), completed with 7493 local objects.
warning: no common commits
remote: Counting objects: 708160, done.
remote: Compressing objects: 100% (124705/124705), done.
Receiving objects:   9% (70213/708160), 25.33 MiB | 70 KiB/s

loki 215 /usr/packages/linux/linux% ls -l .git/objects/pack
total 240224
-r--r--r-- 1 compiler hackers   2651912 2008-02-11 20:44 pack-69c40f2970403946a75203cc393ecc2b1abf8aa3.idx
-r--r--r-- 1 compiler hackers  69189104 2008-02-11 20:44 pack-69c40f2970403946a75203cc393ecc2b1abf8aa3.pack
-r--r--r-- 1 compiler hackers  14719304 2007-12-02 16:01 pack-7eb87d068cee2214e4b0c5b6b571014654cbaaa4.idx
-rw-r--r-- 1 compiler hackers         0 2007-12-06 14:45 pack-7eb87d068cee2214e4b0c5b6b571014654cbaaa4.keep
-r--r--r-- 1 compiler hackers 157916633 2007-12-02 16:01 pack-7eb87d068cee2214e4b0c5b6b571014654cbaaa4.pack
-r--r--r-- 1 compiler hackers     11744 2007-12-14 22:55 pack-993c8617968f3d44603663e4a2915ee260236f91.idx
-r--r--r-- 1 compiler hackers   1004082 2007-12-14 22:55 pack-993c8617968f3d44603663e4a2915ee260236f91.pack


Oddly enough I then halted it: I have no desire to blow an extra 160Mb
of space on duplicates of objects I've already got.

Pullng again promptly grabbed 102791 objects (i.e. prety much the same
set again) as if the pack up there at the top of the directory listing
didn't even exist. (git-repack will happily clean up the duplicates for
me, I'm sure.)

That time, it worked:

loki 216 /usr/packages/linux/linux% git pull
remote: Counting objects: 118319, done.
remote: Compressing objects: 100% (22389/22389), done.
remote: Total 102791 (delta 85463), reused 97353 (delta 80303)
Receiving objects: 100% (102791/102791), 26.39 MiB | 91 KiB/s, done.
Resolving deltas: 100% (85463/85463), completed with 7494 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new tag]         v2.6.24    -> v2.6.24
 * [new tag]         v2.6.24-rc1 -> v2.6.24-rc1
 * [new tag]         v2.6.24-rc2 -> v2.6.24-rc2
 * [new tag]         v2.6.24-rc3 -> v2.6.24-rc3
 * [new tag]         v2.6.24-rc4 -> v2.6.24-rc4
 * [new tag]         v2.6.24-rc5 -> v2.6.24-rc5
 * [new tag]         v2.6.24-rc6 -> v2.6.24-rc6
 * [new tag]         v2.6.24-rc7 -> v2.6.24-rc7
 * [new tag]         v2.6.24-rc8 -> v2.6.24-rc8
 * [new tag]         v2.6.25-rc1 -> v2.6.25-rc1
[...]

This is with git version 1.5.4.25.g7f255-dirty. (only local changes are
some makefile tweaks).

I've never seen this failure before with any earlier git version, but
that might just be coincidence.

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET
