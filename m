From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Mon, 08 Apr 2013 21:37:18 -0700
Message-ID: <7vobdotj41.fsf@alter.siamese.dyndns.org>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <20130409035126.GA17319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 06:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPQJJ-0000QL-4o
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 06:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933540Ab3DIEhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 00:37:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab3DIEhV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 00:37:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41717E13E;
	Tue,  9 Apr 2013 04:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wixw+O2mRZQDtaZZ4OHfdsh67iQ=; b=n9iRXm
	H6BOUyupZkANSN3uMA91BGANu2M4oudM657b0NlZMWf84dRV5hPkWppQHlYJZKRF
	xWckZ8u8FwqSgwoNRVJ0uq82KsXHGrCjfgIj0fqD0X3v9p2x5sTXbzLSqy6vBuod
	eb+9zAw/eAuHyPcA8TixZe2XL3lArKrT+Noms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TBY2i7niKDnohAqb46fPxdbpFLpOVAJZ
	Vzkk0WsKzEQ+On+fZQLZsRvmOyMdvDTnO+mdVhKPazOgOp7lprvrkRlgur/217J2
	qrAoUCSoHv0TCf+i7dNIbqFzP1GROVXZepeOfPfyj2Vw2yLKCoAsrADRIgCx3XrH
	fyRKTEMkZe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34E66E13D;
	Tue,  9 Apr 2013 04:37:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86053E135; Tue,  9 Apr 2013
 04:37:20 +0000 (UTC)
In-Reply-To: <20130409035126.GA17319@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 8 Apr 2013 23:51:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A75CA3C-A0CF-11E2-8008-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220548>

Jeff King <peff@peff.net> writes:

> Neat. Reading through, I didn't notice anything obviously wrong with any
> of the patches (though there is one gcc warning, which I'll respond to
> separately).
>
> It does make me a little nervous to have code that almost never gets
> exercised (i.e., when indegree is really high, or a large number of
> encodings). It seems like a bug waiting to happen when somebody does hit
> that condition.

One round of work-in-progress code I had when you asked what I was
up to did have that off-by-one bug ;-)  set_indegree() had to spill
into the hash when storing 255 (i.e. exactly the value of LIMIT) but
I was spilling strting from 256, so an entry with 255 children looked
into the hash, finding nothing and said "I am done" X-<.

I haven't bothered to try the "more than 256 encodings", but with
the likely off-by-one in mind, I think I was being careful enough.
