From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Fri, 29 Apr 2011 16:00:11 -0700
Message-ID: <7vk4ecvf2c.fsf@alter.siamese.dyndns.org>
References: <ipek0o$l0v$1@dough.gmane.org>
 <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
 <20110429224829.GC3434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Csaba Henk <csaba@lowlife.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwfp-00056l-P0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 01:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934103Ab1D2XAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 19:00:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934101Ab1D2XAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 19:00:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 635F15648;
	Fri, 29 Apr 2011 19:02:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NiG0wpjSZS5KarW8NzZtoZ/i/3w=; b=Y/P2tb
	Kiu4jHRgl3KUHRsZZmLgAgDNkVaLkzOyhT8Qt+aipY1PNcKM6DJAM07q2hxr4Kqk
	70qImmLT3yIPEWNIDKQ/G083xiG0thNdOP8TkbbNsZLEFt4zlz7sik5o22JotrOV
	QY6Njx1u8BqAi78QjRrBVauwSPecE3xTFIsJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1hXmeFMiYkMYHZdPyjka+akRhSLE5lK
	pJMtwgpG8GcgNhMeckjdqz7mmrX5Za/XJqRd/2vUhSrsgR7F5itqs351uRcZVuEa
	enjIYuGqG3Yatk3BHz3oM9ov62QryySrAa1SvHMt2RKxbbp9UKmKnk58tEYxXUAA
	WR6TiMbAsWg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 305EC5645;
	Fri, 29 Apr 2011 19:02:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE067563F; Fri, 29 Apr 2011
 19:02:14 -0400 (EDT)
In-Reply-To: <20110429224829.GC3434@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Apr 2011 18:48:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBBC0772-72B4-11E0-AC4F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172510>

Jeff King <peff@peff.net> writes:

> I think every caller should be using "-m" these days.  I know we can't
> _require_ it for historical reasons. But shouldn't symbolic-ref always
> write a reflog entry? Even something like "we changed and I can't tell
> you why" to cover older scripts that call symbolic-ref?

I think the particular instance Csaba saw in rebase may want to pass the
reason why it flipped the HEAD.

Flipping HEAD temporarily to another ref to do something, only to flip it
back before giving the control back to the user, might be something a
script may want to have a choice of not logging, so I am mildly negative
on changing the command to unconditionally log empty entry without being
told.

"update-ref" seems to write an empty entry even when not given an "-m"
option, and we can view it as robbing a similar choice from the scripts.
We might want to fix it.  I dunno.
