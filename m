From: Junio C Hamano <gitster@pobox.com>
Subject: Re: hooks not fired by a merge's auto-commit
Date: Thu, 29 Jul 2010 09:50:01 -0700
Message-ID: <7vzkxatepy.fsf@alter.siamese.dyndns.org>
References: <AANLkTindr-y0uAu46FVEqtB5BLw9ZjB0y0ETwmW+8+PV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Bronosky <Richard@Bronosky.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 18:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeWJI-0002nY-Tc
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 18:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab0G2QuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 12:50:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab0G2QuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 12:50:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C85FC9D59;
	Thu, 29 Jul 2010 12:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ozEmuyhyneQIzsxnpXBxIJ01qAI=; b=PdGDeN
	WYUCbIBki/0FJZBGDlGUbLzYv3MbjlwuzlD8r1hdZ8GTV0XnkFQBIGrXSZF0ve4K
	pwM9ewXgomlDcviSpqBiRIndJZhmZfjAucLvNlsplr3nQysHnUiuQw9tv5tS1or1
	1OWzpgwjunbSz9HCpBYUCQ52HNN7xj/fjaYsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IwtN+aRlbAdzkKeExf8nFuLm5wMy32T3
	5DapOgCuRJD5rQgQK+pwd9oTSFVLvS5gg8ZWMoude1nAUHThj8E+ROoz2bZCEelF
	/B2xXvSrfKDOgVXlBnRjwJgo/2KEsmL8zIND0UJmzGXSngrCqsCFrEG3rBkGP9HU
	Gfnkkf6kcj0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E44C9D56;
	Thu, 29 Jul 2010 12:50:06 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1605BC9D52; Thu, 29 Jul
 2010 12:50:02 -0400 (EDT)
In-Reply-To: <AANLkTindr-y0uAu46FVEqtB5BLw9ZjB0y0ETwmW+8+PV@mail.gmail.com>
 (Richard Bronosky's message of "Wed\, 28 Jul 2010 21\:25\:36 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5748F530-9B31-11DF-89BE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152187>

Richard Bronosky <Richard@Bronosky.com> writes:

> Using git 1.7.1 it seems that a merge (more specifically the
> auto-commit) does not fire any of the following hooks:
> pre-commit  prepare-commit-msg commit-msg
>
> Is that by design?

I would probably call it an unintended design that now has long been
established that changing it may break people's existing setups rather
badly.

Especially pre-commit hooks that look for and prevent common mistakes from
happening for individual developers may not want to run, when you are
pulling in other people's work that already has the mess they created.
Such problems are often either too late to fix or you are in no position
to reject their pull requests.  So you would break _my_ workflow (and
others who play similar roles as me, making changes themselves and merging
others work) if you did such a change.

You _could_ add pre-merge to introduce it as a new feature.  For people
who want to apply the same check for merges and individual commits
(e.g. those who never merge other's work), pre-merge can just invoke
pre-commit.
