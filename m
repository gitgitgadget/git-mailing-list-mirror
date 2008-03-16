From: kenneth johansson <ken@kenjo.org>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 21:02:59 +0100
Message-ID: <1205697779.12760.20.camel@duo>
References: <frh8dg$t9j$1@ger.gmane.org>
	 <7vabkzmltc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 21:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JazjK-0007Hm-GH
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 21:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYCPUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYCPUoj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 16:44:39 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:42193 "EHLO
	garbo.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYCPUoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 16:44:39 -0400
X-Greylist: delayed 2491 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Mar 2008 16:44:38 EDT
Received: from duo.kenjo.org ([172.16.0.10])
	by garbo.kenjo.org with esmtp (Exim 4.69)
	(envelope-from <ken@kenjo.org>)
	id 1Jaz4O-0002f8-E5; Sun, 16 Mar 2008 21:03:00 +0100
In-Reply-To: <7vabkzmltc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77381>

On Sat, 2008-03-15 at 19:42 -0700, Junio C Hamano wrote:

> You do not want to have any of your own work in this repository, however,
> so there is no reason to separate the remote ones in remotes/origin/
> namespace.  You would want "mirroring".
> 
> You can have in your $GIT_DIR/config something like this:
> 
>         [remote "origin"]
> 		url = $elsewhere
>                 fetch = +refs/heads/*:refs/heads/*

> Modern git allows this setup via "git remote add --mirror"; it is merely a
> convenience wrapper and it is perfectly fine to edit the configuration
> file yourself without using it.

I tried using the option --mirror but then the config end up in a way
that 
all remote repositories master branch maps to exactly the same name. 

However changing the config file manually I did get one that works more
or 
less as I intended. 

So with the below config I can create an empty directory and in that do 
"git --bare init"
copy in the config file and any objects I have laying around. 
then simply put a cron job that once a day do a
"git remote update"

the resulting repository is then possible to clone. And as long as no
repacking is done the object data will be shared. But to share data even
after a repack I guess I need to use GIT_ALTERNATE_OBJECT_DIRECTORIES
for my local clone. And then I need to be very careful when doing any
pruning on the download repository since my local clone could need data
that is no longer needed in the download repository. 

What would a safe procedure be ?? copy all data in the object hierarchy
from the download repository to my local clones then do a gc in them
starting from the download repository. 

------------
[core]
	repositoryformatversion = 0
	filemode = true
	bare = true
[remote "linus"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	fetch = +refs/heads/*:refs/heads/*
[remote "stable_2.6.12"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.12_*
[remote "stable_2.6.13"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.13.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.13_*
[remote "stable_2.6.14"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.14.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.14_*
[remote "stable_2.6.15"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.15_*
[remote "stable_2.6.16"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.16_*
[remote "stable_2.6.17"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.17_*
[remote "stable_2.6.18"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.18_*
[remote "stable_2.6.19"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.19_*
[remote "stable_2.6.20"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.20_*
[remote "stable_2.6.21"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.21_*
[remote "stable_2.6.22"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.22_*
[remote "stable_2.6.23"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.23.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.23_*
[remote "stable_2.6.24"]
	url =
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.24.y.git
	fetch = +refs/heads/*:refs/heads/stable_2.6.24_*

------------
