From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/2] Separate stat_data from cache_entry
Date: Sun, 12 May 2013 22:10:13 -0700
Message-ID: <7vli7jqxca.fsf@alter.siamese.dyndns.org>
References: <5190500E.8060907@alum.mit.edu>
	<1368414007-3819-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 13 07:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubl1p-0004CI-Cx
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 07:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab3EMFKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 01:10:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3EMFKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 01:10:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115091A199;
	Mon, 13 May 2013 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ubGZS+cz6muGDRimqb6FQeOHcQ=; b=jdftNE
	RKb/ht/7XY8+XNSsu0zBcxKCId9TzhAhvI2O4CZJm/CvfV/z597R5X8wWB441juv
	/f7e0LkT1TiaOyh6Dagxuv1bCkWx9dW2i1zzYasWQmEFmftnUydYbBMwDWBPSt/r
	XXxiZX0+NrSrAkFRLinU2HRiVrUnhlEXYLzHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xkQ0CAhDfFUfPDUi+f5jN5fr/zlK61Ml
	2hu92ToSErhPZFGjAf0ip/K0lQrXPvTzhiCBa+3GBsDDYA7MiVOGWV+IgSWpNoVB
	zlXFdnfGSdfBfEB30rbcGFWtahHJym6w+dMsdux84ySQa4/a0P9g5KsJi92AFdWS
	lSu3d93gDSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07BD41A196;
	Mon, 13 May 2013 05:10:22 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81AB41A18B;
	Mon, 13 May 2013 05:10:21 +0000 (UTC)
In-Reply-To: <1368414007-3819-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 13 May 2013 05:00:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6943632E-BB8B-11E2-907B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224089>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Michael Haggerty (2):
>   Extract a struct stat_data from cache_entry
>   add a stat_validity struct

Some indentation glitches carried over from the original in that
"from-ondisk" function were distracting while reading it through,
but I think these show us a reasonable direction to go, if we want
to have "We have read that file and already know what it says.  Do
we have to read it again?" check for files that are not tracked
working tree files.
