From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git 
	repository
Date: Mon, 9 Feb 2009 13:59:40 -0800
Message-ID: <e38bce640902091359j3f306839h9aeb699e18e420ab@mail.gmail.com>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
	 <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
	 <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
	 <200902081918.35665.bss@iguanasuicide.net>
	 <e38bce640902081859o47462a58s59c120209fabb0@mail.gmail.com>
	 <7vmycww6if.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:01:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeBk-0001Yj-Ei
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbZBIV7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZBIV7n
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:59:43 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21050 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbZBIV7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:59:42 -0500
Received: by yx-out-2324.google.com with SMTP id 8so98867yxm.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 13:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y5hI/49HwaUP8fjNyF+2JJXjwJNqiHPlYb7VnfJqK0g=;
        b=Q/wH6ByW4CZOmnmnpz0Jz+bd4aTUcrbCtLiboD8ZUEIILFBR0QyzMk+C5iDq20OGBZ
         m1BV8w0h39XmCUpqIIrUQVHK6++/ccvDcOVKkdxDo4PIYyPSbghon3Z6WNeGU0VeUYg1
         p1ovrCQNJ5Zy6AvdfgtUsvqm9OS/q6uRr16Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hA8mKjywE6NOdjGQxW22Ma+gZ0sQold249cqI7I+Mi+dTy5RGrNPBfxHZdtdWDznkz
         Zc9O7L7jtArwkzALB3TbMEQ78LB+X+245DF2XNXCEdkQfFFmkw3hu3ES4M4vLX8YDo4G
         SRnM2vORFmOkXEY1K7Vc8/MpIYWwlZ78JCPZs=
Received: by 10.90.96.1 with SMTP id t1mr386208agb.93.1234216780756; Mon, 09 
	Feb 2009 13:59:40 -0800 (PST)
In-Reply-To: <7vmycww6if.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109141>

My changes should live on my bg/no-progress branch until which time as
they are accepted so I don't want them plunked down onto the
originating branch quite yet (rebasing is fine, but I don't want to
disturb that originating branch).

To explain what I mean: Yesterday, I had this configuration on my
bg/no-progress branch:

             A---B---C---D (bg/no-progress)
            /
----1-----2----3----4 (master)

B C and D commits are noisy,
fix-the-white-space-and-conform-to-coding-guidelines type commits. I
want to collapse A through D into one commit called E on that branch
so that I can run git format-patch -M on the result and provide a nice
patch email. I would end up with:

             E (bg/no-progress)
            /
----1-----2----3----4 (master)

I do have a way to do that, but it is cumbersome: I ended up doing:

1. git diff -p >saved_patch of A through D (I don't recall the exact
git diff command).
2. Use a form of git rebase similar to "git rebase --onto topicA~5
topicA~3 topicA" as explained in the git-rebase man page
3. Use git apply saved_patch
4. Reapply the commit with a new commit message
5. Use git format-patch -M --stdout .... > mail.txt

Again, all while staying on the bg/no-progress branch.

But that was tricky (at least the git rebase command was). Is there a
shorter, cleaner way to compress multiple commits on a given branch
using one rebase command and not saving off a patch?

Thanks,
bg


On Sun, Feb 8, 2009 at 8:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Brent Goodrick <bgoodr@gmail.com> writes:
>
> > What I really want to do is simply replace the last two commits on the
> > branch with one commit, so that when I make my patch it will be just
> > the full set of changes and not a lot of noise. Is there a way to do
> > that? (note: I did try the git merge --squash command but it just
> > showed me the usage, as I was on my bg/no-progress branch).  Note that
> > I know that I would not be able to do this once some of my changes had
> > merged upstream.
>
> Suppose you have this topology.  You forked and built 2 commits, while the
> upstream advanced its tip (or not).
>
>                 1--2 your commits (master)
>                /
>        ---o---o---o upstream (origin)
>
> 1. Using "rebase -i"
>
>    ... on your "master"
>    $ git rebase -i origin
>    ... will give you an insn sheet for interactive rebase to edit.
>    ... you will see something like:
>
>        pick xxxxxx title of commit 1
>        pick yyyyyy title of commit 2
>
>    ... edit the second "pick" to "squash", save and exit the editor.
>    ... You are telling it to "first cherry-pick my 1, and then squash my
>    ... 2 on top of it.
>
>    ... it will do as it is told, and will give you another editor, with
>    ... messages from both commits in it.  Edit to formulate a log message
>    ... suitable for the combined commit, save and exit the editor.
>
>   You will end up with:
>
>        ---o---o---o---X
>
>   where rightmost 'o' is still origin, X is your two commits squashed
>   into one.
>
> 2. Using "mrege -s squash"
>
>    ... on your "master"
>    $ git merge --squash origin
>    ... this will stop without creating a commit.  Then you would
>    $ git commit
>    ... and the editor will give you the log message from all the
>    ... commits on the branch you just merged.  Come up with a single
>    ... log message to describe all, save and exit the editor.
>
>   You will end up with:
>
>        ---o---o---o---X
>
>   where rightmost 'o' is still origin, X is your two commits squashed
>   into one.
