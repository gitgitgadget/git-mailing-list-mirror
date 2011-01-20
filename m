From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 12:21:00 -0700
Organization: icecavern.net
Message-ID: <201101201221.00977.wjl@icecavern.net>
References: <ih1449$ul6$1@dough.gmane.org> <ih95fg$62b$1@dough.gmane.org> <AANLkTikvVaSTV8hVjDXLvOEEDv5qr19ybk3Cm--+bgWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 20:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg04J-0000a5-RU
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 20:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab1ATTVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 14:21:10 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:46988 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753029Ab1ATTVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 14:21:08 -0500
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id C048135AF3;
	Thu, 20 Jan 2011 12:21:03 -0700 (MST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <AANLkTikvVaSTV8hVjDXLvOEEDv5qr19ybk3Cm--+bgWA@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165323>

On Thursday, January 20, 2011 10:32:40 Felipe Contreras wrote:
> Hi,
> 
> On Thu, Jan 20, 2011 at 1:14 PM, Stephen Kelly <steveire@gmail.com> wrote:
> > Stephen Kelly wrote:
> >> On Friday we had an issue where a developer pushed a branch called
> >> HEAD to the remote server. The result was that other developers could
> >> not pull or push.
[...]
>  Which version of git?
>  Which kind of network transport was used?
>  Is this reproducible?

FWIW, here is a quick demonstration of at least one problem with having a 
branch called HEAD. You can make it and push it fine, but when cloning, you
don't get it.

#!/bin/bash
git init --bare origin.git
git clone origin.git wc1
cd wc1
git commit --allow-empty -m "Initial rev"
git checkout -b HEAD
git commit --allow-empty -m "Make HEAD branch"
git push --all
cd ..
git clone origin.git wc2
diff -u <(cd wc1; git branch -a) <(cd wc2; git branch -a)
diff -u <(cd wc1; git log --all) <(cd wc2; git log --all)

If I do the following from wc2 I can get the branch manually:

git pull origin refs/heads/HEAD:HEAD

I haven't played with it enough to see what other problems might arise.
