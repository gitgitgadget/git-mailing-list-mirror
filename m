From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Doing a dummy or empty merge
Date: Thu, 11 Mar 2010 12:26:37 -0800
Message-ID: <7vljdyzjsy.fsf@alter.siamese.dyndns.org>
References: <8440EA2C12E50645A68C4AA9887166513FC480@SERVER.webdezign.local>
 <86wrxiepv3.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Richard Lee" <richard@webdezign.co.uk>, <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Thu Mar 11 21:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npoya-0005jd-EL
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 21:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab0CKU0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 15:26:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab0CKU0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 15:26:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38652A11D5;
	Thu, 11 Mar 2010 15:26:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iPkts/TA9gDnPjB5ebEnVL5U/pY=; b=FsBU6Z
	1CI0ICR/pZArrim+aGYFpAhqWSOQD1cufWtyrNcsIYYRtrAoQQcfgyisnJfVDrU8
	YzUBoOxM9yK59h2PB8SXXxrsX9HU30yGlOMdZostA4h/8lI6sGkXgQGNsM/Zn5Xt
	yj29zXV6UPiez/SnVFs0gb5PM9aJ6DGvC6gM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NhHboBr+kW16J72HHJN+H7hLGFq6TAaD
	nCD4dvbcS3N+d/0POZfsp5g0I2A2bcJgAB/y6KHLKMDMn+DFPa0YOu5L1T1LgmKt
	9uguk/3kglSbp0ZqCsShfk7rl+n7LESvXEcepjMSEl9MllJf3Ots6MBWnAAA6EDh
	1nKZIz1nncA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03ACCA11CB;
	Thu, 11 Mar 2010 15:26:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40B8AA11C7; Thu, 11 Mar
 2010 15:26:39 -0500 (EST)
Importance: high
In-Reply-To: <86wrxiepv3.fsf@blue.stonehenge.com> (Randal L. Schwartz's
 message of "Thu\, 11 Mar 2010 09\:21\:20 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67FDA3C4-2D4C-11DF-B508-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141996>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Richard" == Richard Lee <richard@webdezign.co.uk> writes:
>
> Richard> At this point I want to merge this test branch into the live branch
> Richard> despite not having made any commits apart from deployment related
> Richard> changes on the test branch. I want this to be a dummy merge so that a
> Richard> merge is recorded into the live branch, but the contents of the live
> Richard> branch remain untouched. This is as if I made an empty commit on the
> Richard> live branch.
>
> I think you'll get what you want with a "merge -s ours" from test
> to live.  That says that "I've looked at test, and I've looked at
> the parents of live, and this is how I want the result to look".
>
> Further commits on test can then be merged to live automatically using
> this new merge as the (initial) base.  Of course, later commits after
> that will use subsequent bases, but that should already work the way you
> want.

After the above "merge -s ours", you obviously can never merge from live
to test.  You have declared that you favor the live configuration over the
test configuration with that merge commit, and merging a branch that has
that merge commit (i.e. live) into any branch (i.e. test) is your consent
to be bound by that declaration.  The resulting backmerge will wipe the
test configuration and replace it with that from live.

Not that anybody would be likely to want to merge live back to test, but I
thought it is worth a warning, as people who haven't thought through what
it means to make a merge commit (or more generally, any commit) can get
confused.
