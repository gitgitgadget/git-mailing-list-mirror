From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] tests: fix gzip with exported GZIP variable in environment
Date: Tue, 03 Dec 2013 10:21:35 -0800
Message-ID: <xmqqy541okwg.fsf@gitster.dls.corp.google.com>
References: <1386061054-30796-1-git-send-email-mail@eworm.de>
	<CAPig+cQqKQdVEojYF+-+ZE2hQjxsH4WrgPymj8g7P6pSQzfVpw@mail.gmail.com>
	<20131203131812.GC26667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Christian Hesse <mail@eworm.de>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:21:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnubW-00065Q-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab3LCSVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:21:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab3LCSVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:21:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A756B5560B;
	Tue,  3 Dec 2013 13:21:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WAKrIhs4yJtBrKeexzcpJkCsTwA=; b=EmQDUP
	QCtIFFB+tkM2UeD8dNpeaoqJyXzN+7yOS4yZSYBRDPcSI3FUjOzvNXOWYzjDArzl
	Ymc5y6gENFfFuf3Fg25srDEb1e7fV7upp7I+Cr1eF+2jpFrJ302aa1If2nsmNpBY
	kyyLK8kYTRbk+A22ZuHnKeVLDypWIt6YAzhgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZImp3TwG1yf3GqJJoHrko7DVy9EaCMc/
	lNVyzJFDjWwx0lFPyuQK92Nkzw5tc2e+AW871GyGG2IcvrdULRpAMFxeLgFNCAb4
	IXqjCdSFjCh2hskT4sTUi2WBpIorC2KIXu+MykcowD5mpd8rL8vrBFf93D+u5t95
	VCezFxfDx9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97A145560A;
	Tue,  3 Dec 2013 13:21:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA86C55608;
	Tue,  3 Dec 2013 13:21:36 -0500 (EST)
In-Reply-To: <20131203131812.GC26667@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 Dec 2013 08:18:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF03D3FE-5C47-11E3-B977-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238708>

Jeff King <peff@peff.net> writes:

> There are a few options I see:
>
>   1. Drop $GZIP variable, and hard-code the prerequisite check to
>      "gzip", which is what is being tested.
>
>   2. Keep $GZIP (but rename it to $GIT_GZIP), and explicitly set up
>      tar.tgz.command as "$GIT_GZIP -cn".
>
>   3. Teach the Makefile a knob to set the value for "gzip" at compile
>      time, and use that for the baked-in config (and propagate it to the
>      test to check the prerequisite).
>
> I think I'd be in favor of (1). It's the simplest, and we have not seen
> any reports of people who do not actually have gzip called "gzip". Users
> can still override it via config if they really want to.

I am OK with (1).

A related tangent is that we may have to worry about is how/if a
random setting coming from GZIP in the environment (e.g. "GZIP=-1v")
would interfere with the test.  It may be the simplest to unset
$GZIP at the beginning of these tests, regardless of which of the
above three is taken.
