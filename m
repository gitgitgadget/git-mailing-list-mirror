From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Tue, 01 Jan 2013 11:49:50 -0800
Message-ID: <7vfw2kbs4h.fsf@alter.siamese.dyndns.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
 <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Gr=C3=A9gory?= Pakosz <gpakosz@visionobjects.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 20:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq7qn-0005RK-En
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 20:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439Ab3AATtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 14:49:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab3AATtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 14:49:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0390CAE6F;
	Tue,  1 Jan 2013 14:49:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wvEzQOxc+MYJ
	HdIcr5X6dSF2P7s=; b=aPnzcGUjKC/aZt6K1HoRXmaXIRvjpjDntNSvuzWtq4yC
	eJrMO+kG7kDXsjEAjbUIpUvf2dilblA7oH+6owDedsgTEVqLPepe1txeHh3AT4JM
	Dog5z6R67VHRtpPaXcmB2Nde/CQ0zREf9iUHcLOZWxlIoxwRMSkp9LcD+kKGOks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NtVIjz
	Iqyv+4hggbBSUzlC0ssR2KV8SjfL7nSB/+OGP81eLKFqtUllp38Jv4QwoYj9q4zR
	dNc/bEuBLyyaY72QEGDVro6tz1FGzIolcy3ZI7xirKYvSyH75kYoqLASOPSYeFqZ
	po9veWQQD/lPqPLPLPrhYxbMx+o117BmvBkh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9939AE6E;
	Tue,  1 Jan 2013 14:49:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C66AAE6B; Tue,  1 Jan 2013
 14:49:52 -0500 (EST)
In-Reply-To: <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
 (=?utf-8?Q?=22Gr=C3=A9gory?= Pakosz"'s message of "Tue, 1 Jan 2013 14:11:42
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68925E86-544C-11E2-95CD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212433>

Gr=C3=A9gory Pakosz <gpakosz@visionobjects.com> writes:

> in my use case, $ref is "refs/tags/4.0" which is an annotated tag
>
> $ git rev-parse "refs/tags/4.0"
> e941b1999906c17b59320f776d58b71fc2fcdb72

Yeah, but in that case it appears to me that you told the command to
rewrite the tag itself and the history behind the commit the tag
refers to, but the end result did not rewrite the tag itself and
left the tag pointing at the original history.

The "$rewritten" variable being empty in this codepath tells me that
the command decided that it *does* want to delete the tag, but as
J6t mentioned in his review, it is unclear to me what is expected by
the user.

If the command and the filters you gave the command decided the tag
should be removed, then not being able to delete it is a problem and
the code you patched that compares the object name of the tag and
the object name of the commit the tag refers to is certainly doing a
wrong comparison.=20

But I have this suspicion that you did not want to remove the tag in
the first place.  The application of "map" shell function to obtain
$rewritten is done on the unwrapped object name by passing "$ref^0"
to rev-parse, but perhaps that "^0" is the real source of the
problem instead, so that it checks what new object the original
annotated tag was rewritten to?  If the tag object was rewritten,
either to empty to signal its removal or to a new object name, then
we do want to update-ref it, but the decision should be made on its
object name, not the object name of the commit it points at?
