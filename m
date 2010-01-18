From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Sun, 17 Jan 2010 22:30:19 -0800
Message-ID: <7vk4vgsz5w.fsf@alter.siamese.dyndns.org>
References: <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
 <20100118015140.GB6831@coredump.intra.peff.net>
 <7v8wbwultw.fsf@alter.siamese.dyndns.org>
 <7v3a24ukku.fsf@alter.siamese.dyndns.org>
 <20100118055703.GA17879@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 07:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWl8m-00066e-E9
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 07:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab0ARGai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 01:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140Ab0ARGag
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 01:30:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab0ARGad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 01:30:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35DE792424;
	Mon, 18 Jan 2010 01:30:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QeuJqLEZ38L7ADABq47z1nIbMuI=; b=EbAY6d
	6hL618GPIm+6hURr47JIH4rTAhITll+VKyo9NZxa8kgAMxr4vAWD+WRTgwm+QEl9
	5RtWs8A5bwS4bogp8kC2PYXBEhrqcGbwa7I222u2L8GzVD5jZNgwaeXE/6vyKqNe
	zz6jxq9i3kCwJaSOCg7phSjw75Wt7TfHGA1Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ohz6PYmoTyCkAE+qDc3s+yPLqvAa4bt7
	18g2CAu5WsIjDwp9KcJkR1/Yxw0fqbe3YuKUl34KMCrhlOPJhfG+m++LnXBwV/oO
	DOyuOdsxjSbqMwIPqnQ6z34hTbvwlblorNfFCcDMD+pdeKFCQHabe1GiXKEuje2B
	5rMFnsknaBc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8D8992422;
	Mon, 18 Jan 2010 01:30:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCAC19241F; Mon, 18 Jan
 2010 01:30:20 -0500 (EST)
In-Reply-To: <20100118055703.GA17879@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 18 Jan 2010 00\:57\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F69B6ABA-03FA-11DF-92EB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137371>

Jeff King <peff@peff.net> writes:

> Hmm. I like the new behavior. The implementation feels a little
> hack-ish, like we should really be supporting full-on:
>
>   git log --author=me --and --grep=foo
>
> That gets a little weird, though. We already have "--not" for ref
> limiting, so clearly there is some conflict ...

That is fundamentally wrong.

Remember, "grep" works on two levels: a line matches or does not match the
given set of patterns (rather, the expression given), and matched lines
are shown.  A file as a whole is considered to have matched if one or more
lines produced a match, or under the --all-match option, only when all of
the top-level ORed terms in the expression have fired for some lines in
it.

And --not and --and are both elements of grep expression that determines
if the expression matches "a single line".  --author=me --and --grep=foo
would ask: does the "^author " line in the header have "me" _and_ also
string "foo" on it at the same time?

IOW, most of the "logical" stuff (including the precedence binding
parentheses) works at a line level.  --all-match is currently the only
thing that affects "grep -l" (and "will the commit get shown") behaviour
by collecting hits from the whole buffer.
