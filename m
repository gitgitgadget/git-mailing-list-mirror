From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: allow author-specific timezones
Date: Tue, 16 Oct 2012 08:49:41 -0700
Message-ID: <7vzk3mto16.fsf@alter.siamese.dyndns.org>
References: <1350261054-5171-1-git-send-email-crorvick@cogcap.com>
 <7vpq4jws4d.fsf@alter.siamese.dyndns.org>
 <CAEUsAPY3fJJSzX8WPRVQPNOF0A0KAMCXr1u0ZzjEFvXDF=v6JA@mail.gmail.com>
 <7v4nlvulc2.fsf@alter.siamese.dyndns.org>
 <20121016063152.GB22941@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:50:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9P7-0000uE-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab2JPPtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:49:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab2JPPtq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 11:49:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79BC281AC;
	Tue, 16 Oct 2012 11:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GPea4pBhqyYSNxFj5sPK+x5bt0g=; b=pKwGvo
	U/bywvXvWYf20K4H8B2R67tbXgOB5l/f7OTvGwPTi0WtkEHVrifmvlq7rRhAd0dQ
	fGU/YQ7TK26+RubOiGRmq0QdJzlWW3mnZzbYZcDc29vv71nkBLzakPHdi1KMPzan
	/2cC/z/H6FltjqlyVpdX4UITS9SIr3jE8uD5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M7Q6nh669QYvnkJJ4CRL20P85csZBlZL
	lsyQx8BWYNUyagm3NoJPPIzPgza1cs7u4KWXg7i5sm7xy3gNx4Qka24cxudQuVVk
	rHirI2+7lxOVhEdmG0oorU4TpKTsHeeM6jZzkpcD5jyf4O7jMrIuuQfQQmpqShgC
	ckLT6w/jU4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6746181AB;
	Tue, 16 Oct 2012 11:49:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5657181A9; Tue, 16 Oct 2012
 11:49:43 -0400 (EDT)
In-Reply-To: <20121016063152.GB22941@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 16 Oct 2012 02:31:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A5B0928-17A9-11E2-AEB7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207837>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 15, 2012 at 08:50:21PM -0700, Junio C Hamano wrote:
>
>> Chris Rorvick <chris@rorvick.com> writes:
>> 
>> > It occurred to me that the success of the unit test depends on the
>> > host platform's zoneinfo database.  I think this problem is inherent
>> > with this functionality.  Should the unit test attempt to detect
>> > support for the used timezones and short circuit if this fails?  Not
>> > sure exactly how I'd do this, but wondering if it's worth thinking
>> > about.
>> 
>> Yeah, that did indeed cross my mind.
>> 
>> You could say TZ=QST6QDT or something silly like that but that in
>> turn has to assume your tzset() is POSIX.1 compliant anyway.
>
> We use EST5 in t0006 (it was originally just "EST" but IRIX complained).
> It's been in the test suite for two years without a problem, so it may
> be simple and safe enough to just use that.

Sounds good.  As the test vector for the last piece seems to be
designed to show that the dst conversion correctly works, we would
need to use STD$nDST formats, though.
