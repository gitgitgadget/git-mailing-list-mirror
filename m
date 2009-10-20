From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 00:48:15 -0700
Message-ID: <7veioyqzeo.fsf@alter.siamese.dyndns.org>
References: <4ADD6026.8070203@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, ftpadmin@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 09:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N09SN-00043X-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 09:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbZJTHsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 03:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbZJTHsU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 03:48:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZJTHsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 03:48:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B76C95FDD9;
	Tue, 20 Oct 2009 03:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z9xG7EaycCA66ySVEUkiRxUUkcY=; b=rBZm4m
	0WKBRv7QTppXtWtDCDnnECodfSnLZOExplf+OZO3jLydA/3Jzlgk4m2OxcVKrV8c
	gjJu446dnHVLtGddhFVfqKLv8MfHF1XsrHsg6g3qoR/PvkFjWQB2A4Eb+9GO9kX/
	qVx9OYlTVyKfXTLYJe7XbD0+SCI/q1ZmTS+Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cz4CBy//WY4Ph4VFhfIo3qcKYEHjVZu2
	yzxK86UnO6xkXHhUsfsKfQnSHsBWTkWyPUlXkNx7ih/LLwJNP3IQ92eZ1JjJpEse
	vTHVYxcy/2C6tFSblJgjdqEj4pLRFqHS9c3/bePyFdVywspAPsOuSO5L/FRA6u8D
	/QDYoQGma30=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D1CD5FDD8;
	Tue, 20 Oct 2009 03:48:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC8085FDD6; Tue, 20 Oct
 2009 03:48:16 -0400 (EDT)
In-Reply-To: <4ADD6026.8070203@zytor.com> (H. Peter Anvin's message of "Tue\,
 20 Oct 2009 16\:00\:54 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFC18606-BD4C-11DE-BE3F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130771>

"H. Peter Anvin" <hpa@zytor.com> writes:

> We have run into two major problems with git on kernel.org.  We have
> discussed workarounds, but I believe they are generally major problems
> which will affect other sites, and really need to be fixed upstream.
>
> 1) git receive-pack doesn't run git gc --auto.
>
> This cause repositories which people thought were being autopacked to
> not be so.  This can be done via a hook, but that is way too painful
> for people to do -- in fact, it's hard enough just to get people to
> enable the post-update hook for http fetching.
>
> 1b) as per the above, a way to make "git update-server-info" at
> post-update time a configurable option rather than needing to be done
> via the hook would be very nice, since a configuration option can be
> enabled sitewide.
>
> 2) When pushing to a repository, it apparently doesn't honor new
> objects in alternate repositories.  This causes massive unnecessary
> duplication.
>
> I believe these are major issues that need to be addressed.  If we are
> *mistaken* on these, then we would appreciate being corrected.

I actually was wondering if (2) is still true after reading the message
from Wilcox.  It should be a simple matter of testing, but I think this
issue was improved around the end of January this year with v1.6.1.2.

As to (1), I think it is reasonable to do some sort of "gc" in
receive-pack, and while I recall that Linus was violently against the
idea, I personally think it is reasonable to run update-server-info
ourselves at the same time without needing the hook, even if the
repository is never going to be served over dumb http [*1*].  At one
point, update-server-info used to compute a lot more than what we
currently compute and it made some sense to oppose against it on
performance ground.

But these days it only lists the refs and packs and does nothing else; the
performance impact should be immeasurable and it adds only two files to
the repository.  It cannot be a big deal, unless you oppose to http
transport on a non-technical ground.
