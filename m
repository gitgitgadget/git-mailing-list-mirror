From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 13:12:53 -0700
Message-ID: <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
 <7vabghr5br.fsf@gitster.siamese.dyndns.org>
 <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDO0-0001fw-Tj
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbYGPUNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbYGPUND
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:13:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbYGPUNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:13:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4769F24EC2;
	Wed, 16 Jul 2008 16:13:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4D21C24EC1; Wed, 16 Jul 2008 16:12:55 -0400 (EDT)
In-Reply-To: <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 16 Jul 2008 15:46:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 96876310-5373-11DD-A725-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88739>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 7/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>>  You said svn makes it easier because it makes it very hard to do merges
>>  and forces users to stay away from them.  This results in user doing "svn
>>  update" which is to resolve conflicts with large uncommitted changes but
>>  keeps the history straight single-strand-of-pearls.
>>
>>  I am not saying the merge based workflow in git does not have any room to
>>  improve.  I am just saying that there is nothing we can learn from svn in
>>  that area.  "Solves it by not letting us to do merges" is not a solution.
>
> What svn does is essentially an unsafe version of
>
>        git stash && git pull x y && git stash apply

If you are advocating that mode of operation to be easy in git, you should
think again.  That pull (be it with or without --rebase) can conflict and
you would need to resolve it, and then your "stash pop" can conflict
again.  You can have your own "git avery-up" alias which is your "svn up"
equivalent, but if you train users with that first, the users have to
learn how to cope with conflicts in individual steps anyway.

Making these three into a single alias is not an improvement either.  If
you are not ready to incorporate other's changes to your history, why are
you pulling?  Being distributed gives the power of working independently
and at your own pace.  You should train your brain to think about the
workflow first.  "You should stash before pull" is _not_ a good advice.
"Do not pull when you are not ready" is.

Suppose you are about to finish something you have been cooking (say a
series of five logical commits), you've made three of these commits
already, and what you have in your work tree and the index is to be split
into the last two commits.  Somehow you learn that $x above has a updated
version.

Yes, running "git stash && git pull --rebase && git stash pop" would be
better than running "git pull --rebase" alone from that state.  But that
would mean your history would have your first 3 commits (of 5 commit
series), somebody else's totally unrelated commits, and then you will work
on finishing the remaining 2 commits on top of it.  Why?  Why is such a
bogus linear history any better?

With git, instead, you have the choice:

	* "git fetch" first to see if it is truly urgent; otherwise you
          don't even have to pull.  First finish whatever you were doing
          and then make the pull

	    $ make commit 1
            $ make commit 2
            $ git pull

	  This results in a merge but it is a good merge.  The resulting
	  history shows your 5 commits are isolated work independently
	  developed while that urgent thing was being done elsewhere.

	* if it is, then, you save away your work and pull first:

	    $ git branch mywork
            $ git stash save "remaining two commits' worth of changes"
            $ git reset --hard HEAD~3 # wipe your 3 commits
            $ git pull

	  and then continue working:

	    $ git checkout mywork
            $ git stash pop
            $ make commit 1
            $ make commit 2

	  and finally integrate:

            $ git checkout master
            $ git merge mywork

	  or if you really want linear, pretend all 5 of your commits
	  were done on top of that urgent thing.

            $ git rebase master
            $ git checkout master
            $ git merge mywork

> And that's actually a good example of what I'm talking about; in svn,
> that's just "svn up",...

What you forgot to add in the above is that in svn the equivalent of "pull
x y" step will always fast forward because you will not be making forked
development with the upstream.  In svn it's just "svn up" and it results
in a linear history because that command does not work with merges.  By
definition, not working with merges will result in linear history.
