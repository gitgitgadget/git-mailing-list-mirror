From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] convert: fix normalization of foreign idents
Date: Sun, 12 Sep 2010 14:44:59 -0700
Message-ID: <7vd3sid4bo.fsf@alter.siamese.dyndns.org>
References: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
 <E1Ot4NP-0002xn-Nc@chiyo.mc.pp.se> <7vmxrqjvf6.fsf@alter.siamese.dyndns.org>
 <yf9hbhuisla.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Sun Sep 12 23:45:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuuMP-0002NS-Go
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 23:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab0ILVpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 17:45:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab0ILVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 17:45:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3BDD57AF;
	Sun, 12 Sep 2010 17:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pqrUTU1YA1TXfUkLXJyoZ4DdPo8=; b=fPXySV
	MtgiRPSwsjwP95KBtpA3eCh/ZQEPX7XiX2NNyYr3kDo57OCbS2ENbPfetRSltKBT
	zqjBpqGuue41vkdk2HZAWdvehxj1GtPq9Vg8u1S8J1R9WcgbT0rtu5vtCkXjeBez
	ZZg/18I/v0YOOONavl+FfOi4O+Kcilitch1ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qE8hxdk4l0uDXpG9+zxzs/I4idcqg2qL
	izBgnn5gSeUDNLX1P4yO5ueLon4Tk8NrKAZMINzTtaSBj7Ecfz4+tZUzKHNuWqCg
	s5ezMg5tTnqcitOh9NfRzD+s5DLeSVrYvJwZRsdq0oJuuirbMfbERMRV52xwQ/PM
	K9nuiqsKUPc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E91D2D57AA;
	Sun, 12 Sep 2010 17:45:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D64DD57A8; Sun, 12 Sep
 2010 17:45:01 -0400 (EDT)
In-Reply-To: <yf9hbhuisla.fsf@chiyo.mc.pp.se> (Marcus Comstedt's message of
 "Sun\, 12 Sep 2010 23\:01\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 006434F6-BEB7-11DF-B389-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156059>

Marcus Comstedt <marcus@mc.pp.se> writes:

>> It also smells wrong that this "sometimes we convert, sometimes we don't"
>> is a special case for "$Id$" and for no other conversion.  Why don't
>> smudge/clean filter or CRLF conversion have the same issue that can be
>> solved with the same approach as this patch takes?
>
> I gather that this is because nobody has come up with a use case
> for smudge/clean or CRLF where a (pervasive) non-normalized
> representation in the repository makes sense.

Think a bit more about what you just wrote means.

Imagine there isn't any "$Id$" (or "$ident$" as it was originally known)
expansion in git.  You can implement it easily using a smudge/clean pair,
and the smudge and clean should be conditionally applied in the codepath
you touched using exactly the same logic as your patch uses, no?

That is what I meant.  It smells wrong to make this "sometime we do,
sometimes we don't" as a special case for "$Id$".  Specifically, the
parameter name "normalize_foreign_ident" feels wrong; the concept that the
parameter tries to convey covers much wider than just "foreign ident", no?
