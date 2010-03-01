From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git add' regression in git-1.7?
Date: Sun, 28 Feb 2010 18:00:17 -0800
Message-ID: <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 01 03:00:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nluw1-0004VT-K5
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 03:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0CACAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 21:00:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0CACAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 21:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F30D9DAF6;
	Sun, 28 Feb 2010 21:00:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nuYR8vc1IeatRh21E+B2IG5m8gk=; b=Jl+oyb
	mhOXQBGKT3vboPHDbq9aG0pS0Gjpyt0VHtJcAbO7Hb7k0FL6WUViSuIwvMZUpcdE
	6wDMRnFK7Iq+7LwC9qLc3U4M50vg4zGTSMoG596RJgNu2K9OOeLemv6p8X4TkrY+
	0V0oLECKNBUjmSaywFoVQLnf0JezA9StjVOVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9ABMZDi471z97AD/YJ5yFJ7yazo6tgQ
	THZHcbMUgyC20JHsVnPBh8f6B3YrCBWSqB6EgFTmMflpZ0xHP/lFyEEa0NwNSbn8
	9hOvs2iS2JCFYORC4Mm96dRs6xAR2GB3488Dw8Y1CxE5s57Uo05WTLVucWB/rCHH
	TA0J29m7gQ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4523A9DAEE;
	Sun, 28 Feb 2010 21:00:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60B879DAED; Sun, 28 Feb
 2010 21:00:19 -0500 (EST)
In-Reply-To: <20100219082445.GB13691@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 19 Feb 2010 03\:24\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33A62ADE-24D6-11DF-83AA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141293>

Jeff King <peff@peff.net> writes:

> I'm not sure of the right way to fix this. We can drop further down into
> the directory hierarchy when doing COLLECT_IGNORED and look for actual
> files, but that may have a negative performance impact.

Wouldn't that have negative correctness impact?  I don't see an obvious
way out, other than perhaps checking the set of pathspecs twice.  One
thing that might help is to carry the seen[] array a bit longer so that we
do not have to lose sight of what paths we were given but didn't match.
