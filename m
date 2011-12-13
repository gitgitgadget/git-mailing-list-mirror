From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 15:24:25 -0800
Message-ID: <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu>
 <4EE7CDF2.3040408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rabi7-0002ld-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab1LMXYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:24:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab1LMXYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:24:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2E475B8;
	Tue, 13 Dec 2011 18:24:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EmmR0NtWYuKeSu2Go/hnM7lSmC4=; b=W2fpLo
	4IuC0E5P1yHBV2iiAMZy9TG0nQDvMYGC0f8ulr7uGcwzVFYRkJIUAjgANzu6vGng
	+cT0Fs8/dvd7RO4wXDYExcmwGZ4z1yKEQgnTv680EEbLiEmorIa52cBgef/t3GN2
	QbiXsd68jH4UPjRv2ICAYRVqyQxdmw7fJqCnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rcjPa4A1INIAtGRCunnG2L/MbjYujjo4
	rJW7xxFfbQwQWZKmgrrmSP6ZEwJkeoHJWkMNUSTC6xw888p9y7ja1YqmGm5u047T
	OueJVzwEBwM8hjldxark+viKIdn1KjVkCKuTNtTOf9/I2ZJ3SffLRhoXrlEz1H8T
	GUb2tKRd9Po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6249575B7;
	Tue, 13 Dec 2011 18:24:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE37475B6; Tue, 13 Dec 2011
 18:24:26 -0500 (EST)
In-Reply-To: <4EE7CDF2.3040408@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 13 Dec 2011 23:13:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 996A1868-25E1-11E1-9D32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187077>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> .... For example, extra refs added in builtin/clone.c is used by
>>> builtin/fetch-pack.c, meaning that the codepath that discovers and
>>> remembers these extra history anchor points and the codepath that uses
>>> them while walking the history are not localized and we would need some
>>> sort of "extra ref API" anyway. I am leaning towards this option.
> ...
> Namely, we should figure out what code wants to set extra refs and or
> wants to include extra refs in its iteration over references. The
> setters don't have to be changed, but the readers should be.

You read me correctly. That is exactly what I meant by "extra ref API" in
my earlier response.

> ...  But there are so many calls to the
> for_each_ref*() family of functions that I wasn't able to determine
> exactly which should allow for extra refs and which shouldn't.

Only the ones that follow add_extra_ref() in the control flow.

builtin/clone.c adds them in setup_reference() to deal with --reference.
The objects known to be complete in these repositories we borrow from
need to be marked complete on our end (i.e. clone does not have to fetch)
and transport_fetch_refs() that eventually goes to fetch_refs_via_pack()
that calls fetch_pack() uses this information. All three for_each_ref()
calls in builtin/fetch-pack.c are about "what are the objects that we know
are complete?" and needs to pay attention to extra refs.

Having said that, I have a slight suspicion that you might be able to
eliminate this one in clone.  setup_reference() adds the reference
repository to the $GIT_DIR/objects/info/alternates, and the fetch logic
already knows to account for the refs in alternate repositories via
insert_alternate_refs() callchain.

builtin/receive-pack.c adds them in add_alternate_refs() to deal with the
repositories listed in $GIT_DIR/objects/info/alternates in the receiving
end of a push. Again, the objects known to be complete in these
repositories we borrow from need to be marked complete on our end, and
write_head_info() in that function sends these extras together with real
refs we have.
