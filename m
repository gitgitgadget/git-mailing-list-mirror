From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Fri, 18 Apr 2014 09:26:51 -0700
Message-ID: <xmqqlhv2d2no.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
	<xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
	<20140417221619.GA697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 18 18:27:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbBd9-0004Yn-95
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 18:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaDRQ1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 12:27:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaDRQ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 12:27:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FD2C78B44;
	Fri, 18 Apr 2014 12:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEXqHVmX+XMulqjw+dFvBpdUIjM=; b=Bn4fKP
	bou7i6RLzU9gC7KeIZQT+ORvvkTHJdp/3AFBgCGzNQmOyaJlsqSa9ShWIRIu1hyM
	X5OomQnLwIgWDvzgjNKBTPDBKCwvTlgA4lJVX3sc0eYG+pJbkotr9yDCbiNImSJu
	9o2zeZP6O2SuTEUET2l/pxAcbb21aOQs7Tj1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jqbNViqfrzTJz4eIjfNcx+SiT/Yv36oL
	A5muuxUzIdbbb6kKV2f5TY9p5BsFz+5v7gQLPLLnLqDGUkUrHgTRXRwG4KxxcWZ+
	5VTWotNunz0v3QIoPV5HQJz1prN26M2YHcn0DDoi1MtBe2OKn0bcsy8nWEvoOnJy
	ceuUSQZGUrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 367A378B43;
	Fri, 18 Apr 2014 12:26:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 716BF78B42;
	Fri, 18 Apr 2014 12:26:53 -0400 (EDT)
In-Reply-To: <20140417221619.GA697@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 17 Apr 2014 18:16:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 406ABE60-C716-11E3-8F26-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246473>

Jeff King <peff@peff.net> writes:

>  ---A---B---C-----D---E---F (maint, v3.4)
>      \   \       /
>       \   ---G-----H---I (master, v4.0)
>        \       /  /
>         ------J---
>
> The fix is J, and it got merged up to maint at D, and to master at H.
> v4.0 does not contain v3.4. What's the best description of J?
>
> By the rules above, we hit the third rule "pick the closest". Which
> means we choose v3.4 or v4.0 based solely on how many commits are
> between the topic's merge and the tag release. Which has nothing at all
> to do with the topic itself.

Even if J..F and J..I were of the same hop-count, there is no
fundamental reason to choose one over the other.

What is "best" at that point depends on what the user wants to see.

 - Luis's case that started this thread may want to favor v3.4 if
   only because that "sounds" the smaller, even though v3.4 and v4.0
   in the illustration cannot be compared.

 - I think the "closest" we have had is primarily a heuristic to
   favour the result that is textually shorter.

 - And as I alluded to, "which one has the earliest timestamp?", is
   another valid question to ask.

In other words, there is no single "correct" answer, once you have
multiple canidates that are all valid from topological point of
view.

> In this case we'd show v4.0 (because "J-H-I" is shorter than "J-D-E-F").
> But I suspect most users would want to know v3.4, because they want to
> know the "oldest" release they can move up to that contains the commit.
> But that notion of oldness is not conveyed by the graph above; it's only
> an artifact of the tag names.

Yes, exactly.
