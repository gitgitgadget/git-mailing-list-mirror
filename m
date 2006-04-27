From: Alex Riesen <raa.lkml@gmail.com>
Subject: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 23:32:07 +0200
Message-ID: <20060427213207.GA6709@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 27 23:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZE5w-0004aa-TE
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWD0VcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 17:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWD0VcO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 17:32:14 -0400
Received: from devrace.com ([198.63.210.113]:49413 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751689AbWD0VcN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 17:32:13 -0400
Received: from tigra.home (p54A05521.dip.t-dialin.net [84.160.85.33])
	by devrace.com (Postfix) with ESMTP id 6ECCA154
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 16:32:13 -0500 (CDT)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FZE5o-00057G-00
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 23:32:08 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FZE5n-0005HA-PP
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 23:32:08 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19244>

NFS server: 2.6.15
Client: 2.6.17-rc2
mount options: tigra:/home /net/home nfs rw,nosuid,nodev,noatime,vers=3,rsize=8192,wsize=32768,hard,intr,proto=udp,timeo=7,retrans=3,addr=tigra 0 0

Repack protocol ($SRC is /net/home/src):

$SRC/linux.git$ git repack -a -d
Generating pack...
Done counting 235947 objects.
Deltifying 235947 objects.
 100% (235947/235947) done
Writing 235947 objects.
 100% (235947/235947) done
Total 235947, written 235947 (delta 182131), reused 235466 (delta 181650)
Pack pack-6dcda5a7782864d57ec44bd30ebec13b07df2c87 created.
$SRC/linux.git$ git fsck-objects --full
git-fsck-objects: error: Packfile .git/objects/pack/pack-6dcda5a7782864d57ec44bd
30ebec13b07df2c87.pack SHA1 mismatch with idx
git-fsck-objects: fatal: delta data unpack failed
$SRC/linux.git$ git fsck-objects --full
git-fsck-objects: error: Packfile .git/objects/pack/pack-6dcda5a7782864d57ec44bd
30ebec13b07df2c87.pack SHA1 mismatch with idx
git-fsck-objects: fatal: delta data unpack failed
$SRC/linux.git$ du -sh .
124M    .
$SRC/linux.git$ cp . -a $BIG/linux.git
$SRC/linux.git$ cd $BIG/linux.git
$BIG/linux.git$ git fsck-objects --full
git-fsck-objects: error: Packfile .git/objects/pack/pack-6dcda5a7782864d57ec44bd
30ebec13b07df2c87.pack SHA1 mismatch with idx
git-fsck-objects: fatal: delta data unpack failed
$BIG/linux.git$ git clone -n . ../tmp
Generating pack...
Done counting 235947 objects.
Deltifying 235947 objects.
 100% (235947/235947) done
Total 235947, written 235947 (delta 182131), reused 235947 (delta 182131)

git-index-pack: fatal: packfile '/mnt/large/tmp/raa/tmp/.git/objects/pack/tmp-wc
Rvk5': bad object at offset 102601801: inflate returned -3
git-fetch-pack: error: git-fetch-pack: unable to read from git-index-pack
git-fetch-pack: error: git-index-pack died with error code 128
fetch-pack from '/mnt/large/tmp/raa/linux.git/.git' failed.

So the repository is now _really_ broken.
I didn't noticed when it started to happen, sorry.
