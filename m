From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: confirm on empty mail subjects
Date: Tue, 25 Aug 2009 10:35:08 -0700
Message-ID: <7veiqzpzjn.fsf@alter.siamese.dyndns.org>
References: <1249490994-23455-1-git-send-email-jengelh@medozas.de>
 <7vhbwlpigo.fsf@alter.siamese.dyndns.org>
 <alpine.LSU.2.00.0908241927300.5382@fbirervta.pbzchgretzou.qr>
 <7v1vn1gjlp.fsf@alter.siamese.dyndns.org>
 <alpine.LSU.2.00.0908251825150.21065@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfzvb-0007eW-0N
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 19:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbZHYRfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 13:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755448AbZHYRfQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 13:35:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351AbZHYRfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 13:35:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80ADE3528D;
	Tue, 25 Aug 2009 13:35:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZNix/62GIOlq0egAnpiPWA6osrY=; b=nqvByb
	DP+kM6cd/dh8hYhsCShQJr5Hon4myeQXyjVThAEQOuwe8kLOkVjrTe4XCLzr0tOb
	Ohg2F1IvrGOevBZ+sHjKwWsSGbonN4I2BBKYHuR7x9TpueqxglpnjudoT5Vjs3NM
	WnQNJcD5PZQ6lkRkkiR4+rKLJzGC3c6N/o3rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubI4hGsRlCcEzNJfZCQoG+DCUHihsSqA
	30VyEuCP6wEZV1VHp/tKvEzuSy4Tg8yRjKlAVvwKfkhiQQEeTgwMfXp1VX+lvmYR
	aJbYTmgYVz6PVOj8cD3nGSEZ8wKZcPhZqZQ2eLuYXEyWDS9BQo/8MvcSpzZzu3kM
	++LdzeT1bO8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6252E3528C;
	Tue, 25 Aug 2009 13:35:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3EA763528B; Tue, 25 Aug 2009
 13:35:09 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.00.0908251825150.21065@fbirervta.pbzchgretzou.qr>
 (Jan Engelhardt's message of "Tue\, 25 Aug 2009 18\:27\:48 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A51A4A6E-919D-11DE-9AAF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127032>

Jan Engelhardt <jengelh@medozas.de> writes:

>>Near the tip of the 'pu' branch I
>>have a iffy workaround to "unbreak" the issue, but it is a rather
>>sledgehammer approach I do not feel comfortable enough to squash into your
>>patch yet.
>
> I see. Perhaps
>
> 	echo -en 'y\ny\n' | ...
>
> would be more gentle? (Noting that, how else should it be,
> many a shell do not have -e/-n again.)

You can solve it with printf "y\ny\n", but the reason I said it feels
wrong was because your added tests are the _only_ ones that expect more
than one "yes".

If some _other_ tests that currently need only one "yes" are broken in the
future and starts asking for more than one, we would like to know about
the breakage, but we won't notice it if we unconditionally fed "yes | ..."
or your "two y's | ..." to them.  That is what I am unhappy about the
"iffy workaround".
