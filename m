From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Force-with-lease and new branches
Date: Sun, 08 May 2016 11:29:47 -0700
Message-ID: <xmqqfutsz9lw.fsf@gitster.mtv.corp.google.com>
References: <20160507180914.GR14612@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 08 20:30:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azTSo-000057-E8
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbcEHS3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 14:29:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750849AbcEHS3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 14:29:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 450B017CF1;
	Sun,  8 May 2016 14:29:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ICrkNRHyHdoOryZHXw8fAC1ZJdU=; b=CUa0Dx
	YNHGvtwOeWmyRItz8U91KJ9/oYQuYShk/M/DvDXkBuLJlMr7IRnsmIxkYIE6GpbO
	2gAXLsqTanU2t0jmw1ko8L6wJmmYeGec87wFC+iZDP1VPpz+j+uEN+T390OZ7KJx
	oXvVgmlsT+3hWlmC7kf+gDX11+AXGIwUZ8OEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DUWScZ6HxKKlnEeI6uTZreMOg5STafCF
	zsPgGUciGSLsqQqpy415LQTfEwmyfF18099nGib82C7ehRef5G+6tROfobMEZnC/
	Cqq4sFRurtEB/g1epZUaqn3UMjQAx5fpbkL0P6+G/y8TRwdko3G3n+YF8QUcSO2A
	rGbDZpMONzY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D67017CF0;
	Sun,  8 May 2016 14:29:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCA9F17CED;
	Sun,  8 May 2016 14:29:48 -0400 (EDT)
In-Reply-To: <20160507180914.GR14612@serenity.lan> (John Keeping's message of
	"Sat, 7 May 2016 19:09:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8A55B0C-154A-11E6-9A72-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293973>

John Keeping <john@keeping.me.uk> writes:

> It looks like this has been the case since the first version of what
> would become --force-with-lease [1] and I can't find any discussion
> around this particular behaviour in the three versions of that patch set
> I found on Gmane [2], [3], [4].

I never considered the "creation of a new ref, ensuring that it must
not exist yet" use case when designing it.  I do not think anybody
in the discussion did so, either.

> So my questions are: what will break if we decide to treat "no remote
> tracking branch" as "new branch" and is that a reasonable thing to do?

If you are only following a subset of branches they have, you may
never get copies of them in your refs/remotes/$there/ hierarchy, so
your addition would make 'force-with-lease to create' mistakenly
think that a branch does not exist over there, when there is already
one, and it will attempt to push your version through.  As long as
that is caught and fail on the receiving end of the request, it is
OK, I would think.  I didn't think it through nor checked the code
to make sure the remote end behaves sensibly--please do so yourself
if you want to pursue this route ;-).

Thanks.
