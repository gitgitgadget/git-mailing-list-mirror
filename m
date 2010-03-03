From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 03 Mar 2010 13:04:37 -0800
Message-ID: <7v3a0hktga.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
 <20100303204257.GA5501@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 22:04:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvkY-00033W-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 22:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0CCVEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 16:04:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0CCVEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 16:04:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DEA9E19B;
	Wed,  3 Mar 2010 16:04:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X35fE7P9fEsyPnPNaBhRIh3OYm8=; b=ayQoLc
	Ocf6SVyqIGrOFQocoGw/CsrIWvcIN27t5P4txmkVl3Fx7pvNpEDA7ASvshpuMzCb
	CpZbb1KyorVIsVCvbxvd4DQoYJzlFN28zoX6sOq70B38fOorgFm6ZMW790uQQO45
	hn23r8ijKp6QbX9YnBKrR19HQdMKJVM7ynPpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMiqCOcDoitz31NLMpG5kIRPs+ZIb2tI
	zOryB+ciyPiITtXwW3T3nsOdFcNHHMS8SR0kZfMH58/gXfaF0U/jFgSQXKLSwJjo
	CzwiUBgq53Dy2t4K8mdhmKrRgqCYkBebAqfjbJC/0FvGpzXtSLg5+5BC5r1GAedH
	8UA+Q0n9egg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E0DA9E197;
	Wed,  3 Mar 2010 16:04:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F74E9E194; Wed,  3 Mar
 2010 16:04:39 -0500 (EST)
In-Reply-To: <20100303204257.GA5501@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 3 Mar 2010 15\:42\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 644AF8D4-2708-11DF-9DD7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141479>

Jeff King <peff@peff.net> writes:

>>  - "git submodule summary path...", defaults to HEAD which is _not_ unborn
>>    (we shouldn't shift).
>
> I don't think this is a problem. We do:
>
>   git rev-parse -q --verify --default HEAD path
>
> and it correctly reports failure, so we never do the problematic shift.

Stepping back a bit, why do we even special case an unborn branch case in
the first place?  

    rm -fr one && git init one && cd one && git diff HEAD

would diagnose it as an error (we may want to sugarcoat "ambiguous
argument" error message, but that is a tangent).

I may be able to buy "status/diff internally calls submodule summary, and
that codepath needs to special case a submodule on an unborn branch _for
such and such reasons_" if the reasoning is sound, but even if that is the
case, shouldn't that special case be triggered explicitly by the caller of
"submodule summary" with an option?
