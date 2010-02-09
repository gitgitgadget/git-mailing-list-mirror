From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon, 08 Feb 2010 21:55:51 -0800
Message-ID: <7vwrynq7fc.fsf@alter.siamese.dyndns.org>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
 <7vtytrrrju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 06:56:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej4z-0007BV-Nz
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab0BIF4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:56:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab0BIF4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:56:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACFC697167;
	Tue,  9 Feb 2010 00:55:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=astpbG3X0JCfVyIc8oJsc6E9ItY=; b=KM/s5m
	s9oLbvbUjTxHXpJbaX1etBHeh3/9nvHe4kGk/nQqGpSY2z7zih3H4mXWy2npgP5W
	UDbg06jqrxgcl6iksFK9RE3FYE4xskG6PivCS5jrLItinC1cBb0kC0BiKJPYiYLR
	hqBjYwEHD60ne5MorOitgYN9q/9ovV2c4rVdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wyEkd5KwpqNDxAhjq2MHNZ87BSy2/uIs
	F7wdde9mojGHDshJyUYo8x7DIaOUwYnZwxdVHerHaq67WsURn2vjJOZ0BOj6oZ4F
	Rl+yx9VlMxqq6+dlk4l0bccJUqVZRVPCGJcElIKvUnFpZe65Vog6XSo/ecYfVy98
	mDzqQZ/h9YI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A1E197162;
	Tue,  9 Feb 2010 00:55:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD12497161; Tue,  9 Feb
 2010 00:55:52 -0500 (EST)
In-Reply-To: <7vtytrrrju.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 08 Feb 2010 19\:55\:49 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA49F87C-153F-11DF-A97E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139369>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> -	if (lno < top)
>> +	if (lno < top || lno < bottom)
>>  		die("file %s has only %lu lines", path, lno);
>
> Thanks; I think we make sure that "bottom < top" always hold true before
> we reach this point, so checking with bottom alone should suffice, no?

I am ... stupid.  If lno < bottom, then lno < top, but we need to check
both anyway.
