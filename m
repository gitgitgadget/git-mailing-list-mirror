From: Nicolas Noble <pixel.nobis@gmail.com>
Subject: git-svn: ignoring a bogus svn revision ?
Date: Sun, 3 May 2009 12:24:03 -0700
Message-ID: <a70244740905031224j6b215bcfxfe11bf5ae84c70fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 03 21:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0hIL-00019J-Pa
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 21:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbZECTYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbZECTYF
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 15:24:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:11488 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbZECTYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 15:24:04 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1981707yxj.1
        for <git@vger.kernel.org>; Sun, 03 May 2009 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=UlBcywEb5NXurucOYouu7lPR2DrirCJYeXP7kxMa7nY=;
        b=xQPkmLlT01eA5mMqIdX54K0fdC8LgWq4CgR+0W8H4rH5N3Z0o5zSyWbYFhbsOwTJEE
         Zb5hPgiagiN9ppkfXPvapCy9e1JCLOhNyTBldoPLer4xfomjox+MBVZg4OMZD/FKMTvJ
         63ZtJUv252o/Cs0I4H0mmZt8opziTWsD4KFOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=RzLtyPVnelelHFRbe5dMYD1mDblws9DgoUr7/gCUALnh3P2wNC7afR5/bXNtZaUcLI
         SnJj9pfO9XYiJ/IjYr2DD8an96VNH9dPKA44JPSssiELMH1easxjK41GSw6MjdPE9q0s
         nXvapKGNAJ+zZgeG1WTDIsV58lAOtXswWh0pY=
Received: by 10.150.177.20 with SMTP id z20mr10582337ybe.13.1241378643116; 
	Sun, 03 May 2009 12:24:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118186>

Hello,

  I'm a frantic user of git-svn at work, as my company uses SVN as a
SCM for all of our projects. I've been very happily using git-svn over
our repositories since quite some time, and I think I managed to
convert a couple of colleagues by doing so.

  But now I'm facing an interesting issue. Our biggest repository has
over 102600 revisions, and initializing from scratch the git
repository up to this revision takes approximately 2 days of computer
work. The trouble begins with revision 102601... Up so far the
repository was in a perfect shape, and no one did any huge mistake. On
revision 102601 however, someone branched... /. Not /trunk, but /,
which means the whole nine yards, containing tags, branches, and
trunk.

  So I'm stuck with this:

repository-up-to-102600$ git branch -r | wc -l
1824

  And when I issue a git-svn fetch --no-follow-parent --revision
102601, git-svn starts trying to fetch all of these 1824 branches and
tag, obviously. I had to add the --no-follow-parent otherwise git-svn
would just go nuts. Now if it wasn't for the loosy svn server
disconnecting me after 2 or 3 days of work trying to check out this
branch, git-svn would probably manage to get over it. But the server
can't keep up it seems, and I eventually get disconnected, which means
I have to do it all over again.

  Of course, this svn commit is undeniably bogus, and no one will ever
be able to check it out and work on it for real. However, this doesn't
disrupt the usual course of work for other SVN users, but just
prevents anyone from using git-svn ever again on this repository.

  I've tried to look into how to remove/amend this svn revision
directly onto the server, but even if some documentation was telling
me how to do so (which isn't the case), our IS crew is just too
stubborn, and fills my requests back with "Please use a SVN client
supported by the IS crew; you can find links on this page...". I'm
still going to try to go through this path though, as I feel this is
probably the right thing to do, (apart holding my boss hostage in his
office until they finally decide to switch over to git completely, and
stop using a piece of software that allows you to push bogus commits)

  So on the other hand, I'm looking at how git-svn works, and I'm
trying to jump around this utterly bogus svn revision. I haven't found
any information at all about how I could skip this revision, and even
though I'm all willing to make some tests on the git repository itself
by tweaking it, I'd hate to leave it in a broken state that would
explode in my hands several weeks/month later. Thus I think I'd better
ask the authors directly, in order to know how I could achieve that in
a way that isn't too disruptive.

  Thanks!

  -- Nicolas Noble
