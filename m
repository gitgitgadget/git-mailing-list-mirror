From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 10:21:25 -0700
Message-ID: <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <20120321121126.GA27660@odin.tremily.us>
 <m3sjh2ay6j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@drexel.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAPE6-0006sO-6x
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 18:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab2CURV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 13:21:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab2CURV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 13:21:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C486F7D;
	Wed, 21 Mar 2012 13:21:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WyhV65q9lHX33tJtiLv3rVLoXYI=; b=pWy3Gs
	+3klZ7FwJYqJeJfDRh5rSyhZGs1rXTuT4O2/YVd5mgNQoURgHWOmSbaXUM3JU4M+
	IklGtdu013BFOAEyOV/hWG0IxWj0rX7iCjZawy5vsubhBw+jY2BJkOvtQxXUXz4A
	4gIRmv+y4YTbPNge06qwqxsZ7Kcb+eKPwfjjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lm2oft0seKlZWD6cW6hKJJUEG32YjuMC
	Q2qpsAkZzqJgO17G2EaoaslTYZEET9ct5qzH4qbwp1TIkhDQDNkpyCTqA4Ze49yx
	FacGWhzvf0CDQMNGcxODpviUVuVPSLV3sINRomce/V3bG3MbjmOeDSkNTSBbS2yK
	YTGRGxgwrjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC506F7C;
	Wed, 21 Mar 2012 13:21:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B4DD6F7B; Wed, 21 Mar 2012
 13:21:27 -0400 (EDT)
In-Reply-To: <m3sjh2ay6j.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 21 Mar 2012 06:19:51 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AAC8D32-737A-11E1-942E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193591>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, it is custom on this mailing list to usually Cc (send a
> copy) to all people participating in discussion, and not only to git
> mailing list.
>
> "W. Trevor King" <wking@drexel.edu> writes:
>
>> Subject: [PATCH v3] Isolate If-Modified-Since handling in gitweb
>
> Perhaps a better title would be:
>
>   gitweb: Refactor If-Modified-Since handling, support in snapshot

With "gitweb: " prefix to denote what area it affects, that is certainly
better.  Given the primary objective and effect is that the snapshot
feature starts honoring i-m-s,

	gitweb: honor If-Modified-Since request header in snapshot

would be sufficient.

> to mention all that thispatch does.  Though trouble with coming up
> with a short but fairly complete one-line summary might mean that this
> patch would be better split in two: refactoring and adding support for
> If-Modified-Since to snapshots.

If many existing callsites had duplicated code to handle i-m-s, we may
want two patch series, the first of which consolidates them into a single
helper function without changing anything else (most importantly, without
regression) and the second that uses the helper to add support in the
snapshot feature.  But if that is not the case, I think we can go either
way.
