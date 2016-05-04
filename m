From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remotes
Date: Wed, 04 May 2016 01:11:14 -0700
Message-ID: <xmqq1t5ijl99.fsf@gitster.mtv.corp.google.com>
References: <20160503181624.1504eb0a@laborpc>
	<xmqqshxylvwh.fsf@gitster.mtv.corp.google.com>
	<20160504013624.4c51ce42@wind.levalinux.org>
	<CAGZ79kat4rW7raoXQNF2mb0nS5qF0e7yTCoSkiFe2VFJ=E_VdA@mail.gmail.com>
	<xmqqk2jajobz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kovacs Levente <leventelist@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:11:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axru4-0003Fy-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620AbcEDILW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:11:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757615AbcEDILS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:11:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10CCC12028;
	Wed,  4 May 2016 04:11:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q94ZT94PvRaTtFuDbj/DMl0IwP4=; b=vFmD+Q
	sVP+cnHe8nFY0RvtrrmXQIneceOLhgztCGGGvF7fZBpNaEEvbY61EIg92Ftbh2rg
	jWiIK+dogT2JT33vD0Xr2IhCOH10yd6mF4GAJMdLfzjuYeu+NTGx0L19CEEOLTFS
	jDj/u37X1bc4QWOdcoBzl2vWbAn6JTTm2fwWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cDkdgIuQBQPwt3eaq6TI/8lpsNVqB3nH
	qekbhRQYY7e6kq46Kf3YN28KHczYIvsyUhi8HyT3wT/b0dVg5fJGR2dZaraKXXPd
	D4i1wafI7jQWc/4rEifC4woYPSbdQ/OSwXxNYn9JR9pmp4CIzuSyHuYqCTU2o27K
	sexJzCtly/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0753E12027;
	Wed,  4 May 2016 04:11:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7022D12026;
	Wed,  4 May 2016 04:11:16 -0400 (EDT)
In-Reply-To: <xmqqk2jajobz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 00:04:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C654A51C-11CF-11E6-8EEC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293511>

Junio C Hamano <gitster@pobox.com> writes:

> The difference is in this sequence.
>
>  (1) Alice owns the canonical history.
>  (2) Bob copies Alice's tip tree without history, starts a
>      different root, and builds some history.
>  (3) Alice builds some more history.
>  (4) Bob pulls from Alice.  The check in e379fdf3 triggers here, but
>      Bob can override it.
>  (5) Alice builds even more history.
>  (6) Bob also builds even more history.
>  (7) Bob asks Alice to pull from him.
>  (8) Alice pulls from Bob.  The common ancestor discovery finds the
>      merge base between (4) and (5), which is (3).

Correction.  That merge-base is between (6) and (5); I renumbered
the steps while writing the document and failed to update the
reference.

>     ---(1)---(3)---(5)---(8)
>                 \        /
>           (2)---(4)---(6)
>
> The history traversal is done at (8) to find merge-base for two
> purposes.  One is to find the common ancestor to use in 3-way merge,
> and the other is for the check introduced by e379fdf3.  It stops at
> finding (3), and does not traverse the history all the way down to
> (2).  But in order for Alice to notice that the merge would pull a
> new root Alice never has seen, i.e. (2), a traversal needs to
> continue down to the root of other's history.
>
> Naively, it would be running
>
> 	rev-list --max-parents=0 ^HEAD MERGE_HEAD
>
> and see if the result is not empty, in which case you found (2).
> But that is way too expensive unless (2) is relatively shallow.

A not-so-naive optimization Linus alluded to in the discussion that
was a tangent of e379fdf3 was to teach unpack-objects and index-pack
to report when they see any root commits in the payload.  When Alice
pulls from Bob at (8), one of these two programs would already be
examining every object received from Bob's history, and they can
notice the presense of (2), a new root commit, and report it to the
caller with minimum additional cost.

Unfortunately that approach will not work in the general case of
"fetch to examine first and then decide to merge" workflow, as there
is no medium the first step, i.e. "fetch", can use to convey the
fact that it saw a new root to the later step, i.e. "merge".  Doubly
unfortunate is that "git pull" is in fact implemented in terms of
handling that general case.  We _might_ be able to futz with the
file format used in FETCH_HEAD to help "git pull", but that would
not help a true user-space "git fetch $there master:there/master"
followed by "git merge there/master" workflow.
