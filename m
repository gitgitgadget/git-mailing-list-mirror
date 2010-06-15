From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: No working tree repository
Date: Tue, 15 Jun 2010 14:41:34 -0600
Organization: icecavern.net
Message-ID: <201006151441.35554.wjl@icecavern.net>
References: <4C17BEB7.90403@cfl.rr.com> <vpqy6egi2va.fsf@bauges.imag.fr> <4C17C77C.9000002@cfl.rr.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/V+FMA8v1IrnFSD"
To: Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 22:50:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOd5v-0005OO-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 22:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0FOUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 16:50:45 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:60188 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754147Ab0FOUuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 16:50:44 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2010 16:50:44 EDT
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 80335361E5;
	Tue, 15 Jun 2010 14:41:38 -0600 (MDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-trunk-amd64; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4C17C77C.9000002@cfl.rr.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149223>

--Boundary-00=_/V+FMA8v1IrnFSD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday, June 15, 2010 12:33:32 Phillip Susi wrote:
> Ahh, that's the magic word I was groping for.
> 
> It seems that --bare on clone will prevent the checkout of the local
> working tree.  If I decide I do want the sources today I can just check
> them out, but what is the proper way to do the reverse?  I was thinking
> something like somehow empty the index file then do a git-reset or
> git-checkout-index to clean up the working tree to match the empty
> index, but I can't figure out how to empty the index.

I often want to have a regular tree, but only sometimes check it out, and I 
want it to be in-place (e.g. not a bare repository and a separate work-
tree).

What I do is I make a local "empty" branch with no files or ancestory. For 
this I have a "git-emptybranch" script (attached), but you can easily do 
this by hand.

Then when I want files, I do:

$ git checkout master  ## or whatever branch

When I'm done, I do

$ git checkout empty

and all the files go away.

Even with empty checked out, I can fetch, push, run gitk --all, etc.

This works well for me.

--Boundary-00=_/V+FMA8v1IrnFSD
Content-Type: application/x-shellscript;
  name="git-emptybranch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-emptybranch"

#!/bin/sh
if [ $# -ne 1 ]; then
  2<&1
  echo "usage: git emptybranch <new_branch>"
  exit 1
fi

if ! git check-ref-format refs/heads/"$1"; then
  2<&1
  echo "fatal: '$1' is not a valid branch name."
  exit 1
fi

git symbolic-ref -m "git emptybranch $1" HEAD refs/heads/"$1"
git rm --cached -r -q --ignore-unmatch -- '*'

--Boundary-00=_/V+FMA8v1IrnFSD--
