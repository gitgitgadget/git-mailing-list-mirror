From: Harry Johnson <hjohnson@viasic.com>
Subject: Re: noob question
Date: Fri, 14 Jan 2011 16:32:53 -0500
Message-ID: <AANLkTi=gqfb1KDGZ_h2bbxH7HyBw70JkVnO-Xi98OSCu@mail.gmail.com>
References: <AANLkTinU---Bw5nWFXr7psSyZEty=awihPrDGqNX916O@mail.gmail.com>
	<201101141210.25523.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 14 22:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdrH1-0004M7-CW
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 22:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab1ANVd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 16:33:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34317 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab1ANVd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 16:33:26 -0500
Received: by wwa36 with SMTP id 36so3474114wwa.1
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 13:33:24 -0800 (PST)
Received: by 10.216.17.3 with SMTP id i3mr2063081wei.80.1295040773230; Fri, 14
 Jan 2011 13:32:53 -0800 (PST)
Received: by 10.216.243.129 with HTTP; Fri, 14 Jan 2011 13:32:53 -0800 (PST)
In-Reply-To: <201101141210.25523.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165124>

>> I have used git-svn to create a git repo from our subversion repo. I
>> have done this as user foo which is just an account that is used for
>> doing central builds. I have then cloned this as repo as myself,
>> harry. My thought is that the repo owned by foo would be a central
>> repo that all of the developers, including myself, could clone and t=
o
>> which =A0we could then 'git push' our changes.
> [...]
>> when checking the git log is that while the changes I made and check=
ed
>> into my repo clearly showed me as the author, the same changes after
>> being pushed to foo's repo showed a different author.
>>
>> So two things.. First should the author have been preserved? How can=
 I
>> make sure that it is?
>
> Yes, absolutely, and since the author is encoded in the commit object=
s
> it's impossible to change it without also changing the commit sha1s.
>
> Can you spell your experiments in actual commands and output snippets
> so we can see what happened?
>
> Did you ever run 'git svn dcommit', 'git rebase', 'git commit --amend=
'
> or similar in foo's repo? =A0All of these rewrite commits. =A0As part=
 of
> their rewriting they set the *committer* to the identity of the
> current user. =A0'git svn dcommit' sets author&committer to the ident=
ity
> coming back from SVN.

Ah that does sound like the issue then. I did in fact do a git svn
dcommit to commit the changes from the foo repo to our subversion
repo. If dcommit rewrites the commit changing the author then that
would explain it.

So I did a new test. I made a change and committed it to my local
repo. I then did a git pull to bring my repo in sync with the foo
repo, then did a push to the foo repo. Before doing anything else I
checked the author of my changes in the foo repo and sure enough I am
the author! Yay for that.

Now I try to git svn dcommit and I receive the following error:
Merge conflict during commit: File or directory 'bar' is out of date.
Try updating ...

So I do a git svn rebase, followed by git svn dcommit which works. Now
looking at git log I see that my changes are 'authored' by some else.
All that to say that you seem to hit the nail on the head and the git
svn rebase and git svn dcommit are rewriting the commits and changing
the author.

If we do indeed adopt git as our version control system then we would
freeze the subversion repo and not worry about git svn any further so
I think this is ultimately a non-issue and just something we will deal
with during this hybrid testing period.

Thanks!!
-Harry

>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
