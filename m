From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and worktrees
Date: Wed, 01 Jun 2016 08:15:28 -0700
Message-ID: <xmqqbn3l0wkv.fsf@gitster.mtv.corp.google.com>
References: <574D382A.8030809@kdbg.org>
	<CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
	<20160531221415.GA3824@sigill.intra.peff.net>
	<574EA364.60408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 01 17:15:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b87rx-0001hP-HB
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 17:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbcFAPPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 11:15:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758614AbcFAPPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 11:15:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B050E1EB24;
	Wed,  1 Jun 2016 11:15:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CM3UZk9vzQu94iiBnRkCyAuMw5w=; b=Z6Cpx3
	pMo2m1IThIMYnKGrXJ0wkVFfOqAxT9ylrkD1q8ztyvUTOYZtUrR544hpyHQGbnnH
	TFZgZhmSlpD5BD57zzMF1uCL9Pna7CtTAqAwuYu9E+LloD8XAj+11w9H+xOSrqE7
	WzZJFrxJ5WL55u0fOSJ+noRkUScGeax3g4bNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIGZN0jy37hkYyzMVCaXVB/1y8Oc0r2m
	Qc3nUfQVy2BAqAUlGOC4z8+H3LtnEO9+g2lkM7H+aWdbAS25fYOaMkH4t7KiFuAA
	4dknrssABKrjd1n3yct6uQYNPcIT6uYI2x7uwp27FBZBRDzsKTX4ZL3smVYGESD/
	dpcYvJ+h1Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A70D01EB23;
	Wed,  1 Jun 2016 11:15:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 323A01EB22;
	Wed,  1 Jun 2016 11:15:30 -0400 (EDT)
In-Reply-To: <574EA364.60408@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 1 Jun 2016 10:57:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD8340D2-280B-11E6-956F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296088>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think reference stores are going to need two distinct types of
> reference iteration: one to iterate over the *logical* reference space
> of a single repo or worktree, and one to find all *local* references
> and/or reachability roots (e.g., when run within a linked repo).

This is hard reason about without defining *logical* and *local*.

For protecting necessary objects from pruning by anchoring them as
"reachable", and for avoiding unnecessary object transfer by showing
things via ".have" lines, we're better consider references and
reflogs that do not appear in the namespace visible from the current
worktree.  I wanted to come up with an example of wanting to iterate
over refs of the current worktree, but other than "what are my
branches including HEAD?" I didn't think of anything interesting.

> The current approach, where subtrees of the reference namespace
> are pasted ad-hoc into each other partly by manhandling the
> ref_cache and partly via the hack in `git_path()` is not, I think,
> a very good long-term design.

This I agree with.

Thanks.
