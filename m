From: Avishay Lavie <avishay.lavie@gmail.com>
Subject: git svn rebase following a merge causes duplicate commits
Date: Sun, 13 May 2012 12:19:21 +0300
Message-ID: <CAHkK2brTtW2XLm=dwfPiSfjNWNBiS_dcbKX4K+h9dmxqj4P5Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 11:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STUyR-0003IN-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 11:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab2EMJTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 05:19:44 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48034 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab2EMJTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 05:19:42 -0400
Received: by weyu7 with SMTP id u7so1188180wey.19
        for <git@vger.kernel.org>; Sun, 13 May 2012 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=UO7bsLgn0a9fCGe1uTjZYjkQpd5rDjjMVgZnIA/rvjU=;
        b=ZhcvJK57ARa7UCgk7e3JUWpNoQ5FYjWUo5vMkIZwgTMS/BZ6byL4S4VtERWhpfp3i2
         pmUlJ925oRzmLG5dM8a7jiZq5gZZgQiBl8qb7gonckgFkl7l/GZ+PvxY0TueK74WwSVA
         TOBbM4iFdNn0L7bfy65UFRmwo/e75dmoMW5/Ux0F1vnnw3xYYdtYu98yPdYIh8pXXjmM
         x342GE04mXzzTz2RO6nAbl2g2Eutj+ydkKsPWsuNGyIJj7hvV6w11Cgo7CbsKrrff2Tq
         Lp+VX6kvnH9X82DLaxocHbzL314kRaL8fPbufX/PqW2Yq0YbZ7nf/WwJbJbeLWcu7XEn
         B3OQ==
Received: by 10.180.106.9 with SMTP id gq9mr10154548wib.17.1336900781296; Sun,
 13 May 2012 02:19:41 -0700 (PDT)
Received: by 10.216.187.204 with HTTP; Sun, 13 May 2012 02:19:21 -0700 (PDT)
X-Google-Sender-Auth: q3zeYQFPRjB2p_Av_DVJrwaTkg8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197746>

Hi,

With the introduction of the svn.pushmergeinfo flag, merging SVN
branches using git-svn has become possible and streamlined, with git
svn rebase acting as the usual method to get up to date with remote
changes.
However, when git svn rebase is performed after an unpushed merge, the
rebase operation follows both parents and replays both the user's
local commits and those from the merged branch.

As a concrete example, suppose I branch from master (tracking
svn/trunk) to a new branch called 'topic'. I commit a few commits on
topic and then merge from svn/trunk. Meanwhile someone else has also
committed and dcommitted to topic, which requires me to svn rebase.
Upon svn rebase, my local 'topic' branch is reset to the updated
svn/topic, and then both my commits *and the ones I merged from trunk*
are replayed -- essentially duplicating them.

What should have happened is for the merge commit to be replayed as a
merge (instead of each of its commits individually replayed on the
current branch). Incidentally, this is exactly what --preserve-merges
is supposed to do; however despite the git svn docs claiming that git
svn rebase accepts all the options git rebase does, this particular
flag is not recognized.

So, at the very least, I think git svn rebase should honor the -p /
--preserve-merges flag.

Additionally, I propose that -p should be made the default for git svn
rebase, or it should at least warn or abort when it encounters merges
about to be rebased, or otherwise find a way to avoid the current
behavior which is rarely the desired outcome (unless I'm missing
something obvious?).

Thoughts?

Avish
