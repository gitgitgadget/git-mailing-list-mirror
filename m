From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Mon, 09 May 2016 15:04:46 -0700
Message-ID: <xmqq37pqubup.fsf@gitster.mtv.corp.google.com>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
	<1462824758.24478.37.camel@twopensource.com>
	<xmqqinynt01r.fsf@gitster.mtv.corp.google.com>
	<5731062B.6080909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 10 00:08:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aztLo-0007sQ-7t
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 00:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbcEIWEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 18:04:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753704AbcEIWEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 18:04:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 35BC018F58;
	Mon,  9 May 2016 18:04:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IIkPognpSes3wDg0oTJi7nJGq7U=; b=hJMEUD
	VH4Msg0OIZkUGpKK+EO7B0afZuS9bDtLJ+4ceRKzahTPP56YIOv5gFD66M9j5DeS
	bm9to0fEGQVXwP3pmqoLAVmMFPNr6vkIeBuJh2Km1QmemFTh5IY8Te47gG+maJWC
	QTQHsC4++jtGl+o5DaK/YWKwFXEOWYq22fBmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OJiQnV/wryCnLBqLvaQX46jeTVFwHdwZ
	Wn1B5NksWm0SG8DqsOCghIz2GiOh6gGQ0jIwI25fa1JW16b8RxdqobBUF6gLEPPK
	AK737Vf8Kyxr15I5Meu810OCIjKqqvfUOtJfDz8hcqaX0SOO3Wn8SkZrmIMdp+SY
	SpbtVPqjfUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E7C818F57;
	Mon,  9 May 2016 18:04:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A67A818F56;
	Mon,  9 May 2016 18:04:47 -0400 (EDT)
In-Reply-To: <5731062B.6080909@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 9 May 2016 23:50:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B71DCDA-1632-11E6-AD5C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294077>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> The "demonstrate an existing breakage first" order makes it slightly
>> easier to review and follow a long series, as it forces the reviewer
>> to see the issue first and think about possible avenues to solve it
>> for themselves, before seeing a paticular solution.  For a trivial
>> single-issue fix, it is not necessary (including a fix and a test to
>> protect the fix from future breakage in the same patch is a norm).
>
> I find it useful to add the broken test in a separate patch, because it
> is then easy to cherry pick that patch to other versions of Git to
> discover which ones are also affected by the problem. If the addition of
> the test is combined with the fix, then the patch would more often fail
> to apply to other versions due to conflicts at the locations of the fix,
> and even if it applied, you wouldn't learn whether that version of git
> was broken but the breakage was fixed by the same fix, or whether it
> wasn't broken in the first place and the fix was unnecessary.

Note that I only said "it is not necessary", and did not say "it is
not desirable".  I wouldn't automatically reject a two patch series
with demonstration followed by fix, only because they are not in a
single patch.

Even when I know the maintenance track a particular fix and test
targets at, I'd do the "only try to test to see how it is broken
currently" step manually anyway as part of the initial "acceptance"
check when applying [*1*], so trying the same procedure for older
maintenance tracks is no big burden for me.  Having these as two
separate patches is easier to split them apart, which unfortunately
makes it easier to lose one of them while cherry-picking.

This is of course subjective.


[Footnote]

*1* There is a bit of white-lie here.  Instead of applying only t/
    part, I tend to just do "git am" the whole thing, and then pipe
    "git show" to "git apply -R" to in-work-tree revert only the
    code that fixes it.  But the result I get is the same.

    And the "cherry-picking" would also involve "show only the t/
    part and pipe that to "git apply", which is even simpler than
    actually cherry-picking and creating a commit (I do not have to
    be very careful not to leave such a "test cherry-pick" commit in
    the real history).
