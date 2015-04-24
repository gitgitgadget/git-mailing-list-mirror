From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: git-completion.tcsh
Date: Fri, 24 Apr 2015 13:30:28 +0200
Message-ID: <20150424133028.Horde.fL7zuT7X5Dj99hzpmme9Hw1@webmail.informatik.kit.edu>
References: <20150401115519.Horde.JM0TEyhacRn5LYAEffMggQ1@webmail.informatik.kit.edu>
 <481BCBD7-457B-4AFB-B878-1417C8C5940C@gmail.com>
 <CAFj1UpHBk1JFmSv4T=wQUNiade9ZW8yiaco9z2-wGJh7yXATuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Perry Rajnovic <perry.rajnovic@gmail.com>, git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:30:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylbob-0007YH-6T
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbbDXLac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2015 07:30:32 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52170 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755038AbbDXLab convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 07:30:31 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YlboS-0004sZ-TB; Fri, 24 Apr 2015 13:30:28 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YlboS-0003nJ-1Z; Fri, 24 Apr 2015 13:30:28 +0200
Received: from x590e20ae.dyn.telefonica.de (x590e20ae.dyn.telefonica.de
 [89.14.32.174]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 24 Apr 2015 13:30:28 +0200
In-Reply-To: <CAFj1UpHBk1JFmSv4T=wQUNiade9ZW8yiaco9z2-wGJh7yXATuA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1429875028.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267729>

Hi,

Quoting Marc Khouzam <marc.khouzam@gmail.com>:
> Hi,
>
> I did notice the problem a while ago and had traced it back to the
> fact that the bash completion scripts no longer adds the trailing '/'
> at the end of directories.
> Tcsh needs that '/' to know not to add that annoying extra space.
>
> Bash 3 needed to put it that trailing '/' but bash 4 did not.  Two
> years ago (!) changes were made in commit
> 3ffa4df4b2a26768938fc6bf1ed0640885b2bdf1 to allow bash 3 to work
> without the trailing '/'.  That caused
> the problem in the tcsh script.
>
> The thing is that with master of today, I don't see the problem any
> more.  I can't tell you when it started working again.
> What is interesting is that the reason it now works is that the
> git-completion.bash script no longer returns anything
> for the case you mention:
>   git add f<tab>
> Instead, it seems to rely on file completion only.

I can't reproduce it with git-completion.bash from current master on =20
its own on with bash 3.1.20(4) from MSysGit, it seems to work as =20
intended here wrt tracked-file-aware file completion.

Set up test repo with these commands:

   git init
   >tracked
   git add tracked
   >non-tracked
   mkdir -p foo/bar
   >foo/bar/somefile.c

Now let's see what happens with 'git add':

   $ git add <TAB>
   foo/         non-tracked

Note, that the file 'tracked' is not offered, so this is clearly not =20
standard bash file completion, but our completion script.  Also note =20
the trailing '/' in 'foo/'.

   $ git add f<TAB>

Just completes to 'git add foo/', no space after '/'.
Add the file:

   $ git add foo/bar/somefile.c

Now let's see 'git rm':

   $ git rm <TAB>
   foo/     tracked

Note, that the file 'non-tracked' is not offered, so again this comes =20
from our bash completion script.

Did you test the bash completion script on its own, or only through =20
the tcsh wrapper?
I'm on MSysGit now, so no tcsh or bash v4 at hand, and no time either, =
=20
so can't dig further at the moment.


G=C3=A1bor
