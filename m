From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t7503: use write_script to generate hook scripts
Date: Wed, 26 Nov 2014 12:07:35 -0800
Message-ID: <xmqqy4qxpvy0.fsf@gitster.dls.corp.google.com>
References: <cover.1416955873.git.oystwa@gmail.com>
	<78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
	<20141126045127.GC15252@peff.net>
	<xmqqk32hrfuv.fsf@gitster.dls.corp.google.com>
	<20141126190315.GB1734@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 21:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtisI-0000Bx-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 21:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaKZUHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 15:07:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751107AbaKZUHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 15:07:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F7021384;
	Wed, 26 Nov 2014 15:07:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nsYrN1KMSPkJDhGqSXBul7U++mI=; b=domVGS
	1Se4zQ/jJE0J/nY+QoSb458Unepzs4ucZQZhUexUgHozUgXrxdRBjGjetEGSBypt
	hQHFCKjZtzE1D+zXjiWVrU2HA0Q/K5aCGjC2YYVUDwdYWVxmy96vsqP6e/SagNNR
	PIsCL0xJlRAJPKX6ujnBjFpbDVGyXM1T3LMVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MPOqUBVpsjy/hvpIOsg3fOyVcV7mEBp7
	GNUB9FqSArrXfz9LzGH2jnUBZfqKhr8yoJgePNbWpqTCHK+2gTFbWtziynLD4Qy5
	0NjCX02LUrIF8Ha4leYN8th7/OI8NVtN60jxOB03wPYpFqmiOPkB1ONTp+cmb9Es
	gXqR4NUGznA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 583B621383;
	Wed, 26 Nov 2014 15:07:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C96AF21382;
	Wed, 26 Nov 2014 15:07:36 -0500 (EST)
In-Reply-To: <20141126190315.GB1734@peff.net> (Jeff King's message of "Wed, 26
	Nov 2014 14:03:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDC0D07E-75A7-11E4-A1AF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260298>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 26, 2014 at 10:12:08AM -0800, Junio C Hamano wrote:
>
>> >> +write_script "$HOOK" <<EOF
>> >
>> > While you are touching this line, please make it "<<\EOF". It does not
>> > matter for these simple cases, but as a style, we try to avoid
>> > interpolation unless it is necessary.
>> 
>> Thanks.  It is more about reducing cognitive burden from the
>> readers.  An unquoted <<EOF signals you that your eyes need to scan
>> carefully for $subsitutions to understand what is going on, instead
>> of coasting it over.
>
> While we are talking about it, do we have a style preference on
> always/never using "<<-" unless necessary? I do not think it is as
> important as preventing interpolation, because it does not introduce a
> cognitive load in the same way. But consistently using "<<-" is one less
> thing for shell newbies to be confused by, and to get wrong when
> cargo-culting.

Not using "<<-" is a sign of another problem that is bigger, namely,
the test vector is prepared outside of a test_expect_success setup
block.  Inside test_expect_success, I'd prefer "<<-" to make it
clear where each test begins and next test begins, which would make
it easier for our to coast over.
