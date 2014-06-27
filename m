From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Fri, 27 Jun 2014 11:55:39 -0700
Message-ID: <xmqqsimq18t0.fsf@gitster.dls.corp.google.com>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
	<cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
	<20140613080229.GJ7908@sigill.intra.peff.net>
	<539ACA8A.90108@drmicha.warpmail.net>
	<20140613110901.GB14066@sigill.intra.peff.net>
	<xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
	<20140616195428.GB24376@sigill.intra.peff.net>
	<xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
	<20140616203956.GA3546@sigill.intra.peff.net>
	<53AD640A.9060006@drmicha.warpmail.net>
	<53AD685A.1030401@drmicha.warpmail.net>
	<53AD76C3.3060702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0bJQ-0000dE-LR
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 20:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbaF0Szt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 14:55:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53787 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaF0Szs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 14:55:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 979AC216D1;
	Fri, 27 Jun 2014 14:55:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jjMpPyaRH+zHtLuSUZ8x43otzqM=; b=dsn1s1
	CdKsoOh3mYx00WvPMVMhqOmgGARSqD7uQ553vtVmH+ziRuzLPde6499iNqjFwFEg
	mDK5YmqXHtv6PrKYm942yStMUrb8F0SjYidcOEoAqr9An+PR5dCC9eteWQhsxt4M
	AMZZD9QwDLqDHVbyt9vPsoOttf1LlO91Q3dvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vn56kgK3dV198Rpl7WKuY281iIAEWNie
	zTYk4W2mERkxFTuwZwCJo1aUMb/gdd8FTjA7qArDsWI18+sKFPmzzayN4fFSfDmO
	flPH9zSwiTGkvk6B8RM+j2v8bo0eOerd6HZMjSjQDrXL+wFy8EivhgvkzrmVJB/Z
	KN7UPGOJ9SU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 546E1216D0;
	Fri, 27 Jun 2014 14:55:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9DFCA216C3;
	Fri, 27 Jun 2014 14:55:32 -0400 (EDT)
In-Reply-To: <53AD76C3.3060702@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 27 Jun 2014 15:50:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D8E07D0-FE2C-11E3-A9B4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252570>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ... or an extension <ref>^{mergetag} to our machinery, defaulting to the
> tag object containing the mergetag for the 2nd parent, with an optional
> version <ref>^{mergetag}<n>?

One thing you should not forget is that with mergetag, the original
tag object is not even necessary to exist in the repository, and
often the original tag will not be propagated to the general public.

You _could_ extract the necessary information from the commit that
merges a signed tag to recreate the tag, but for what purpose?  Your
"$commit^{mergetag}<n>" needs to recreate the named tag object but
it is unclear to me how you envision it to be used.
