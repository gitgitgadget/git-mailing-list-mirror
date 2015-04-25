From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Avoid file descriptor exhaustion in ref_transaction_commit()
Date: Sat, 25 Apr 2015 12:27:59 -0700
Message-ID: <xmqqk2x0ypmo.fsf@gitster.dls.corp.google.com>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
	<20150424172648.GB30592@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 21:28:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym5kR-0004lZ-9k
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 21:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbbDYT2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 15:28:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750749AbbDYT2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 15:28:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 033F64A88B;
	Sat, 25 Apr 2015 15:28:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lz7ph6kAzT6k9lLxcEAjomHh66M=; b=e6+CH/
	1vUOKU2azZrr3+ksRMMqrYXgNTjbgV5QSdx5NGaa6sPPyn2T+WWwGqJ4I5fwhtXG
	HBVyyzXQFOK0H7SYg10yQMWV9K8eaOAKTcQfQPmBYQCL4Um/FSOAdHP1rrOJ/XWT
	mlNIE5gPFefYp38PG/jGEnYEegPaCPZsTzmPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJAznNyo9qjQ9VIQNPSEsYLUpiuGXw7X
	W7vb03dkSW07xuCNv0itgBQP3e934Pl1ZeuX6eVlUOdSW0CADpRGQuh+Usrol/4J
	L62vCuvqAmDxGFhuvKyL6z61izexHlY6YpMMTKcCj8dtdAziZkxGgDK6CjVhILSq
	j3csMcoGuoo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0A504A88A;
	Sat, 25 Apr 2015 15:28:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D8374A889;
	Sat, 25 Apr 2015 15:28:01 -0400 (EDT)
In-Reply-To: <20150424172648.GB30592@peff.net> (Jeff King's message of "Fri,
	24 Apr 2015 13:26:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FEE8860-EB81-11E4-9B81-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267799>

Jeff King <peff@peff.net> writes:

> Stefan's patch is just in pu at this point, right? I do not think there
> is any rushing/release concern. It is too late for either to be in
> v2.4.0, so the only decision is whether to aim for "master" or "maint".
> To me, they both seem to be in the same ballpark as far as risking a
> regression.

The series builds on c1f0ca9 that is on 2.4.0-rc2, so we would need
to wiggle things around to apply to older codebase if we want to fix
the "too many open file descriptor" issue on older maintenance
releases for "update-ref --stdin".

I personally feel that it is OK to ship v2.4.0 without the fix,
leaving "push --atomic" broken, and fix it in v2.4.1, but I kinda
prefer that the final fix to be applicable for older maintenance
releases, at least to 2.3.x track, if not 2.2.x track.
