From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 09:55:14 -0700
Message-ID: <xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
	<20140530015855.GG28683@sigill.intra.peff.net>
	<CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
	<20140530065737.GA13591@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 18:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQ5Y-0000Vv-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 18:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933645AbaE3QzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 12:55:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61368 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbaE3QzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 12:55:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D7211BC2B;
	Fri, 30 May 2014 12:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55D4WD2ujHTP+F9kmOmD1+wYpys=; b=fwH9P6
	uCmtbok2AOT1ih3uvPg2npfdGQw91eOCMiy0Bhdgch3g7MSTfXEcdzvwDgF/Dv9S
	QJfYlmShTQgcxHvJQjpyvHdy39oRl+tSh5X1Eaz7OQj1XfI++RHK85MGRcJetBUl
	PQ6xuWsTrZqUnW8peJGRYW9vmXm9+U7DezD+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o+ZLbH5hyyp/9oDeLxuxUKuQXrQ7v3pK
	06oEGEOASBdEWX3lRU0pEgKr5TYSyXiQ5kCdmscIw/1AcDliqaYuhmOQNnhTpBad
	axeIFUudIyKN/kUgtLRuvAKU6lt//WOD3PWW8deRFKpcLg2MzTVsOke3J3xuIEB+
	3P8GWV0LM2g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 247301BC2A;
	Fri, 30 May 2014 12:55:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D8451BC27;
	Fri, 30 May 2014 12:55:20 -0400 (EDT)
In-Reply-To: <20140530065737.GA13591@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 02:57:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F42BDA6-E81B-11E3-B8BE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250444>

Jeff King <peff@peff.net> writes:

> On Thu, May 29, 2014 at 09:54:10PM -0700, Linus Torvalds wrote:
>
>> That said, part of it is just that show-signature is so suboptimal
>> performance-wise, re-parsing the commit buffer for each commit when
>> "show_signature" is set. That's just crazy, we've already parsed the
>> commit text, we already *could* know if it has a signature or not, and
>> skip it if it doesn't. That would require one of the flag bits in the
>> object, though, or something, so it's probably not worth doing.
>
> Wow, it's really quite bad. Not only do we spend time on commits that we
> could otherwise know do not have signatures, but we actually pull the
> buffer from disk, even though we generally have it saved as
> commit->buffer.

The one for the signature on the commit itself is me being lazy and
defensive; I did not want to have to worry about people mucking with
what is in commit->buffer for whatever reason (e.g. re-encode in
different charset, etc.) and then asking the signature validated.

The other one for the merge-tag is me just being lazy, as it is
unlikely to be corrupt by any reasonable kinds of mucking with
commit->buffer on a merge.
