From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 11:25:00 -0700
Message-ID: <7vwqrq31tv.fsf@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net>
	<7vehdy7j5f.fsf@alter.siamese.dyndns.org>
	<CAMP44s0FHnm0xeSuzVNxVhn_rMQ=oKqoDxCU+OWGKPNOxmnGyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:25:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQr1-0007B8-4m
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268Ab3DYSZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:25:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757717Ab3DYSZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:25:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0914117D62;
	Thu, 25 Apr 2013 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pD7dZX+euWUyriJ2RrkaE30sn+8=; b=v2g+YD
	Su4MFdczPaGOaD7LS/RHhYo2ay3Oi/e63Vl2bCPOq7wkh034T3Aw3hWGOSzAiEtw
	3dMuhhEd+dLPlO3ck9DkNyw1yReKFl3cYRIW+NUEYRjc++DM1PpK9ESmQOAY03p1
	6CYEECy2uBqcwnQAsN+ttWr37ziX0n1U6Q9qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2cVBYnPiHASsm165hhKUgM0qBE4f7nh
	O3RGWNsGTZi6/pxW5j+clrZ8xZ/r10QxDDuwcmH6VqW81+hUQhNrCU1raoItX6tR
	i6/6AqIOKfuvkP+C+RZixykkFGAFBXSbqfJMhECPGnNoToHSLB9DHmwXIsRZ+jQg
	AS1RthTt4Sc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F11F417D60;
	Thu, 25 Apr 2013 18:25:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0F017D5E;
	Thu, 25 Apr 2013 18:25:01 +0000 (UTC)
In-Reply-To: <CAMP44s0FHnm0xeSuzVNxVhn_rMQ=oKqoDxCU+OWGKPNOxmnGyA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 12:50:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7146B8F0-ADD5-11E2-8B9B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222407>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>> ...
>>> +             git for-each-ref --format='%(refname) %(objectname)' |
>>> +             while read ref a
>>>               do
>>> -                     test $a == $b && continue
>>> +                     case "$before" in
>>> +                     *"$ref $a"*)
>>> +                             continue
>>
> I wonder if we should bother with this at all. The purpose of the code
> was mainly to show to users that they should report the success only
> if the refs have been updated, but the code is becoming more
> obfuscated, a comment should do the trick. And then, we can just
> report success for all the refs (and explain in the comment why).

Are you proposing to say "ok $ref" to everything we see in the
resulting repository, even the ones the caller of remote-testgit did
not ask us to do anything with?

Wouldn't the caller be surprised if we did so?
