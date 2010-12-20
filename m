From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sun, 19 Dec 2010 18:41:22 -0800
Message-ID: <7vd3oxdv3h.fsf@alter.siamese.dyndns.org>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru> <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru> <20101218161337.GB18643@sigill.intra.peff.net> <20101218205514.GA21249@landau.phys.spbu.ru> <7vk4j6fnta.fsf@alter.siamese.dyndns.org> <20101219121059.GA10985@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Dec 20 03:41:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUVh5-0006C8-3Y
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 03:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab0LTClm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 21:41:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab0LTCll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 21:41:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65355486A;
	Sun, 19 Dec 2010 21:42:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jvDZyyK1XO0vbIiWr/KfeWK0n8U=; b=StoEub
	umdw5WeZGszTYcIR16iySD5pJX58jUnxe0IUmleONlSExNB9OzPesgOhh2Fy//FW
	4tt0zNR8a+f8Eyz4VjyBsuVy4/CCoFDY9UOL2C2wIxwG0sTGd5nwzlyYmLbvzzW/
	PQDIxJ4ST/B6fDKxRuLFkI4mB4AArioB7V04U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXPrCVq+2hK4OxkXcTso9jLUiqgwVTlE
	zUiWXcXfiIaEHS9Ak7GaWw0/512NBAACi1O6UIW+EpdraUte+LtXFPwbZyw7tbv9
	nNl4lVBpTFsEQvgtVfUJmlKOUiWQQvgzq5Yx/YjzORiFVclzNF2pViF91CTjMAo3
	jQfM5YxpYOo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0211C4866;
	Sun, 19 Dec 2010 21:42:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C68AF485F; Sun, 19 Dec 2010
 21:41:52 -0500 (EST)
In-Reply-To: <20101219121059.GA10985@landau.phys.spbu.ru> (Kirill Smelkov's
 message of "Sun\, 19 Dec 2010 15\:10\:59 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9412984-0BE2-11E0-89B2-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163978>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> On Sat, Dec 18, 2010 at 07:23:29PM -0800, Junio C Hamano wrote:
>> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>> 
>> > Thanks for your ACK and for the explanation.
>> >
>> > My last patches to git were blame related so semi-intuitively I knew
>> > that invalid sha1 are coming from files in worktree. Your description
>> > makes things much more clear and I'd put it into patch log as well.
>> > What is the best practice for this? For me to re-roll, or for Junio to
>> > merge texts?
>> 
>> Re-rolling to explain changes in your own words is preferred; thanks.
>
> I see, thanks.
>
> I'm not that familiar with git internals involved, so here is updated
> patch with added paragraph about "df->sha1_valid=0 means files from
> worktree with unknown sha1", and appropriate excerpt from Jeff's post.
> That's the most reasonable I could come up with.
>
> Thanks,
> Kirill
>
> P.S. please don't forget to pick patch 1 which is unchanged.

Here is how I would describe it.

commit 87bb04bb760659dd33d7a173333329cd900620a9
Author: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Date:   Sat Dec 18 17:54:12 2010 +0300

    fill_textconv(): Don't get/put cache if sha1 is not valid
    
    When blaming files in the working tree, the filespec is marked with
    !sha1_valid, as we have not given the contents an object name yet.  The
    function to cache textconv results (keyed on the object name), however,
    didn't check this condition, and ended up on storing the cached result
    under a random object name.
    
    Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
