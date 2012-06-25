From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checking for 'clean' bare repo before push
Date: Sun, 24 Jun 2012 22:35:51 -0700
Message-ID: <7vk3ywhs20.fsf@alter.siamese.dyndns.org>
References: <js6pnt$28f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:36:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj1xu-0002Ml-8d
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 07:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab2FYFfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 01:35:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab2FYFfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 01:35:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C503E24;
	Mon, 25 Jun 2012 01:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NWgrkLT069iCWkNkwSslIj5+Q78=; b=dLpJlF
	P29Gm3Woy9hYju7tFkIp9e886q+Z1Nbpik4Ukg/QNu0aH/r4IVG2dbDARbnuRSsc
	ADDTaX6eWTfYp5SR2ZRv7N/rLva/z3gfJAEHGeG9KcHYoQaE7dFfR8I0DrVC9u2+
	cPE/U4kEC3bUbBFiVBuCN1PBpW+D9ocTLfH3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oV6IoCA80Rja/9P8w238v9QzBn5TIbds
	2AtC6LHK2JOk8e9KAhXuOB9APmwTLlotPzGuq0Am4oE2It/Pczh6+mRfmSMOg61l
	DSgk7AXlgVK3+zC1RtjqNbnyduWlXqIGb9widvbZHd8wF2Wb370CKuP3KseBMMFJ
	YH3BfvZoG6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE5D3E23;
	Mon, 25 Jun 2012 01:35:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2CA93E22; Mon, 25 Jun 2012
 01:35:52 -0400 (EDT)
In-Reply-To: <js6pnt$28f$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Sun, 24 Jun 2012 05:21:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A112BEE6-BE87-11E1-AEE4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200545>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I'm being asked to provide commands to check for 'clean' state of bare
> repo before and after a git-push.  This request is based on the notion
> of checking for a clean worktree (git status) before a checkout,
> merge, etc on a non-bare repo and checking the worktree state after
> such operations.
>
> Context:
> Since the bare repo and non-bare clone repos in question only have
> branch master, and deny-non-ff is set for the bare repo, I don't think
> there are checks to be done before and after git-push in our
> case. git-gc and git-fsck could be possible, but don't seem normative
> for every single push.  git-gc has auto configurations, and git fsck
> is expensive.  It seems like routine git-gc obviates the need for git
> fsck.
>
> Am I correct on this?

I agree 100% with you that it is entirely unclear what 'clean'-ness
your requestor wants from your description.

At a higher conceptual level, "before I do merge I want to check if
the working tree is clean" is a wish to avoid "overwriting" things,
and in that sense, perhaps the requestor wants to make sure that a
push she accepts does not overwrite somebody else's work.

Such a 'clean'ness is called "fast-forward", and by default a push
has to be a fast-forward to be accepted.  The pusher can "force" a
push that is not fast-forward, but there is a way to forbid such a
forced push (receive.denyNonFastForwards).
