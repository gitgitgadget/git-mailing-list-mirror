From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 04 Apr 2013 14:19:19 -0700
Message-ID: <7vip42gfjc.fsf@alter.siamese.dyndns.org>
References: <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
 <20130307180157.GA6604@sigill.intra.peff.net>
 <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
 <20130307185046.GA11622@sigill.intra.peff.net>
 <20130404203344.GA25330@sigill.intra.peff.net>
 <20130404204944.GB4913@pengutronix.de>
 <20130404205423.GA25986@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>, kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrZX-000552-M3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764222Ab3DDVTW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 17:19:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764180Ab3DDVTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 17:19:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB5713072;
	Thu,  4 Apr 2013 21:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=alBopGAXHc47
	JypXaQ6mDMP0BtY=; b=c7FNS13VWJNavhcsHzV6C/SHGPlPuMeuws3LuvaAYiHv
	McL+rTfPoscW6fDO0NUPMtahlWwHe9WZm0zIQ7kLaCn5cg0uHwQHyRd5dChDWdbh
	/WbV0Cu00NM+asFLUUK/nTpa7EoIsPxi68M5C5gFeyZ8bv1p5nmNj3JEYW/yw4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XmhiNn
	/V4mU7FZzsArlB+xuHCFtYvJP8PRBTHIxak9DY56315AFEO/+V21olzbPejmrXdw
	IatdoMUNEnGHN9a/uCl8fIqmVJsk7kHp/7U787p1GP+A/k9xlYX/zmPWt6JIQ2sC
	iAKzUOUIjt3VT8Yg0hqtNCZT+ENsM5l1DseZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9244A13070;
	Thu,  4 Apr 2013 21:19:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E916A1306E; Thu,  4 Apr
 2013 21:19:20 +0000 (UTC)
In-Reply-To: <20130404205423.GA25986@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 16:54:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50F33768-9D6D-11E2-A3B5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220108>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 04, 2013 at 10:49:44PM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
>
>> On Thu, Apr 04, 2013 at 04:33:44PM -0400, Jeff King wrote:
>> > [...]
>> > So I do think zdiff3 is useful, and I plan to continue using it.
>> Thanks for your description. I'm using and liking zdiff3, too. So I'=
d
>> really like seeing it in vanilla git.
>
> I don't know if Junio is interested in taking a patch with the concep=
t
> or not,...

In two messages upthread before you restarted this discussion, I
said:

    As long as we clearly present the users what the option does and
    what its implications are, it is not bad to have such an option,
    I think.

> but as I recall, your patch needed at least a documentation update
> before it could be picked up. Unless Junio wants to say "no, I am
> not interested at all", I think the next step would be to repost
> an updated version.

Yup.
