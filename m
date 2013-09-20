From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: print in-body "From" only when needed
Date: Fri, 20 Sep 2013 11:17:45 -0700
Message-ID: <xmqq61tvqrw6.fsf@gitster.dls.corp.google.com>
References: <20130920101626.GA21684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 20:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN5H7-0005bj-5W
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 20:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab3ITSRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 14:17:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681Ab3ITSRs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 14:17:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DFDB4379F;
	Fri, 20 Sep 2013 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yi0hzi1HM/6saMJdUEghXTNYjxU=; b=ootfhv
	0ZmF9jtuMiXBCABWTtBsHc6VFYfNbvjpntDucxUh1PwhW6Kh38p12jM4awN2QHMT
	kz35GCr/9Mm1YB+fp2XevvqqJw83uknFe+CXgN2XwX6QO8MD185vHlLa8OHLCPX7
	Ht4BUmp4/+DZJKIZ0zn3vJJR9dXlPaC9PtuQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YOGC1yu2QGYSdck7qYiemM0LHaChQzlE
	EmE/zNlDiaGzxIluGFIlcGMCgXrhW76ByK6yCtDDFvYEbQZMO9LTMw5c9ELLzGlf
	voRtpDzZi4S8aFjU184XE9baVwf7s4ztGDUyX356/Tek6UMMrB4zhZKh8cA4VIW0
	ukV1W8s/7iU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF3B4379C;
	Fri, 20 Sep 2013 18:17:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A4F54379B;
	Fri, 20 Sep 2013 18:17:47 +0000 (UTC)
In-Reply-To: <20130920101626.GA21684@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Sep 2013 06:16:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3D58D9A-2220-11E3-B234-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235074>

Jeff King <peff@peff.net> writes:

> Commit a908047 taught format-patch the "--from" option,
> which places the author ident into an in-body from header,
> and uses the committer ident in the rfc822 from header.  The
> documentation claims that it will omit the in-body header
> when it is the same as the rfc822 header, but the code never
> implemented that behavior.
>
> This patch completes the feature by comparing the two idents
> and doing nothing when they are the same (this is the same
> as simply omitting the in-body header, as the two are by
> definition indistinguishable in this case). This makes it
> reasonable to turn on "--from" all the time (if it matches
> your particular workflow), rather than only using it when
> exporting other people's patches.

This fix makes 100% sense to me under the assumption that the
"--from" option is a good idea, but then it makes me wonder why we
need the option in the first place.  What would break if we made
pp->from_ident default to the value of GIT_COMMITTER_IDENT?
