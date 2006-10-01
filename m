From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] 'git mv a/fileA b/fileB' causes 'c/fileC' to be deleted
Date: Sun, 01 Oct 2006 10:34:04 -0700
Message-ID: <7vpsdc0wkz.fsf@assigned-by-dhcp.cox.net>
References: <750170aa0610010721p66899ba5pcc7efa13be4cd10a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 19:34:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU5Cs-00036Y-TZ
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWJAReS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWJAReQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 13:34:16 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62353 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932116AbWJAReF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 13:34:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001173404.WHXO12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sun, 1 Oct 2006 13:34:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id V5a71V0031kojtg0000000
	Sun, 01 Oct 2006 13:34:07 -0400
To: "Michael Cassar" <m.e.cassar@gmail.com>
In-Reply-To: <750170aa0610010721p66899ba5pcc7efa13be4cd10a@mail.gmail.com>
	(Michael Cassar's message of "Mon, 2 Oct 2006 00:21:38 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28183>

"Michael Cassar" <m.e.cassar@gmail.com> writes:

> Is this just me being an idiot, or could there be a bigger problem
> here?
>
> Please CC me in any replies.

There could be a bigger problem, but it does not seem to easily
reproduce as you noted in the message.  It could be that some
unrelated thing in the working tree is playing a role in this
breakage, but I do not think of offhand what that is.

Here is what I just ran.

-- >8 cut >8 --
#!/bin/sh

report () {
	echo
	echo "* $*"
	echo
}

rm -fr test0
mkdir test0
cd test0

report working tree preparation
mkdir -p partA papers/unsorted papers/all-papers
echo outline >partA/outline.txt
echo Thesis >papers/unsorted/Thesis.pdf

report repository initialization
git init-db

report initial import
git add papers partA
git commit -m 'initial'
git show --root --stat --summary

report run mv
git mv papers/unsorted/Thesis.pdf papers/all-papers/Thesis.pdf

report before commit
git diff --stat HEAD

report make a commit
git commit -m 'moved a file'

report final result
git show --stat --summary
-- 8< cut 8< --

and I did not see the breakage.  Care to show a bit more details
on your working tree?  I do not think this depends on any
contents of the individual files, but

> Here is a transcript. These results are reproducable using the same
> files, but I can't seem to reproduce with different files.
>
> ## Create initial respository
>
> [mike@simba ~] git version
> git version 1.4.2.1
>
> [mike@simba ~] mkdir repos; cd repos
>
> [mike@simba ~/repos] git init-db
> defaulting to local storage area
>
> [mike@simba ~/repos] cp -r ~/thesis_work/* .
>
> [mike@simba ~/repos] ls -a
> .  ..  .git  metathesis  notes  papers  partA
>
> [mike@simba ~/repos] git add metathesis notes papers partA


output from "find metathesis notes papers partA -ls" and "git
ls-files -s" at this step may be a starter.
