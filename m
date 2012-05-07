From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] correct git-status Porcelain Format documentation
Date: Mon, 07 May 2012 11:10:23 -0700
Message-ID: <7vobpz6ewg.fsf@alter.siamese.dyndns.org>
References: <20120506132959.GA28214@sigill.intra.peff.net>
 <20120506135141.GA17176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 07 20:10:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRSOG-0005mu-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab2EGSK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:10:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606Ab2EGSK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:10:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAC976C5A;
	Mon,  7 May 2012 14:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f5+VKrJ4170Tvfv0a30A0YAFAVI=; b=szNLsQ
	2uXE1OrJtirKSZIw9b3wUwsqvdmn1GF2fFR5Y4apuvwdwk20IQ/Q52vaVanlmNBt
	5fAGC9BqFtP3Sy6/Pe0p73jWQUd3tG8j1716nbu9CmF/CJhP5p4kMfsTFnD0en3d
	8V376CTHk/jCkwxwH2PnrVvmGt7VrfexqsvJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chdMiZOnyymDJ4DxoFf5xFXYILfxWCCV
	RMmiIpNUlZl1gY9e3qyvEk4qly7yVthwykyGW8VYS939UyJOGFXp7n6ptMujWrdl
	MGWSGgHKirv4Q67tOK3Ykz1igpHw+Q5WfF2dAq7GgUisCPaHPfAUlN+ei2u+TbrN
	VbCm2INylkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A21E26C59;
	Mon,  7 May 2012 14:10:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C1B86C56; Mon,  7 May 2012
 14:10:25 -0400 (EDT)
In-Reply-To: <20120506135141.GA17176@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 6 May 2012 09:51:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB286190-986F-11E1-9794-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197290>

Jeff King <peff@peff.net> writes:

> What should "git status --porcelain -z -b" look like? With my patch, it
> prints the branch-line with only a newline, not respecting the NUL
> termination. Which sounds like a bug, except that's what happens _now_
> with "git status --short -z -b".  Which seems like a bug to me, but
> maybe somebody is relying on that. It seems kind of broken to me.

It is broken; and it is not a problem if somebody relied on a broken
output without giving --porcelain in a script and such a script needs to
be updated.  If we are updating the code to give "## <branch>" in the
output under the "--porcelain", let's do that right from the beginning.

> Also, while looking at the documentation, we say of "-z": "This implies
> the --porcelain output format if no other format is given". But the only
> other format you could give is "--short", since there is no way to ask
> for the long output (and nor do we handle NUL-termination in that code,
> anyway).

... nor do we define long porcelain format to begin with.

> Should this be simplified to just "this implies porcelain"?
>
> That would technically break somebody who wanted their
> status.relativePaths config option respected. But it kind of seems crazy
> to me.

I do not think it is worth changing it.  It is not too much touble to
spell "status --porcelain -z <whatever else>" in a Porcelain script only
once and forget about it.
