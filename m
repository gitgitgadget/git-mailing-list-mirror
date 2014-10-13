From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Mon, 13 Oct 2014 11:21:50 -0700
Message-ID: <xmqqh9z74ypt.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
	<5433CBC3.5010202@gmail.com>
	<xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
	<vpqzjd7kta6.fsf@anie.imag.fr>
	<xmqqy4sqbi12.fsf@gitster.dls.corp.google.com>
	<vpq61fujtlk.fsf@anie.imag.fr>
	<xmqqk34a8hl3.fsf@gitster.dls.corp.google.com>
	<20141010081107.GA8355@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:22:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdkFv-0000O4-2O
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbaJMSV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:21:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752453AbaJMSV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:21:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 941BD1496C;
	Mon, 13 Oct 2014 14:21:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bb89mF2Pkv6UPdMGDQXsV3U+EXU=; b=nxEMLt
	3QXz0GJTk3G4a7XLK+3fvxswRHfk+hyyMgNFpXK9mhxDoNmqfJhVexxkKL8hSBzd
	HmAVmjtFXATYTBOMOOo3DfzLS8XvbXAmxvjZM9lFmEEMlFl+C/Px+iR8OVba4Vis
	m+YxtXJ5J88Fj7cHBj9wt/CWLa40wRY4HihJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hUR5ZUsryHWZM++/j1Qz5BJnOaqHsxdi
	9pmuc11PhzGaIAtgbC4S4JCeuJTJvbizjVeA7yPs4ruUOQ30uP3TcwV6vEea04hj
	mRvqQwT6kmU021vQNcBS4sXVbHntQ12fZDIMFMXA2j28cUsfWm10LwgEKleHyqU5
	L4W67MlsCAM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD621496B;
	Mon, 13 Oct 2014 14:21:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 086BC14969;
	Mon, 13 Oct 2014 14:21:52 -0400 (EDT)
In-Reply-To: <20141010081107.GA8355@peff.net> (Jeff King's message of "Fri, 10
	Oct 2014 04:11:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE626D14-5305-11E4-B0AA-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Which makes me wonder if safe-include is really helping that
> much versus a project shipping a shell script that munges the repository
> config. The latter is less safe (you are, after all, running code, but
> you would at least have the chance to examine it), but is way more
> flexible. And the safety is comparable to running "make" on a cloned
> project.
>
> I dunno. I do not have anything against the safe-include idea, but each
> time it comes up, I think we are often left guessing about exactly which
> config options projects would want to set, and to what values.

I tend to agree.  Every time somebody says "a project wants to give
its participants suggested settings", we seem to tell them to ship
an instruction to their participants, either in BUILDING or setup.sh
or whatever.  It certainly is simpler and more flexible.

The only real difference it might make is an attempt to push to an
unattended place and automatically making the changes to take effect,
aka "push to deploy", which is not what we encourage anyway, so...
