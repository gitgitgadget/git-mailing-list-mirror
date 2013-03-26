From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Tue, 26 Mar 2013 13:49:10 -0700
Message-ID: <7v7gktubsp.fsf@alter.siamese.dyndns.org>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-3-git-send-email-gitster@pobox.com>
 <20130326185559.GB26462@sigill.intra.peff.net>
 <20130326203914.GA29167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaoP-0007fy-PE
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab3CZUtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:49:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848Ab3CZUtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:49:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6EAFA77A;
	Tue, 26 Mar 2013 16:49:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GxBPpq5DtvKF+d45Uv+SQ/RgFSk=; b=PHAJJJ
	VJBVtzP9pQQLWFwDLQpc9ZImEComiyfufwCXsyIZnJn+ZjF9NOHYBRMr9QnMenBe
	PPUj8Vc5QbUxWhRXKRF3OgLfe5fTOToSK8lSpY0QrabHGENMrGZQ0pD9wE8pf7+v
	3Ag/ozIv+M+eMa8pZ92b1ifG1pyK1hd9vZduM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vdP2mSFN2dCelfvM/MmOqa+uLCCCggzo
	pdNOTjgpGj01z86sop1vVkrpUaLTwITfIV1T9/DSz5njsk0rnolMPyqprk3oLA4u
	qFFTuww+3QyxwGlXRxB9a+9f1BlmGbT7nRiYqyGS0BXQxSvLxdthTI6l82E2K/qq
	2IMDhyYzO1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FC3A778;
	Tue, 26 Mar 2013 16:49:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39EB2A773; Tue, 26 Mar 2013
 16:49:12 -0400 (EDT)
In-Reply-To: <20130326203914.GA29167@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Mar 2013 16:39:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D277752-9656-11E2-A412-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219205>

Jeff King <peff@peff.net> writes:

> I timed this doing "git archive HEAD" on webkit.git before and after. It
> actually ended up not mattering much (I think because it is only the
> directories which are affected, not each individually path, so it's a
> much smaller number than you'd think). The best-of-five timing was
> slightly slower, but was within the noise.

Interesting.  Because "archive" has to incur a large I/O cost
anyway, I expected extra allocation for correctness for only the
directory paths would be dwarfed in the noise.

I actually care more about cases other than "archive", though.  Do
we even feed directory paths to the machinery?

> So I do still think it would make sense to go to a byte-limited version
> of fnmatch eventually, just for code cleanliness and predictability of
> performance, but this is really not a bad solution in the interim.

Yes, what we do with wildmatch is a separate issue for 'master' and
upwards.
