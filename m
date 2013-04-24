From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 11:11:50 -0700
Message-ID: <7v38ufer2x.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4Ag-0003Ap-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab3DXSLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:11:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321Ab3DXSLx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:11:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6691159E8;
	Wed, 24 Apr 2013 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W6FZpUvphKhOd6N2SiuZegIjo7I=; b=ASj+5J
	rNa4DmlSUdxe2Ef/Iv4UTd0bpfpekWB4FqNw1x6U0khLt7fHRuQRcVyhkYJ9R8+8
	YJSurWCzBWIlz63gsKwxFGLhTDv+X73UqD6SdhiluAZRw5KDv1iuV3gUaxpHRuIY
	fE7YFR2C8eItFHiS9Gr8d+AM1u/wxW1Zj5fQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PlWlZ1AVMgapKtTjLk4aIQEYnEchJzKY
	SS9jmMwJb9SE5IHzVugfpusVo9bpFjiEZx+hI8h/VtlhF72B0GostZW/M6HBU0nd
	6bHbK3ycq4S8IPDfoGcVNb1FiHxNciJY8sHolRuO2pcdkesCcjbNuKZDWk6YYo7K
	vCIZNj1D3qM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD1A9159E7;
	Wed, 24 Apr 2013 18:11:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 609DE159E6;
	Wed, 24 Apr 2013 18:11:52 +0000 (UTC)
In-Reply-To: <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 24 Apr 2013 22:21:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 708C1570-AD0A-11E2-9716-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222282>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> What are your thoughts on inventing a new syntax A~B = $(git
> merge-base A B) B which can be used by both range commands like log
> and non-range commands like diff ?  (In other words, why shouldn't log
> be able to do this?).

The idea for a new syntax to denote a merge base may be an
interesting one.

"log" is inherently about ranges, so you do not need a new operator
to denote a merge base.  Between "log A..B" and "log A...B" with or
without --left-right, --left-only and --right-only, you should be
able to ask questions about histories leading to commit A and B
without having to worry about a single "merge base" between A and B,
no?  So I do not think "A~B" would help "log".

Because "diff" is inherently about endpoints, you DO have to have a
single "merge base" that gives you a point to compare something else
against.

The reason why "diff A...B" was invented was primarily because we
wanted to avoid having to say A twice on the command line, be it
"diff $(git merge-base A B) B" or "diff A~B B".  In other words,
"A~B" will not help "diff" at all, either [*1*].

There isn't always a single merge base between an arbitrary pair of
commits (there may be 0, or 2 or more).  When used in the context of
"diff A...B", we know that the user is more interested in using one
merge base (among possibly many) to get some diff, than seeing the
command fail [*2*].  Taking that as a context cue, "diff A...B" can
(and did) choose to use one picked at random, even though the design
is fully aware that the chosen one may not be the best one.

A generic "A~B" syntax implemented at the revision parser level may
not have that luxury of assuming that it is fine to pick any, and
may have to fail when there is not a unique merge-base.


[Footnote]

*1* That does not mean nobody needs that syntax.  It just means that
    it is still a solution looking for a problem.

*2* Otherwise the user can more carefully script what he wants to do
    using the merge-base command himself, choosing to do different
    things when there are 0, or 2 or more merge bases.
