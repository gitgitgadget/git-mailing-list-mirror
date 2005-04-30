From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Fri, 29 Apr 2005 22:37:29 -0400
Message-ID: <4272EF69.2090806@dwheeler.com>
References: <20050430005322.GA5408@tumblerings.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	xpasky@machine.sinus.cz
X-From: git-owner@vger.kernel.org Sat Apr 30 04:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRhju-0004Qo-GO
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 04:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVD3CfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 22:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVD3CfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 22:35:16 -0400
Received: from aibo.runbox.com ([193.71.199.94]:20964 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S263130AbVD3CfB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 22:35:01 -0400
Received: from [10.9.9.16] (helo=lassie.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DRhoo-0002oD-9E; Sat, 30 Apr 2005 04:34:58 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by lassie.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DRhon-0005fP-OR; Sat, 30 Apr 2005 04:34:58 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050430005322.GA5408@tumblerings.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Zack Brown wrote:
> Hi,
> 
> I'm trying to figure out the new Cogito syntax. What is the difference between
> cg-update and cg-pull? Here is my take so far, please correct me:
> 
> 'cg-update branch-name' grabs any new changes from the upstream repository and
> merges them into my local repository. If I've been editing files in my local
> repository, the update attempts to merge the changes cleanly.

Yes. "cg-update branch-name" is EXACTLY the same as
  cg-pull branch-name && cg-merge branch-name
You can see this by examining the last lines of the cg-update script.
Because updating is one of the single most common operations for an SCM,
it makes sense to have a single command that does it.

Currently cg-update without a branch name does "recover deleted files"
instead, but I think that's a wart & Petr agrees (that will probably
get moved to a different command, see separate discussion).


> Now, if the update is clean, a cg-commit is invoked automatically,

Correct; cg-merge calls "cg-commit -C" (ignore cache)
if the merge is clean.

> and if the
> update is not clean, I then have to resolve any conflicts and give the cg-commit
> command by hand.

Correct.

> But: what is the significance of either of these cg-commit
> commands? Why should I have to write a changelog entry recording this merge? All
> I'm doing is updating my tree to be current. Why should I have to 'commit' that
> update?

I can't speak Petr, but I would guess that he's doing that because
he's trying to avoid data loss.

> Now I look at 'cg-pull'. What does this do? The readme says something about
> printing two ids, and being useful for diffs. But can't I do a diff after a
> cg-update and get the same result? I'm very confused about cg-pull right now.

cg-pull BRANCH copies any changes from the named branch into your
repository.  You could do a diff afterwards, yes, to get the
same results as long as the data is in your repository.  However,
after a successful merge the HEAD will be different from before
a successful merge, so the DEFAULT answers from a
diff will be different.


> Also, the README says that cg-clone and cg-init are identical, except that
> cg-clone creates a new directory for the repository. Is that really the only
> difference? Why do we have cg-clone then?

You'll have to ask Petr.  My guess is that he has bigger plans
for cg-clone, what you're seeing is just the current stub.

Anyway, hope my guessing helps.

--- David A. Wheeler
