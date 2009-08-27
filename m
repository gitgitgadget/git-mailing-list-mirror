From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 14:20:46 -0700
Message-ID: <7viqg9q7gx.fsf@alter.siamese.dyndns.org>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:21:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmP8-0006kw-J1
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZH0VVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753145AbZH0VVB
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:21:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbZH0VVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:21:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A49A53996E;
	Thu, 27 Aug 2009 17:21:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nJRJ7AZWz32CKzrgV9KMEhmyiUM=; b=bTfr3B
	AfROteGIowRj8RH63DL2wWg+iSyVhAXZgANpSenM0V97EcWjmMFcnBKQds4fcePD
	Ha/Jnl+cumd7JpTH0QEnoxJ7FPkk94yrcDt33gh49jAZCkW+wB/Il1ZrVAJFUeLe
	UAJkaKAAj0xjJNZJJlkekBMOO1TNM3K6W3wAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSJtYYJ1EAtZMnJnbra2Z0C9pWAxGXon
	1wEjvukPY5o9LzQ70ZY8poUHM1CI3WZ41B262aDF+nCW3wA9o/9X7gjHdEaVLZoT
	xQpdgvC69eZFKlEoQ9DvFcjnXCNwzi1qs7+NP2oq6QsdCcDpti0xfB39O5q0MvMj
	5SPf0U7r8dU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C5A93996D;
	Thu, 27 Aug 2009 17:20:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 50DF13996B; Thu, 27 Aug 2009
 17:20:52 -0400 (EDT)
In-Reply-To: <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 (Avery Pennarun's message of "Thu\, 27 Aug 2009 15\:36\:53 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8371674A-934F-11DE-8F69-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127213>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Thu, Aug 27, 2009 at 3:30 PM, Tom Lambda<tom.lambda@gmail.com> wrote:
>> What was a little bit surprising to me is that running "git fetch central
>> master" does not update refs/remotes/central/master but simply updates
>> FETCH_HEAD.
>
> I've often wanted this myself, especially when doing things like "git
> pull origin master".  However, I know the current behaviour is also
> useful sometimes, and changing it would introduce an unexpected side
> effect.  Git currently promises that your refs/remotes/* branches will
> never be updated unless you explicitly request it, even if you're
> fetching, merging, and pulling other stuff.  This means you can write
> scripts to do complicated things without triggering unexpected
> user-visible side effects.

I think it is reasonable, in 1.7.0, to change "git fetch" with command
line refspacs that lack colon (i.e. saying "fetch this ref" without saying
"and store it here") so that it updates remote tracking refs if and only
if an appropriate remote.$remote.fetch is configured to do so.  E.g. when
I fetch from Eric for git-svn updates with

	$ git pull git-svn master

because I do have

	[remote "git-svn"]
                url = git://yhbt.net/git-svn
                fetch = +refs/heads/*:refs/remotes/git-svn/*

defined, it is Ok to update refs/remotes/git-svn/master (but not others).

On the other hand, if my refspecs for "git svn" _were_ like this:

	[remote "git-svn"]
		url = git://yhbt.net/git-svn
                fetch = +refs/heads/master:refs/remotes/git-svn/master

then I would _not_ want this:

	$ git fetch git-svn dev

to create a new tracking branch refs/remotes/git-svn/dev.

It used to be that the only way to check the progress of other people
were to do this:

	$ git fetch git-svn master
	$ git log git-svn/master..FETCH_HEAD

But these days, even if we changed the "git fetch" semantics, we can still
rely on reflogs to do the equivalent with:

	$ git fetch git-svn
	$ git log git-svn/master@{1}..git-svn/master

In other words, I think the "feature" that an explicit "fetch but do not
store this time" request to prevent "git fetch" from updating the tracking
branches outlived its usefulness.
