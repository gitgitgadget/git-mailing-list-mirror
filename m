From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 18:04:00 -0800
Message-ID: <7vaav7wb8v.fsf@alter.siamese.dyndns.org>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
 <20100218011620.GA15870@coredump.intra.peff.net>
 <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 03:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhvl9-0003DD-VE
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 03:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab0BRCEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 21:04:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab0BRCEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 21:04:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE6A9AB9A;
	Wed, 17 Feb 2010 21:04:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eu7QTN8EYt1wPfGf8J3Ovvdo22s=; b=bJ7ihh
	fZ1KiVfzsBL/5upXcf4hp+UKnEkeAST+fB6FC/8gA0j932uoQgsuQtzLiHM2HJlk
	AnlM8I+TMHWYHOkEtvCaO8AxlDAxECt5qbA8kxbbH4AEI85Gw56tRRcpJQpNv31b
	B2BLiKDVdsaKsH2TU9AY19Gnd+Iw8GnuIXBRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkqIXeeIhfcbVRyjnshMYMsLKD2NsQCb
	PzEWmCSjhCouXG0L9VXrGANcggGAYELe3OSOGIjj79pJmUIMRDvsAPMKFTHJJ4oy
	IZ1jt7rVhmwcY1sn/LHLGfifH4cScvQCLhR8cJykEFiVEA/YreuxzOsFa1gdiGhx
	CtNHkOvYYfw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B52A9AB94;
	Wed, 17 Feb 2010 21:04:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C3E99AB8A; Wed, 17 Feb
 2010 21:04:31 -0500 (EST)
In-Reply-To: <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
 (Avery Pennarun's message of "Wed\, 17 Feb 2010 20\:51\:27 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAE649EC-1C31-11DF-8C6B-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140285>

Avery Pennarun <apenwarr@gmail.com> writes:

>> ++
>> +For any of the `$GIT_DIR/refs` cases above, packed refs from
>> +`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
>> +`refs/heads/master` in the packed-refs file would have the same
>> +precedence as the file `$GIT_DIR/refs/heads/master`).
>
> Are they really equal precedence?  How does git decide, when there's
> one of each?  I'd guess packed-refs might actually be strictly higher
> precedence, but I'm not sure.

This is not about "I have packed refs/heads/master and then a loose
refs/heads/master also exists" case.  After packing, update ref simply
creates a new loose ref, and we read loose ones and give precedence to it
over packed one.  This is so that you once gc and most of the unchanging
refs will stay in packed file, but some active branches can be quickly
flipped without having to rewrite the whole packed refs file (or removing
the ref from that file).

But the statement is not about that.  The statement is about this:

    "refs/tags/master" gets higher precedence over "refs/heads/master",
    and this order is indifferent to where these two refs come from,
    either packed refs or loose in the filesystem.
