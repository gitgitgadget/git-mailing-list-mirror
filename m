From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 06 Feb 2015 14:17:25 -0800
Message-ID: <xmqqr3u2d6ru.fsf@gitster.dls.corp.google.com>
References: <20150206124528.GA18859@inner.h.apk.li>
	<20150206193313.GA4220@peff.net>
	<xmqq386ihk5w.fsf@gitster.dls.corp.google.com>
	<20150206203716.GA10857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJrDP-0006J3-MH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 23:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbbBFWR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 17:17:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752759AbbBFWR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 17:17:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9977736B32;
	Fri,  6 Feb 2015 17:17:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P0IoXz74lkectgu7MtpoxoR25H8=; b=gPLSQ9
	DGrTfmPcmpDu7XkwIR6RA3DEtYsFLFGBrRq8LxAGnLLCz2FMpZV61DucCJvoBM1r
	dhknBqj3wjJWomX0Hxtv/YVJk69DPrBnbGMrfb6NTiEgKQAUvDDtuRBM21kiPq6P
	+j10rSqadaNZHx4D91IEnECo4ytyugWJJPfCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dy994ZOWUXoDSZYqBVOTzzt+eiJlRi5L
	g805BbJlwd46GWhTqiOzcK70jigDShTvc3nKKw/NzE9W63k21H59ktwoJ94GNS5R
	AsMtsEJOHBpbi1PHwG2SBu6f168Cyah1FvSs8+q6oxtlrucBvE6/DAh3FngJjm1N
	S5CJH97ZO/4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 908E536B31;
	Fri,  6 Feb 2015 17:17:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B36936B30;
	Fri,  6 Feb 2015 17:17:26 -0500 (EST)
In-Reply-To: <20150206203716.GA10857@peff.net> (Jeff King's message of "Fri, 6
	Feb 2015 15:37:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE459388-AE4D-11E4-88A4-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263431>

Jeff King <peff@peff.net> writes:

>> That is one of the reasons why I had the "unbounded set, including
>> the ones under our control such as subcommand names" in the draft
>> update for the guideline.  I dropped that part after the discussion
>> to keep other "obviously agreed" parts moving, but we may have to
>> revisit it later.
>
> I think this may be the heart of where we were disagreeing. I took
> "unbounded set" to mean "a set where you might keep adding things
> forever". So fsck errors would count in that. But if you mean it as "a
> set where the syntax may be unbounded", then yeah, we definitely would
> not want it in the key name, as that becomes an unnecessary restriction.

What I mean is "possible keys are unbounded and its syntax is not
under control of the 'config' subsystem".  The syntax does not have
to be unbounded; as long as it is wrong for the config subsystem to
dictate what shape the possible values may take, it shouldn't be
used as the top or the bottom level in the variable namespace where
it has its own syntax restriction that may or may not match the
requirement of the using code of the config subsystem.

Those who name Git subcommands will be limited to sane looking
subcommand names that do not have SP in it, for example, but just
because config subsystem does not want to see "_" in its keys, it
should not force its world view to those who name subcommands.

If the names are not "unbounded", it becomes easier to live with
such a third-party limitation (imposed by config subsystem), but
otherwise, "we just pick a name within that syntax" becomes an
unnecessary and artificial limitation.
