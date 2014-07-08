From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v20 00/48] Use ref transactions
Date: Tue, 08 Jul 2014 11:48:06 -0700
Message-ID: <xmqqa98jadqx.fsf@gitster.dls.corp.google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<53BC1C53.9030203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 08 20:48:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4aR7-0006bp-V7
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 20:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbaGHSsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 14:48:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53379 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908AbaGHSsN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 14:48:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E96F127A3A;
	Tue,  8 Jul 2014 14:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V3WtL7FPES9SPPCSIqn56FJoxk4=; b=ITRpHV
	5SkvN/OueLTa+Tt06xj7c1lB2FnfmiBiuhhRacxYy4AtklNzrgSXEcg0xTgQHxfM
	leaaOwnFukJQJeY44CwQ1BIOKEeLnKwpzmDczluVClnCWoTAVstaOCIx7YgBtILc
	G2iuh0nPm0whx0hcUWpiuZx6nzgKU4Zrbctus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9bJztI4eomByfNlPI9a67XNIfiGMJbD
	1TadDT+GPqCIvzAD+Kb4ezXnt+8P+VDfC5ok4AlgIqGY+Izj4/Dl+Vvs2mfv+ZTZ
	bPjWLyZkMnFRe+KKnLjcZMmP24j9Uv0orB6bidA/bckTon4SzQukJSb9mVPw/ohk
	komPnR3oxDo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE9EC27A39;
	Tue,  8 Jul 2014 14:47:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B299327A32;
	Tue,  8 Jul 2014 14:47:54 -0400 (EDT)
In-Reply-To: <53BC1C53.9030203@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 08 Jul 2014 18:29:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5F287B5E-06D0-11E4-8FA4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253038>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Patches 01-19 -- ACK mhagger
> Patches 20-42 -- I sent various comments, small to large, concerning
> these patches
> Patch 43 -- Needs more justification if it is to be acceptable
> Patch 44 -- Depends on 43
> Patches 45-48 -- I didn't quite get to these, but...
>
> Perhaps it would be more appropriate for the rules about reference name
> conflicts to be enforced by the backend, since it is the limitations of
> the current backend that impose the restrictions.  Would that make sense?
>
> On the other hand, removing the restrictions isn't simply a matter of
> picking a different backend, because all Git repositories have to be
> able to interact with each other.

I'd say that "if you have foo/bar you cannot have foo" may have
started as an implementation limitation, but the interoperability
requirement with existing versions of Git and with existing
repositories makes it necessary to enforce it the same way as other
rules such as "you cannot have double-dots in name, e.g. foo..bar"
or "no branches whose name begins with a dash", neither of which
comes from any filesystem issues.  That a rule can be loosened with
one new backend does not at all mean it is a good idea to loosen it
"because we can" in the first place.

> I think it would be good to try to merge the first part of this patch
> series to lock in some progress while we continue iterating on the
> remainder.  I'm satisfied that it is all going in the right direction
> and I am thankful to Ronnie for pushing it forward.  But handling
> 48-patch series is very daunting and I would welcome a split.
>
> I'm not sure whether patches 01-19 are necessarily the right split
> between merge-now/iterate-more; it is more or less an accident that I
> stopped after patch 19 on an earlier review.  Maybe Ronnie could propose
> a logical subset of the commits as being ready to be merged to next in
> the nearish term?

Yeah, thanks for going through this, and I agree that we would be
better off merging the earlier part first.
