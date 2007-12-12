From: Nix <nix@esperi.org.uk>
Subject: git-pull followed by git-gc often yields *much* bigger pack than git-pull alone
Date: Wed, 12 Dec 2007 20:47:41 +0000
Message-ID: <87ejdrej2q.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 21:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2YUy-0004CO-OC
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 21:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbXLLUrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 15:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbXLLUrq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 15:47:46 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:42014 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXLLUrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 15:47:45 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id lBCKlgSw026771
	for <git@vger.kernel.org>; Wed, 12 Dec 2007 20:47:42 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id lBCKlfED007682;
	Wed, 12 Dec 2007 20:47:41 GMT
Emacs: don't try this at home, kids!
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-dcc-servers.net-Metrics: hades 102; Body=1 Fuz1=1 Fuz2=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68101>

I've seen this intermittently, but this is a particularly extreme
example. This happens to be with 1.5.3.7, but I've seen the same
symptoms back in git 1.4.x. I assumed it was something I was doing wrong
then, but I'm no longer so sure.

,----
| hades /usr/packages/poppler/poppler% ls -al .git/objects/pack
| drwxr-xr-x 2 compiler hackers    2048 2007-12-12 20:35 .
| drwxr-xr-x 9 compiler hackers    2048 2007-12-12 20:35 ..
| -r--r--r-- 1 compiler hackers  149288 2007-10-25 23:51 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.idx
| -rw-r--r-- 1 compiler hackers       0 2007-12-06 14:45 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.keep
| -r--r--r-- 1 compiler hackers 1610421 2007-10-25 23:51 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.pack
| 
| hades /usr/packages/poppler/poppler% git-count-objects
| 0 objects, 0 kilobytes
| 
| hades /usr/packages/poppler/poppler% git-remote update
| Updating origin
| remote: Generating pack...
| remote: Done counting 491 objects.
| remote: Result has 351 objects.
| remote: Deltifying 351 objects.
| remote:  100% (351/351) done
| remote: Total 351, written 351 (delta 274), reused 0 (delta 0)
| * refs/remotes/origin/master: fast forward to branch 'master' of git://git.freedesktop.org/git/poppler/poppler
|   old..new: ab0a6c3..f24259c
| * refs/remotes/origin/poppler-0.6: fast forward to branch 'poppler-0.6' of git://git.freedesktop.org/git/poppler/poppler
|   old..new: 5c321d3..db1e360
| Auto-following refs/tags/poppler-0.6.2
| Auto-following refs/tags/poppler-0.6.3
| remote: Generating pack...
| remote: Done counting 2 objects.
| remote: Deltifying 2 objects.
| remote: /2) done
| remote: Total 2, written 2 (delta 0), reused 0 (delta 0)
| Unpacking 2 objects...
|  100% (2/2) done
| * refs/tags/poppler-0.6.2: storing tag 'poppler-0.6.2' of git://git.freedesktop.org/git/poppler/poppler
|   tag: 26470b3
| * refs/tags/poppler-0.6.3: storing tag 'poppler-0.6.3' of git://git.freedesktop.org/git/poppler/poppler
|   tag: fdf7e0b
| 
| hades /usr/packages/poppler/poppler% ls -al .git/objects/pack
| drwxr-xr-x 2 compiler hackers    2048 2007-12-12 20:35 .
| drwxr-xr-x 6 compiler hackers    2048 2007-12-12 20:35 ..
| -r--r--r-- 1 compiler hackers   12080 2007-12-12 20:35 pack-f534c957f3ee7f3f1046dee0081fcc315d9698bb.idx
| -r--r--r-- 1 compiler hackers  678643 2007-12-12 20:35 pack-f534c957f3ee7f3f1046dee0081fcc315d9698bb.pack
| -r--r--r-- 1 compiler hackers  149288 2007-10-25 23:51 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.idx
| -rw-r--r-- 1 compiler hackers       0 2007-12-06 14:45 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.keep
| -r--r--r-- 1 compiler hackers 1610421 2007-10-25 23:51 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.pack
`----

OK, so that's a 662Kb packfile, 351/274...

[... a couple of trivial merges, then ...]

,----
| hades /usr/packages/poppler/poppler% git-count-objects
| 5 objects, 10 kilobytes
| 
| hades /usr/packages/poppler/poppler% git-gc
| Generating pack...
| Done counting 827 objects.
| Deltifying 827 objects...
|  100% (827/827) done
| Writing 827 objects...
|  100% (827/827) done
| Total 827 (delta 393), reused 695 (delta 331)
| Pack pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47 created.
| Removing unused objects 100%...
| Done.
| 
| hades /usr/packages/poppler/poppler% ls -al .git/objects/pack
| drwxr-xr-x 2 compiler hackers    2048 2007-12-12 20:36 .
| drwxr-xr-x 4 compiler hackers    2048 2007-12-12 20:36 ..
| -r--r--r-- 1 compiler hackers   20912 2007-12-12 20:36 pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47.idx
| -r--r--r-- 1 compiler hackers 1144055 2007-12-12 20:36 pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47.pack
| -r--r--r-- 1 compiler hackers  149288 2007-10-25 23:51 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.idx
| -rw-r--r-- 1 compiler hackers       0 2007-12-06 14:45 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.keep
| -r--r--r-- 1 compiler hackers 1610421 2007-10-25 23:51 pack-f5a84fe3e212f9dc62a65aee617be4bf1387cb2b.pack
`----

The git-gc figures are wildly different from the original server-side
packing, as is the size of the resulting packfile.

This has me scared to do git-gc, which is presumably not good if we're
supposed to get into the habit of running it whenever we have a spare
moment :)

A while back I did a git-gc on the kernel and watched as a 10Mb pack
resulting from a git-pull blew right up to 130Mb: I had to zap the .keep
file, do a complete repack, and blow a backup CD to get the space
back. (This only happens if you have .keep files lying around: if git-gc
is allowed to amalgamate all your packs, it doesn't do this.)

Possibly-relevant .gitconfig settings:

[core]
legacyheaders=false
deltabasecachelimit=32m

[pack]
window=50
aggressiveWindow=100
depth=100

[repack]
usedeltabaseoffset=true

(yes, those windows and depths are intentionally high. I was hoping that
maybe the servers were running with enormous windows... it didn't help.)

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET
