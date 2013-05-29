From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] push: fail early with detached HEAD and current
Date: Wed, 29 May 2013 12:59:52 -0700
Message-ID: <7v7gihsgjr.fsf@alter.siamese.dyndns.org>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
	<1369855311-23367-3-git-send-email-artagnon@gmail.com>
	<7vppw9shq2.fsf@alter.siamese.dyndns.org>
	<CALkWK0mCY0F-EgO6hQv-LvV1Nb5H9jNXBWLDrY07rVNqLBPjkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:00:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmXP-0006Wv-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935096Ab3E2T74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:59:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934976Ab3E2T7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:59:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C1A2370A;
	Wed, 29 May 2013 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X+j0aapRRuVpgcKWRoG1C+yYL04=; b=nc9+qr
	98+ogBTwTP35MWivCh3t5KModccqpX3v6iSWmRNK+ghTmbYdUqERwppeYO9rL8sw
	teLaeXAQ9YiSEJioAMmEseIUwk6CbyJ5RtTmFCcHQX1nE/jR/B71P6Kk19C6JQWD
	d8myTwa5dQTFPyPlfhW3IaHMbAT0qTt4wiihM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=juI+AmyCaOugC1OEQdS4N961opJb0a/h
	1v6fEUR4BIFvKnEZEONVOfHB1Nk0V+1yKMWBjRHdImo6HBXJsYPH/6N8ZxIrT6Ft
	YzcEKJuvP12R1JbtMh6Ly8Xqddj0b/YlDkldJzEPofq6VzSIBCKSnEfqDiRQ2gyd
	Kb6WkNPOn1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40CED23709;
	Wed, 29 May 2013 19:59:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A69123708;
	Wed, 29 May 2013 19:59:53 +0000 (UTC)
In-Reply-To: <CALkWK0mCY0F-EgO6hQv-LvV1Nb5H9jNXBWLDrY07rVNqLBPjkw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 30 May 2013 01:07:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 541FC5AC-C89A-11E2-AB3F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225881>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>>       case PUSH_DEFAULT_CURRENT:
>>> +             if (!branch)
>>> +                     die(_(message_detached_head_die), remote->name);
>>>               add_refspec("HEAD");
>>>               break;
>>
>> Would it hurt to do
>>
>>         if (!branch_get(NULL))
>>                 die(...);
>>
>> here, without the first hunk?
>
> And how would I change the add_refspec() call to take branch->name in [3/3]?

By doing something like this, perhaps?

	struct ... branch;

        switch (...) {
        ...
        case it-only-matters-here:
        	branch = branch_get(NULL);
                if (!branch)
			die(...);
	}
