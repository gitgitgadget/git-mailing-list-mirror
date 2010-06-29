From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: git-rebase --abort eats files
Date: Mon, 28 Jun 2010 23:47:26 -0700
Message-ID: <4C2996FE.3010206@pcharlan.com>
References: <20100626125924.160F11F212@leonis4.robolove.meer.net> <201006262009.30380.j6t@kdbg.org> <20100628090517.GA8091@debian> <20100629012412.7FDBD1F212@leonis4.robolove.meer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, j6t@kdbg.org,
	git@vger.kernel.org
To: Madhu <enometh@meer.net>
X-From: git-owner@vger.kernel.org Tue Jun 29 08:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTUc1-0004BD-3O
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 08:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab0F2Gr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 02:47:59 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:47419 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0F2Gr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 02:47:59 -0400
Received: from swarthymail-a2.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 9143B179822
	for <git@vger.kernel.org>; Mon, 28 Jun 2010 23:47:58 -0700 (PDT)
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a2.g.dreamhost.com (Postfix) with ESMTP id CCA52EE629;
	Mon, 28 Jun 2010 23:47:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <20100629012412.7FDBD1F212@leonis4.robolove.meer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149888>

On 06/28/2010 06:23 PM, Madhu wrote:
>   |Date: Mon, 28 Jun 2010 11:05:17 +0200
>   |From: Ramkumar Ramachandra <artagnon@gmail.com>
>   |Cc: Madhu <enometh@meer.net>, git@vger.kernel.org
>   |
>   |> No, it can't be that simple. If rebase stopped due to a conflict
>   |> on a commit that added new files, then your version of rebase
>   |> --abort will leave these new files behind as untracked.
>   |
>   |Right. The interactive rebase has to be able to differentiate
>   |between files that you added to resolve a conflict and files that
>   |you added to retain at the end of the rebase -- and the interactive
>   |rebase has no information about this. Hence, this problem can't be
>   |fixed without explicitly finding out the intent of the user.
> 
> Wrong.  Rebase has to be able to differentaiate between two cases
> 
> 1. when there is a conflict, and the user is prompted to fix it, and
>  then continue with a git-add, git-commit, and git-rebase --continue
> 
> and 
> 
> 2. when the user is given a commit, which he is asked to git-commit
>   --amend, and then git-rebase --continue
> 
> Rebase is already aware of when each situation occurs.

If I read your original question correctly, the problem is: if you
have an untracked file in your directory before you start a rebase,
and then you add that file during the rebase, and then abort the
rebase, Git will delete your file from the working directory instead
of just returning it to its untracked state.

So aborting a rebase doesn't simply roll back time: it can be
destructive in a way the user may not expect.

The followups to the original question seem to me to be clouding the
issue with the question of what to do with any new material added
during a rebase, not just files that were originally present but
untracked.

Maybe it's not easy to solve the original problem, or maybe it's not
worth doing; maybe it's worth documenting.  (And documenting how to
recover the files, since they're in the object database for a while.)
I'd guess that to solve it rebase would have to do a "git status" when
it started, to see which files it should leave behind in the working
directory.  I'm not a Git hacker so that's just speculation.

But I think it's worth discussing this behavior on its own, separately
from the question about other material added during a rebase.

[As to what to do with other material added during a rebase, I'd like
it nuked.  When I abort a rebase it's because I've gummed things up
and want to start over.]

--Pete

> 
>   |In my opinion, you should simply stash your changes before aborting
>   |the rebase instead of adding files and figuring out some complex
>   |way of expressing intent.
> 
> This does not make sense.
> 
> --
> Madhu
