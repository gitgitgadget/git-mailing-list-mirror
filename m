From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Mon, 13 May 2013 08:45:21 -0700
Message-ID: <7vd2suopda.fsf@alter.siamese.dyndns.org>
References: <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
	<20130511214900.GF2299@serenity.lan>
	<CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
	<7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
	<20130512085934.GG2299@serenity.lan>
	<7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
	<20130513075906.GP2299@serenity.lan>
	<7vzjvzoujq.fsf@alter.siamese.dyndns.org>
	<20130513140243.GQ2299@serenity.lan>
	<7v38tros3y.fsf@alter.siamese.dyndns.org>
	<20130513145948.GR2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 13 17:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuwL-0004VH-0o
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab3EMPpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab3EMPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03F961E6BB;
	Mon, 13 May 2013 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GOUykwJTHLKmk2nDoLOVKb3KWBs=; b=g1Wc9I
	bQbAYPPuLAxnpMIn1GMnda/zO16I8ff8kBkyhBTeBOwgr69EQP3hgWYYyXX2EOjF
	faJUgneSiL15qJTsvsgvgoKmvXIY/BF03+0ay4m8zCfW38x0u+qy3eNjfB5LcEHI
	FfO83/kOX3QePlFK0DpFWWuerWA4gqcFknpx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DwPyyi2+2lmuU9P8Eqo9OQQDJwo5ahMr
	y6ldHys0W7Hkdt6Pt2AEazWFgWXwG+cWVUposv2au0e7CENhhCmsg+T3wvVs03jg
	wT5xRU8KfoY1Qq6BSKcreJ/i/2wyH5oCkz5rb70E6AddlWLnnBOO2clhZTLfG4yA
	TYW2NF1HURs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA8F01E6BA;
	Mon, 13 May 2013 15:45:23 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 703F51E6B9;
	Mon, 13 May 2013 15:45:23 +0000 (UTC)
In-Reply-To: <20130513145948.GR2299@serenity.lan> (John Keeping's message of
	"Mon, 13 May 2013 15:59:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC83720-BBE4-11E2-B185-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224173>

John Keeping <john@keeping.me.uk> writes:

> This has the advantage that you get the benefit of the cache if you run
> "git log --cherry-mark" with the same paths more than once.  In my
> testing the cache is beneficial as soon as you examine more than one
> similar range (e.g. master...feature-A and then master...feature-B).

OK, so perhaps the notes that are keyed with commit ID will record
multiple entries, one for each invocation pattern (i.e. all pathspec
given, possibly with nonstandard options)?

"git diff -- t Documentation" and "git diff -- Docu\* t", even
though they use different pathspec, would produce the same diff;
instead of pathspec you may need to key with the actual list of
paths in the patch, though.
