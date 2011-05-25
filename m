From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 12:23:44 -0700
Message-ID: <7vzkma37pb.fsf@alter.siamese.dyndns.org>
References: <20110524210758.GH16052@localhost>
 <20110524224525.GI16052@localhost> <vpqfwo3ush3.fsf@bauges.imag.fr>
 <20110525150631.GA29161@localhost> <4DDD3A01.6040407@elegosoft.com>
 <20110525184514.GA20005@localhost> <7v4o4i4mte.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wilson <cwilson@vigilantsw.com>,
	Johannes Gilger <heipei@hackvalue.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:24:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJgg-0006PV-TU
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681Ab1EYTYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:24:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab1EYTYC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:24:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9126D59E0;
	Wed, 25 May 2011 15:26:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=li72MFQykuXNDbvDDtg7uoNoY7o=; b=D28e+R
	WdPwEsAyDGgeJGULIE3J6sZZXcdkbNlI8bBQHcIgZ67PkMZBx4BCyW5TPfyrxY47
	Vks67t/c1qdf4kN4jya+NJOAkAxO5dkqupZcKAPeSjYLXHqtNrWafCVl5GTsZzvP
	Xxx7n16dxStPGZnWfrdaayiWSQLfaKTceYkYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKDGIuZr5U81bxXpJLgIRVcgkgOp3DmU
	v4mWRz58h6uN8rw2dRW1thdzsWceyhcaiiX6jfprxUdU4JEBkZ0u/g5gza4TFjAl
	WljmI2GJD9fFJIDswpmUcC6eHOwY2uiW7ieE1nSece3oNd+DaM3zMG6ZyEjSEmO1
	0RyyPmSgKZ0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D61059DC;
	Wed, 25 May 2011 15:26:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17A2D59DA; Wed, 25 May 2011
 15:25:53 -0400 (EDT)
In-Reply-To: <7v4o4i4mte.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 25 May 2011 12:11:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4363836-8704-11E0-B54D-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174449>

Junio C Hamano <gitster@pobox.com> writes:

> The if statement says "we might be passing NULL in fmt and in that case
> please fall back to user_format" to human readers, but the compiler is too
> stupid to infer such an intention, so you have to help it with your brain.
> I have to wonder if the strbuf_expand() should be passing fmt instead of
> user_format.  "git blame -L1082,+7 pretty.c" points at 5b16360 (pretty:
> Initialize notes if %N is used, 2010-04-13).
>
> The only callsite that is introduced by that patch passes NULL to fmt, so
> a better fix might be to do something like this instead.

If somebody cares about the reusability of the code for other callsites
added in the future, we could do this instead.

I think this is what Johannes wanted to do from the beginning, and is a
better fix than my previous one to remove the fmt parameter altogether.

-- >8 --
Subject: userformat_find_requirements(): find requirement for the correct format

This function was introduced in 5b16360 (pretty: Initialize notes if %N is
used, 2010-04-13) to check what kind of information the "log --format=..."
user format string wants. The function can be passed a NULL instead of a
format string to ask it to check user_format variable kept by an earlier
call to save_user_format().

But it unconditionally checked user_format and not the string it was
given.  The only caller introduced by the change passes NULL, which
kept the bug unnoticed, until a new GCC noticed that there is an
assignment to fmt that is never used.

Noticed-by: Chris Wilson's compiler
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index dff5c8d..52174fd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1084,7 +1084,7 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 			return;
 		fmt = user_format;
 	}
-	strbuf_expand(&dummy, user_format, userformat_want_item, w);
+	strbuf_expand(&dummy, fmt, userformat_want_item, w);
 	strbuf_release(&dummy);
 }
 
