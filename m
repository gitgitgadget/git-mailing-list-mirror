From: Pete Forman <petef4+usenet@gmail.com>
Subject: Re: How to pre-empt git pull merge error?
Date: Thu, 28 Nov 2013 08:25:39 +0000
Message-ID: <864n6x2arg.fsf@gmail.com>
References: <86d2llc1rs.fsf@gmail.com>
	<20131127194240.2abaff5575961b3d73e1970f@domain007.com>
	<vpq8uw9q1r4.fsf@anie.imag.fr>
	<CALWbr2wNODeLSmQ5ztQmKVxBSguNJ1bbSbvY66sdsP09dSUUgA@mail.gmail.com>
	<878uw9hdf0.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 09:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlwv4-00080i-SR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3K1IZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 03:25:51 -0500
Received: from plane.gmane.org ([80.91.229.3]:41552 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab3K1IZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 03:25:50 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vlwuz-0007wr-Ad
	for git@vger.kernel.org; Thu, 28 Nov 2013 09:25:49 +0100
Received: from petef.plus.com ([212.159.107.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 09:25:49 +0100
Received: from petef4+usenet by petef.plus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 09:25:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: petef.plus.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
Cancel-Lock: sha1:ffBKZA3sSWoxzxptbkIxkWZ4tfg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238477>

Thomas Rast <tr@thomasrast.ch> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>>>> On Wed, 27 Nov 2013 15:17:27 +0000
>>>> Pete Forman <petef4+usenet@gmail.com> wrote:
>>>>
>>>>> I am looking for a way of detecting up front whether a git pull or
>>>>> git merge would fail. The sort of script I want to perform is to
>>>>> update a server.
>>>>>
>>>>>     git fetch
>>>>>     git okay
>>>>>     stop server
>>>>>     backup data
>>>>>     git merge
>>>>>     start server
>>>>>
>>> I don't know a simple way to do the pre-merge check without actually
>>> doing the merge (other than patching git merge to add a --dry-run
>>> option)
>>
>> Wouldn't that be a nice use-case for git-recursive-merge --index-only
>> ($gmane/236753) ?
>
> Possibly, but most of the use-cases for merge --dry-run are better
> answered by the XY Problem question:
>
> Can you step back and explain what the *underlying* goal is?
>
> The above sounds a lot like a deployment script, and such scripts are
> almost always better served by using an actual deployment tool, or
> failing that, by using some form of checkout -f instead, to ensure
> that they get whatever they are supposed to deploy.
>
> (Using a merge to update is really terrible in the face of
> non-fast-forward updates, especially when caused by rewriting history
> to not include some commits.)

It is a deployment script and updates are fast-forward. There was a
problem on a test server where a file had been hacked to investigate an
issue. The next deploy failed with the merge error.

There are three approaches, which might all be done with git or an
actual deployment tool.

1. test early, bail out if deploy would fail
2. set target to good state before applying the merge
2a. discard changes
2b. stash changes

I intend to use (1). First I will need to clean up the stray files or add
more entries into .gitignore.

  test -z "$(git status --porcelain)"


-- 
Pete Forman
http://petef.22web.org/payg.html
