From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Wed, 14 Jan 2015 13:54:26 -0800
Message-ID: <xmqqsifd81v1.fsf@gitster.dls.corp.google.com>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
	<xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
	<xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
	<20150112231231.GA4023@peff.net>
	<xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
	<20150113015427.GA5497@peff.net>
	<20150114142146.16390.54937@typhoon.lan>
	<xmqqr3uxb7kj.fsf@gitster.dls.corp.google.com>
	<20150114204926.GA1155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBVta-00066W-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbbANVya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:54:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbbANVy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:54:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31AAA2DDB1;
	Wed, 14 Jan 2015 16:54:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=noOmFUkx3ZpuqXbgK7iRxlOGGs8=; b=e5NDup
	TUoqENT561zDZJZiLlNOa706DesFREI7NxKgVXRG1cWuE6hNiqO/O9W7ByEGne9e
	h8nJcxXovAt/DVGh2caMJXi+SZFJHSAl54huV6xiyjz7UoVfq925xco45ef7AvqB
	nbbC4gZw202PcEtJ9ePACb7p0fw8uLJ/c/X2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g1EPCXg0YMjMSruu7qqXRuj9cAtsuOZ5
	OriN2Uy1dDtOcZo3rUXQmK3dJ60WkkWgBAtPPib+kv4R3NdC6M5AnZpOpVYs8gAP
	ryLhJ7c+8nEmUZwubFNGrYd4lRZaqlt77CFtW+h6EqJaom8yOdQU27riKEyIy6N4
	7euXDM5K9fg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2357F2DDB0;
	Wed, 14 Jan 2015 16:54:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A5332DDAF;
	Wed, 14 Jan 2015 16:54:27 -0500 (EST)
In-Reply-To: <20150114204926.GA1155@peff.net> (Jeff King's message of "Wed, 14
	Jan 2015 15:49:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E917E910-9C37-11E4-A205-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262434>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 14, 2015 at 09:22:52AM -0800, Junio C Hamano wrote:
> ...
>> And the result should merge just fine to 'maint'.
>
> Are we in agreement then that the resulting code with the helper is
> actually easier to read? I think replacing the straight ?: lines is, but
> I am on the fence on whether:
>
>   const char *x = some_fun(...);
>   return xstrdup_or_null(x);
>
> is better or worse than:
>
>   return xstrdup_or_null(some_fun(....));

I think the latter is fine as long as some_fun(...) invocation does
not get overly long, and even the longest I saw in refs.c, i.e.

        return xstrdup_or_null(resolve_ref_unsafe(ref, resolve_flags, sha1, flags));

did not bother me too much.
