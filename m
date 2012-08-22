From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch/push: allow refs/*:refs/*
Date: Wed, 22 Aug 2012 09:56:08 -0700
Message-ID: <7vlih6ams7.fsf@alter.siamese.dyndns.org>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com>
 <1345484397-10958-2-git-send-email-gitster@pobox.com>
 <50332E2D.2070602@alum.mit.edu> <7vpq6kdu31.fsf@alter.siamese.dyndns.org>
 <50348C97.4040606@alum.mit.edu> <7v7gsrb1xs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EE8-0003W2-FT
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797Ab2HVQ4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:56:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992Ab2HVQ4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:56:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBF8C8A47;
	Wed, 22 Aug 2012 12:56:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qdhEgabaOizk7KGIUb1bCZPRU3w=; b=A8h2XQ
	rYbs8/rMsTUHnBeXNOBuuU/96jQImCsDr3awN4gg38QjYNpKURDndo7JyVFhmH44
	71wx4DjqnpRRnBntmgEA5TKis8z/cC80mBW8Xw0PTeNZtqaVRY+vc3isB+HGSmCa
	2eUrujsGAJ7Q3rq1iOUaxmX5V7bSbxLq+ryto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XBraN1sE8lmzfkS0y6mUvu8v64rzAJVh
	Ryz0ig6VRNnPYxiQ7OOrCPd5lzygTeMiNaflGsJCz9ySh4HTOCbU/1OAgNLSTYxG
	a2irqQlzzvINvM2YBgljvw9024jWnuQoOhQnmiIDgiyzygEaAkCgO+ScYCUfRpOi
	2WCknjbzz4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C5C8A46;
	Wed, 22 Aug 2012 12:56:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A4128A44; Wed, 22 Aug 2012
 12:56:10 -0400 (EDT)
In-Reply-To: <7v7gsrb1xs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 22 Aug 2012 04:28:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 460AFA10-EC7A-11E1-B7ED-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204030>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> ...
>> * The second branch of the if is *never* executed.
> 		else if (args.fetch_all &&
> 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
> 			*newtail = ref;
> 			ref->next = NULL;
> 			newtail = &ref->next;
> 			continue;
> 		}
>
> I am not familiar with (nor particularly interested in) the "args.depth"
> code, so I have no comment on this part offhand.

This is "fetch --all" case.  I think the original intent was to
fetch all branches (hence exclusion of tags) so the prefixcmp() may
not be correct (!prefixcmp() with "refs/heads" would be more kosher)
these days.  I am not sure what !args.depth check wants to do here
(that is, I can see it wants to defeat "fetch --all" and instead
make it go through the usual refspec matching codepath, but I do not
know why we thought that is a good thing to do here).
