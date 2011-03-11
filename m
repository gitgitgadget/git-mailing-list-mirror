From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 17:33:08 -0800
Message-ID: <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 02:33:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxrEL-0005Zu-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 02:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab1CKBdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 20:33:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab1CKBdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 20:33:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33D8D430F;
	Thu, 10 Mar 2011 20:34:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w6nIbIWdwVCMmBC5dghg6t+aZFE=; b=TzNFml
	+zstTk0P90G4mNnZMpNrsH5ua1ZfP0sM7LIZpSGr4yknzWujl7XsdU9FPRZQP/u9
	++yuUtlnIc2u5G4R2AmRiRfbNEx+90H3qgwdg8ahhxC4T+TVF3IQKYHqphAzsWUk
	cErTDAlZdV+d0Kljii3u6DZnUngaVrATbO69E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X/FzSwGPV6vJc+YvEIjYHLt/tc7AvRlw
	gw8bloQWFyqS5YLWeOnfRSh9vYpWrn9aaFnCCDB/N8D5o9yglFLhj2D9gAhjqslf
	Gnl6IwXSaM9y764Jgk+zxOpU1KYcB3sqGCcxKoQUYjCBvLdAIxb6hY3vB2eTbT/H
	c4gweAS1PDU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0008D4303;
	Thu, 10 Mar 2011 20:34:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BA1EF42FD; Thu, 10 Mar 2011
 20:34:39 -0500 (EST)
In-Reply-To: <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 (Linus Torvalds's message of "Thu, 10 Mar 2011 17:16:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDD8B12E-4B7F-11E0-A6BE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168877>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> IOW, try your example thing not just with "master", but with two
> extreme commits. For example, try
>
>   git -c core.abbrevguard=2 rev-parse --short=5 83c3c622
>   git -c core.abbrevguard=2 rev-parse --short=4 979f7929
>
> and tell me what you get. I _think_ you should get 7 digits for the
> first case, and 8 digits for the second one. Even though you "asked"
> for a longer name in the first case, and you had the same abbrevguard.
>
> See what I'm saying? I think that's just insane.

Hmph, why?

That 979f79 one already have enough other objects with similar names, so
compared to 83c3c that doesn't, it is natural that you would need more
digits to protect its uniqueness, no?  The result shouldn't be affected by
the value of "short" as long as it is not long enough, as that is merely
specifying "at least this many letters".

Another thing to realize is that without abbrevguard with the code before
the configuration was introduced, you would get very similar results.
With --short=5, you would get 5 letters for 83c3c622 and with --short=4,
you would still need 8 letters for 979f7929.  Because either of these
values are not long enough and it is merely a way to specify "at least
this many letters".

If we don't care about uniqueness, we can just truncate at the number of
characters specified by the "len" without doing anything else.  That would
give us an output of uniform length without the uniqueness guarantee, and
"git describe" output cannot even be fed back to git running in the same
repository immediately after it is obtained.  I don't think that is what
we want.
