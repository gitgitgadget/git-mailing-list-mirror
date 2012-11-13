From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Mon, 12 Nov 2012 16:55:13 -0800
Message-ID: <7v1ufygw3y.fsf@alter.siamese.dyndns.org>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <20121113000637.GI10531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:55:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4mr-0005ZH-N1
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab2KMAzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:55:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab2KMAzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:55:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BA27AF2A;
	Mon, 12 Nov 2012 19:55:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N6whhtNAAyb/7nKvv8+9GcCEmvo=; b=nOCp53
	70zQuJvaT89F9JyJEqrRYs7fRookYvEO4ej+XipKBpUek1aJwy6KIhJoUap0GoPb
	vrmBTrtvtdCLXYmByhxIEelWdXs91ZCZw1FVJt06QQOfTpB4gLzL7tf/Y99e2L9t
	mvBU03K+xYNoaBE0YjduQJKbrCD18WXOi3/q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oM23pFwRomzTSsdf2ojbCWrDotytqIu5
	xjpiqudadXCzo3x/YTkrXz1bWOiG18MKTfxRsLiJ/YuJ96X3dBkSbeevkqvytoHc
	jxm7WrqDONyihbPjtm2DFrgB1EcWhfyZoSeTqLyfQnX1HkB3eW7HrOiVwvza09Ur
	zxnI+SQmhxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 097DFAF29;
	Mon, 12 Nov 2012 19:55:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 537AEAF28; Mon, 12 Nov 2012
 19:55:15 -0500 (EST)
In-Reply-To: <20121113000637.GI10531@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 19:06:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C94B63EA-2D2C-11E2-9AAD-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209556>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 12, 2012 at 07:02:17PM -0500, Jeff King wrote:
>
>> The one distinction that would make sense to me is pausing to ask when
>> we use "implicit" methods to look up the ident, like concatenating the
>> username with the hostname to get the email.
>
> By the way, I suspect this is the answer to "what do people type for
> this prompt". It is probably more about a safety on bad ident than it is
> about people routinely updating the information. I actually think it
> would make more sense to drop the prompt entirely and just die when the
> user has not given us a usable ident.

Yeah, I agree with pretty much everything you said in this thread
(including that environment and config are equally likely to reflect
user's wish and it does not make much sense to treat environment as
more suspicious).

> But maybe people who do one-off format-patches would rather type
> their name in a prompt than set an environment variable and re-run
> the program.

s/one-off format-patches/one-off send-email/.  I think dying will
force them to configure their names once (so that later invocations
do not have to stop) while prompting will force them to type their
names every time, so the current behaviour is probably a false
economy.  As long as we caution users in the release notes, it
probably is OK to change the command to die.
