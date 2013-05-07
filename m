From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t7900: Start testing usability of namespaced remote refs
Date: Tue, 07 May 2013 15:20:45 -0700
Message-ID: <7vppx2ig8y.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-3-git-send-email-johan@herland.net>
	<7va9o7pogo.fsf@alter.siamese.dyndns.org>
	<CALKQrgctyZGf2z+=+qjcW-s0uyVCqw01pv6X2NG+8yyC3FoTvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 08 00:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZqFh-0004Cd-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab3EGWUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:20:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3EGWUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:20:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6F21DAC2;
	Tue,  7 May 2013 22:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zbfpbM1j3frjneKNUYmZkDEBLkA=; b=mm3efw
	3aHKgW9eiHiiOlWvi29fDcADMm+39FX2sPOATKlX6jrNgwzcmmj/Coent0GzFNHZ
	OqCEdf0Tw+QLG7wYKKeobEp1DHKWl8hadWJ7Gg7IucurvJe0uClKZ16sffhPKBCr
	wCL2s+x+ceCsIYZtZHYsrriNLk1YPf3gj7CX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FlMwlsgVfSBVftE9GI+WOmSQzxPr9oZF
	zXcb+rXua9T3cwd810zIbrBKN/6Gh6fHCaAFgNpCLaLkdh6/AWjz4O13m0XJ2LFz
	OSZe082XmcY5/Okmgdg7s7iWnDUNjzHhpA2Fj4RPyVa6FkwwvBVYnjkYPhhl2fVY
	O/wEqx4bdhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C971DAC0;
	Tue,  7 May 2013 22:20:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F13A1DABD;
	Tue,  7 May 2013 22:20:47 +0000 (UTC)
In-Reply-To: <CALKQrgctyZGf2z+=+qjcW-s0uyVCqw01pv6X2NG+8yyC3FoTvQ@mail.gmail.com>
	(Johan Herland's message of "Tue, 7 May 2013 23:52:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DB5F722-B764-11E2-A659-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223624>

Johan Herland <johan@herland.net> writes:

> That said, I could have a go at using "refs/peers/*" instead of
> "refs/remotes/*", and see how that works out.

Hmm, I had "refs/track/" in mind.  Perhaps "peers" may work as well.

> If it sticks, how pervasive do we want this renaming to be? I guess we
> don't want to rename the "git remote" command to "git peer" just
> yet.

If we were to do this, I would expect that the transition would be
similar to the way we introduced the separate remote layout.  The
effort was started at around v1.3.0 era and we allowed the users to
choose the layout when they make a new clone for quite some time,
until we made it the default at v1.5.0 boundary, IIRC.  Let the user
opt into using the new layout first, and then if the new layout
turns out to be vastly more useful than the current one, then the
userbase will welcome it as the new default (and otherwise, it won't
become the new default).

We _should_ be able to tell the layout being used by checking which
of refs/peers/ or refs/remotes/ is populated, but I do not mind if
we added core.remoteLayout configuration variable that explicitly
tells us which, if such an explicit clue turns out necessary.
