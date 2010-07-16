From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] blame: Odd -L 1,+0 behavior
Date: Fri, 16 Jul 2010 14:11:34 -0700
Message-ID: <7vy6dbqghl.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-6nck9aVKPTwOy_PmrGUs1iS8ruqzIORbf8jb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 23:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZsCD-0002aK-4g
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 23:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113Ab0GPVLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 17:11:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab0GPVLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 17:11:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9A1C5ACB;
	Fri, 16 Jul 2010 17:11:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=inLFlyFn1gIU
	8lkOFzeGorVVq9c=; b=xTdav/3B+0kCsiVv097U6cTj9NeG+2+3m7eJGpibs10a
	wsbOEsoMPMjN52oRf4x7MgJWf6vuB7z+sqi76cIi+2cnGgfCXPjyzK0wN9Qxg/8x
	LMpm9aClYwrGSBEPs0Z7adsrH/RVyq1IFyX+vMoisF49THyREO67UMka9pR/2Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i5Lm0R
	IUaUsIS2+Dz1shIKVtmNKYePLeqmZCDCA0NpEzst2MCgbD16IjOOz9edmcCmXyJ3
	kHxQSM+SX730TTQPD4BBxLXMYoDI9OwO8SpbO/BRf6y6X4V3El4q3Y1TVHFAdqN8
	9cRSrm1yZ/4kmyZ3hYQII4f5aW55al5GnxoWQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B2FC5ACA;
	Fri, 16 Jul 2010 17:11:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB855C5AC8; Fri, 16 Jul
 2010 17:11:35 -0400 (EDT)
In-Reply-To: <AANLkTin-6nck9aVKPTwOy_PmrGUs1iS8ruqzIORbf8jb@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 16 Jul
 2010 15\:50\:52 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9A1B5B8-911E-11DF-8BB1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151173>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ok, +/- are zero-indexed:
>
>     $ git blame -L 1,+2 cow

I don't know what "zero-indexed" means, but +2 means "starting from the
line I told you earlier, give me two lines".  Likewise -2 means "ending=
 at
the line I told you earlier, give me two lines".  As a side effect of t=
he
internal implementation of this logic -L 5,3 means the same thing as -L=
 3,5
but that is not an intended nor documented behaviour.

> Shouldn't this either print nothing, er be an error:
(multiple)

The parsing code is lax in the sense that rejecting nonsensical input l=
ike
"-L 10,-100" and "-L 2,+0" as an error was not considered a primary goa=
l.
The only error checking it does is to make sure it does not parse numbe=
rs
that it cannot use (i.e. start from line 30 in a file that does not hav=
e
that many lines).
