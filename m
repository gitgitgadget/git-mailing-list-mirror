From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git default behavior seems odd from a Unix command line point of view
Date: Tue, 12 May 2009 09:12:47 -0700
Message-ID: <7vd4ae8fls.fsf@alter.siamese.dyndns.org>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Schein <andrew@andrewschein.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:13:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ubC-0005Ar-Ap
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbZELQMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZELQMr
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:12:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50120 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZELQMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:12:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512161248.YRXU17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 May 2009 12:12:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id qgCn1b00M4aMwMQ03gCn5X; Tue, 12 May 2009 12:12:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=A1kTP2ZL0g4A:10 a=li4ZYzts3J4A:10
 a=Bhe3I19XAAAA:8 a=wJiRL6NJiQNpZ1JfRNkA:9 a=v2nod3P60WwJmRu4kI4A:7
 a=FnR0oH26hLdKNFfqpqRoRzZndn0A:4 a=ZJ-4dWC0NaIA:10
X-CM-Score: 0.00
In-Reply-To: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com> (Andrew Schein's message of "Tue\, 12 May 2009 11\:18\:25 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118913>

Andrew Schein <andrew@andrewschein.com> writes:

> ais@ace:bio$ git status
> # On branch master
> nothing to commit (working directory clean)
> ais@ace:bio[1]$ git commit -a

This is merely a historical accident that you cannot change.  "git status"
was originally a dual-purpose implementation detail of "git commit"
command to:

 (1) report if there is anything you can commit with its exit code; and

 (2) if there is something to be committed, show what will and what won't
     be committed.

For the purpose of (1), the calling command "commit" was told by the user
to make a commit, so the situation where there is nothing to commit was
signalled as an error.  The code conceptually looked like:

	(git-commit.sh)

	do the preparation
	if git-status
        then
        	# message "there is nothing to commit" already given
		revert the preparation
                exit 1
	fi
        really make a commit

These days, "git commit" has been rewritten and the logic to see if there
is anything to commit is built-in, but people still use "git status"
primarily for purpose (2), the listing of what's committed and what's
left.

Oh, and your example is wrong.  If you are going to commit with -a, and if
you want to see if such a "git commit" has actually something to commit,
then you should be giving -a to status as well, like:

	git status -a && git commit -a

Also, unless you ask explicitly, "git commit" will not make an empty
commit, so you can always omit the "git status -a &&" part and have "git
commit" itself do the checking.
