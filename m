From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] remote: remove dead code in read_branches_file()
Date: Sun, 23 Jun 2013 14:15:01 -0700
Message-ID: <7vzjugedgq.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-6-git-send-email-artagnon@gmail.com>
	<7v1u7vkslz.fsf@alter.siamese.dyndns.org>
	<CALkWK0mYmhnOL-F+StuKWSeQ48EsQSAnS0_6u-B8KKq+RrOW5A@mail.gmail.com>
	<7vhagpfdwp.fsf@alter.siamese.dyndns.org>
	<CALkWK0=pgivbq0D3Q29H4+RM77s67EALharbVCwAGFqjBPQgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 23:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqrcv-0006bC-11
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 23:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab3FWVPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 17:15:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab3FWVPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 17:15:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85A42A71C;
	Sun, 23 Jun 2013 21:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zr8v6b8KKvZegUQtbFdqT1oieTA=; b=sbnBw6
	NCjB40dUx0Ln6O/0DXNkIiyOoNeZ//jhYUX9ojUP5xmgh9wWWTmEY0iip8jYcnNc
	iEfqnX2dscpYDIT32FUocTwTDJBD3te7UtcmYBT4wMYxk/ZCRk5Atdf0UFfTzKk6
	Y06gLvWp9E4xWg/Dst8w4MmmgjEKcZYSzaL4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NLp6c1d2gd+ZqYSCmH2ekz/27ne5PsK7
	zB7qUG1H8GbVbhPMmLTA80k032YqQ/aaNnf+2WFGI1Ff7DEEd44/p+LEdHjVaNwM
	KtwHzLeZh8qG/VC80/NP7SpDpeKLSsnX1P0jhxycfRwnipu50tQQqkj5FcTbFero
	/DRPjdAeH2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F2C52A71A;
	Sun, 23 Jun 2013 21:15:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 236812A719;
	Sun, 23 Jun 2013 21:15:03 +0000 (UTC)
In-Reply-To: <CALkWK0=pgivbq0D3Q29H4+RM77s67EALharbVCwAGFqjBPQgwQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 23 Jun 2013 14:07:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F85442B6-DC49-11E2-9B67-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228760>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>>> Reminds me of the strategy to deprecate functionality in X (cf.
>>>> http://lwn.net/Articles/536520/) ;-)
>>>
>>> Leaving dead code around to confuse readers? :\
>>
>> We broke the use case to access jgarzik/netdev-2.6 only by having
>> jgarzik remote accidentally, and waited for quite a while (since
>> early 2008 until now) to see if anobody screamed.  Nobody did.  We
>> now know we can remove that feature.
>
> Did we _not_ leave dead code around to confuse readers (no comment or
> log message indicating intent), or am I missing something?

The largest thing you are missing is that it does not have anything
to do with my "Reminds me of ..." comment.  The silent breakage by
df93e33c is exactly "broke silently and started waiting for bug
report, which never came."  It is not about those reading the code
(only to them, dead code matters) at all, but all about users who
use the system without reading code at all.
