From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [1.8.0] Tracking empty directories
Date: Wed, 2 Feb 2011 19:21:53 -0700
Organization: icecavern.net
Message-ID: <201102021921.53755.wjl@icecavern.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com> <4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 03:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkopt-0007kA-C0
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 03:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab1BCCWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 21:22:09 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:55367 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754956Ab1BCCWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 21:22:08 -0500
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id AAB1B35A87;
	Wed,  2 Feb 2011 19:22:01 -0700 (MST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165946>

On Wednesday, February 02, 2011 16:33:09 David Aguilar wrote:
> I don't like where this is going. Users are not always right.
> Touch .gitignore and be done with it.   This is a big change with
> negligible benefits.  I don't understand why this is needed.

I am not usually bothered too much that git doesn't story directories, and 
when I need to do it, I can do the .gitignore trick just like anyone else.

However here are a few reasons that I miss this feature sometimes:

  1) Why WOULDN'T you want to track empty directories? We track empty files: 
isn't that just as pointless? What if git couldn't track empty files and 
automatically removed files when they became empty? Well, I could live with 
that just as well, with some silly workarounds every once in a while (e.g. 
echo empty > some_file).

  2) One of git's best strengths is that it's so easy to interact with other 
SCM software, primarily because git's features are a SUPERSET of other SCMs. 
However, almost every other SCM can track empty directories, except git, 
which makes it much harder to use as universal tool, where I can trust that 
everything will round-trip as well as possible. Also, other SCMs don't want 
".gitignore" files cluttering their repository any more than we want their 
SCM tool's random control files in our repositories.

  3) Forget for a moment the cuddly git idosynchracies that through use we 
have come to know and "love". From a design perspective, does putting and 
tracking, a file called IGNORE in a directory you want to KEEP make sense? 
It's one thing to use "touch .gitignore" in an empty directory to keep it 
*as a workaround*, based on implementation details (i.e. any file in the 
directory will do, but we probably will have a .gitignore anyway eventually, 
so might as well as use that) but it's a strange *design*. =)

  4) On many projects I work on with a huge number of people, the workflow 
is to create a very, very intricate directory hierarchy skeleton, so that 
it's clear to everyone where everything goes and how it is organized, even 
before any work is started. In this case with git, it's annoying to do this 
because there are worthless .gitignore files cluttering up everything, which 
makes it harder to find where there are *actual* ignore rules being applied.

  5) Git not tracking empty directories and the (perceived?) arrogant 
reaction from git experts ("no big deal, just touch .gitignore" -- I've said 
this to people too, since it's the canonical answer, but I always feel a 
little chagrined after hyping up everything git can do) sometimes is just 
one more thing that makes git harder to sell to others, especially when they 
are already in love with Subversion or whatever.

Most of all, think of it this way: maybe git doesn't need to track empty 
directories in order to be awesome, but is there some reason that tracking 
empty directories would make it less awesome?

Anyway, just some thoughts.
