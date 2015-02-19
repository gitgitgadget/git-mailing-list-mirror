From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --decorate: do not leak "commit" color into the next item
Date: Thu, 19 Feb 2015 10:02:12 -0800
Message-ID: <xmqqvbixzsnv.fsf@gitster.dls.corp.google.com>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
	<xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
	<20150218230728.GA17302@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 19:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOVRe-0005rM-KU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 19:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbbBSSDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 13:03:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751623AbbBSSDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 13:03:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C540C383CB;
	Thu, 19 Feb 2015 13:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrDT7GbE0oFeG90ybUuMtkNKQgI=; b=XzuZHA
	3hqRE+lfeOoVUesbWQdPICabBs1E37Kcbp7Vlv5oiD8tqdBZfeNSlkDR9k6XHaH4
	83oN4+9+sZOdPTocNU6orFjPzQXMuO/I5iwI5FByGGr9RkOg32xI8TPT69kYUuir
	xtZ7fdIWAkO16W3MkbE8tZZh+65vPiAKNRJCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vaQnNK5X/s/JJTI61JJlM5y491BNBZ9r
	7LCk3KmmU3kmODHOyj813dCiZcJusi3ccgDtWR1T0OdAcpfsZnLd74TgLFGN/mkH
	RZzvAhLV5R2mgmMJgv5YUNRIkjR64rLkIYrGZ2RbZIN9c/2wy6jNBZSS+0XSEcnJ
	iOv7+F/r/lg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B854A383CA;
	Thu, 19 Feb 2015 13:03:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5FF938389;
	Thu, 19 Feb 2015 13:02:13 -0500 (EST)
In-Reply-To: <20150218230728.GA17302@peff.net> (Jeff King's message of "Wed,
	18 Feb 2015 18:07:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EE0F6A0-B861-11E4-BB97-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264107>

Jeff King <peff@peff.net> writes:

> Yeah, I think this is a good fix. I had a vague feeling that we may have
> done this on purpose to let the decoration color "inherit" from the
> existing colors for backwards compatibility, but I don't think that
> could ever have worked (since color.decorate.* never defaulted to
> "normal").

Hmph, but that $gmane/191118 talks about giving bold to commit-color
and then expecting for decors to inherit the boldness, a wish I can
understand.  But I do not necessarily agree with it---it relies on
that after "<commit-color>(" and "<commit-color>, " there is no reset,
which is not how everything else works.

So this change at least needs to come with an explanation to people
who are used to and took advantage of this color attribute leakage,
definitely in the log message and preferrably to the documentation
that covers all the color.*.<slot> settings, I think.

Thanks.
