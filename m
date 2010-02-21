From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/12] several notes refs, post-rewrite, notes
 rewriting
Date: Sat, 20 Feb 2010 19:47:37 -0800
Message-ID: <7vhbpb2qsm.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 05:14:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2na-0006d4-HH
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227Ab0BUDrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:47:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224Ab0BUDrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:47:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 015739BF30;
	Sat, 20 Feb 2010 22:47:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j05EIlIHf5Orsyx3wUvZAZSjamc=; b=I8eSQW
	Pt3Da/U0UBylcK4GT1OD5DJSgWc+wizq0dXMrB05PBo94m47InovVIG7Fskfp+4i
	mugNYwiWgnHqzU13BWsYfJUdEXqLx4eFAVGST53jvOnV/3wjUzpIB2LCIwKzkxOb
	rt3Vya2DhGkSR9ADN+ZQQaPeDWmUouoV08kYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I+mxm5DPSpbyNzUxUbqDZKKcNhCMazE2
	imIZz1Coxn/Vh6UoFofdVXimF24+HSjlSwV2DEzJvF1QpNN6ra0y94qTh0mxtok/
	zKSaIkx0263Z0fQSs6Fp+HhEe8j3ZQy7sjHofhDss91I/2EJ221ofdENKPctIO3J
	1oUCOw5eqmM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD689BF2F;
	Sat, 20 Feb 2010 22:47:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A1FB9BF2E; Sat, 20 Feb
 2010 22:47:39 -0500 (EST)
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Sat\, 20 Feb 2010 23\:16\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEF5E80C-1E9B-11DF-8F14-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140592>

Thomas Rast <trast@student.ethz.ch> writes:

> Brief overview of changes since v2, with some inline questions about
> things that need to be settled:
>
> * new [1/12] "Support showing notes from more than one notes tree" that
>   teaches a "notes.displayRef" option which can glob for notes that
>   should be shown, and can be specified more than once.
>
>   - maybe we should default this to "refs/notes/*"?

Probably not.

I like the general direction in which this series is going, but a config
that does not have any command line counterpart is a design mistake.

When adding a feature, always start from the command line option, and then
add configuration mechanism purely as a convenience (so that users do not
have to give the same option every time they run the command).  By forcing
yourself to stick to that design pattern, it is easier to ensure that any
new feature can be disabled by people who do not want it from the command
line.

> * new [12/12] "notes: add shorthand --ref to override GIT_NOTES_REF"

Hmm; if this will _always_ be limited to "git notes" command and no other
commands will _ever_ learn a command line option to override what notes
namespace to use in the future, then "--ref" is perfectly a good name.
But otherwise, "git log --ref=notes/amlog" would look _very wrong_, and
would end up being called "git log --notes-ref=notes/amlog" instead.  When
that happens, "git notes --ref=notes/amlog" would look inconsistent and
people will complain, no?
