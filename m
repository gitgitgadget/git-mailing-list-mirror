From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: working with a large repository and git svn
Date: Wed, 12 Jan 2011 08:30:45 -0700
Organization: icecavern.net
Message-ID: <201101120830.47016.wjl@icecavern.net>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joe Corneli <holtzermann17@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 16:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd2pQ-0004Wc-CU
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 16:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab1ALPlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 10:41:35 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:49957 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752263Ab1ALPle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 10:41:34 -0500
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2011 10:41:34 EST
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id CD9FC35A88;
	Wed, 12 Jan 2011 08:30:51 -0700 (MST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165016>

On Tuesday, January 11, 2011 18:27:10 Joe Corneli wrote:
> I am experiencing trouble with git svn, trying to import a
> large repository (7.9 gigs, ~54000 commits) from Git into
> SVN.
> 
> This has failed in a couple of different ways, depending
> on the operating environment.  With Git version 1.7.3.5
> running on Ubuntu 9.10, in the final step
> 
>   git svn dcommit --no-rebase
> 
> of the formula described below, I get:
> 
>  failing with "Can't fork at /usr/share/perl/5.10.0/Git.pm line 1261."
> 
> after committing just over 2000 revisions.

I haven't tried importing 8 GB from Git to Subversion, but I have used Git 
against existing huge Subversion repositories that are >= 10 GB with little 
trouble, other than that it takes forever because Subversion is slow.

Here are some thoughts on how I'd approach what you are doing. Realize that 
no matter what, it's still probably going to take "forever" (e.g. run it 
over the weekend).

  1) Sounds like git-svn is running out of resources on your machine -- 
that's probably a bug, but work around it: Don't dcommit all 20000 revisions 
at once. Maybe write a shell script that goes through and dcommits a 100 
commits at a time.

  2) Do you need the full history to be in SVN? Can you rebase/squash large 
parts together and thus need to commit less revisions in the first place?

  3) I love git-svn for working with Subversion repositories, but you could 
consider a different tool, like tailor, if you can't make git-svn do what 
you want. I have also heard talk (but I don't know the state of things) of 
people working on a fast-import tool for SVN, so you could git-fast-export 
and svn-fast-import in a big batch.

  4) Does 8 GB of data really belong in the same repository? Maybe it should 
really be split up and used with git submodules or SVN externals? That may 
make things easier to work with in the long term.

  5) Do you really want to be going from Git, to Subversion? That seems like 
a big step backwards. =)

In any case, good luck!
