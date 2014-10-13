From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 11:43:32 -0700
Message-ID: <xmqq8ukj4xpn.fsf@gitster.dls.corp.google.com>
References: <20141010062722.GB17481@peff.net>
	<20141010064727.GC17481@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:43:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdkay-0003Bp-BH
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbaJMSng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:43:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753797AbaJMSnf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:43:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0E23150B9;
	Mon, 13 Oct 2014 14:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pfmCHmLW/ZxESgALu+dylNh2m2c=; b=bc5Q0A
	ZlPFVDxBZR/QbDRygd4B9E/jm3ewBbNXvGejvQGCZo382WjJvqDPThFbsd0Nw0FU
	owaOcmDC5cla+NXJzHq0/baNcoEnzLRb/i/mYEmIhv03bntw2c9e9PwmwHont745
	oqNQWetr0uIoGQCXX+d1vO+cBbUr2wE/1j9sM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tk+iZmyMiqIWcXa5uyjlZdjYJ+xmtrEG
	DmS+FMAhOelkT6lKzY374NZO7AoS3mwRT/FXnEhRFghJ2vHALHOjubcPL3ZJwtKo
	JgrtYHe2BruXPdS5cBo6fh7lZYDtK5PAzwQHUHLIThnlVcYFI0CS9Yy0azGf4O3B
	F/PqmrSCbS8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98AFB150B8;
	Mon, 13 Oct 2014 14:43:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F0C6150B7;
	Mon, 13 Oct 2014 14:43:34 -0400 (EDT)
In-Reply-To: <20141010064727.GC17481@peff.net> (Jeff King's message of "Fri,
	10 Oct 2014 02:47:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5E550A8-5308-11E4-8824-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Hmph. I had originally intended to make this "set -x;" with a semicolon,
>> to keep it split from $*. But I forgot to, and much to my surprise, all
>> of the tests still passed.

Yup, I was wondering why you posted a version without the semicolon,
which looked obviously bogus, as I've never seen you post an
untested thing without marking as such.

> +	# The test itself is run with stderr put back to &4 (so either to
> +	# /dev/null, or to the original stderr if --verbose was used).
> +	{
> +		test_eval_inner_ "$@" </dev/null >&3 2>&4
> +		test_eval_ret_=$?
> +		if test "$trace" = t
> +		then
> +			set +x
> +			if test "$test_eval_ret_" != 0
> +			then
> +				say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
> +			fi
> +		fi
> +	} 2>/dev/null

Hmph, that is a clever way to squelch output from set+x (and
everything that runs after the eval returns) I never thought of.

Nice.
