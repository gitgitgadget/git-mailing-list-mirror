From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Wed, 30 Apr 2014 12:16:00 -0700
Message-ID: <xmqqy4ymeihb.fsf@gitster.dls.corp.google.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
	<53614470489f9_f9b15012ecbc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZzI-0007yB-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759417AbaD3TQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:16:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759344AbaD3TQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:16:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8A17EE18;
	Wed, 30 Apr 2014 15:16:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vOskiiMwAw6mQZ/a/ghfb1zx8MA=; b=PaBXKt
	n5ZAdpcGiN4rzdc4IXh47kZ6wFcGKmnKupPULpFKNC0xPx7GhPJIHJNAmGRFsBJd
	UpPFtCWrJtsJMKrZxDaRg9HcsGFvduLNjI9sxr751ibf1kXL1sKKuOkmfBBGyKRV
	QK8xfoIuDowMfegzMx2A+bqk4sTljilDZXh+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d+hjYUlkVK8mbrlrZ62xxwM4HteBtsTo
	hHgbpPfFjcJjU0r3k6KJzqmgbVeg3ns64H3+8QxRNGkSqOrCqn0Xm7AaIKSYBqhF
	lGpAYKfNQA+5ZhrvPgQXNdnaVAa8rQz3BhY5TJnozFeifhN2uoQTNIAlwZUoldjm
	siZmT1pwjds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 843067EE15;
	Wed, 30 Apr 2014 15:16:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 879B07EE10;
	Wed, 30 Apr 2014 15:16:01 -0400 (EDT)
In-Reply-To: <53614470489f9_f9b15012ecbc@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 30 Apr 2014 13:44:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE233310-D09B-11E3-A612-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247759>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>     - With the endgame of "out of box Git without any configuration
>>       refuses 'git pull' (without --merge/--rebase) that does not
>>       fast forward" in mind, start warning "In the future you will
>>       have to either set pull.mode (and/or its friends) or type
>>       "pull --merge" (or "pull --rebase") when the endgame version
>>       of 'git pull' would fail with the error message, but still do
>>       as was asked to do as before.  At this step, existing users
>>       can set pull.mode to "merge" or "rebase" or whatever to
>>       squelch the warning.
>> 
>>     - Flip the default.  By the time this happens, thanks to the
>>       previous step to warn beforehand, nobody needs to see the
>>       warning. (your step 4)
>
> This is what my last version of the series did[1]. However, my plan was
> to land this in 1.x so users could see the warning, and then flip the
> switch on 2.0.
>
> This plan, however, fell off the cliff.

Yeah, I see that $gmane/234488 explains why the second step in the
previous one stopped.  I guess it was in expecting a reroll state,
waiting for that other topic (I do not remember offhand) to
graduate.

I see nothing touching the affected codepaths now, so this time
around we may have a better chance, perhaps?
