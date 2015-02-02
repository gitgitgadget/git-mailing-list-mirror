From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration variables
Date: Mon, 02 Feb 2015 10:39:58 -0800
Message-ID: <xmqq7fw0uphd.fsf@gitster.dls.corp.google.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
	<1422484393-4414-1-git-send-email-gitster@pobox.com>
	<1422484393-4414-4-git-send-email-gitster@pobox.com>
	<54CDB5C6.3020702@alum.mit.edu>
	<xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
	<20150201215729.GA19692@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILuo-0006VA-Op
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbbBBSkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:40:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753737AbbBBSkA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 13:40:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B5E034331;
	Mon,  2 Feb 2015 13:40:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1PLN8/a2l5Zlk44UNV6IB5Xt9uE=; b=Ry6bkq
	C2uF0YGtPKNVgCEL2jF5gCx0RwhpenZhoNmWlfivhx5V4k43h8J//TU4ov6vCh+x
	RhtYA4UlzrH6pfDkzNg2LOTfmGgY6RQsVZZUAKEs656W9E55sY9QL7lEbuMgGBeQ
	sOCSE9F3q7DnkHyRkVYmo/fGeXB2BXTnSgoIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fY42EZWY2HNCHywdBE8p36KWjDuRaGAP
	Z10dfQUc5s5k9d66e5Qkq1g2YGPaIaXUk8A7IU4e2iC1Qq9EepPUeGlwKX/HAXRp
	BG3KC/VLO0i9JQtl1MzUMEvLLOAVbKRfkRS1eZ/HgdCOmyS2QkaKdguPawSmm2cL
	o8jWQMFCUMk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E173D34330;
	Mon,  2 Feb 2015 13:39:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5686D3432D;
	Mon,  2 Feb 2015 13:39:59 -0500 (EST)
In-Reply-To: <20150201215729.GA19692@peff.net> (Jeff King's message of "Sun, 1
	Feb 2015 16:57:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E430054A-AB0A-11E4-B4EC-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263271>

Jeff King <peff@peff.net> writes:

I didn't reply to the latter part of this message yesterday, because
I wanted to think more on it.

> But is it such a bad thing to have them in conflict? Can't we define a
> set of rules that does what people expects? For example, by the "last
> one wins" principle, any time we see "whitespace.tab-in-indent", it
> clears the setting of "whitespace.indent-with-non-tab", and vice versa.
> This isn't represented syntactically in the config file, ...

I agree.  Both one-variable-per-knob and value-with-list-of-knobs do
not express the semantic linkage between knobs; once we convince the
users that one-variable-per-knob format does not mean they represent
independent and orthgonal settings, the issue becomes a trade-off
between

 * Is it concise to let end users skim through?
 * Is it easy to parse by scripters?

> By the way, this is the exact case I am concerned about for fsck.*. Our
> use case at GitHub would be something like:
>
>   a. We set up sane defaults for fsck.* in /etc/gitconfig
>
>   b. User complains that we will not accept their push, which contains
>      objects with malformed committers.
>
>   c. Support investigates, determines that the malformed objects are
>      part of a well-established history, and that they are OK to enter.
>
>   d. We relax fsck.committerIdent in that repo's $GIT_DIR/config file.
>
> Copy-and-pasting the rest of the rules from (a) into the repo config
> file in step (d) is not ideal.

It probably can be worked around by the later-one-wins rule per
item, e.g. after seeing "fsck.ignore = A B C" in /etc/gitconfig and
then seeing "fsck.error = B" in $GIT_DIR/config, the latter will
flip the three-way radio button for B from ignore to error (the
other possible setting of the radio button is 'warn'), while leaving
the three-way radio buttons for A and C set to ignore.

We can (and have to) do the same with "fsck.B = ignore" in
/etc/gitconfig that gets overridden by "fsck.B = error" in
$GIT_DIR/config, and that comes _free_, which makes it an
attractive proposition.

As I already said, I am fine with "fsck.missingTagger = ignore".
