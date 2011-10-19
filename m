From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git --reference bug(?)
Date: Tue, 18 Oct 2011 23:33:46 -0700
Message-ID: <7v8vohebhx.fsf@alter.siamese.dyndns.org>
References: <CAK-xaQaUxJ5c_kN48g7-J9fosDv6awbAFQSFLpF2fA+hc-i-MA@mail.gmail.com>
 <4E9E59A7.7070307@alum.mit.edu> <7vpqhtec2n.fsf@alter.siamese.dyndns.org>
 <7vipnlebwb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGPir-0001qa-CL
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab1JSGdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:33:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290Ab1JSGds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:33:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25D492F9E;
	Wed, 19 Oct 2011 02:33:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cLQPXRd0gxbBPzwpVs4N5eQkhmk=; b=RgqFd6
	xm0trbnZHCS/qGEkOlhQir515Y4epopPQxD5SDYTkw7nNitvqrPurKeevq00zldv
	DuUcPvJVkXUoIIxxov5K/PRpjixG0xynHcEqI/dhvtjoQKABsbD6rSobVkofcJq8
	ByEx8fwRloJg1uIohUNHkqCH24ymfvG3/eoT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxPZnTTnQjMxd7j17oo+Ef6C0PQZ+iKb
	PzBFJCBp6LEjGcKbl/lx2NKFCc8vy1FmBoPn07SmIdBMdOsqDy9Xh/eBCgTMMI2R
	Ydx40lOxbwMq7EgcNRfOTI8sSD7EISqfPHXEDIT2EKH1YbN2k6hO9g18glvS+tHf
	i9oUesLsb68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C02B2F9D;
	Wed, 19 Oct 2011 02:33:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99A362F9C; Wed, 19 Oct 2011
 02:33:47 -0400 (EDT)
In-Reply-To: <7vipnlebwb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 23:25:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CD8785A-FA1C-11E0-B1C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183920>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a	refs/tags/v2.6.12-rc3
>>> a2755a80f40e5794ddc20e00f781af9d6320fafb	refs/tags/v2.6.12-rc3^{}
>>> [...]
>>>
>>> I've never seen this format before; is this the remote protocol for
>>> peeled refs or maybe the behavior of an old version of git?
>>
>> This should be very well documented and has been the output from fairly
>> early days of ls-remote.
>
> I take the first half back. The ls-remote documentation seems to have
> bit-rotten quite a bit.
>
> IIRC, we started doing this when we introduced auto-following of the tag
> objects. Even update-server-info knows about it so it way predates smart
> HTTP and is a fairly old and established behaviour.

In addition, you must be careful about what is added with add_extra_ref();
they are often not refs but are placeholders for Git to know that the
history leading to it is complete, even though they do not exist as
refs. The values of real refs that exist in your alternate object store
are treated this way, because you know you do not have to fetch (if you
are initiating fetch-pack) or receive (if the other side is initiating
send-pack) histories leading to them from the other side.
