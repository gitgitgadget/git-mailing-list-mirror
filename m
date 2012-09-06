From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Thu, 06 Sep 2012 14:07:26 -0700
Message-ID: <7vvcfq273l.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-6-git-send-email-git@adamspiers.org>
 <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
 <7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
 <CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
 <7v627r7s5c.fsf@alter.siamese.dyndns.org>
 <CACsJy8Aq7Sodm1_k2kAmfajHG4wP76xHCshDGPfiLYfzuNwWaA@mail.gmail.com>
 <CACnwZYe19r9mefDmAQtuE5NU4jw033fc_i4JvMZUgtMUkNgEOw@mail.gmail.com>
 <CACsJy8CoBvxg9SWFFXbuDJM7Lu74Jw6LVc=7cNwu24h7pijeXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jIY-0001EL-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab2IFVHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:07:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933128Ab2IFVHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 17:07:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 978059333;
	Thu,  6 Sep 2012 17:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A1FU3IUuRHcqtYaw9ot5tPs+gj4=; b=L7Xlhp
	GxY9fRZKw0LZuqw3DedG+XRGyYDR87AeY+x48XZblaSqaWI8VNYWOfEP609bYTZ3
	g9UdfnSYd/TtSkXBF8Ix0uNs2fRzcbpc8DTi5Kc2yNi0e0KJg03TNFf+SKqIBdCq
	wY/rSYlT38XdzwnZ+TCAJUwC5imBzj67poZHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CCPqDj9Hf9OnyDkJ5T7/qLubxXsFnR7j
	NM7FsJYuwrtwlKgPi5Ba1lpmaRWCzVyP9Ts5nMsW9+j0rdopXBgdCs/NX0TIw4XZ
	YK+VUMxkSc7yp6wr6Dmp73+p+4WMwz/SkkqxDUGW6JD+3kEMKkqW0U4ac1P36x6s
	vlhiquQm8ik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 842049332;
	Thu,  6 Sep 2012 17:07:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 011E29331; Thu,  6 Sep 2012
 17:07:28 -0400 (EDT)
In-Reply-To: <CACsJy8CoBvxg9SWFFXbuDJM7Lu74Jw6LVc=7cNwu24h7pijeXQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 6 Sep 2012 22:05:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDD87834-F866-11E1-B792-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204924>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>> I'm not great at naming. And path_excluded() cannot be reused to avoid
>>> problems with other ongoing series if any. So path_is_excluded()?
>>
>> is_path_excluded()?
>
> Good too.

Sure, either would work.
