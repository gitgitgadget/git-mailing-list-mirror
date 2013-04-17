From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 22:26:40 -0700
Message-ID: <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 17 07:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKtO-0000AS-2I
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 07:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564Ab3DQF0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 01:26:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab3DQF0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 01:26:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21946EBF8;
	Wed, 17 Apr 2013 05:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qjMKSLpLp9EI
	kVFu6hNZuBhW4uo=; b=RdrT1kXuuw+cj2oruVFOc1JWGGxk7E8LLtils3jDJnPp
	qpTGhN5rr8ME8g6K5flhNXYulso/hYjZdrb1XisscfjknAWlT2cFirBuM6avBMQU
	4SimyYqMH8ve7a6AbIfUkbesj9MfSobaCZsAYzQzIcZShE15yZ2717wc2xqqQuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f8Q5u5
	2JXSq9nnlQO38hKm42UGNMx9NMI2TLZyl8RguGa9uyXBr3y7kBco/h7ur71tPmBc
	NM7ORZZqyM2lNYoRI3N6dxxNzYTTst5FktCVjwtajf/QcXSQs0LO7cBOWkBlBqim
	QsMSNLbuyZOZBJHBfCo3J4aO1KJTdvys67keQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14676EBF7;
	Wed, 17 Apr 2013 05:26:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 588F0EBF4; Wed, 17 Apr 2013
 05:26:42 +0000 (UTC)
In-Reply-To: <7vzjwyi0ba.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 16 Apr 2013 15:21:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63251120-A71F-11E2-A7C8-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221509>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> How about making split_ident_line() a bit friendlier be letting it
>> provide the epoch as default time stamp instead of NULL? =20
>
> Two knee-jerk concerns I have without going back to the callers:
>
>  * Would that "0" ever be given to the approxidate parser, which
>    rejects ancient dates in numbers-since-epoch format without @
>    prefix?
>
>  * Does any existing caller use the NULL as a sign to see the input
>    was without date and act on that information?

I looked at all the callers (there aren't that many), and none of
them did "Do this on a person-only ident, and do that on an ident
with timestamp".  So for the callers that ignore timestamp, your
patch will be a no-op, and for others that assume there is a
timestamp, it will turn a crash/segv into output with funny
timestamp.

So I think the patch is a right thing to do (we would need in-code
comment to warn new callers about the semantics, though).

Thanks.
