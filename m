From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add GIT_PATHSPEC_GLOB environment variable
Date: Wed, 19 Dec 2012 14:00:03 -0800
Message-ID: <7v7god8zz0.fsf@alter.siamese.dyndns.org>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <7vk3sd930z.fsf@alter.siamese.dyndns.org>
 <20121219210919.GA11894@sigill.intra.peff.net>
 <20121219215008.GA17908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:00:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlRgi-0002n7-6s
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 23:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab2LSWAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 17:00:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab2LSWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 17:00:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C78FD68B7;
	Wed, 19 Dec 2012 17:00:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g6fnci6VxgLjVSK0/ymXuzX3OkA=; b=Q+hN18
	RjCC2UHiOReKBRNQH7w4OEU2AGKD2iuv760im2APYayHDVZU0dv9qZDi6r8p+Mks
	oVEREUYZPJlt0r53PtIgx2BeZsaDGsajSV2M41ES6IeSCaoUwI2Fhb/Y+RAEU7qD
	wR4TycO8SjYK3lE+/ino+qCdzrGHg37e/ef+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CoA78dMFw4QlrFGekdEfyDuDTYkqXgQP
	wZhqBl1sgAuNnzjHTLANY6PLqJ6T3dzwGmgaveOTYI/WyzQ3ZQ0HnQmiAHmPPWpP
	tugeLw72cJolAZbjQspv7ZeiNbQ5NRDHGFFvCnsHkWvycxyv8ninX53V/FW/MmYg
	9mtXluk6Zl4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7897B68B5;
	Wed, 19 Dec 2012 17:00:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46C2E68B3; Wed, 19 Dec 2012
 17:00:07 -0500 (EST)
In-Reply-To: <20121219215008.GA17908@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 16:50:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 736849DA-4A27-11E2-9B74-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211855>

Jeff King <peff@peff.net> writes:

> I included the common_prefix fix you mentioned (I do not think it
> produced incorrect results as it was, but it did not take full advantage
> of an optimization).

I do not think it would have affected the outcome; you would only
have worked with more cycles.

> Subject: add GIT_PATHSPEC_GLOB environment variable

Seems cleanly done from a quick look.

Given that the normal mode of operation is to use globbing, I
suspect that the names would have been more natural if the toggle
were GIT_PATHSPEC_LITERAL and the boolean function were
limit_pathspec_to_literal(), instead of "allow_pathspec_glob()",
sounding as if using glob is done only upon request.

But that is a minor issue.

> This patch introduces an environment variable to turn all
> pathspecs into literal strings. This makes it easy to turn
> off the globbing behavior for a whole environment (e.g., if
> you are serving repos via a web interface that is only going
> to use literal programmatic pathspecs), or for a particular
> run.

I am not sure if "web interface" is a particularly good example,
though.  Is it unusual to imagine a Web UI that takes pathspecs from
the user to limit its output (e.g. "diff" or "ls-tree") to those
paths that match them?  In such a case, the user would expect their
pathspecs to work the same way as the Git installed on their
desktop, I would think.

Will queue; thanks.
