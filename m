From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat() functions
Date: Thu, 18 Jul 2013 16:32:11 -0700
Message-ID: <7vd2qf1m2s.fsf@alter.siamese.dyndns.org>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk>
	<51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org>
	<51E4AABD.9010701@web.de> <51E4C400.6000009@gmail.com>
	<51E82AE0.9050707@ramsay1.demon.co.uk> <51E862FC.4090607@web.de>
	<51E86E02.4060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 01:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzxgI-0000S8-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934677Ab3GRXcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 19:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934602Ab3GRXcN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 19:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C72A32DD0;
	Thu, 18 Jul 2013 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9qVzHcd6DSC5euUPD6yWjUPN7o=; b=rurYG6
	SauFjcje44VI1qKCqp9zCjmcUiSWYY90iDhQfG8vw3DoVUmexH/cNNi17bnNeYXV
	8HMsLcmjrP2pfw6ok0F+4yV69mrX7CZv7Dzgbc3Qjq1dvo/VjrXH0Iia62HLnARf
	GaxOs+4+1cLw7LpoJ/j4XfVOhWsldFobAvInY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKh7RWWYFBGtj/X9xAnf4vFZVZK1T7CB
	gRrK3hdBZ84ADyvhOU10wAcSk3VPz2CgRCPesv7hRNoWfXTvTCB8ENrpXZG5fJ7J
	lvg0VVoA5jBjmHVWwDEAtxQQjd7bFBkotJ8zd4flrKmfCz1AqVi6vbUmvAmZH5po
	toytHETDX6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3024432DCF;
	Thu, 18 Jul 2013 23:32:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 832AF32DCE;
	Thu, 18 Jul 2013 23:32:12 +0000 (UTC)
In-Reply-To: <51E86E02.4060208@gmail.com> (Mark Levedahl's message of "Thu, 18
	Jul 2013 18:36:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45CF468C-F002-11E2-B28B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230767>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Unlike the results on the fast Win7 laptop, the above show
> statistically significant slow down from the fast_lstat approach. I'm
> just not seeing a case for the special case handling, and of course
> Junio has already voted with his preference of removing the special
> case stuff as well.

Please don't take what I said as any "vote" in this thread.  I do
not have a first-hand data to back anything up.

I was primarily trying to see my understanding of the consensus of
the thread was correct. If we can do without s/lstat/fast_lstat/
almost everywhere in the codebase, of course, I would be happier, as
it would give us one less thing to worry about.

If the assumptions like "they were declining minority and only lose
population over time", "it is easy for them to revert the removal
and keep going", and "removal will not hurt them too much in the
first place, only a few hundred milliseconds", that might trump the
longer-term maintainability issue, and we may end up having to carry
that win32 stat implementation a bit longer until these users all
switch to Cygwin 1.7, but judging from the "cvs binary seems to be
built incorrectly" incident the other day, it might be the case some
users still hesitate to update, fearing that 1.7 series may not be
solid enough, perhaps?
