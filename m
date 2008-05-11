From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 04:42:10 -0700 (PDT)
Message-ID: <m31w495apd.fsf@localhost.localdomain>
References: <4826D8FA.30305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 13:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv9xe-0007aV-Os
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 13:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYEKLmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 07:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbYEKLmP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 07:42:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:9186 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbYEKLmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 07:42:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so500577ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=DnWsXk6NJNV8hkVDsUdUic7OFWrIo6+1gv42zq6AMd0=;
        b=WllpJLE3kQ7QKa4xWVfxGKjp/vMi1WGD60RHlh+slEAjR2qSE+xgi2lZNahwCE6/uZEMIdLxJ3OinfFVeUt4584jmi2Q04z6w3Yc7HWVC09vZNY9FJqUeJFFvrz8L35Zu6N83ebHJTmOlWYZui5YpGIOqB307l6WXnbWFBV8pE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=lbuLW0ogLUZSbF7kobBnSHRtIIPhbF5HTsvSrda6eIhI6A8adnokIvnsFrDRgE+RR2B7fJWzd56XVm8qzDBGfRtdrIRo7uN5BfQdGxY4S8ChLurX6LEUmxVxnzjEIxakB4H4K/HZ1gp3uUFK8/9lejIry1oHnecTi6AllTwzL9s=
Received: by 10.66.216.7 with SMTP id o7mr3973364ugg.69.1210506131846;
        Sun, 11 May 2008 04:42:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.178])
        by mx.google.com with ESMTPS id t12sm12937596gvd.10.2008.05.11.04.42.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 04:42:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4BBg7iF003454;
	Sun, 11 May 2008 13:42:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4BBg6X0003451;
	Sun, 11 May 2008 13:42:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4826D8FA.30305@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81758>

Dima Kagan <dima.kagan@gmail.com> writes:

> I'm currently evaluating git for doing some local work without
> depending on the main subversion server. I started with the following
> steps:
> 
> > git-svn clone http://svn.test.org/test/trunk
> > cd trunk
> > git branch test_branch
> > git checkout test_branch
> > vi somefile
> 
> Now, when I run 'git status' I get:
> # On branch test_branch
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   somefile
> #
> no changes added to commit (use "git add" and/or "git commit -a")

And now you have 'somefile' in the working arew, which state isn't
saved anywhere git knows of.
 
> This is what I expect of course. However, when I execute 'git checkout
> master', I get:
> M       somefile
> Switched to branch "master"

Git tries hard to preserve your modifications.  If you don't want to
commit changes to test_branch, you can use git-stash to stash them
away.

Note that the above is possible only in the trivial merge case.
Otherwise you would need to use "git checkout -m" (to merge), or
"git checkout -f" (to force checkout, possibly losing changes).

> And after running 'git status' on master I get:
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   somefile
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> Basically I see that the same file I edited on the 'test_branch'
> branch appears to be modified on the 'master' branch as well. This
> behavior is unwanted, of course.
>
> Can someone please tell me, what am doing wrong? Or is this git's
> normal behavior?

This is normal, and wanted, behavior.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
