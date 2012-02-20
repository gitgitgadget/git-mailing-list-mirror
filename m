From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 14:04:26 -0800
Message-ID: <7v1uppkvpx.fsf@alter.siamese.dyndns.org>
References: <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
 <20120220151134.GA13135@sigill.intra.peff.net>
 <87d3991gyg.fsf@thomas.inf.ethz.ch>
 <20120220203540.GA5966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:04:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbLj-0007SC-2v
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab2BTWEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:04:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442Ab2BTWE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:04:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DE0C79FC;
	Mon, 20 Feb 2012 17:04:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQuxyJVXSnUCDWzG5JUrwW0nqKs=; b=qQMTBi
	pZRYdNzaq++khjHm9+YEP91Cm5oaPNVZBMQh9UiR9Nyq0tl5nIq35xqYNQiMXY80
	eXloIAxY9O3umU3UFrutaa8uTpeT8yte5psXkgSjSUjgvBcGw/o5dkNbT4cnpQON
	aaXHte9DgURNVQw3rfAcpczcKNig/cgJyEiWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLbHqkoybh8BD1eEQNEtjArbE2PI+EzA
	oBkogQSIb3qNsdcFOXdGggz5h70+IkOnInn2QyUeSDBjultJRFp3xztX8miVUQrz
	mWMAhaGdrZCF4ul8gs9z+IMH1Kl9t+oNF5LkjqyI2mtvasiEpZcZWLEuTnuLFhLj
	UTlx7hQdqn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35F5979FB;
	Mon, 20 Feb 2012 17:04:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAF6879FA; Mon, 20 Feb 2012
 17:04:27 -0500 (EST)
In-Reply-To: <20120220203540.GA5966@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Feb 2012 15:35:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB6259C0-5C0E-11E1-9003-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191117>

Jeff King <peff@peff.net> writes:

> ... Things may have changed since then, of course, but I at
> least know that they were sufficient in 34110cd^.

Looking at where cache_tree_free() is called, I think back then the
two-way merge was deemed OK, but we did not trust three-way merge or
merge-recursive at all.

> I think you can construct two tests that will both work in the "ideal"
> case. In the first one, you move to a tree that updates "foo", and
> therefore the root cache-tree is invalidated.

I have to warn you that under-invalidation of cache-tree is extremely hard
to find.  The only way I know, which I had to resort to when dealing with
a handful of instances of under-invalidation bugs, is to run write-tree
with potentially corrupt cache-tree and then using the same index but with
the cache-tree purged, run another write-tree and check to see if two
trees match.

> In general, t0090 could benefit from using a larger tree. For example,
> the add test does "git add foo" and checks that the root cache-tree was
> invalidated. But it should _also_ check that the cache-tree for a
> subdirectory is _not_ invalidated (and it isn't; git-add does the right
> thing).

It is OK to check that we do not over-invalidate for performance, but it
is a lot more important to make sure we do not under-invalidate for
correctness.  I am a bit worried that you seem to be putting more stress
on the former.
