From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 15:30:33 -0700
Message-ID: <7vippzlj7a.fsf@alter.siamese.dyndns.org>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 00:37:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsjIz-0007mp-EV
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 00:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab1HNWah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 18:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab1HNWag (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 18:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA5C332A8;
	Sun, 14 Aug 2011 18:30:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jtN+dsyP9E7FbW76aXb63HY6ICk=; b=fU3lhR
	EQAZhPSjhjdhqfblGazqu9O8BkAZEg/YpLO42kM1BpuvLAZimPK8l0+VP4lsYeG2
	OxQGp6FhWJnrhqbTT2xzokVl70bb7/BN3AlJg3CaVObLJH02E/11bTnh9whTZNnb
	2dPcfc0KvHGw2nFoVMV4KT84iTR2PwHQ9NpFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JR8ARKOft/PxeN77/6yGy6XzmUVqIXta
	Xv4auB+Kv41ShYr3fgJzl04d/tsUYerd9jIGZCqqB2VH28bsPLYY12Cpf/Z1eabc
	+sPFJ9QFwh8gHHAnSpz7J7e7yl0ybVYD30uJCsbXoZwTSOfKt/QYAXnSEIGg0Glq
	lw1h5fPtp20=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1BA732A7;
	Sun, 14 Aug 2011 18:30:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F2A232A6; Sun, 14 Aug 2011
 18:30:35 -0400 (EDT)
In-Reply-To: <20110814213200.GA6555@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Sun, 14 Aug 2011 16:32:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0753AEA6-C6C5-11E0-863D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179352>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I believe it is meant to support command sequences such as these:
>
> 1.
> 	git cherry-pick foo; # has conflicts
> 	... resolve conflicts and "git add" the resolved files ...
> 	git commit
> 	git cherry-pick bar

Why does a single commit "cherry-pick foo" leave any sequencer state that
may interfere with the latter to begin with? Isn't that already a bug?

> 2.
> 	git cherry-pick foo bar; # has conflicts applying "bar"
> 	... resolve ...
> 	git commit
> 	git cherry-pick baz
>
> Those were intuitive things to do before the sequencer existed, and if
> I understand correctly, d3f4628e was intended to support people and
> scripts (such as the test suite) that have these commands wired into
> their fingers.

Given that the latter was broken when "foo" stopped with conficts (it lost
"bar" altogether anyway), I am not worried about it, and I do not care
much about anybody who had wired such multi-pick into scripts or fingers,
either.

IOW, I do not necessarily agree with your "those were intuitive"
assertion.
