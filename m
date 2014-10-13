From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 16:14:59 -0700
Message-ID: <xmqq4mv71s0c.fsf@gitster.dls.corp.google.com>
References: <20141010062722.GB17481@peff.net>
	<20141010064727.GC17481@peff.net>
	<xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
	<20141013223303.GA17045@peff.net> <20141013224342.GA22290@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 14 01:15:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdopc-0007Us-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 01:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbaJMXPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 19:15:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343AbaJMXPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 19:15:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B3A416025;
	Mon, 13 Oct 2014 19:15:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Xr/QVM1lefCrmgn+IqiiV1GoYU=; b=thgd/a
	UTuLPvR3BIUSNCCw4IiKV5I7csGSPFJZpif86LEmsHlvlTWFj9Oe2TnDgL2miHz3
	v+bexvpzfRt58rvMWERFVhMxGBHJs1dE5uqlNAhILpuyIjtcUbHwOxUcWlg8mESk
	l8sfdjAqJxLTnRud/rm5VwPEqFcPEgW0LykIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMgahIoG4dGvIFHXotjlAG3UqeTtyRTq
	uMsMS013PQqwRC4CGcSVCtnjYqQAMbcYhDEDZQQ7ii6/RwaV9JV+rA8F+lxccFj9
	TUo0UWapITG92DygUvMpkBkMS2Fzfm0hGVni1p+/TCUfnd0jH8NIpPOZjVnUMZed
	h7KkqYB/Tcg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE27B16023;
	Mon, 13 Oct 2014 19:15:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF49A16021;
	Mon, 13 Oct 2014 19:15:00 -0400 (EDT)
In-Reply-To: <20141013224342.GA22290@peff.net> (Jeff King's message of "Mon,
	13 Oct 2014 18:43:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1A9B658-532E-11E4-A87D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK, I lied. I couldn't resist spending 5 more minutes on it.
>
> If you instrument t1308 on master to look at the contents of .git/config
> directly after the setup step, you'll see that the file ends with (tabs
> marked as ^I):
>
>   [...]
>   ^I^Ihorns
>   ^IEOF
>
> Which makes sense. We forgot the tab-eating "<<-" in the here-doc, so
> the tab-indented EOF was not counted as the end of the input. So this
> test is bogus and broken, and the breakage introduced by my patch is
> only triggered because of that (which isn't to say we shouldn't
> necessarily adjust my patch, but we definitely should fix this test).

We came to more or less the same conclusion.  With your $*" fixed,
the test "works" as before, with the same definition of "works",
because without your patch the file ends with <HT>EOF<LF> and with
your original $*<LF><HT>" the file ends with <HT>EOF<LF> with these
extra <LF><HT> appended, which was what made me notice, and with $*"
the file ends with the same <HT>EOF<LF> as before.

I've queued a fix for the original test on ta/config-set and also
amended your $*".


> What really surprises me is that the shell is fine with a here-doc
> ending inside an eval.

Yup, it smells somewhat mis-feature-ish, doesn't it?

Anyway, you do not need to respond to this message in a hurry.

Enjoy your dinner ;-)
