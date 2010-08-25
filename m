From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Wed, 25 Aug 2010 15:09:15 -0700
Message-ID: <7vpqx6pcok.fsf@alter.siamese.dyndns.org>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
 <20100825084416.GC3280@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:09:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOA5-0004bL-UY
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab0HYWJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:09:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab0HYWJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 18:09:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2B2D0402;
	Wed, 25 Aug 2010 18:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k09+a/57de/1rXf3H0LMYLPvWew=; b=DVwGeR
	CCACRiYmUasDmXYNIVlh4UDZG3IYNurR/+S0+wW4TluVKx6udkS2XABOWxGrxCbj
	GcqJYcxhdo9BzihfKrtBfMtV0dVO+lfP3k5rNVAvkUOZJh78cFWErU0QYF/q8jHL
	An9ZGton2quDiZCoQe2lG+VWIIdzsvtOSJi7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PlPg6pT3dEA2U0/6/f7wOBMkPwzkJhMz
	OOUiXdHDwLczPGn3epemtgocybuH0H7aHcJQlydd+cJvrSIKVEhezIJ/1WQdivvv
	Zp6mjOeWT4mjpr/Dd1qxE4qhejFzA3/AZkyUr1crT+KJAPPoNVQEQLyODGV4JA1Q
	/7sVbP1eGLo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5F3BD03FC;
	Wed, 25 Aug 2010 18:09:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79ED4D03F8; Wed, 25 Aug
 2010 18:09:17 -0400 (EDT)
In-Reply-To: <20100825084416.GC3280@kytes> (Ramkumar Ramachandra's message of
 "Wed\, 25 Aug 2010 14\:14\:21 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B9D5E58-B095-11DF-A24E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154484>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra writes:
>> The first patch implements Jakub's suggestion. Arguably, it's slightly
>> complicated- it took me more than a few minutes to do the math with
>> `nr` and `nr_i`.
>> 
>> The second patch clarifies the meaning of the `-<n>` option. We should
>> also probably force the mutual exclusivity of `-<n>` and <revision
>> range> to avoid confusion.
>> 
>> Additionally, thanks to Thomas for drilling into me the fundamental
>> difference between -<n> and a revision range (on IRC).
>> 
>> Ramkumar Ramachandra (2):
>>   git-format-patch: Print a diagnostic message when ignoring commits
>>   log: Improve description of '-<n>' option in documentation
>> 
>>  Documentation/git-format-patch.txt |    2 +-
>>  Documentation/git-log.txt          |    2 +-
>>  builtin/log.c                      |   42 ++++++++++++++++++++++++++---------
>>  3 files changed, 33 insertions(+), 13 deletions(-)
>
> Do you see value in this patch or is it just unnecessary baggage?

I am not very impressed by the counting.  It probably makes more sense to
count only what we are actually going to process and emit, i.e. always use
no-merges (do we even support format-patch on a merge?).  
