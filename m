From: cmn@dwim.me (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: Git ~unusable on slow lines :,'C
Date: Tue, 09 Oct 2012 19:39:57 +0200
Message-ID: <87a9vvczo2.fsf@centaur.cmartin.tk>
References: <50731B2A.6040104@gmx.net> <87lifgct3j.fsf@centaur.cmartin.tk>
	<50742F53.3050205@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Marcel Partap <mpartap@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 19:40:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLdmk-0004tE-8F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab2JIRjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 13:39:51 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:52738 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756363Ab2JIRju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 13:39:50 -0400
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 1A2FE80014;
	Tue,  9 Oct 2012 19:39:46 +0200 (CEST)
Received: (nullmailer pid 18524 invoked by uid 1000);
	Tue, 09 Oct 2012 17:39:57 -0000
In-Reply-To: <50742F53.3050205@gmx.net> (Marcel Partap's message of "Tue, 09
	Oct 2012 16:06:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207332>

Marcel Partap <mpartap@gmx.net> writes:

>>> Bam, the server kicked me off after taking to long to sync my copy.
>> This is unrelated to git. The HTTP server's configuration is too
>> impatient.
> Yes. How does that mean it is unrelated to git?
>
>>> - git fetch should show the total amount of data it is about to
>>> transfer!
>> It can't, because it doesn't know.
> The server side doesn't know at how much the objects *it just repacked
> for transfer* weigh in?
> If that truly is the case, wouldn't it make sense to make git a little
> more introspective? f.e.

It sends you more objects than the ones it just repacked in the normal
case. It could tell you, but it would have to keep track of more
information (which would make it take longer for the first bytes to get
to you) for little gain. The only thing you'd be able to do is to
abort the transfer immediately, but you can do that anyway, and waiting
is only going to add history to download.

>> # git info git://foo.org/bar.git
>> .. [server generating figures] ..
>> URL: git://foo.org/bar.git
>> Created/Earliest commit: ...
>> Last modified/Latest commit: ...
>> Total object count: .... (..commits, ..files, .. directories)
>> Total repository size (compressed): ... MiB
>> Branches:
>> [git branch -va] + branch size
>
>> The error message doesn't really know whether it is going to overwrite
>> it (the CR comes from the server), though I suppose an extra LF wouldn't
>> hurt there.
> Definitely wouldn't hurt.
>
>>> - would be nice to be able to tell git fetch to get the next chunk of
>>> say 500 commits instead of trying to receive ALL commits, then b0rking
>>> after umpteen percent on server timeout. Not?
>> You asked for the current state of the repository, and that's what its
>> giving you.
> And instead, I would rather like to ask for the next 500 commits. No way
> to do it.

Do you mean that there are no tags in between your current state and the
one you want to be at?

>
>> The timeout has nothing to do with git, if you can't
>> convince the admins to increase it, you can try using another transport
>> which doesn't suffer from HTTP, as it's most likely an anti-DoS measure.
> See, I probably can't convince the admins to drop their anti-dos measures.
> And they (drupal.org admins) probably will not change their allowed
> protocol policies.

Switch to using the raw git protocol, which is much less likely to have
this sort of measure.

> Despite that, i've had timeouts or simply stale connections dying down
> before with other repositories and various transport modes.
> The easiest fix would be an option to tell git to not fetch everything...
>
>> If you want to download it bit by bit, you can tell fetch to download
>> particular tags.
> ..without specifying specific commit tags.
> Browsing gitweb sites to find a tag for which the fetch doesn't time out
> is hugely inconvenient, especially on a slow line.

Don't use the web then. Use ls-remote to see what's at the other end.

>
>> Doing this automatically for this would be working
>> around a configuration issue for a particular server, which is generally
>> better fixed in other ways.
> It is not only a configuration issue for one particular server. Git in
> general is hardly usable on slow lines because
> - it doesn't show the volume of data that is to be downloaded!

How would showing the amount of data help your connection?

> - it doesn't allow the user to sync up in steps the circumstances will
> allow to succeed.

This is unfortunate is some circunstances, but you haven't shown that
yours is one of these.


   cmn
