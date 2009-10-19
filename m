From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 13:27:48 -0600
Organization: icecavern.net
Message-ID: <200910191327.49092.wjl@icecavern.net>
References: <loom.20091019T094924-194@post.gmane.org> <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de> <7v7hur1a0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 21:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzxtg-0006Ro-Q4
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 21:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbZJST1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 15:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbZJST1u
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 15:27:50 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:59201 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755220AbZJST1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 15:27:50 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id E8A5C3686E
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 21:27:52 +0200 (CEST)
User-Agent: KMail/1.12.0 (Linux/2.6.29-2-amd64; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7v7hur1a0h.fsf@alter.siamese.dyndns.org>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130730>

(Not CCing everyone, since this is mostly curiosa in the "using git as it 
was never intended" section):

On Monday 19 October 2009 13:03:42 Junio C Hamano wrote:
> Once a packfile is created and we always use it read-only, there didn't
> seem to be much point in suspecting that the underlying filesystems or
> disks may corrupt them in such a way that is not caught by the SHA-1
> checksum over the entire packfile and per object checksum.  That trust in
> the filesystems might have been a good tradeoff between fsck performance
> and reliability on platforms git was initially developed on and for, but
> it might not be true anymore as we run on more platforms these days.

Filesystems are mostly reliable, but only until your crazy users do strange 
and terrible things. I have a real, non-toy environment where I use this 
stack as a [horrible] workaround for some issues beyond my control:

git -> ext4 -> lvm -> dmcrypt -> loop -> sshfs -> cygwin sshd -> SMB share

Amazingly, this works pretty reliably with many gigabytes of data in a git 
repository, even with the occasional crash because of flakiness with the 
"sshfs -> cygwin sshd" piece of the puzzle. But a good "git fsck" sure 
doesn't hurt in this environment! =)
