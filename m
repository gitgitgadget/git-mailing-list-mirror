From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the global packed_git variable static to sha1_file.c.
Date: Wed, 12 Feb 2014 11:28:55 -0800
Message-ID: <xmqq1tz8nn9k.fsf@gitster.dls.corp.google.com>
References: <20140212015727.1D63A403D3@wince.sfo.corp.google.com>
	<52FB22F3.8070100@gmail.com>
	<CAHOQ7J-2BkQOr+_BF42ja4pWaUWkt8OC-YE0ETwHAYsmrubi=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDfUd-00081t-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbaBLT3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:29:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbaBLT3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:29:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9C9A6A272;
	Wed, 12 Feb 2014 14:28:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vjFFCASGWJ+hMjJBwiRVbUWdQ5k=; b=N5CEq9
	Gxjc9xSjH7I87HJ6fsEqXz+t0rP/dV7XvPjTtH4wwsh5w7CQzS4j0sUWYma1Mfqs
	qOuWU+Z62x3fzMkasSHoC9IahQTRqSRJ2MtD446CK0ACNGUxLg+TnLnORDpPuPfv
	k+LFE2cH/6V961G53iDOdqxy6T7Fg/o9ZKJEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6HjAG8Jz3ixSUyTfUip5SwpctJVmbGh
	RFSfRFLC8FThSvvw5VNSNOlnN0vLelxgxr7KE0nTV7iczwZycSkuXdAb1iO0FEVU
	LHzFGpgr5esm5iSbRNo1bOeW0jGlvv/bEDHCBXIjDQe6DxBYmVoC2M7nOSWszb3R
	+kPEbVC8Y54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC4F6A271;
	Wed, 12 Feb 2014 14:28:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 705C96A26F;
	Wed, 12 Feb 2014 14:28:57 -0500 (EST)
In-Reply-To: <CAHOQ7J-2BkQOr+_BF42ja4pWaUWkt8OC-YE0ETwHAYsmrubi=A@mail.gmail.com>
	(Stefan Zager's message of "Wed, 12 Feb 2014 10:26:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EABFAC5A-941B-11E3-8928-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242016>

Stefan Zager <szager@google.com> writes:

> If anyone has a recommendation for a less labor-intensive way to do
> this in emacs, I'd be very grateful.

This is not "do this in emacs", but here is a possible approach.

You can ask "git diff" about what you changed, and actually apply
the change while fixing whitespace errors.  I.e.

	git diff sha1_file.c | git apply --cached --whitespace=fix
	git diff
	git checkout sha1_file.c

The first step will add a cleaned-up version to your index.

The second "diff" (optional) is to see what whitespace errors are
introduced when going from that cleaned-up version to what you have
in the working tree.

With the last step you would update the working tree version to the
cleaned-up version from the index.

	[alias]
	wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached --whitespace=fix;\
		git co -- ${1-.} \"$@\"' -"
