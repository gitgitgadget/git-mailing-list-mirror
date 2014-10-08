From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/16] make prune mtime-checking more careful
Date: Wed, 08 Oct 2014 10:03:21 -0700
Message-ID: <xmqq38aycx46.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
	<20141006014249.GA11495@peff.net> <20141008083109.GA3767@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 19:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbueH-0001HO-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 19:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaJHRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 13:03:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58341 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750875AbaJHRDY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 13:03:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CFB314458;
	Wed,  8 Oct 2014 13:03:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cEwpHzwoc/gDr8uv9G02lLger0Y=; b=wtokLL
	TtG2173yUPU1qsVG2DktZxQXJX+3fKgzyUbqJtqu+sQVO4aMy1oXKkg3eywk4uHj
	XO0MRXTSQD3aCXLvhoenYqidpOlC8WiSRFXkttZsXKROyXz11bG8mybYjqG74dlK
	QslSQl8tCU77yRyqmleyuhwBc+8cSQ60CJRs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qKj++C9XRrywvm8eZVRDgip3HNFZzwJF
	nc0IZmi42BgwGL/5QMSwJPNMzwvb20tFnBPlk/d+KVwBa3VuxgzCh0fG+iPHQTVk
	NS5eMSC73P1amLKwJUnXIpoQ9rEFnOoMGb0mhv+ToIPCdBE8NbbUZ7awCKQ8YqcN
	I4B3tv2AhZA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0398B14457;
	Wed,  8 Oct 2014 13:03:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7662714452;
	Wed,  8 Oct 2014 13:03:22 -0400 (EDT)
In-Reply-To: <20141008083109.GA3767@peff.net> (Jeff King's message of "Wed, 8
	Oct 2014 04:31:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 029CEE9E-4F0D-11E4-A13E-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So that explains that bug (as a side note, you might think that if we
> are flipping return values, lots of things would fail when they ask "do
> we have this packed object" and it erroneously says "yes". But that does
> not happen. The wrong return value comes from freshening the file, so we
> only flip "yes" to "no", and never the opposite).
> ...
> When dt/cache-tree-repair is merged, we have a valid cache tree when we
> run "git commit", and we realize that we do not need to write out the
> tree object at all. Thus we never hit the buggy code, the object isn't
> created, and the subsequent prune reports that there is nothing to
> prune.

Wow, that is a tricky "bug" (rather the series with the bug failed
to fail when applied to 'master', so it is an "unbug" that hides a
bug) to hunt down.  Thanks for digging.
