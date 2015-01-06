From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] for-each-ref: Always check stat_tracking_info()'s return value.
Date: Tue, 06 Jan 2015 15:51:04 -0800
Message-ID: <xmqqsifnmpsn.fsf@gitster.dls.corp.google.com>
References: <1420451935-6008-1-git-send-email-raphael.kubo.da.costa@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:51:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8du5-0001Cv-WA
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 00:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbbAFXvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 18:51:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752219AbbAFXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 18:51:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4CC82DCDF;
	Tue,  6 Jan 2015 18:51:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uTUxBPdbjtVIPa86xz/ukwj6Pkg=; b=PU/s91
	36QMEv9fmrMSLO03rvDtn8czVEzGNdqbbCENG7jMrqSYYGH223Cdjvhy+7bHW/pP
	IyQaSgVi9BK38OuCojYjhZWrKb38kONAuBrWkXhTvbYR6l2vRH+gt8eV6bYisWf7
	R7y+dGfHfqSHzNZHwJ/QrNo+SO1rXUGvIt5kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSeYkgDHqIdsSOzkQJWKrpE6xsPr1NGC
	7N2kq+spTYqhfy/YtGA/tmrbLV/VcLnjNLbdjo9PuS7HjkeJQzfyz2y0Kb87nXXs
	BSWzJIFGjfDp7uUrAroHMrPR4J/TIxv4tFIC5q9lslP891lysZvJsPtkDIZc1wNa
	NnTJA3ti4FI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91AC12DCDE;
	Tue,  6 Jan 2015 18:51:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FB462DCDC;
	Tue,  6 Jan 2015 18:51:06 -0500 (EST)
In-Reply-To: <1420451935-6008-1-git-send-email-raphael.kubo.da.costa@intel.com>
	(Raphael Kubo da Costa's message of "Mon, 5 Jan 2015 11:58:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1D0D6EC-95FE-11E4-9FB8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262113>

Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com> writes:

> The code handling %(upstream:track) and %(upstream:trackshort) assumed
> it always had a valid branch that had been sanitized earlier in
> populate_value(), and thus did not check the return value of the call to
> stat_tracking_info().
>
> While there is indeed some sanitization code that basically corresponds
> to stat_tracking_info() returning 0 (no base branch set), the function
> can also return -1 when the base branch did exist but has since then
> been deleted.
>
> In this case, num_ours and num_theirs had undefined values and a call to
> `git for-each-ref --format="%(upstream:track)"` could print spurious
> values such as
>
>   [behind -111794512]
>   [ahead 38881640, behind 5103867]
>
> even for repositories with one single commit.
>
> We now properly verify stat_tracking_info()'s return value and do not
> print anything if it returns -1. This behavior also matches the
> documentation ("has no effect if the ref does not have tracking
> information associated with it").
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
> ---
> v4: Use Jeff's suggestion and simplify the test case and making it
>     easier to understand what is actually being tested.

Nicely done, indeed.  Thanks all.  Will queue with some cosmetic
tweaks.
