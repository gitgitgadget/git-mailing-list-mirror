From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Fri, 10 Feb 2012 13:17:11 -0800
Message-ID: <7v62fepew8.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
 <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu>
 <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu>
 <4EE7CDF2.3040408@alum.mit.edu> <7vzkewt5qu.fsf@alter.siamese.dyndns.org>
 <4F158E99.2020906@alum.mit.edu> <4F352F03.2030104@alum.mit.edu>
 <20120210204457.GD5504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvxqK-0006gI-TI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759160Ab2BJVRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:17:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab2BJVRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:17:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7E07C4F;
	Fri, 10 Feb 2012 16:17:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=As0QulF8xXbtPVYowKaF4mfvriY=; b=Ocqt+u
	IgybAS7g1t3nkTKD8s6I07LHCQI5BL2sLpwJAXeuBK5yxgdTee/QPPJc55AE6Yd/
	hh5anGoI4GKD3LUgk6qiW2h/3yIpfzRSx3nxw+GVm6VKS+DZhaVl3U7fxphoUIfD
	1HKcOiw08HoWs2M3miOQVUeTVZAL9UmhyP67U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A2wtOuBcliHjsoxrCTXjyGErecz23lka
	fUCzhF7+qEyvU0MN4AzlsI1RJzZlqSjxeLY44iHY8lUwDCHegn4rm2VDNdJjO56O
	AvGrmnYPsJVtUq6NrhZRgooIygqu+WJTmsQmJ1ixT5bVC2KbUc1AYi0sSPsVaghe
	PmKsY9oNYEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 659977C4E;
	Fri, 10 Feb 2012 16:17:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C12617C49; Fri, 10 Feb 2012
 16:17:12 -0500 (EST)
In-Reply-To: <20120210204457.GD5504@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Feb 2012 15:44:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 997D869A-542C-11E1-A568-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190454>

Jeff King <peff@peff.net> writes:

>> If everything_local() is trying to check that the references are in the
>> local repository plus alternates, then it is incorrect that
>> everything_local() doesn't consider alternate references in its
>> determination.  My guess is that this is the case, and that something
>> like the following might be the fix:
>
> Junio could answer more authoritatively than I, but I am pretty sure it
> is the latter. The point is to skip the expensive find_common
> negotiation if we know that there are no objects to fetch. Thus the
> "local" here is "do we have them on this side of the git-protocol
> connection", not "do we have them in our non-alternates repository".

Correct.  The function is about "do we need to get any object from the
other side?" optimization.

I originally thought to go through the rest of your message, but I
realized I can just say "everything you said is correct and I have nothing
more to add."

Thanks.
