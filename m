From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 00:02:19 +0100
Message-ID: <51537A7B.7050206@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 00:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzN5-0004SL-VH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 00:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab3C0XCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 19:02:40 -0400
Received: from mout.web.de ([212.227.17.11]:59209 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab3C0XCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 19:02:39 -0400
Received: from [192.168.178.41] ([91.3.173.243]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LvjrE-1UkIf12cA8-017iFU; Thu, 28 Mar 2013 00:02:20
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:uy9gzFwHXXN1AYhB0b2+ygA1T8LoS8MVk3klYahknJ0
 zov0l4uWGMl1MeEv/YmSWBhG9X2JiOJl233YZpLNR1zd3kULLr
 tkphj3RljfzXO+A01Q9fsaU4q/YqHpl/47dTjG628DB+8PHYWt
 DX99wYnqTKyxkhHNutXfWlJ2Lp//EYTDW3rVDBGHyQ8uF8dloW
 tuy6ienw7Uw14aJ6vnZbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219352>

Am 27.03.2013 18:02, schrieb Ramkumar Ramachandra:
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> Junio C Hamano wrote:
>>>> So you have to stash it somewhere.  We could have made it to move
>>>> them to $HOME/.safeplace or somewhere totally unrelated to the
>>>> superproject.  So in that sense, the repositories are *not* owned by
>>>> the superproject in any way.  However, you are working within the
>>>> context of the superproject on the submodule after all, and
>>>> somewhere under $GIT_DIR/ of the superorject is not too wrong a
>>>> place to use as such a safe place.
>>>
>>> Thanks for the explanation.
>>
>> What do you _exactly_ mean by that?  You understood why things are
>> arranged in that way, and no longer think that it is unnecessary,
>> ugly and unwieldy to stash the real copy of $GIT_DIR of submodules
>> away from their working trees and store them inside $GIT_DIR/modules
>> of the superproject?
> 
> In essence, git commands are built to act on pure worktrees.  It's
> trivially Correct to pretend that an object store present in the
> toplevel directory (as .git/) of the worktree doesn't exist, but it's
> quite non-trivial to handle a .git directory anywhere else in the
> worktree. Since we built git ground-up to act on a single
> repository's worktree, embedding one repository inside another is a
> hack: as a "workaround", we simply relocate the object store of the
> submodule repository.

Submodules work pretty well, no matter if you call them a "hack".
And what you call a "workaround" allows us to move, remove and
recreate submodules, which is one of *the* major inconveniences
submodules currently have.

>  Even then, working with one worktree embedded
> inside another is something git never designed for: it explains why I
> have to literally fight with git when using submodules (no offense
> Jens; it's a very hard problem).

Unless you acknowledge that submodules are a different repo, you'll
always run into problems. I believe future enhancements will make
this less tedious, but in the end they will stay separate repos
(which is the whole point, you'd want to use a different approach
- e.g. subtree - if you want to put stuff from different upstreams
into a single repo without keeping the distinction where all that
came from).

> Representing submodules as commit objects in the tree is also a hack.
> I'm sorry, but a submodule is not a commit object.  We need a fifth
> object type if we want them to be first-class citizens.

What else than a commit object should that be??? Submodules are
there to have a different upstream for a part of your work tree,
and that means a commit in that repo is the only sane thing to
record in the superproject. A lot of thought has been put into
this, and it is definitely a good choice [1].

> Sorry, I'm deviating.  I learnt why you think the hack is necessary
> and not "too wrong".  As I explained above, the entire design is
> asymmetric and inelegant; I think we can do much better than this.

How? The "submodules suck, we should try a completely different
approach" thingy comes up from time to time, but so far nobody
could provide a viable alternative to what we currently do.

And apart from that, let's not forget we identified some valuable
improvements to submodules in this thread:

*) Get rid of the "toplevel" requirement

*) Add functionality to relocate the object store out of the work
   tree (either "git submodule to-gitfile" or something similar,
   maybe even as a separate script in contrib)

*) Add an option to "git submodule add" (and/or maybe a config
   option) to relocate the object store immediately on adding an
   already present submodule

All of those are topics I like to see materialize, and you are
welcome to tackle them.


[1]: http://article.gmane.org/gmane.comp.version-control.git/151857/
