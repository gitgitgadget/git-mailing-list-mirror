From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as an
 escape character
Date: Wed, 07 Jul 2010 17:29:29 -0700
Message-ID: <7v7hl6stna.fsf@alter.siamese.dyndns.org>
References: <20100706225522.GA31048@genesis.frugalware.org>
 <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 02:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWezn-0003GT-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 02:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab0GHA3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 20:29:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0GHA3i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 20:29:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7204C2727;
	Wed,  7 Jul 2010 20:29:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qH9bFc4S96SX
	n5yTfhdvU7Rf3gc=; b=nnYGQTKOp4A/T8rQ+xMNdk07PVa2NEUWzWM/1TOe7M1j
	fp3i1lm1ExDkIvDFf2eNGcPjfF+mhvacgMinHm0sz7v2QmI6Fk0auRkTTh/MGrK2
	6n4tjEDjKgzJQMwbUmWoly05g/dihnsgXaaGvYqUxdUHx04jCsEb7o1cWiCA1Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rCChHO
	c7A05RJTsA72I4WZga87/4YI9ZlgISoSxYGOBOzITqZSCQG1xpYJhqIg+VNj1T7U
	mX08Q8p2dYL5P1ONw9x5xjKotAnCpSArUNqxKFz2HAqC2tdWQYZTr7Crhl890WVe
	OllgTsdrggRnGTduBCXPQe9vjtQ2jYverkGU4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8395DC2726;
	Wed,  7 Jul 2010 20:29:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4960C2725; Wed,  7 Jul
 2010 20:29:30 -0400 (EDT)
In-Reply-To: <20100707094620.GC31048@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed\, 7 Jul 2010 11\:46\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E20A09CC-8A27-11DF-BAE0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150519>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Wed, Jul 07, 2010 at 11:22:29AM +0200, Santi B=C3=A9jar <santi@ago=
lina.net> wrote:
>> No. This one:
>>=20
>> http://article.gmane.org/gmane.comp.version-control.git/150328
>>=20
>> :-)
>
> Heh, then sorry for the noise. I noticed the problem on 2th, added th=
e
> "I should fix this" to my TODO, then made the patch yesterday. I forg=
ot
> to check the list archive again before sending the patch. ;-)

Thanks anyway.  It may have been a bit of duplicated effort, but served=
 as
a sanity check as well.

Our patches do seem to fix the reading side of the issue, but I am not
sure if the writing side needs further fix.  If I recall, the script ha=
d
liberal use of "echo $var"; some implementations of echo interprets
backslash sequence without being asked with an explicit "-e".
