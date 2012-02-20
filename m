From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 15:31:36 -0800
Message-ID: <7v8vjxjd47.fsf@alter.siamese.dyndns.org>
References: <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
 <20120220151134.GA13135@sigill.intra.peff.net>
 <87d3991gyg.fsf@thomas.inf.ethz.ch>
 <20120220203540.GA5966@sigill.intra.peff.net>
 <7v1uppkvpx.fsf@alter.siamese.dyndns.org>
 <20120220224140.GA7116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 00:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzchs-0005AM-K6
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 00:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab2BTXbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 18:31:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab2BTXbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 18:31:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C73688D;
	Mon, 20 Feb 2012 18:31:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WOhiGngkR7J86QvI4NEd5IJUiaA=; b=IjzcGs
	HaKFK15DV0HAqTjehbsq/TOe2e5B5SZB9Y30ayK8lGOY8JcPsJFxV1c2J9Fiz0QI
	ctlMlkh1qC9cekFW3SdiZYL2Z4dTiuceFigTMDGYCw6XqBQ+7W5kCViEFXG2O82e
	82LWuAv/joO4pIQzLPhdsd5IZJgwR8HmHU5dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpSqIIDkF7oDJlnTBTqQe5v9QjI7xv6V
	+iLU+w8ZWEcH+CLVk6/ko0KekYx/Jew2MmJY/5jKF0tTBPg9vEt5LUUzr5RD96ff
	WhX6+NS1doqSz7O5p6fbj2WRXRyPMlTwqcNpkdguC5qtQTQdQK2whlbdVrtIr0Mo
	4E7/79zuLPQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CB5F688C;
	Mon, 20 Feb 2012 18:31:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 720AA688A; Mon, 20 Feb 2012
 18:31:37 -0500 (EST)
In-Reply-To: <20120220224140.GA7116@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Feb 2012 17:41:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 088763E4-5C1B-11E1-A9DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191125>

Jeff King <peff@peff.net> writes:

> I still think replaying real-world test cases is going to be more likely
> to find issues in invalidation.

Yes, but it depends on what kind of replaying you have in mind.  It is
very hard to come up with "replaying real-world test case".

For example, randomly picking commit pair <$A,$B> from the kernel
repository and running

	git reset --hard $A
        git checkout $B
        T0=$(git write-tree)
        drop-cache-tree
        T1=$(git write-tree)
        test "$T0" = "$T1" && test "$T0" = $(git rev-parse $B^{tree})

is necessary but I do not think that is sufficient.  We also want to do
something like:

	git reset --hard $A
        ... modify paths that do not change between $A and $B
        ... git add these paths
        git write-tree
        git checkout $B

with and without the "git write-tree" to see the part of the cache-tree
smudged by the modification behaves sanely.  The codepath that is used
to deal with the case where the index does not match $A but matches $B is
also different, so the "modify path and git add" step would have to be
crafted carefully to touch all bases.
