From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch names in $PS1
Date: Tue, 22 Apr 2014 10:38:43 -0700
Message-ID: <xmqqy4yx5knw.fsf@gitster.dls.corp.google.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
	<20140421202454.GA6062@sigill.intra.peff.net>
	<53562A96.6000002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	git@vger.kernel.org, sitaramc@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:38:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wceej-0007L5-QG
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402AbaDVRis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:38:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932927AbaDVRir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:38:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56E747F54E;
	Tue, 22 Apr 2014 13:38:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7unf7SK1KtWyInNaGrEOKowaFYU=; b=acWpj8
	EPBcMSnWEJ1wtHe8cc9cghQnZl1aUW+xZV+yLehucgUmGVRDyak56sdu9a/QPeqv
	6WiIC9+vaUvbblqXp5LD/23nCKT1Z5WYb5lKvxrin7/U6v0dkD9QeL5TPQNYv9I8
	swRHSxE4+rjNZ9/RyVbCgvreXFIOYrTnZ9ESc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K1ypF8929IEBcdjUL09gtuviazwHP4bh
	eI2z61cAPkpHiz9CmyOIoj/Mdtcoo+QZ6rO/r2S22Ln4QLcIin3XCD3Z1/hWrx02
	9E6nG7n8ebKv8LC6uPPIhMQW1wBXnZYoCbIPH3mJiboEdJ47cCtnAeFRoAbnyjDF
	Nmhn+FQWa/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B51B7F54D;
	Tue, 22 Apr 2014 13:38:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 990A47F544;
	Tue, 22 Apr 2014 13:38:45 -0400 (EDT)
In-Reply-To: <53562A96.6000002@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 22 Apr 2014 10:38:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F44EFD02-CA44-11E3-9866-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246758>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> While we're at it, I think it would be prudent to ban '-' at the
> beginning of reference name segments.  For example, reference names like
>
>     refs/heads/--cmd=/sbin/halt
>     refs/tags/--exec=forkbomb(){forkbomb|forkbomb&};forkbomb
>
> are currently both legal, but I think they shouldn't be.

I think we forbid these at the Porcelain level ("git branch", "git
checkout -b" and "git tag" should not let you create "-aBranch"),
while leaving the plumbing lax to allow people experimenting with
their repositories.

It may be sensible to discuss and agree on what exactly should be
forbidden (we saw "leading dash", "semicolon and dollar anywhere"
so far in the discussion) and plan for transition to forbid them
everywhere in a next big version bump (it is too late for 2.0).
