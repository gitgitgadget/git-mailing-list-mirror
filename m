From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Fri, 19 Sep 2014 10:29:12 -0700
Message-ID: <xmqq4mw3o6xj.fsf@gitster.dls.corp.google.com>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
	<20140919093910.GA15891@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 19:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1zl-0000xp-2i
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562AbaISR3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 13:29:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56411 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757413AbaISR3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:29:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C19893A4FB;
	Fri, 19 Sep 2014 13:29:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vkiej6QViqOsK74oUhV7/tvTcYI=; b=GKWBUb
	WyDbCvBPP7hZejNiyY2FqczaOCQ7hY8/wlI2DIqEekue7cJaIdt8V2HeFVwuoATR
	whDOlJj6tsJBq54wOZ4IH9JqWMXzDVFy+U1W9fqI27qjTAklx0ZzgQdDn/VcPXkQ
	pt+7v8J4Q8UAzvbEbKjuZBYzNBX9olphYi9uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdLbN3dJ3g4Nv7kurQArxR9sgShFGD01
	h8gMa3Mt41yxe+Zf3GxL0URA5TPcyaGiBye+zGE3nZm4rwq7/yY9CsEL0YL5+d0I
	RRtR+ndvv/gjMCWYIsbWpWu8s9ln9PCXllqD4ock77OQIm1UaeNSQ0cZbXyRL/G4
	iKDmMNdzdpU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 767AF3A4F7;
	Fri, 19 Sep 2014 13:29:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E42163A4F6;
	Fri, 19 Sep 2014 13:29:14 -0400 (EDT)
In-Reply-To: <20140919093910.GA15891@peff.net> (Jeff King's message of "Fri,
	19 Sep 2014 05:39:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A18C1CC-4022-11E4-902E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257299>

Jeff King <peff@peff.net> writes:

> I think this change affects not just "git notes merge", but all of the
> notes lookups (including just "git notes show"). However, I'd argue
> that's a good thing, as it allows more flexibility in note storage. The
> downside is that if you have a notes ref like
> "refs/notes/refs/heads/master", you can no longer refer to it as
> "refs/heads/master" (you have to use the fully qualified name to get the
> note). But:
>
>   1. This makes the notes resolution a lot more like regular ref
>      resolution (i.e., we now allow fully qualified refs, and you can
>      store remote notes outside of refs/notes if you want to).
>
>   2. There are already a bunch of names that have the same problem. You
>      cannot refer to "refs/notes/notes/foo" as "notes/foo", nor
>      "refs/notes/refs/notes/foo" as "refs/notes/foo". Yes, these are
>      silly names, so is the example above.
>
> So it's backwards incompatible with the current behavior, but I think in
> a good way.

Yup, I agree with the analysis.

>> ---
>>  notes.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I think you need to adjust t3308 (and you should probably add a new test
> exercising your case; this is exactly the sort of thing that it's easy
> to accidentally regress later).
>
> -Peff
