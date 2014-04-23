From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 15:15:06 -0700
Message-ID: <xmqqvbtzwv4l.fsf@gitster.dls.corp.google.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com>
	<xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
	<53559b0cc066_6c39e772f09d@nysa.notmuch>
	<xmqqtx9m70fh.fsf@gitster.dls.corp.google.com>
	<53583111dd8ad_24448772ec17@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:15:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd5Ro-00068V-8P
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 00:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbaDWWPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 18:15:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaDWWPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 18:15:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D1C67F966;
	Wed, 23 Apr 2014 18:15:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mjO8/2UHUlN+qDCZ3loSAiCHqV0=; b=DLg6Zw
	6IpENKIXBYgDu5Ma16W5mU2lpiRJivRvhx9H3djnwUrnSWwv52d5N1LIzGypM4ff
	BuztF/3IAC3f695Fz5qT92oENESpVXtTKvweKHH3S7uejwdD4NEMp5IEsnAX/GrJ
	i7K2xXtAIcEN8elj89r23HqSqpViWwph1nvfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ifq5u5VIWEk6NOnU9elriMJEOqYxdkiH
	ab4HPGa+EPqNTvwWuy3ZyFHhbd9mvcgFzEpJ8P2A8fQgvZU+hZg/iBMMKNi4YPqJ
	JQ+sT0vvGsxA4zurUIIoZBCbQVyf6sXy5TKWu9mhpuiP6Lse1QWyigYvCixFn/Ys
	FBvKvHZfPFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52CDD7F965;
	Wed, 23 Apr 2014 18:15:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 579977F962;
	Wed, 23 Apr 2014 18:15:09 -0400 (EDT)
In-Reply-To: <53583111dd8ad_24448772ec17@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 23 Apr 2014 16:30:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB62B682-CB34-11E3-BA31-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246907>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > ... there are _already_ hooks without pre/post.
>> 
>> Like commit-msg?  Yes, it would have been nicer if it were named
>> verify-commit-message or something.
>
> No it wouldn't. I can use the commit-msg hook to change the commit message and
> to absolutely no verification, so verify-commit-message would be misleading.

You are confused (and please do not spread the confusion).  If you
read the first paragraph of the documentation on the hook and think
for 5 seconds why "--no-verify" countermands it, you would realize
that the hook is primarily meant for verification.  We also allow
the hook to edit the message, but that is not even "a useful feature
added as an afterthought"; the documentation mentions it because the
implementation did not bother to make sure the hook did not touch
the message file.

It was a mistake not to call it with a clear name that tells
verification happens there.

>> Old mistakes are harder to change because of inertia.  It is not a
>> good excuse to knowingly make a new mistake to add new exceptions
>> that the users need to check documentations for, is it?

I see no reason to waste more time on this point.
