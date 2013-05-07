From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] revision.c: Make --full-history consider more merges
Date: Tue, 07 May 2013 08:21:17 -0700
Message-ID: <7vip2ulssy.fsf@alter.siamese.dyndns.org>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
	<1367767977-14513-6-git-send-email-kevin@bracey.fi>
	<7vtxmfq1ll.fsf@alter.siamese.dyndns.org> <518913B8.5080302@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue May 07 17:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZji1-0000Cj-BB
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab3EGPVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:21:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757108Ab3EGPVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:21:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 709DD1CF4B;
	Tue,  7 May 2013 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3CEHtTip/rZtKYPON0bQjGE7hsw=; b=oo/9bP
	qz1dAhp+W9TA3bij6dJuFgl0MxQ3IYeb5U/3dQVs6zfeWtjW0I3su1noS7Pd3m7i
	PnwqzAPe8o20uj7GurXhTWIyA+5cWqEuzIlWPNntkEslAnt/hY8LlBkLjUuz4Yjg
	2eNSnut9Mz5f6kZhEx2Fiv26RsVxREtd3dQTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HX7Hunz8CUCrh08d8wc7mYo5OuBsV3+h
	QEIJ2O5D6UJhDOScHjnE+stfAupTlVVb6LrU9QEu+IWAcd3YC4kKmaOoHpPkFEtx
	/YCcozXX0CvOgqDhKc1CLk+p/6pejFw/9YZIef3nO2P89r8N643YMS9JBl9DDQgH
	pXk9xM3MWJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67B361CF4A;
	Tue,  7 May 2013 15:21:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E23F61CF47;
	Tue,  7 May 2013 15:21:18 +0000 (UTC)
In-Reply-To: <518913B8.5080302@bracey.fi> (Kevin Bracey's message of "Tue, 07
	May 2013 17:46:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C44B5260-B729-11E2-9351-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223578>

Kevin Bracey <kevin@bracey.fi> writes:

> On 06/05/2013 23:45, Junio C Hamano wrote:
>> Kevin Bracey <kevin@bracey.fi> writes:
>>
>>> +struct treesame_state {
>>> +	unsigned int nparents;
>>> +	unsigned char treesame[FLEX_ARRAY];
>>> +};
>> I have been wondering if we want to do one-bit (not one-byte) per
>> parent but no biggie ;-)
>
> I did start down that path, because I felt bad about bloat.
>
> But then I realised how much I would be complicating and slowing the
> code down to only save a few bytes each time we walk a merge with at
> least 5 parents, and I came to my senses. :)

;-)
