From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More detailed error message for 403 forbidden.
Date: Thu, 28 Mar 2013 12:11:55 -0700
Message-ID: <7vk3ortk3o.fsf@alter.siamese.dyndns.org>
References: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
 <20130328183601.GA11914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Yi\, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:12:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULIFO-0005Nu-TD
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3C1TL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 15:11:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331Ab3C1TL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 15:11:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FFEAEF9F;
	Thu, 28 Mar 2013 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3WSn2JJr7q5lxNWy3V4Ty8GCW8M=; b=Mcrsj5
	MFkSP0nt2uB5Z3oaNA5G0GZlzhtvfx93McqmTUtFbfKaR9ozUPlBg2I7P7Gsjrcg
	05ZqybsTUFEdTh5JiNIYg5oXx7EFk39TF5FrJ1tTKLHUFqOS+/C4d9Jlp4gKWnAS
	0iwMt+ANQDJVECWDa2BEdiAa4YO6x/WITY6yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A07fmK7J9guIGebNq+wDLc739puljN1u
	YSFoRopfWmrxGa5SHqMqLIKWzVXmr71YhQxo+OjLbBX99Pde+1jTC8fFJYV+MbfE
	8cIt2UTmvRrdzqXO2d7StdgAkqZY23j8xfNPijpGumPm4D1a13r/SPOcXXOE3zrc
	KCjrl2CHL2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17264EF9E;
	Thu, 28 Mar 2013 19:11:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90236EF9D; Thu, 28 Mar 2013
 19:11:56 +0000 (UTC)
In-Reply-To: <20130328183601.GA11914@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 14:36:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BA9AB66-97DB-11E2-9531-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219449>

Jeff King <peff@peff.net> writes:

> One problem is that the content body sent along with the error is not
> necessarily appropriate for showing to the user (e.g., if it is HTML, it
> is probably not a good idea to show it on the terminal). So I think we
> would want to only show it when the server has indicated via the
> content-type that the message is meant to be shown to the user. I'm
> thinking the server would generate something like:
>
>    HTTP/1.1 403 Forbidden
>    Content-type: application/x-git-error-message
>
>    User 'me' does not have enough permission to access the repository.
>
> which would produce the example you showed above.

Actually, isn't the human-readable part of the server response meant
for this kind of thing?  I.e.

	HTTP/1.1 403 User 'me' not allowed to accept the repository.
