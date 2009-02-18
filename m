From: Brent Goodrick <bgoodr@gmail.com>
Subject: Is there a way to exclude user-specified files or directories from 
	participating in merges?
Date: Tue, 17 Feb 2009 16:49:01 -0800
Message-ID: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 01:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZae4-0007iF-QP
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 01:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbZBRAtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 19:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZBRAtF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 19:49:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:1572 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZBRAtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 19:49:03 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2266522rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 16:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=TYlWxpylFaie+TT+L9TmMXdR4B98hGIoEHZwCIBrd0Q=;
        b=RUWXqoIdZV4oMC4Oiy481bv7Zj43qkRSFrMnmzr+AInR31BweNP52ag9uoJB+fz+Ts
         p2DoLorZRun7u4IAB0F+cYveQn6Wo7IuluuXgK3yPSA66LGweM1Hi0VGgyKMHXolJBNg
         w9n6prubhGdu5wRN4RNDNHoWFH6MDRWe6RB3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=AvseI3CkHDuREAGYTGfE56ccfPT7JBzoyM5dCn7wJfkU4Q1VFy37jpN9UATn+drncT
         4DmxEy3Lk4U6PJ2petmHgiszv3ir9trRfzIqvgF67soPb2UN3ISZqncetjgC8K4OLAEY
         DSJikstJOdViM/B3gYaaoOaOLEBabIMp5KELw=
Received: by 10.141.177.2 with SMTP id e2mr221206rvp.266.1234918142005; Tue, 
	17 Feb 2009 16:49:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110488>

Suppose I create a git repo called central.git on a machine I will
call "central". In that central.git repo, I put these files:

  work.sh
  home.sh
  generic.sh

When I clone the central.git repo on to a different machine I will
call "work", I want this fileset to be pulled:

  work.sh
  generic.sh

But not the home.sh file.

Similarly, when I clone the central.git repo on a machine I will call
"home", I want this fileset to be pulled:

  home.sh
  generic.sh

But not the work.sh file.

What I think I need are two branches, one called "home_branch" and
"work_branch", but read on for the twist:

Say I'm working on editing the work machines fileset on the work repo
I had cloned originally from central.git, and commit a change to both
generic.sh and work.sh.  I do a git-push to an appropriate remote
branch I have set up on the central.git repo, so that I can do a
git-merge type of integration on the central machine in the
central.git repo into the other branches (i.e., into the home_branch),
specifically so that the home_branch gets updated with the change to
the generic.sh file.  However, I want the home_branch to be updated
with the change I made to generic.sh, but I don't ever want the
work.sh to show up in the home_branch that would occur during a normal
merge. Likewise, I would not ever want the home.sh file to participate
in merges from the work fileset back over to the home fileset (and
likewise I would not ever want to see the work.sh file show up on the
home_branch).

The above should apply for all files certain special directories. For
instance, if I were to have a work_files directory and a home_files
directory, then the the work_files is for the "work" machine (and
work_branch) and the "home_files" is for the "home" machine (and
home_branch).

How do I mark certain files and/or directories (via relative file
paths or with file globbing) on certain branches to be excluded from
being merged into all other (or a specified list of) branches?
Ideally I would want to only have to add some logic to the .git/config
file in the central.git repo that specifies the exclusions/exceptions,
and not have to remember to make corresponding changes into any of the
other repos that are cloned from it. Is this possible?

Also, is there a way to avoid the home.sh file from ever being added
to any file underneath the .git directory of the repo I cloned on the
"work" machine. I would not want there to be any risk that anyone with
network access to the "work" machine (say, a sysadmin with sufficient
privileges) to be able to see any form of the home.sh file since it
exists on some branch in the .git directory.

Thanks,
Brent
