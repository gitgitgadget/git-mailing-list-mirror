From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Mon, 1 Aug 2011 07:14:15 -0400
Message-ID: <CADo4Y9g8pA7ew6LrcHWpBo0ym5R8aTmtkfXGsUm3Ytx5-rfXxQ@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
	<CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
	<4E350F15.9050009@lsrfire.ath.cx>
	<7vy5zej611.fsf@alter.siamese.dyndns.org>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 13:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnqRx-0006aD-H2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1HALOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:14:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33027 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1HALOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:14:16 -0400
Received: by ywn13 with SMTP id 13so617935ywn.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YZYXUMOZp1gp9l1M0kAJbVnbGa/tp1cmQk2gvWBbnqI=;
        b=M9YX2yt0/urPkreUCdSaCk8uhI3nwTfKUXadZI9xW0T7wxJ8ufnFxyLY2Nr+LGqNlT
         HPBf15+k2M1SIXWFBih55fmimVN2Rg0MO04U3yqmPtlJxA0LVag0fiR/jaJzpvGEwEgM
         /a+K2HgUGti+y3lwqQi+uM0+RQqcw06AU8cAs=
Received: by 10.150.235.15 with SMTP id i15mr755351ybh.31.1312197255994; Mon,
 01 Aug 2011 04:14:15 -0700 (PDT)
Received: by 10.150.199.6 with HTTP; Mon, 1 Aug 2011 04:14:15 -0700 (PDT)
In-Reply-To: <7vy5zej611.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178328>

Hi Junio,

I started this thread with a very long post that rejoins the NEXT /
WTREE debate with more ammunition.  (A theory to back it up and
explain what happens during merge conflict.)

I also proposed that git treat snapshots, the working tree, and next
commit like unix file systems and support the commands from them such
as: cat, ls, find, etc.  These follow-up emails were focused on the
small problem of whether or not xargs could work.  (I'm now convince
it can't - you want to just to a checkout and then run it.)

I excepted the proposals below.

Mike



PROPOSAL 3: Add aliases NEXT and WTREE that work in place of a
snapshot in any commands.
     e.g., "git diff HEAD NEXT"
     e.g., "git ls NEXT etc/"
During a conflicted merge state, we _may_ want commands to treat WTREE
differently.


PROPOSAL 1: git should imitate the Unix file system commands for
accessing the snapshot of a commit.

For these commands to work, the git command will have to include an
argument that specifies which commit it operates on.  So some basic
ones might be:
    "git ls <commit> -- <path>"
    "git cat <commit> -- <path>"
(There exists "git ls-files", "git ls-tree", and "git cat-file" but
they are not quite the same.)
    "git find <commit> -- ..."
    "git grep <commit> -- <path>" (Exists)
The Unix command "diff" compares two files/directories.  So, the "git"
version requires two commits to be specified.
    "git diff <commit> <commit> -- <path>"   (Exists)
I'd love to see something to apply a command to every file in a commit
or every file found by "git find".
    "git xargs <commit> ..."  (Is this possible?)
Since snapshots are a read-only version of a file system, git can't
implement the commands "rm", "mv", or "cp" for them.
NEXT and WTREE are writeable file
systems, the Unix filesystem commands that write should be implemented
as part of git to work with them.
    "git cp <snapshot> <writeable_filesys> -- <src_path> <dest_file>"
    "git mv <snapshot> <writeable_filesys> -- <src_path> <dest_file>"
    "git rm <writeable_filesys> -- <file>"
I believe "git cp" would be similar to the proposed "git put".  The current
"git mv" and "git rm" does operation on both NEXT and WTREE by default.
(Which I think is a sensible default in those cases.)
We may want to consider "mkdir", "rmdir", "chmod".


PROPOSAL 2: adopt a term like edit and rigorous terms
like split, join, and reorder to describe the operations of git
commands.
We should also use exacting vocabulary to describe git commands.  It's
not unusual to use the word "commit" when referring to:
    * a snapshot  (stored in the commit's tree object)
    * an edit   (the difference between this commit's snapshot and its
                   parent's (if it has only one parent...))
    * a complete history of edits going back to the initial snapshot
    * the commit object itself (e.g., when tagged)
While often the appropriate definition can be picked up from context,
we should be precise if possible.
It would be good to define a term like "snapshot tree" that refers to
a tree object that is the root of a snapshot, to differentiate it from
other tree objects that store subdirectories.
