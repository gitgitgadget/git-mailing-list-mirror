From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Sun, 11 May 2014 10:22:03 -0700
Message-ID: <xmqqppjkut6s.fsf@gitster.dls.corp.google.com>
References: <20140505212938.GA16715@sigill.intra.peff.net>
	<20140506151441.GA25768@sigill.intra.peff.net>
	<xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
	<20140507030254.GC20726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 19:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjXUI-00072W-O0
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 19:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbaEKRWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 13:22:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61946 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbaEKRWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 13:22:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5154015A3D;
	Sun, 11 May 2014 13:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8yh9C6ESnKzB/sdjsxJY1c/7Cbg=; b=SB+e6I
	tVVREG/glSkBBem9r9/E7+lqq5VLFtkf3gxo2C3aT6g9S15RzrxcuAP/4aZM4gq5
	0giB+wTkAwGbbXFmUzViT+/l3qcpalwMZkmLcC2I9S8JgUh+VAOdr6Y4T9XfO3Xp
	9mqvaFBnJ8YGaW7b+q/05cHYXlAQNNiLnj8xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kanEFp6dL9dV+gWENFL/z/N2MlaUYsxO
	l0eBo/5ETcjXO/rOD3aUMJG++EQINJlYkOMExjvwRFM5J58wDbzL+I3GiV0Rqa34
	FI4LyXbOJ07Y+mJkoNuaKckwelPoMxIWpJEXxCgVeJZm2onTyVxchHUKJGVv2r6n
	SK/OBvHTnY8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4829815A3C;
	Sun, 11 May 2014 13:22:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC70315A3A;
	Sun, 11 May 2014 13:22:04 -0400 (EDT)
In-Reply-To: <20140507030254.GC20726@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 May 2014 23:02:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C59FF7C2-D930-11E3-B08E-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248675>

Jeff King <peff@peff.net> writes:

> On Tue, May 06, 2014 at 03:29:37PM -0700, Junio C Hamano wrote:
>
>> That's kind of W*A*T magic, and I generally try to avoid magic, as
>> long as it solves your "can we make both -O2 with new compilers and
>> -O3 happy?" I wouldn't complain ;-)
>
> I agree it's rather magical, but I think it's something we can count on.

Certainly. Sorry that I missed "but" before "as long as", which made
me sound as if I were unhappy.  At least, I didn't call it an ugly
"hack" ;-)

The alternative you mentioned up-thread "... to write out "return
error(...)"  as "error(...); return -1". In some ways that is more
readable, though it is more verbose..." has one more downside you
did not mention, and the approach to encapsulate it inside error()
will not have it: new call-sites to error() do not have to worry
about the issue with this approach.

Until it breaks, that is.  But that goes without saying with the
"it's something we can count on" pre-condition in place ;-).
