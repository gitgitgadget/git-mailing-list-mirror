From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: creating a new branch without an ancestor
Date: Fri, 5 Feb 2010 11:38:31 -0700 (MST)
Message-ID: <80b2e7a2e4025acdad6e869fdeb9aab7.squirrel@webmail.icecavern.net>
References: <d2e97e801002041919r2043d05cjfb114a466605d9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Michael Wookey" <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 19:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdTET-0001yJ-3O
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 19:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933763Ab0BESsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 13:48:38 -0500
Received: from rinoa.icecavern.net ([92.243.7.152]:34181 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933738Ab0BESsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 13:48:36 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2010 13:48:36 EST
Received: by icecavern.net (Postfix, from userid 33)
	id 2B32B3614B; Fri,  5 Feb 2010 11:38:31 -0700 (MST)
Received: from 134.253.26.6
        (SquirrelMail authenticated user wjl)
        by webmail.icecavern.net with HTTP;
        Fri, 5 Feb 2010 11:38:31 -0700 (MST)
In-Reply-To: <d2e97e801002041919r2043d05cjfb114a466605d9a1@mail.gmail.com>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139065>

On Thu, February 4, 2010 20:19, Michael Wookey wrote:
> Maybe I'm missing something from reading the docs, but I couldn't see
> how to create a new branch in an existing repo that has no ancestor. I
> would like to do something like what git.git does with some of the
> other ancillary branches like "man", "html", and "todo".
>
> I was hoping to do something like "git branch --no-ancestor
> new-branch-name" but didn't see anything in the documentation that
> describes the necessary branch options.
>
> Or, am I looking in the wrong place?

I do this all the time for various reasons, so I made myself a
"git-emptybranch" command and stuck it in my path. Besides the error
checking, this just creates a new ref and clears the index so you can
start from a clean slate. No actual files are deleted from the work-tree.

$ cat ~/bin/git-emptybranch
#!/bin/sh
if [ $# -ne 1 ]; then
  2<&1
  echo "usage: git emptybranch <new_branch>"
  exit 1
fi

if ! git check-ref-format refs/heads/"$1"; then
  2<&1
  echo "fatal: '$1' is not a valid branch name."
  exit 1
fi

git symbolic-ref -m "git emptybranch $1" HEAD refs/heads/"$1"
git rm --cached -r -q --ignore-unmatch -- '*'
