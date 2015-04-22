From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wrong gitignore precedence?
Date: Wed, 22 Apr 2015 11:59:04 -0700
Message-ID: <xmqqh9s8dm6f.fsf@gitster.dls.corp.google.com>
References: <20150422150558.6326cb6152a306f028fb6ad3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yohei Endo <yoheie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykzru-0004zo-Gv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682AbbDVS70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:59:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753710AbbDVS7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:59:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11EA04A91D;
	Wed, 22 Apr 2015 14:59:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9lGyen0NPUg5m8wymVOXH2BiH3o=; b=ZgT/po
	YHhx/ZI8ZQtgGJmef+p/rGA3IL+5uIEq0HsiGrlces9k3oBVptwJ8HqkZWvNN6QN
	yjzTJ1af+ViGSx5uo8+fGGrL55fwApdTMfvzWRzMlPxpFRQmndPbw9zI0yGX36sn
	BVDPOVZVxIEZCqrAbpPhwwY+4lwps8a/RONu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aX2QopAcmmEklmJJhKEVVShdap0vDy3f
	pGg6g/1yhFIDo9yJ79QiRxNpQ+DIxzOFkGRCA0HRD+EVVJDQ4VCu01JeDtw9dy/y
	0UswedRPQEFspRufQmT4Rs+NwVV9xjKu34gmhK+tUf6/H1UBUPS8k/hNw2Sr/HnX
	WnCDgfVhgU8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09EDF4A91C;
	Wed, 22 Apr 2015 14:59:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82DE64A918;
	Wed, 22 Apr 2015 14:59:06 -0400 (EDT)
In-Reply-To: <20150422150558.6326cb6152a306f028fb6ad3@gmail.com> (Yohei Endo's
	message of "Wed, 22 Apr 2015 15:05:58 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A68E6B0A-E921-11E4-8D6F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267610>

Yohei Endo <yoheie@gmail.com> writes:

> I read the document of gitignore (http://git-scm.com/docs/gitignore),
> and learned that $GIT_DIR/info/exclude has higher precedence than
> the file specified by core.excludesfile.
>
> But I noticed that patterns in core.excludesfile override patterns in
> $GIT_DIR/info/exclude.

I tend to agree that info/exclude which is per-repository personal
preference should take precedence over $XDG_HOME/git/ignore which is
a personal preference across repositories that are accessed from
that machine.

It appears that the precedence was screwed-up between these two
files from the very beginning when 896bdfa2 (add: Support specifying
an excludes file with a configuration variable, 2007-02-27)
introduced core.excludesfile variable; seeing that nobody so far
complained with the discrepancy between the documentation and the
behaviour, it would indicate either (1) nobody reads the docs, or
(2) nobody uses both at the same time.

Swapping the order in the code this late in the game after 8 years
may affect people who have come to rely on the current behaviour and
never read the doc, which is somewhat worrying, though.
