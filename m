From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 00:43:31 -0700
Message-ID: <7vr5t2h3do.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <m49nq6-uk5.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 09:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz41N-0005Rw-No
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 09:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbZJQHnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 03:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZJQHnj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 03:43:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZJQHni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 03:43:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E28837A609;
	Sat, 17 Oct 2009 03:43:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iu3uwo8uMsk/qheTl0qS3v1/7dc=; b=IaqlgG
	WYis+mqzTbW/nDqMMHC9Tpen0fSvH8Aezb7dtpvs148HlFnDk1KFSYKTJS7YHHh9
	5yPQDpbV1hf3uvnxzYEAS2PA5zdT3NK1xH2Q+x+6Hj/IHVURlIHATxmbOpj3UDIP
	l7sZQbQiyv2v8mwgBPku0qMjHnSYiZ0or30SE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYU4rVioEceUT8kQHDVfgEPuK7XPKtkI
	17hDE5I98VOSAKPZfSZ/RmdQP7jRgTn7Yp60EXGAqE6ydW8V7rRjO4bs+0Ggj2t9
	m/TKQ4kZv+i3Qg3tlRH04N0UqAGe8JgKyixhbndxsxQ70pd6rpjkvNFTObUNoZbw
	ksOM9dGaaCM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA0947A608;
	Sat, 17 Oct 2009 03:43:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66CAE7A607; Sat, 17 Oct 2009
 03:43:33 -0400 (EDT)
In-Reply-To: <m49nq6-uk5.ln1@burns.bruehl.pontohonk.de> (Christoph
 Bartoschek's message of "Sat\, 17 Oct 2009 00\:36\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C7F3145E-BAF0-11DE-8187-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130547>

Christoph Bartoschek <bartoschek@gmx.de> writes:

[jc: added Daniel back to cc list; please do not cull the cc list without
good reason]

> Daniel Barkalow wrote:
>
>> The upshot of the messages should be:
>> 
>>  $ git checkout origin/master
>>  Since you can't actually change "origin/master" yourself, you'll just
>>  be sightseeing unless you create a local branch to hold new local work.
>> 
>>  $ git branch
>>  * (not a local branch, but "origin/master")
>> 
>>  $ git commit
>>  You've been sightseeing "origin/master". The commit can't change that
>>  value, so your commit isn't held in any branch. If you want to create
>>  a branch to hold it, here's how.
> ...
> But then I was not able to verify that the checkout indeed matched the 
> 1.3.0-beta.  "git status" and "git branch" did not help here. 

This is not going to help you, but "git reflog" would have helped here.

The reason my suggesting "git reflog" now won't help you is because the
word "reflog" does not connect the question "how did I get here" unless
and until you know git already; in other words, it is not your fault that
you got lost, but it is showing a wart in the UI.

If the question you were asking was "does the files I have in my work tree
after issuing that scary checkout actually match origin/1.3.0-beta?", you
could have asked that question in a more direct way, and the command to do
so is "git diff origin/1.3.0-beta".  I do not think this would be asking
the user to be doing something unreasonably unintuitive.

If the question you were asking was (and it was not, from the description
of your experience, but you could be in that situation when you "return
some weeks later") "how does the checked out history relate to 1.3.0-beta?",
then there is a way to ask the question in a very direct way, and the
command to do so is "git show-branch HEAD origin/1.3.0-beta" (or give the
same argument to "gitk").

Although it is not _so_ unreasonable to expect "git status" to show the
information, I suspect it would not be practical.  After all, whenever
somebody is lost, everything is "status".  For a person who is lost and
does not know where in the history he is, it might be reasonable to expect
"status" to give the relationship between your HEAD and some branch/tag,
while for another person who was hit by "git gui" complaining that he has
too many loose objects, it might be reasonable for him to expect "status"
to give the number of loose objects in the repository.  IOW, "status" is
too broad a word and following the path to cram everything into "status"
so that any new person who gets lost can get necessary infor from the
command will unfortunately lead to insanity.

The second item in the Daniel's transcript above may be an improvement but
I think it is a wrong economy to record and show 'but "origin/master"'
(which cannot be correct forever and has to be invalidated once the user
starts committing or resetting) in the message.  I am wondering if a
similar effect to help new users can be had by rewording the message to:

    $ git branch
    * (not a local branch; see "git reflog" to learn how you got here)

The user can see how he got there even after doing something else after
the checkout (see Nico's write-up in $gmane/130527).  The difference is
between giving fish and teaching how to catch one himself.
