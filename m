From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 06/19] rebase -i: Stop on root commits with empty log messages
Date: Thu, 10 Jul 2014 10:33:13 -0700
Message-ID: <xmqqion586g6.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<00ca9dc0d1750301aa22c2bb78976b141233cef3.1404323078.git.bafain@gmail.com>
	<xmqq8uo38p28.fsf@gitster.dls.corp.google.com>
	<53BE5D0D.8090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 19:33:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5IE0-0007Yi-N3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 19:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbaGJRdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 13:33:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59884 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaGJRdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 13:33:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F40226ADE;
	Thu, 10 Jul 2014 13:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EupFzaHvutg3gHolLRvkfLPrJmk=; b=ecFos7
	Z+LiCb3VLqmngWt3vcJV2tVWuQUjixmiA+5xdalhcKbBsrgaW3ZgctTGIyxuMxix
	cMlYewTQA7RvI1xjqfu0mWMOaIrsStb3ACgIy9tJffGMMBhN+ShvqYHnl2DzrDIP
	dJmTRWjbAT3qYyg6RV2haMTK4OVWrYcMoVk+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O8CgrKSpNBcfa/2KbOu6Ih6w0NSHwet2
	Lnb/fcu8wz7hzP/sAbLlJF4NPr8NRWj+BK6MFMgQzAExLjvH/vJBpTPfxrkinj5R
	wBxcWbQ+TnRsnQRL6PxgPwicbTW9nXhnzWiKmPwUGSEjkQ+qL/brOLlMqJQ8zfaL
	wVZwavo7alE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5534F26ADD;
	Thu, 10 Jul 2014 13:33:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F0CBC26ACF;
	Thu, 10 Jul 2014 13:32:59 -0400 (EDT)
In-Reply-To: <53BE5D0D.8090308@gmail.com> (Fabian Ruch's message of "Thu, 10
	Jul 2014 11:29:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3CE8A0C6-0858-11E4-A772-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253194>

Fabian Ruch <bafain@gmail.com> writes:

> Your reply suggests that git-rebase--interactive was wrong from the
> beginning and that the replay of commits without any message should be
> allowed. This would reconcile the first case with the second. In fact,
> since neither of them alters the changes introduced by $1 or its log
> message, it might be incorrect to complain about a missing message in
> the first place.
> ...
> Do you want me to replace this patch with a patch

Now you explained your line of thought more clearly and I have
thought about it a bit more, I think I agree with the conclusion of
the above.

An alternative may be to teach a new option --allow-empty-message to
rebase to allow people to replay/reproduce an existing history with
commits without any message, and uniformly tighten to refuse replaying
a commit without message by default.  But I am not sure if that is a
good direction to go.  Doesn't "rebase" without "-i" by default replay
a commit without message faithfully?  It might be debatable to allow
a commit that we would normally would flag as suspicious (i.e. no
change relative to its parent, or no log message) when replaying
with "reword" or "edit", but when replaying with "pick", "rebase -i"
should behave just like "rebase" without interactive.

Thanks.
