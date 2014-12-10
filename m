From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Wed, 10 Dec 2014 10:15:30 -0800
Message-ID: <xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:15:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylnY-0004Mq-0T
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbaLJSPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:15:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932479AbaLJSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:15:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D913F22ACC;
	Wed, 10 Dec 2014 13:15:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KL0kkpLYJZs7PuxZbHj8CQfSNbQ=; b=lSe7gI
	7Nf1ypNHpl+2f1aLTAPci1j3pt5KvEtDzYDZMpbE+EXi8Kx4be/0bYfNK/tTGeXY
	eNHOUKEYpIFrDWNvEQ+vcdIRBNj5RdfMEAjhJFTb5/QorE6TJY6rvT9S2dCKUmiE
	v48gVjxp2jYREe2dzTBLqFiRDzlZbjWgOrH4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=goUKDpUmnDPqm7HiRxgzTLeXZwvJE6JS
	JOwyYRLAm8dZx7dGHuA4rqv6ynmNE825jTM3wZJnGLfQfjpbP2FxKiK1YKntt5uV
	sE0a4+5xA3sIwnrPY9hg0n1tS+XBEb0HCwYrxjesKehU8JMZqTKA++fNa5asXa6A
	InXU3yLOvLU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF43222AC8;
	Wed, 10 Dec 2014 13:15:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A704622AC6;
	Wed, 10 Dec 2014 13:15:31 -0500 (EST)
In-Reply-To: <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:15:32 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 870A2AB8-8098-11E4-9306-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261233>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We already have support in `git receive-pack` to deal with some legacy
> repositories which have non-fatal issues.
>
> Let's make `git fsck` itself useful with such repositories, too, by
> allowing users to ignore known issues, or at least demote those issues
> to mere warnings.
>
> Example: `git -c fsck.missing-email=ignore fsck` would hide problems with
> missing emails in author, committer and tagger lines.

Hopefully I do not have to repeat myself, but please do not have
punctuations in the first and the last level of configuration
variable names, i.e. fsck.missingEmail, not mising-email.

Should these be tied to receive-pack ones in any way?  E.g. if you
set fsck.missingEmail to ignore, you do not have to do the same for
receive and accept a push with the specific error turned off?

Not a rhetorical question.  I can see it argued both ways.  The
justification to defend the position of not tying these two I would
have is so that I can be more strict to newer breakages (i.e. not
accepting a push that introduce a new breakage by not ignoring with
receive.fsck.*) while allowing breakages that are already present.
The justification for the opposite position is to make it more
convenient to write a consistent policy.  Whichever way is chosen,
we would want to see the reason left in the log message so that
people do not have to wonder what the original motivation was when
they decide if it is a good idea to change this part of the code.

Thanks.
