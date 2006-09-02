From: Russell <russellsteicke@gmail.com>
Subject: Suggestions for my use case
Date: Sat, 2 Sep 2006 22:41:23 +0800
Message-ID: <c1b8b6670609020741q2d45ea3nf336611edcd452b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 02 16:41:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJWgd-0004wY-NQ
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 16:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWIBOlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 10:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWIBOlZ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 10:41:25 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:45090 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750846AbWIBOlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 10:41:24 -0400
Received: by py-out-1112.google.com with SMTP id n25so1774131pyg
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 07:41:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aR7tVRj3xGu6E0cEgOQHX+zkHfZ86NfvOA1wViXoSDpeNtmDxgIGVIq4uj3mriBQQlpeslZO1rxKQAHHK0NuX7yCwve7+Ht0yAvNcXm8GEivG9lPTTaOmfWoTAr9u9nTXb+KU9q36UtmYoRphgM5EBXhuJJLjHRXySth4TzI0ng=
Received: by 10.35.36.13 with SMTP id o13mr5518683pyj;
        Sat, 02 Sep 2006 07:41:23 -0700 (PDT)
Received: by 10.35.92.20 with HTTP; Sat, 2 Sep 2006 07:41:23 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26338>

Hello,

I've been tring git for a few private projects and have come up with a
way to organise distributed development on multiple machines.  I was
wondering if anyone else could comment on what I've done?  Here it
is...

I want to be able to work on a project called proj on multiple
computers, and have backups on removable media.  Let's say I have
computers c1 and c2, and a removable hard disk labelled disk1.  I've
setup the repositories in

  c1: /home/me/proj
  c2: /home/me/proj
  disk1: /media/disk1/me/proj

In c1:/home/me/proj/.git/remotes/c2
  URL: ssh://c2/home/me/proj
  Pull: refs/heads/master:refs/heads/host/c2
  Push: refs/heads/master:refs/heads/host/c1

In c1:/home/me/proj/.git/remotes/disk1
  URL: /media/disk1/me/proj
  Pull: refs/heads/master:refs/heads/disk/disk1
  Push: refs/heads/master:refs/heads/host/c1

In c2:/home/me/proj/.git/remotes/c1
  URL: ssh://c1/home/me/proj
  Pull: refs/heads/master:refs/heads/host/c1
  Push: refs/heads/master:refs/heads/host/c2

In c2:/home/me/proj/.git/remotes/disk1
  URL: /media/disk1/me/proj
  Pull: refs/heads/master:refs/heads/disk/disk1
  Push: refs/heads/master:refs/heads/host/c2

c1 has these branches:
  master
  host/c2
  disk/disk1

c2 has these branches:
  master
  host/c1
  disk/disk1

disk1 has these branches:
  master
  host/c1
  host/c2

So after doing some work at c1 and committing into master, I can
  c1$ git-push c2
  c1$ git-push disk1

Then when I sit down at c2:
  c2$ git-pull . host/c1

Or if I've forgotten to push from c1:
  c2$ git-pull c1

Or I can cart disk1 around, and
  c2$ git-pull disk1

Each repository stays on its master branch.  As per the git-pull man
page, no development is done on branches that I pull from.

This is working fine for me at the moment, which is single person
development, straight line, no branching.  When I come to branches, I
think the branches will need to be added in each repository, with push
and pull lines in .git/remotes/c1 etc.

Does this look reasonable?  What have I missed that would make this
more manageable, particularly with respect to branching?

-- 
VGER BF report: U 0.500329
