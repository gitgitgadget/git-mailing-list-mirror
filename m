From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Tue, 23 Feb 2016 15:30:37 -0800
Message-ID: <xmqqfuwjngwy.fsf@gitster.mtv.corp.google.com>
References: <56B32953.2010908@gmail.com>
	<20160204111307.GA30495@sigill.intra.peff.net>
	<xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
	<20160212224048.Horde.IpOeDKLAMM4a11F2xyIeY4M@webmail.informatik.kit.edu>
	<20160212221639.GA27974@sigill.intra.peff.net>
	<xmqqk2m9ts91.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, tr@thomasrast.ch
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:30:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMPl-0002ba-BG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbcBWXam convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 18:30:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbcBWXak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 18:30:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D22E94882E;
	Tue, 23 Feb 2016 18:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rZqfJ/sHmymT
	np/xXpTRkvpIjSE=; b=d0lxY8e8HFhfeP7NSfv6mk7IPuURP/YHT4KPcBKCZQAW
	dFHGPXL2D6BY4/ehOh/Gjw9ANkhg7PYt1PcQJQP0eg9GLT5aptvW3O8vLPtAojTU
	pPcqhSfSbrGS8Yz7tx1IoFv1XW0kMddEZKP4a6HcCYi0WOVD7SBrSo+rYGtuVAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ibHvKM
	7e2EPPru+0QZ0cDx7vdQTYjyi3PUMDOe8t8xWccQZrD5eGRZJw+DQuV8/W5xfMAr
	OTPt9JDI3A5g4VS0X5oUeozVWNG2k+9P81GNifnIOEAMoo7kmUMMeycaINU9qLQh
	lfyZB/nn1KDR3fJH6qc0Xr7qnJ9wup2qQPpOU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C95304882D;
	Tue, 23 Feb 2016 18:30:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 365754882C;
	Tue, 23 Feb 2016 18:30:39 -0500 (EST)
In-Reply-To: <xmqqk2m9ts91.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 12 Feb 2016 15:37:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 729C59E6-DA85-11E5-9E8C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287142>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Feb 12, 2016 at 10:40:48PM +0100, SZEDER G=C3=A1bor wrote:
>>
>>>  * It would swallow even those errors that we are interested in,
>>>    e.g. (note the missing quotes around $foo):
>>> [...]
>>>  * I often find myself tracing/debugging the completion script
>>>    through stderr by scattering
>>>=20
>>>       echo >&2 "foo: '$foo'"
>>
>> One alternative to deal with these would be to add a flag to
>> conditionally turn off stderr, and then leave it on during normal
>> operation and disable it (letting everything through, including what=
ever
>> random cruft git commands produce) for debugging.
>>
>> But...
>>
>>>  * I have a WIP patch series that deals with errors from git
>>>    commands.
>>
>> I'm happy to wait and see what this patch looks like (and generally
>> happy to defer to you on maintenance issues for completion, as you a=
re
>> much more likely than me to be the one fixing things later on :) ).
>>
>> -Peff
>
> Likewise on both counts.

So, have we decided to wait, or we'd rather apply the band-aid in
the meantime?  I can go either way, just double checking as I
noticed this thread while updating my leftover bits list.

Thanks.
