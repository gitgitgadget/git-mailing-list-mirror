From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 09:30:03 -0800
Message-ID: <7voc6ettgk.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net> <201102141059.12962.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 18:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp2Fv-0001wq-5j
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab1BNRab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 12:30:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808Ab1BNRa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 12:30:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 61C2332AA;
	Mon, 14 Feb 2011 12:31:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBusM3qMljHiAeXb2uWOGrCsIkg=; b=PavVe9
	mSsbqzLrbfsMDoqXm2sEZHqZXH0fCPnFo+oZeibEyihB+Hsx8FKrItBNvdrmCR24
	8Arpnqk/wuQNIN6ClWvy34rQ/lsgn56mKcb3A1hg0lA2cfNb6kItP9ibphi7D5Mi
	RNFZ1RHLQSiH7j1L/WGrdL/0v5qRtKVuyG2s8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W1o6kVx0HRWjWtlqqIU7LW0v8q46Z6ar
	0t0k0snLVP1FdVuf58a71MfvCrcFGonSGV9Q1QN2Q2SndtudzOfqTq7U4LV3buxD
	SrKg7pIlq3BTojX5aHSQN2kmBaSBvmR3vFKMnyGgfHbAiqaV6OfA3x37kuuPvCv5
	ncGBK+j43QQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C91D63295;
	Mon, 14 Feb 2011 12:31:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CA73328E; Mon, 14 Feb 2011
 12:31:10 -0500 (EST)
In-Reply-To: <201102141059.12962.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon\, 14 Feb 2011 10\:59\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D50EBDE-3860-11E0-A8AF-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166740>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 14 Feb 2011, Johan Herland wrote:
>>>> Yes, replicating existing behavior w/explicit refspecs would look like: 
>>>>   [remote "origin"]
>>>>   
>>>>         url = git://git.example.com/repo.git
>>>>         fetch = +HEAD:refs/remotes/origin/HEAD
>
> Perhaps
>
>               setHead = master
>
> or something like that?

If I understand what Johan is saying correctly, I don't think that is
solving any conceived problems.  Currently origin/HEAD once initialized
does not repoint and that behaviour more or less has been kept on
purpose.

What it allows us by explicitly saying HEAD in the refspecs is to move
away from the "origin/HEAD is under control of the local repository---it
determines what you as the cloner consider the primary branch you are
interested in in this particular remote" semantics and instead start
saying "just like we copy the values of normal refs from the other side to
keep track, we want origin/HEAD to _point at_ the branch they pointed at
when we looked at them the last time".  While I personally think that is
also a valid thing to wish for, it probably is a bit too big a change in
the semantics at this point.

If you mean by "setHead = master" to "set origin/HEAD symref to point at
their master", that does not have to live in the config at all.   Once you
point the symref, nobody will repoint it to anywhere.

>>> ... is meant to be used by the local
>>> repository to designate which of the remote branch is considered the
>>> primary branch from local repository owner's point of view, primarily so
>>> that you can say "origin" locally to mean "origin/next" by setting the
>>> symref origin/HEAD to point at it....
>
> Well, we have "git remote set-branch <remote> -a" to re-do this guessing
> or checking, and update 'remotes/origin/HEAD'...

That is exactly what I said, isn't it?

>> Still (as I think was recently discussed in another thread), the existence 
>> of remotes/origin/HEAD _does_ cause problems if the origin remote also has a 
>> branch called "refs/heads/HEAD" (which would collide when fetched into the 
>> local repo).
>
> True, though... can't we consider having branch named 'HEAD' as insane?

There was a discussion to forbid ([ANYTHING_0-9A-Z]*_)?HEAD as a branch
name to reduce confusion, and I think that is probably a sane thing to do
without harming anybody in practice.
