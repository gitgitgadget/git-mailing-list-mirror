From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Mon, 12 Aug 2013 00:00:11 -0700
Message-ID: <7viozbz950.fsf@alter.siamese.dyndns.org>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
	<CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
	<20130811180915.390d660a@sh9>
	<CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
	<7vr4dz1n6c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8m78-0006AZ-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055Ab3HLHAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:00:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab3HLHAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:00:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15875342F9;
	Mon, 12 Aug 2013 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJPCRN89AerDrdRC3w0/yyGdRjY=; b=Z68grc
	SvQDtsSs8EDCnz1cMfL4YoJrMbvy9iyVgJbtOL5lY1srJ0jwmGJGf43xNry2MPcz
	qDRZcyUlVy/cX/ScUkrbeNwUsNY2zV3bxdjcJ9AK5ItTeD7PHp3opVM1cx2OZ6Iw
	fj4ka/XeQLqzqZ0a1IVnWQNzmZU8OoUZyXeqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KTHGFP24ENYK+q2Su2Gag13uyEwA3s4/
	3tDksTaevYelZdHrrapE3qLwN1IUladP/M68WSpROxOheZh/XLNcfH8q24iWW+CY
	znrfzrlnAXcXRSdKAiSm4OF3o/7PtVLuNFTy7/cmb7TK/PK9HssPqrSLz/cuwLSS
	5ErDVN17o0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05DB4342F8;
	Mon, 12 Aug 2013 07:00:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE55D342F0;
	Mon, 12 Aug 2013 07:00:12 +0000 (UTC)
In-Reply-To: <7vr4dz1n6c.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 11 Aug 2013 22:40:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D59F3EFC-031C-11E3-95AE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232161>

Junio C Hamano <gitster@pobox.com> writes:

> Andres Perera <andres.p@zoho.com> writes:
>
>> i just realized that there are ambiguities:
>>
>> pull -r (true|false|preserve) foo
>>
>> there are 2 ways to interpret this:
>>
>> pull --rebase=(true|false|preserve) foo # pull from remote named foo
>>
>> pull --rebase (true|false|preserve) foo # pull from remote named
>> (true|false|preserve), branch foo
>>
>> options with optional operands usually require that the operands be
>> concatenated with the option argument.
>
> Yes.  This command line option should be like this:
>
>  - "--rebase" and "--no-rebase" are accepted as "true" and "false";
>
>  - "--rebase=preserve" should be the _only_ way to spell the new
>    mode of operation (if we were to add "--rebase=interactive"
>    later, that should follow suit); and
>
>  - "--rebase=true" and "--rebase=false" is nice to have for
>    consistency.
>
> Thanks.

Oh, another thing.

How should this interact with 949e0d8e (pull: require choice between
rebase/merge on non-fast-forward pull, 2013-06-27) which has been in
'next' and will likely to be one of the earlier topics to graduate
to 'master' after 1.8.4 is released?
