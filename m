From: Brian Foster <brian.foster@innova-card.com>
Subject: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 08:37:39 +0200
Message-ID: <20080416063739.4B72647879@blf.utvinternet.co.uk>
References: <20080416062925.8028e952@zebulon.innova-card.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 08:49:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm1NL-000094-QI
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 08:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbYDPGn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 02:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbYDPGnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 02:43:25 -0400
Received: from mail-pc.visp.tiscali.fr ([213.36.240.240]:56615 "EHLO
	mail.visp.tiscali.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbYDPGnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 02:43:25 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2008 02:43:24 EDT
Received: from blf.utvinternet.co.uk (213.36.193.146) by mail.visp.tiscali.fr (7.3.117.3)
        id 479F69B2007C4862; Wed, 16 Apr 2008 08:37:48 +0200
Received: from blf.utvinternet.ie (localhost [127.0.0.1])
	by blf.utvinternet.co.uk (Postfix) with ESMTP id 4B72647879;
	Wed, 16 Apr 2008 08:37:39 +0200 (CEST)
In-reply-to: <20080416062925.8028e952@zebulon.innova-card.com>
Comments: In-reply-to "Brian FOSTER" <brian.foster@innova-card.com>
   message dated "Wed, 16 Apr 2008 08:29:25 +0200".
X-Mailer: [nmh-1.1-RC1] MH.6.8, SUSE Linux 9.1
X-URL: http://www.blf.utvinternet.ie
Content-ID: <10891.1208327859.1@blf.utvinternet.ie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79679>

   (many many apologies if this turns into a double post,
  there seems to have been problems with the 1st attempt?)

 I've recently inherited a bare git repository,
 which, as far as I can tell (I'm something of
 a newbie with git), seems Ok: `git fsck --full'
 does not report any problems.    however, any
 clones I make from it are not Ok:

	$ git-fsck --full   # clone (same command for bare repo is Ok)
	broken link from  commit dd3f3c0636cfd50719c706b030db5473b0270add
		      to  commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
	missing commit fb57c018d15005b60f104e57f198ff34a6035b99
	missing commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
	missing commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
	missing commit dff364d8da15be0b856a174062fb785acb1c363e
	broken link from  commit 8700854c41a40d333e90104971c3abbbcf082e57
		      to  commit b8b78d1c09e7009f97a1d624f4d771d7e5bd8551
	missing commit ce33a5e8c32816f38862bc41560a1d646d0803a6
	missing commit 91483db9b01b547ae9cc45c8c98b217642acb40a
	missing commit b8b78d1c09e7009f97a1d624f4d771d7e5bd8551
	broken link from  commit c87c46fe892211f8aa4fd363ccff4f667a9aaf7d
		      to  commit ce33a5e8c32816f38862bc41560a1d646d0803a6
	broken link from  commit fb5967688f7b464421cff28f266b64ad2a313a9e
		      to  commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
	broken link from  commit e5a60f1636cceac33777bb8098a0b7a4a136a56c
		      to  commit fb57c018d15005b60f104e57f198ff34a6035b99
	broken link from  commit 2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
		      to  commit 91483db9b01b547ae9cc45c8c98b217642acb40a
	broken link from  commit 0ff75b3afff6fb306bef221bf1823ccf5ffc568b
		      to  commit dff364d8da15be0b856a174062fb785acb1c363e
	$ 

 the Ok(?) bare repository only has a `master' branch.
 it has numerous tags.  AFAIK, it has been "inactive"
 for the last c.6+ months (or longer?), except (maybe)
 for browsing, probably with gitweb.  there have been,
 as far as I can tell, no commits or other "writes"
 for the last c.6+ months.

 to my extreme disgust, it was never(?!) backed-up,
 except for one not entirely coincidental backup,
 also c.6+ months ago.  ;-(   (this mind-boggling
 silliness is being fixed ASAP!)

 this is happening regardless of whether the clone
 is made on the same machine or a different one,
 regardless of the transport, and for both `--bare'
 and not-bare clones.  nothing fancy is being done
 during the cloning: `git clone [--bare] DIR_or_URL'

 a test (tried by someone else) using that one
 backup apparently produced the same results:  the
 backup seems Ok, but clones made from it are not.

 the missing commits are linux-mips.org/kernel.org
 mergers (mostly).  apologies for being vague here,
 but I don't have my notes with me.  ;-(

 what is going on?  I'm completely baffled!  to-date,
 nothing terribly obvious/similar has shown up in any
 searches I've tried.  (and there's nothing unusual in
 /var/log/* that I can see.)

 I've also no idea how to "fix" the problem.

 explanations, suggestions, questions, &tc are all
 very welcome.  (please keep in mind my current level
 of knowledge/experience about git is very weak. ;-\ )

 this is all(?) using git 1.5.x (where the .x varies
 depending on the machine in question); the distros
 being used include ubuntu 7.10, FC-5, and probably
 others.  (I'll check the filesystem tomorrow, but
 I believe it's sane.)

cheers!
	-blf-
-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
