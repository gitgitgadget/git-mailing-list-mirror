From: demerphq <demerphq@gmail.com>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Mon, 2 Nov 2009 17:33:25 +0100
Message-ID: <9b18b3110911020833y56be8fbdoaf10b6e6259f57c8@mail.gmail.com>
References: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:33:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4zqc-00088s-P8
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 17:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638AbZKBQdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 11:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZKBQdX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:33:23 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:56636 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbZKBQdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 11:33:22 -0500
Received: by ewy28 with SMTP id 28so5010192ewy.18
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aBVEPYjLNHOvBTRA7ayUSc8chDgQyn+gByBF+MlHHMA=;
        b=FvuLsUH45642qzqcbLmkoS++J77tsbL9tl03aFQzjxbb8is4VRVjNjUIMYG4FuulwK
         I7D4vK2fRxl3OqV9P0k5u+kQ9XDMg7llkCr2Sinb+rbkEnsFp4UuEpGNJ7iwuCgK03g2
         t/9mgsUu36GGKJNiXunki8PcUtF6Ukg7nmqck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uQN9x4evBNT6GOkfX+lZ114zHvEgLtSoWKD0qD+tXzBbQKqHfgVlquOZEGWa4+MaAZ
         QX/tzBFILbvHY+r2Xdn6UIjji8m2dLU0YNjgO5x6aErUGbyar82ylSLJ2Bp2S6zUCEIC
         Dt0ZkiIPR8MY2D22QpNjHkIDxYqKTDayYC2K8=
Received: by 10.216.90.209 with SMTP id e59mr4852113wef.193.1257179606143; 
	Mon, 02 Nov 2009 08:33:26 -0800 (PST)
In-Reply-To: <85647ef50911020818p61d0c975kd5655fa58993e07b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131922>

2009/11/2 Constantine Plotnikov <constantine.plotnikov@gmail.com>:
> I have encountered what looks like critical bugs in the git rebase -i
> -p (it can be reproduced on mingw and cygwin, I have not tried other
> platforms).
>
> Let's create a git repository with
>
> git init
> # the next line is for mingw
> git config core.autocrlf input
> echo a >a.txt
> echo b >b.txt
> git add a.txt b.txt
> git commit -m "init commit"
> echo aa >a.txt
> git add a.txt
> git commit -m "aa commit"
> echo bb >b.txt
> git add b.txt
> git commit -m "bb commit"
> echo aaa >a.txt
> git add a.txt
> git commit -m "aaa commit"
>
> Now let's use the following rebase command:
>
> git rebase -i -p HEAD~3
>
> When the editor will appear, just move the commit "bb commit" to the
> end of the list. The rebase process will complete successfully, but
> commit "aaa commit" will be missing from the history and working tree
> will not be affected by that commit.
>
> Other bug is that if we move "bb commit" to the top of the list in the
> editor, the rebase process will apply "bb commit", but instead of
> applying "aa commit" and than "aaa commit", the rebase process fails
> with a merge conflict.
>
> This can be reproduced with git 1.6.5.1 (msys) and 1.6.1.2 (cygwin). I
> consider these to be a critical bugs that make "-p" option extremely
> dangerous for interactive rebase. It might even make sense to disable
> it for interactive rebase until the bug is fixed.

Doesnt -p ONLY work for interactive rebase?

       -p, --preserve-merges
           Instead of ignoring merges, try to recreate them. This
option only works in interactive mode.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
