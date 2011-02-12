From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sat, 12 Feb 2011 00:17:16 -0800
Message-ID: <7vzkq1y8dv.fsf@alter.siamese.dyndns.org>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <7v8vxlzojs.fsf@alter.siamese.dyndns.org>
 <20110212080456.GA18380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoAfc-0002J1-1V
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab1BLIR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 03:17:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1BLIR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 03:17:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C8F227F7;
	Sat, 12 Feb 2011 03:18:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WV5p0ITgDYSQW0pVVhBuWHjUNxs=; b=fHdXSY
	gMN9y8RIuwp+SaTATMD7VBMAYWPZQ9JHcEufABFhq63DlN7jNSPSVbgOHIL+dwDL
	2TvnCneWJ9pRBhL+GxmW7m+6G0J086OlWErorTPp0w1aDpG7VQwJHJyhjgjW32f7
	zSrFPmso3v/hajyB7vAeyPz6nuErDiJ6A0Ptk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeA5FO0IUE97X4ZuuAr/A3Xm+gJ+2jg3
	e16BugxhaXbhp2+w8OUc1owINlklvW0Y3P9FVc6oK12FJy9R7JrN9FbN8m6nrDb4
	50IClbw2OVzmbN1BnpbyzvBI3Kb8xCSfMCGcmrV4rB95n+6IMHXm98SUuNWRsuYG
	fIrYA6Hd+ZY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CF5227F6;
	Sat, 12 Feb 2011 03:18:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F28727E7; Sat, 12 Feb 2011
 03:18:20 -0500 (EST)
In-Reply-To: <20110212080456.GA18380@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Feb 2011 03\:04\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9B60C64-3680-11E0-B9E3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166600>

Jeff King <peff@peff.net> writes:

> Is it that cheap? A full reachability check for something that is not in
> any ref would involve going to the roots, wouldn't it?

You only need to dig until you hit a merge base, no?

In this case, you would need to compute just one merge base, between the
commit you are about to leave, and the (imaginary) commit that is a merge
across all the tips of your refs.  If the merge base is the commit you are
about to leave, you were sightseeing in the past without creating anything
new, otherwise you will lose commits between the computed base and the
commit you are about to leave.

And merge-base has an interface to compute exactly that, I think.
