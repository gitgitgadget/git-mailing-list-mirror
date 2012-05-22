From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 09:16:47 -0700
Message-ID: <7vwr445gy8.fsf@alter.siamese.dyndns.org>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 18:17:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWrld-0005ak-PV
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 18:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759250Ab2EVQQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 12:16:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755444Ab2EVQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 12:16:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4FC879A;
	Tue, 22 May 2012 12:16:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hQC0PeZiE5kAkdhVrZrpPoSwbio=; b=i8nPOY
	PyB+/hCugkKAb50rMEGmGnX8qqH0pN05jKW0r453N/hjSus0guv2W1jUZH0XGCkl
	ilLs/WygYR6oJzYFPceq6amh0xQLXO1b3pYTBjPy0DfUda/zq0hlF8Vh22a6DeZ/
	6cntyM4KOFmP/i1OIP+KxXe8aDsB+kwExbiYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gPSch/ev9KDx5wzMzi9BybakuLbSUa3W
	bdghMqZnscOsHHLaagnpuo+EkqP/jFQtK8v5n7S705j7GTg8fGtKUkiuUJjEohi4
	lR4SRZGK/nSWHbJgxpcgtzr3gXDXQOT4wtojdbJ281Rk/XUssjOZCw2/fVNrL99g
	OG12FN9VkQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B598799;
	Tue, 22 May 2012 12:16:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A34E98797; Tue, 22 May 2012
 12:16:52 -0400 (EDT)
In-Reply-To: <20120521174525.GA22643@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 May 2012 13:45:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AC7E65C-A429-11E1-BAD9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198202>

Jeff King <peff@peff.net> writes:

> I don't think there is any reason we can't sort the list of heads, and
> then we can get rid of the duplicates with an O(n) traversal, like the
> (largely untested) patch below.

Yeah, I think the only case the order matters in fetch is the traditional
"when multiple non-glob fetch refspecs are configured, only merge the
first one" logic, but it kicks in a much higher layer and the order in
this list should not have any effect on it.

Thanks.
