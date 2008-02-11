From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: referencing a revision at a certain date
Date: Mon, 11 Feb 2008 10:40:39 -0800 (PST)
Message-ID: <m3r6fje3q8.fsf@localhost.localdomain>
References: <20080211180424.GA4905@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT mailing-list <git@vger.kernel.org>
To: David Madore <david.madore@ens.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:41:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdbH-00016U-HM
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYBKSkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYBKSkp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:40:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:41838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbYBKSko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:40:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so343574ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=WUzrDuihJeSdrYgiuoGgXODz0qHksGzdaEGxxf9HCvw=;
        b=OFIziWSXS+lvXUq7XMbMFsrXPlubPqyk8Uh6OttPGjuIFdw6ZhbtSCsc+kR5mHyykxfuJAA8RInyLQhrqY1spzxmlIWA8TJBxh9V7+uZaf+iuTpeuAeforpiqHroyQuyHeY7BQwRim//upHoTS8BSR3LzsDM7PP60AnZfkPU0uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=MyERSYi09xzDtvb9PRkPaHN+6I1vvWy+BI3cjsLd9eO78IakAZAS0Trd2RCnKsYiPCnpQi5Dlx9118eygHmA1KKExAyik9YQ//6JkAzg6TPiGNXLkX4iCGUsuaA4KjJx7WpNxvTt3P8y9iZe0+ztj2GzzywkFU+dMiIxeQO+NrM=
Received: by 10.67.115.1 with SMTP id s1mr9377956ugm.74.1202755241494;
        Mon, 11 Feb 2008 10:40:41 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id c24sm12179999ika.10.2008.02.11.10.40.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 10:40:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BIeXvc016508;
	Mon, 11 Feb 2008 19:40:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BIeWXr016505;
	Mon, 11 Feb 2008 19:40:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080211180424.GA4905@clipper.ens.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73561>

David Madore <david.madore@ens.fr> writes:

> I'm left quite confused by the git-rev-parse(1) man page, I wonder if
> someone can help me with this.
> 
> I understand that if "rev" denotes a certain revision, then "rev~42"
> references the commit which is 42 generations back from rev.  

To be more exact it is 42 generations in straight, first-parent
line. rev~3 is shortcut to rev^^^, which is shortcut to rev^1^1^1,
where rev^1 means 1st parent of rev.

> What I'd
> like to do is write something like "rev~@{2008-01-18}" (say) to get
> the same thing but with the 42 being computed automatically so that
> the commit in question is the latest possible (in commit date) before
> 2008-01-18.  Is this possible?  If so, how?  If not, might I suggest
> this as an addition for consideration?

There is no direct mapping from date to a commit. So you cannot name a
commit (specify a revision) using date. Besides commit has two dates:
author date (creation date), and commit date (modification date,
roughly).

But you can can get commit closest to given date by combining the time
limiting with limiting number of commits, as described in "Commit
limiting" in git-rev-list(1) and git-log(1) manpages.

  $ git log -n 1 --before=<date> <branch>

which would return first commit older than <date>, starting from
<branch>.

> I thought "rev@{2008-01-18}" did this, but apparently it doesn't: it
> requires a ref log of some kind, and I don't know how to make a ref
> log (git-clone doesn't seem to copy them).

Reflogs are history (log) of a position of branch tip (ref) in a local
repository. Reflog stores sha-1 of top commit before and after change,
date of change, and description of command that changed it. For
example <branch>@{1} refers to position of branch before you did
something locally to change it, were it commit, amending a commit,
or for example fetching from remote repository.

> So, is there some way I can either generate a ref log by
> systematically taking the first parent in each commit as per git-log
> --first-parent, OR (better) specify a revision directly that way?

Again: you cannot specify a commit in such way. You can find a (series
of) commits which fulfill given condition.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
