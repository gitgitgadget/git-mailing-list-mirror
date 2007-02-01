From: Bill Lear <rael@zopyra.com>
Subject: Re: What did I just fetch?
Date: Thu, 1 Feb 2007 07:57:55 -0600
Message-ID: <17857.61923.464433.454148@lisa.zopyra.com>
References: <17856.37307.324767.617892@lisa.zopyra.com>
	<epq4nl$ui7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 14:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCcSP-0006Ae-Cd
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 14:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbXBAN6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbXBAN6U
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 08:58:20 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60366 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422895AbXBAN6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 08:58:19 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l11DwIr13934;
	Thu, 1 Feb 2007 07:58:18 -0600
In-Reply-To: <epq4nl$ui7$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38353>

On Wednesday, January 31, 2007 at 14:15:49 (+0100) Jakub Narebski writes:
>Bill Lear wrote:
>
>> When updating in cvs, I get a list of files changed by the update.
>> 
>> How can I do this in git when fetching into a bare repo?
>> 
>> % GIT_DIR=. git fetch git://source/project
>> remote: Generating pack...
>> remote: Done counting 18 objects.
>> remote: Result has 10 objects.
>> remote: Deltifying 10 objects.
>> remote:  100% (10/10) done
>> Unpacking 10 objects
>> remote: Total 10, written 10 (delta 6), reused 7 (delta 3)
>>  100% (10/10) done
>You should have also something like below:
>* refs/remotes/origin/master: fast forward to branch 'master' of git://source/project
>  old..new: 1732a1f..73a2acc
>
>> So, I'd like to see the files, perhaps the differences, etc.
>
> $ git diff --summary 1732a1f..73a2acc
> $ git diff --summary ORIG_HEAD..HEAD

BTW, this is with git 1.4.4.1...

I don't see the refs/remotes/origin/master line you refer to:

%  git --bare fetch git://source/project
remote: Generating pack...
remote: Done counting 18 objects.
remote: Result has 10 objects.
remote: Deltifying 10 objects.
remote:  100% (10/10) done
Unpacking 10 objects
remote: Total 10, written 10 (delta 6), reused 7 (delta 3)

And no refs/remotes file:

% ls refs
heads  tags

I can get a commit id by using -v:

% git --bare fetch -v git://source/project
remote: Generating pack...
remote: Done counting 18 objects.
remote: Result has 10 objects.
remote: Deltifying 10 objects.
remote:  100% (10/10) done
Unpacking 10 objects
remote: Total 10, written 10 (delta 6), reused 7 (delta 3)

* fetched git://source/project
  commit: 89f0bd4

And, why do repeated fetches seem to fetch something instead of
saying "I've got nothing to do, you stupid git!"?

Well, I'd just like to see what is in this commit, I guess, then.

So, I try git cat-file, and notice what looks like an error in
the usage message:

% git --bare cat-file 89f0bd4
usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>

It seems to indicate the switches and the type are optional (square
brackets), but it's not doing anything, so it must want one of the
switches.

% git --bare cat-file commit 89f0bd4
tree d9421c9d3079dc48a3b3c5938a6a29e1404bd322
parent 0624063622c793d5812bdf84c909eaf17abf4f2d
parent 069596712287564e2e6d45207cb5f5b4069ed7ac
author John Smith <jsmith@myco.com> 1170168752 -0600
committer John Smith <jsmith@myco.com> 1170168752 -0600

Merge branch 'master' of ssh+git://source/repos/git/project

So, then I find git show:

% git --bare show --pretty=fuller 89f0bd4
[98 blank lines suppressed!!]
commit 89f0bd43b21431c70fe22e099b8c0fc11b190b0e
Merge: 0624063... 0695967...
Author:     John Smith <jsmith@myco.com>
AuthorDate: Tue Jan 30 08:52:32 2007 -0600
Commit:     John Smith <jsmith@myco.com>
CommitDate: Tue Jan 30 08:52:32 2007 -0600

    Merge branch 'master' of ssh+git://source/repos/git/project

So, still no "content" here.  Should I be expecting some?

And, what does "Merge: 0624063... 0695967..." mean?


Bill
