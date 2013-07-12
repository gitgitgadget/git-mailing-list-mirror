From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Fri, 12 Jul 2013 12:52:09 -0700
Message-ID: <7vtxjzk13q.fsf@alter.siamese.dyndns.org>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org>
	<20130712190531.GD8482@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 21:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxjO5-0004zm-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757638Ab3GLTwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 15:52:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757533Ab3GLTwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:52:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D042A30979;
	Fri, 12 Jul 2013 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xwK3KQxg1xAhRdJOH41wz6Y8uN4=; b=O/e5Mc
	so4rnTVoaY0QQBtAauGoCHfDguHWm4RuBFVvY0VJxUy9yZLEEZ0kCvm0wjUYl/XM
	FVzAUp4eNLIGnhWVTciCr0lq3urcWNccDeZ2r/U9vQLg7Q5YUJlSy0db2C/tQXbZ
	pngCyCKPMLWCQOR1cbUFC4R5dsd0UQ+26rD1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=To7XPuRY6Ft3hSLZVAzsM9DfG0i2bs1o
	W3jW/meYbHw822+yvEYeGBADn+g/di0r4lXQH6+jlOCfD9sFJ3avNbpwYrnmIIYn
	Phq3q/nj/WqDYvHP6OXA8CwsTWJyU/eiQUbIytwzRGrEuSEgXhJq2JIc5JRnTYln
	Ssug5e9UX1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C536930977;
	Fri, 12 Jul 2013 19:52:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 206D930974;
	Fri, 12 Jul 2013 19:52:11 +0000 (UTC)
In-Reply-To: <20130712190531.GD8482@google.com> (Jonathan Nieder's message of
	"Fri, 12 Jul 2013 12:05:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AA0FD76-EB2C-11E2-A539-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230245>

Jonathan Nieder <jrnieder@gmail.com> writes:

> FWIW the GIT_SSL_CERT_PASSWORD_PROTECTED envvar has a similar "can
> only enable" behavior, but since it's documented, that's not as big
> of a problem.  Do you remember why it was written that way?

Not me ;-).

If I have to guess, it is probably that these two are thought to be
equally trivial way to defeat existing environment settings:

	(unset GIT_SSL_CERT_PASSWORD_PROTECTED ; git cmd)
        GIT_SSL_CERT_PASSWORD_PROTECTED=no git cmd

> When that setting was first added[1], there was some mention of
> autodetection if libcurl could learn to do that.  Did it happen?

I do not think so, but let's see if our resident cURL guru has
something to say about it.
