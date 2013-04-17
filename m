From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Wed, 17 Apr 2013 10:37:25 -0700
Message-ID: <7vbo9df48a.fsf@alter.siamese.dyndns.org>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
	<CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
	<CALkWK0=L4mqVBqDMWgzN+BT5bnEF0L6d=GPXvrNhPL_Asvdq8Q@mail.gmail.com>
	<CA+sFfMd-pfmPXNCoAfH59om1cdYh1=bJ7yb-BGZHjkra5Gm_uw@mail.gmail.com>
	<CALkWK0kJOSBN8XTJKBLOqi4tUjjm9unr=No65TtW9V0qvKmV-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 19:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USWIX-0005n5-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 19:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936177Ab3DQRh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 13:37:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272Ab3DQRh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 13:37:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CD9614220;
	Wed, 17 Apr 2013 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P3ZMJn80asFTAogDX4awylRz7tg=; b=OPm0uw
	oa73sROl9hPzFneFgTnqyzNaAR+SwnN/vXTp04tFemTJrv+C8vN1fGsNyMPolH/X
	LxeLS/rVpB/fKcYAHseT87Xt9I9g8PLgFHlPn8J8Kv3/cMOo/X1xrPny0mOeKOOL
	CL+gVdH0/ajUyjW9OX2GiaOmeiRrqh1RO31hY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIscHGtpmpbO9XF6h17fKOCHOqPpSRJo
	7ElZPCTOyfwI6ox0wCx4lPhA7SfXkRf88OeEzoMA2usAd40oxijb4CFZqH3cIJcD
	S8nWJMwOXOreBIkivJb8Wj8oV2QTZCXdWaicMNKofgchscSzUdG9Wx6mY58K96EZ
	p+41/WnxtCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 704891421F;
	Wed, 17 Apr 2013 17:37:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D12E91421E;
	Wed, 17 Apr 2013 17:37:26 +0000 (UTC)
In-Reply-To: <CALkWK0kJOSBN8XTJKBLOqi4tUjjm9unr=No65TtW9V0qvKmV-A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 17 Apr 2013 14:01:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 787FED7C-A785-11E2-B419-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221555>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 1. Any stash that can be shown can be applied, but not necessarily
> popped or dropped (as the documentation indicates).  The reason for
> this is simple: a pop/drop attempts to clear the entry in the stash
> reflog as well, but all stashes need to have a corresponding reflog
> entry (for instance, those created with 'stash create').

Correct.

To show or apply, you only need a product of "stash create" that may
not be linked anywhere in the refs or reflogs.  But you can only pop
or drop something on the stash reflog.

> 2. IS_STASH_LIKE is a misnomer: all it checks is that the given <rev>
> is a merge commit.

The purpose of the logic is to reject a mistake to name stuff that
is clearly not a product of "stash create".  The name is just being
humble by not claiming "I know this is definitely a product of
stash-create" but merely hinting "This smells like such an object";
I am not sure if that is a "misnomer".

You are free to try to think of a way to tighten the implemention to
reject a random two-or-three parent merge commit that is not a
product of "stash create".  People already have looked at this code
since it was written, and didn't find a reasonable way to tighten it
without triggering false negatives, so I wouldn't be surprised if
anybody tried it again today and failed.
