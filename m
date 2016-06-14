From: Andreas Krey <a.krey@gmx.de>
Subject: Re: 'untracked working tree files would be overwritten by merge' on ignored files?
Date: Tue, 14 Jun 2016 23:35:08 +0200
Message-ID: <20160614213508.GD30134@inner.h.apk.li>
References: <20160614160720.GA22675@inner.h.apk.li> <xmqqy467aeev.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:35:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCvzW-00030h-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcFNVfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:35:16 -0400
Received: from continuum.iocl.org ([217.140.74.2]:58757 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbcFNVfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:35:14 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u5ELZ8a01931;
	Tue, 14 Jun 2016 23:35:08 +0200
Content-Disposition: inline
In-Reply-To: <xmqqy467aeev.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297333>

On Tue, 14 Jun 2016 10:06:16 +0000, Junio C Hamano wrote:
...
> 
> IIRC, untracked files are kept during merge and across checking out
> another branch.  Files that are deliberately marked as ignored by
> listing them to .gitignore mechanism are considered expendable, and
> they will be removed as necessary.

Apparently not. Waitaminute - I can check out the other branch,
and then the ignored file is replaced by the versioned file there,
as you say.

But when I try to merge the other branch, merge complains as in $subject.

That is, 'git merge other' does not work, but 'git checkout out;
git checkout -; git merge other' works because then the ignored file is
removed in the first checkout and no longer in the way for the merge:

    $ git status --ignored
    On branch side
    Ignored files:
      (use "git add -f <file>..." to include in what will be committed)

	    a.txt

    nothing to commit, working directory clean
    $ git merge master
    error: The following untracked working tree files would be overwritten by merge:
	    a.txt
    Please move or remove them before you can merge.
    Aborting
    $ git checkout master
    Switched to branch 'master'
    $ git checkout -
    Switched to branch 'side'
    $ git merge master
    Merge made by the 'recursive' strategy.
     a.txt | 1 +
     1 file changed, 1 insertion(+)
     create mode 100644 a.txt
    $

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
