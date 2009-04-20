From: Hannu Koivisto <azure@iki.fi>
Subject: Re: git rebase -i (and gitk) problem in Windows/Cygwin
Date: Mon, 20 Apr 2009 15:06:11 +0300
Message-ID: <83ljpvh6mk.fsf@kalahari.s2.org>
References: <831vs4im37.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 14:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvsHt-0004e8-MN
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 14:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022AbZDTMGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 08:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbZDTMGO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 08:06:14 -0400
Received: from s2.org ([195.197.64.39]:42176 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbZDTMGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 08:06:13 -0400
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LvsGJ-0000AJ-W6; Mon, 20 Apr 2009 15:06:12 +0300
In-Reply-To: <831vs4im37.fsf@kalahari.s2.org> (Hannu Koivisto's message of
	"Tue, 07 Apr 2009 17:18:20 +0300")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116975>

Hannu Koivisto <azure@iki.fi> writes:

> Greetings,
>
> With current git.git (1.6.2.2.446.gfbdc0) built for Cygwin, running
> on Windows XP, executing the following commands...
>
> mkdir test
> cd test
> git init
>
> echo initial > kala.c
> echo initial > sur.c
> git add *.c
> git commit -m "Initial commit."
>
> echo addition >> kala.c
> git commit -a -m "Kala addition 1."
>
> echo addition >> sur.c
> git commit -a -m "Sur addition."
>
> echo addition2 >> kala.c
> git commit -a -m "Kala addition 2."
>
> git rebase -i HEAD~3
>
> ...and moving commit "Kala addition 2." right after "Kala addition
> 1." and marking it to be squashed results to
>
> ---8<----------------------------------------------------
> error: Entry 'kala.c' not uptodate. Cannot merge.
> fatal: merging of trees 787519579d90e45dfee00189985fa8c92f56be8f and 83f124d88764604c7d348e73103168bd98665e56 failed
>
> Could not apply 14eb9c7... Kala addition 2.
> ---8<----------------------------------------------------
>
> rebase -i used to work fine earlier, but unfortunately I don't
> remember which version I used back then (1.6.something).
>
> This problem doesn't occur on Linux with the same git version.

For what it's worth, I managed to bisect the rebase problem down to
commit e4c7292353dbef39feac1c6a60c5cde9140520a6 by Kjetil Barvik:

    write_entry(): use fstat() instead of lstat() when file is open

    Currently inside write_entry() we do an lstat(path, &st) call on a
    file which have just been opened inside the exact same function.  It
    should be better to call fstat(fd, &st) on the file while it is open,
    and it should be at least as fast as the lstat() method.

> I don't know if it might be related (I suppose it could be because
> of that "...not uptodate" message) but I also see the following
> behaviour with gitk:
>
> * I change a file in workspace.
> * I "Update" in gitk - I see the change.
> * I undo the change.
> * I "Update" in gitk - I see an empty change.
> * "Reload" doesn't help - I still se an empty change.
> * I run "git status" on the command line and then select "Update"
>   in gitk -> now the change disappears.

-- 
Hannu
