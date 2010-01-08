From: Junio C Hamano <gitster@pobox.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
 commits?
Date: Thu, 07 Jan 2010 16:32:09 -0800
Message-ID: <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
 <201001071813.01187.trast@student.ethz.ch>
 <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
 <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 01:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT2mA-0008Bv-5v
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 01:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0AHAcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 19:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870Ab0AHAcW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 19:32:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0AHAcV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 19:32:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C878FFEB;
	Thu,  7 Jan 2010 19:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kSRt4qzEBnPYnYdbumwoV6vS93g=; b=P19quc
	3FEuvpnoGMBF2F6v6gQkdnz5exHIJO5coaz1KZqt9wlHGE573b1e+vhx/6we+7A1
	Zyw3rg4Q/9ZAJPS7qwO+0GunXJa4//orm80n1he62qwgtIRQN7rsbtdS4J85Ij34
	5i6uYiuVEidLjuz8LEpMnDl3cmK+RI8f1W+ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=So10H8gJsaxRCT2cXa8NzSdrtYYtBKAo
	jI0loNCfb1aOH+g9f2kKQl06XqMGqk7ztrW3auvq6ovZTbPTqTJ2Ih/UMnGRC3Wk
	e2wjyuK6txUCGrpj3aSf/+BTwPLqmMFkiUCxAaDFzh0IyyOFj0cl4uG+uX02pOAb
	30QSXWdJ6Po=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FC518FFEA;
	Thu,  7 Jan 2010 19:32:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1BB88FFE8; Thu,  7 Jan
 2010 19:32:12 -0500 (EST)
In-Reply-To: <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 7 Jan 2010 18\:50\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45E5C52C-FBED-11DE-A21A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136402>

Eugene Sajine <euguess@gmail.com> writes:

> $ git fetch origin branchname
>
> are both causing the output like this:
>
> From git://....
> * branch      branchname    -> FETCH_HEAD
> ...
>
> but "git fetch" says:
>
> From git://....
> * branch      branchname    -> origin/branchname
>
> Is this inconsistent behavior necessary by design?

It is by design; it is debatable if it still makes sense, though.

Back when "git fetch" was invented, there weren't separate refs/remotes/
hierarchy, the distinction between what's local and what's remote were
only in user's head.  It made quite a lot of sense to have an explicit way
to prevent "fetch" from overwriting all the branches that track branches
from remote.  Suppose you have already spend considerable time inspecting
'origin/branch' and decided that has a suitable commit to build your
changes on, but you needed to work on something else first.  If "git fetch
origin other", an explicit request about "other" branch, updated an
unrelated "origin/branch" at the same time, you couldn't recover from it
by using "origin/branch@{1}", because reflog is a fairly recent invention.

An explicit "git fetch origin other" is a way to prevent such an update
from happening.  It does not update anything in refs/ hierarchy, even when
you have configured to make an implicit 'git fetch $there' make a copy of
$this_ref somewhere in your refs/remotes/$there/ hierarchy in .git/config
(back then the same information came from .git/remotes).

Because we have reflogs on by default, and refs/remotes/ is a separate
hierarchy that is read-only from the local user's point of view, I think
the 'explicit fetch' syntax, as a way to stop tracking branches from
getting updated, ceased to be useful these days.
