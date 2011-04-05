From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Tue, 05 Apr 2011 16:17:45 -0700
Message-ID: <7v7hb8l23q.fsf@alter.siamese.dyndns.org>
References: <20110405212025.GA3579@sigill.intra.peff.net>
 <20110405212314.GA3613@sigill.intra.peff.net>
 <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
 <20110405221827.GA4123@sigill.intra.peff.net>
 <20110405225038.GB7358@sigill.intra.peff.net>
 <20110405230245.GA7631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Lopez <brian@github.com>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:18:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FVc-0002O4-Te
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1DEXR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:17:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab1DEXR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:17:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF78A5753;
	Tue,  5 Apr 2011 19:19:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=td4D6rsGjDTSks8q0qe0zlkr1HY=; b=HoA4hD
	ImDd/THt4rNhaNbLmyiWKkpjGSiF+OypKLeICf+lt/dmXnA5Mm9W3ux27Yxmz/vN
	P+CtyNwptZfcPPcLpn0EnVvDvVffqjDL1+7aMl/vSrrKJLG5+jRA830Lfiug0Qmx
	vAfGgShqMfwDNQxjsSmEdxVzA38gkS27/rJnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wc1uq8wn+qXrILmINO8t22QtwVPeJ3c5
	VJpOZV0Y6a5iV+qMrI6kp3cWQxZ5no5v2niK8hzOpZ2sT3MREMx1zdjnZXPyMLZ4
	jLboncpNjSA59AlMk3JWgjLq/a6gbn8nZG6ZevlLdMjSixfMXMeNkapfMGGA59Rv
	JVHvGzI9AIk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF4625752;
	Tue,  5 Apr 2011 19:19:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98F22574E; Tue,  5 Apr 2011
 19:19:39 -0400 (EDT)
In-Reply-To: <20110405230245.GA7631@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Apr 2011 19:02:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3070D6DE-5FDB-11E0-8BCF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170936>

Jeff King <peff@github.com> writes:

>   The same "robustness" comments for the save_work function apply
>   here.  You probably do not want to restore on a dirty tree; the
>   intended use case is "stash away, pull, then restore", so I
>   think it is Ok to assume that you will only be restoring on a
>   clean state (and it would make the implementation simpler).
>
> So perhaps there is no broken case at all, and it was just a matter of
> being overly conservative from the beginning.

Perhaps.

If we are going to treat this as another mergy operation, we should at
least still make sure that the index is clean (i.e. "diff --cached" is
empty), I think.
