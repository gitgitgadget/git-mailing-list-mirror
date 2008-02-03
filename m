From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Tips for different workflows/use cases
Date: Mon, 4 Feb 2008 00:49:20 +0300
Message-ID: <20080203214920.GW29522@dpotapov.dyndns.org>
References: <8b65902a0802030708i204d1714od850a59d9d25d0c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmji-0000hO-Ng
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbYBCVtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbYBCVti
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:49:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:21135 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbYBCVt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:49:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1056878ugc.16
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=gn7rtTCAVZ5BgdR++n7T6ulqCdx52jF67WFeOvlYuMQ=;
        b=nrKt0G7SbeopR9bm8kLhZ2VL+amup7/H/xlscpm/3ZgzikOCYqHtU5VtW9chVX3uAjP35kZAIOJGYATHDr5BhxwK7B/BBINl9fNDLKCrE0nmgXM85LXgyDriCYGzJ5D2cosxiSpSwZTRcgOj4SIySznWcJBUzgI/0FzIKr10DmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Xd+7nmbIIGhU5VJD1gkWRaSM+fksJWLtOzGIFrp5dgGhV3/qgXaEPW1GTFzZswBQlUEQaWEpVmEH1eQVtK+A0J2cor2In+UYg8ypGSpX8dt9E0yFIvq3i9pS+uAeiJkqDhO1epKeAKE51AydwDYKlUk25e9SoxcIqBFxKlCYb2E=
Received: by 10.66.254.15 with SMTP id b15mr1154769ugi.76.1202075364521;
        Sun, 03 Feb 2008 13:49:24 -0800 (PST)
Received: from localhost ( [85.141.189.132])
        by mx.google.com with ESMTPS id o11sm6140681fkf.9.2008.02.03.13.49.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 13:49:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8b65902a0802030708i204d1714od850a59d9d25d0c1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72408>

On Sun, Feb 03, 2008 at 04:08:07PM +0100, Guilhem Bonnefille wrote:
> So, what is the best practices:
> - should he decide to push/pull every time from the same repo or
> should he only use the "pull" command on each repo (and never push)

If both computers are always online and you can connect at will then
"pull" is the simplest solution. The problem with "push" is that pushing
to the local branch of another that has the working directory attached
to it will give you not exactly what you want. The default refspec for
"push" is only suitable for pushing into a "bare" repository from where
anyone can pull. However, if you do not want to have a separate bare
repository for synchronization, you can avoid by providing suitable
refspec for push.

Let's suppose that you have two computers (computer1 and computer2),
and you can use computer1 to connect to computer2, but computer2 cannot
access to computer1.

In repository on computer1:

  git remote add computer2 $COMPUTER2_URL
  git config remote.computer2.push "+refs/heads/*:refs/remotes/computer1/*"

Please, note I used 'computer1' in the refspec above. It is the prefix
for local branches that will be added when they appear in the repository
on computer2. If you have only two computers then you can use 'origin'
instead of both 'computer1' and 'computer2' above, which will alow you
to use push and pull without additional arguments.

Now, you can safely push my changes from the current computer (computer1)
to computer2:

  git push computer2

Then when you start working on computer2, you can either merge changes:

  git merge computer1/master

or if you want to have linear history then you have to use rebase your
local changes on top of computer1

  git rebase computer1/master

Note: You should never rebase changes that you published (i.e. that you
share with other peoples), because rebase re-writes history.  Also, if
the first thing that you do when you change the computer is to merge
changes for another then you do not need ever use rebase and you still
will have linear history.

Now, you back on computer1, and again you can either merge changes:

 git pull computer2

or rebase local changes

 git pull --rebase computer2

Note:
 'git pull' is equivalent 'git fetch' and 'git merge'
 'git pull --rebase' is equivalent 'git fetch' and 'git rebase'


> - should he decide to create a third repo and use it as central repo.

Often it makes sense to create an extra repo. After all, disk space
is cheap and having extra backup never hurts.

> 
> 2- It's a variation of the previous one. Now, one of the two computers
> is a laptop. Is there any recommended practices to work with laptop?

I suppose that laptop computer has limited online time. So, you have to
push from it. You can push easier to a central "bare" repo, or directly
to your other computer as I described above (laptop=computer1 and
server=computer2).

> 
> 3- Now, the two computer are not connected via network. Two possible
> solutions to sync our both computers: USB disk and e-mail.
> Any recommendation in this context?

Sending patches by emails is good to exchange ideas or to contribute to
mainstream, but you cannot synchronize repositories in this way. If
you really want to synchronize by emails, you should send bundles (man
git-bundle). Bundles can be transfered by emails or using any other
media. Alternatively, you can have a copy of your repository on a USB
disk and synchronize with it using "pull" and "push" commands. However,
if you use a USB disk with VFAT, you should mount it with 'shortname='
'mixed' or 'winnt' on Linux.


Dmitry
