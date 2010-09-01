From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Additional remote on a local clone. Where do the objects go?
Date: Wed, 01 Sep 2010 13:51:03 +0200
Message-ID: <i5len7$dpr$1@dough.gmane.org>
References: <i5kudr$dp7$1@dough.gmane.org> <AANLkTi=_uP_zFOV_k=cM8TXH16kTPAoPGpNkz+QUSzb-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 13:51:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqlqe-0007BX-2v
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 13:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab0IALvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 07:51:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:36299 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab0IALvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 07:51:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OqlqU-00074W-0a
	for git@vger.kernel.org; Wed, 01 Sep 2010 13:51:14 +0200
Received: from 188.111.54.39 ([188.111.54.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:51:14 +0200
Received: from steveire by 188.111.54.39 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:51:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.39
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155039>

Tay Ray Chuan wrote:

> Hi,
> 
> On Wed, Sep 1, 2010 at 3:12 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> git clone git://gitorious.org/qt/qt.git qtrepo
>> cd qtrepo
>> git checkout -b 4.7 origin/4.7
>> git checkout -b 4.6 origin/4.6
>> git clone qtrepo qt46
>> cd qt46 && git checkout -b 4.6 origin/4.6
>> cd ..
>> git clone qtrepo qt47
>> cd qt46 && git checkout -b 4.7 origin/4.7
>> cd ..
> 
> Two improvements: shared objects, and configuring git-pull:

I'm confused. I thought the local clone already used shared objects?

> 
>   git clone git://gitorious.org/qt/qt.git qtrepo
>   git init qt46
>   PARENT_GIT=$(pwd)/qtrepo/.git
>   cd qt46
> 
>   # use of shared objects - tell git where to find the "missing" objects
>   cat $PARENT_GIT/objects > .git/objects/info/alternates
> 
>   # setup of git pull
>   cat <<EOF >> .git/config
> [remote "parent"]
>   url = $PARENT_GIT
> [branch "master"]
>   remote = parent
>   merge = refs/remotes/origin/4.6
> EOF

So this will pull from the gitorious remote and store the objects in the 
parent git from where they are shared with this local clone?

Which is the better solution between this and git-new-workdir given that 
these are permanent branches, not temporary, and I'll want to push and pull 
various clones and share the objects. It looks like the git-new-workdir 
option creates symlinks, whereas the local clone creates hard links, and 
this solution creates a redirect of sorts. 

> 
>   # done!
>   git pull
> 
> Repeat for 4.7.
> 
> If you want to go one step further and track these repos, you could
> look at git-submodule or git-subtree.
> 
