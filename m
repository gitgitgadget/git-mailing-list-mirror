From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 16:19:19 -0800
Message-ID: <7vborct37c.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu>
 <4EE7CDF2.3040408@alum.mit.edu> <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 14 01:19:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RacZC-0007dP-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab1LNATW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 19:19:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab1LNATV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:19:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 592116370;
	Tue, 13 Dec 2011 19:19:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p+X9oFyFbFRCwKVtONb1gjT9Sfk=; b=get1K9
	htG3f0ebrDCFbPofNDmRNn9pZrqRVfvrM/lvqh8pJhNofPDxRyNGolWNGnXf49vT
	vXLToOFMva9bcpLcdZMRP6uq/sRXxhRR//oj6KrYR8TuhqrkRudFiqWg0gC+kFMc
	YksiiRoH7elMnwCGFQaOSfcqE1g8P4PExFQAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXIde5KVAMAWRWJSRciVXdfkiTpAaTg9
	kJ7mPeVc2XazAg+J/FV34LeQ902gzIWNDW/chC+d3Tu6ce4kSBULdal8AtjXtVBM
	zkTVq9zsOcCY0UPKH/MHYbLHalGx6IU+ACrGN0WUaycP4bIQw2cSQz2Nj7Pg+BGV
	SF81UITClPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB89636F;
	Tue, 13 Dec 2011 19:19:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2B78636E; Tue, 13 Dec 2011
 19:19:20 -0500 (EST)
In-Reply-To: <7vzkewt5qu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 13 Dec 2011 15:24:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44C2C906-25E9-11E1-85FA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187085>

Junio C Hamano <gitster@pobox.com> writes:

>> Namely, we should figure out what code wants to set extra refs and or
>> wants to include extra refs in its iteration over references. The
>> setters don't have to be changed, but the readers should be.
>
> You read me correctly. That is exactly what I meant by "extra ref API" in
> my earlier response.

Actually, I do not think it even needs to be the "extra *REF* API". The
only thing that matters is that these commits are considered to be extra
anchor point in the history, in addition to the usual rule of considering
that everything reachable from our refs is complete. The data structure to
hold them does not even have to be a "struct ref". Just an array of object
names (or "struct object *") should suffice.
