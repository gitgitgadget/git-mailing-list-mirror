From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] rename detection: allow more renames
Date: Mon, 30 Nov 2015 10:25:18 -0800
Message-ID: <xmqqegf78hv5.fsf@gitster.mtv.corp.google.com>
References: <20151113163506.GD16219@inner.h.apk.li>
	<20151124233328.GA13872@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:25:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3T8f-0004oh-IB
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 19:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbbK3SZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 13:25:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751909AbbK3SZU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 13:25:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D34C2FDD6;
	Mon, 30 Nov 2015 13:25:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3FDu+Hgqe+5grABNhhElPe3vPUI=; b=J/lW0E
	fvkOfwDQql7X8VYbh3XEs2dhVZShHg7a4J9l1OWbE1Qnx2h+3DjA6f0DpIHoNat2
	d3glo6auw7fVZcNaVlkPFtggxGiroypHTM5YURQEbFmSse3ZND4a5NfFYZn1Vb1J
	SGYWxkuFevY6xVtCL2vq4jnNr0o/9wfz1g8Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HIu1K2vqPY4afCDwAzz4DlQrhs13UOZy
	4ia1E+gtoWeGo1D6qLDedEGOCCJzvwJGlPQjXpzOvvlR9htWVlcQ1JDKwH8U7G7z
	DPv2RHV1c5cqxB8th9TpezrZf1IXk4kIXlgBtfKQf5+T2pTuyPRnaaLSdh69tkU/
	VhTJ2W/L4I8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A21D2FDD5;
	Mon, 30 Nov 2015 13:25:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 83EFC2FDD3;
	Mon, 30 Nov 2015 13:25:19 -0500 (EST)
In-Reply-To: <20151124233328.GA13872@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Nov 2015 18:33:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6138930-978F-11E5-ACFE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281807>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 13, 2015 at 05:35:06PM +0100, Andreas Krey wrote:
>
>> The code talks about limiting the size
>> of the rename matrix, but as far as I
>> can see, the matrix itself never exists
>> as such, and the only thing that could
>> actually overflow is the computation
>> for the progress indication. This
>> can be fixed by reporting just the
>> destinations checked instead of the
>> combinations, since we only update
>> the progress once per destination
>> anyway.
>
> I didn't dig in the archive, but I think we discussed the "just show
> progress for destinations" before. The problem you run into is that the
> items aren't a good indication of the amount of work. You really are
> doing n*m work, so if you just count "m", it can be very misleading if
> "n" is high (and vice versa).

Right.

With s/never exists/no longer exists/ in the above observation, I
agree that this topic is sensible that it revisits the stale comment
from days back when we did use the matrix.
