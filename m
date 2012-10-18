From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch
 --tree-filter' on Solaris?
Date: Wed, 17 Oct 2012 23:06:11 -0700
Message-ID: <7vk3uomi0c.fsf@alter.siamese.dyndns.org>
References: <1109432467.20121017104729@gmail.com>
 <507E5CE0.10002@viscovery.net> <1013956402.20121017125847@gmail.com>
 <20121017220912.GA21742@sigill.intra.peff.net>
 <507F9437.2070501@viscovery.net>
 <20121018053656.GA6308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOjFR-00059s-UH
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 08:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab2JRGGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 02:06:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2JRGGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 02:06:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF7467745;
	Thu, 18 Oct 2012 02:06:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ync3Rx7b8luoN6NxFZ6zlZAxLeo=; b=xYEIaB
	SBqo+s4w4RS1LeySVfAg62/2eLpYgwyd4b7PsPk0ocaQrlJHxMmqw8f4a3i/OC5O
	FWgxWftvcfenS1980s4o3eCxQNOylh3mfJY8AzFCjo/utRNOBLAM37Kl8KxOSjh6
	jYEtmMVfhfnJ7C6uyE12/coFvvnkLZkEDmDNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQurHbmTAl442yrDCqmuF0okuNXqKHwM
	1X06PgAys/z3ZVuhkP02+lfxyIv3mMbHItct3A1s08nBDQBo/8hvww0PD2PEdjfE
	qJkYgrkzi4xKskc65sl1N6+hqDkqzDyej4B/ISRd+CHWrM3wORpG+EVfyw1JL7WB
	Cj153YB4dr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6057744;
	Thu, 18 Oct 2012 02:06:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 110117743; Thu, 18 Oct 2012
 02:06:12 -0400 (EDT)
In-Reply-To: <20121018053656.GA6308@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 18 Oct 2012 01:36:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB6D34FA-18E9-11E2-BE21-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207968>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 18, 2012 at 07:31:35AM +0200, Johannes Sixt wrote:
>
>> Right. But we should really be doing something like this instead to save a
>> few subprocesses.
>> [...]
>> -	eval "$(set_ident AUTHOR <../commit)" ||
>> +	eval "$(set_ident AUTHOR author <../commit)" ||
>
> I cringe a little at losing DRY-ness to avoid processes.

Well, the header field token "author" and the middle word of the
variable GIT_AUTHOR_NAME _happen_ to be the same modulo case, but
they did not have to be, so you could argue the updated set_ident
implementation is more generally useful (you could even argue that
we should spell the first parameter out as "GIT_AUTHOR_NAME" and
"GIT_AUTHOR_EMAIL", two separate parameters).

> Speaking of repetition, this seems like almost the exact same parsing
> that happens in git-sh-setup's get_author_ident_from_commit. Maybe it's
> worth merging them. I suspect you could also avoid another process
> by parsing out both author and committer information in the same sed
> invocation.

Yes, yes and yes.
