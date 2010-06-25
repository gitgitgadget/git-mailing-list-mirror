From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] Teach "git status" the "--ignore-submodules"
 option
Date: Fri, 25 Jun 2010 11:24:13 -0700
Message-ID: <7vlja3j7hu.fsf@alter.siamese.dyndns.org>
References: <4C24C34B.20403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 25 20:24:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSDZq-0001w1-PH
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 20:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab0FYSY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 14:24:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab0FYSY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 14:24:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE6CBF60F;
	Fri, 25 Jun 2010 14:24:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kev5LIaCio+1WAJeT1Q9FMVhhMM=; b=kO/CuG
	nqwgSg07FAfpe3k3J0e6Z3C6qvYyCofC+46f5ZsqdtgF17T0Lh6ILgoT7S5SJHF4
	kcJ0LxS6nIk7l/HEj3IyYcmzXdEdvPNOct9LKLd43/vCd+MJ3yx9ea7e5Ao2ZdIw
	plJFZ1cP/uytQ6Pr7SdHnollGyHZJVpBsTQZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F6UaVMx2+LlUXKIzSWeBhRgfFVVYgOxD
	5rxjvhm09+3Z2rS8rtVo+QPI2palp/fyKg0LeWoJu2j5VTvHtTG4Pvk9ZzmuaoT1
	4u5+YYvOXMIcwSb5IJQhf9OjKEHQ6w4gFtGsbYzPDjELI7UM6FlIbZt0FYW3D7QH
	C2fklM2MeUs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F0CBF60E;
	Fri, 25 Jun 2010 14:24:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45CCBBF60A; Fri, 25 Jun
 2010 14:24:15 -0400 (EDT)
In-Reply-To: <4C24C34B.20403@web.de> (Jens Lehmann's message of "Fri\, 25 Jun
 2010 16\:55\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFCBA120-8086-11DF-93D2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149702>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The first patch in this series lets "git submodule summary" and "git
> submodule status" ignore dirty submodules. I thought about teaching
> them a "--ignore" option too, but didn't for two reasons: First, the
> output of those commands is pretty much focused on commits. Second,
> when using "git status" with the config option 'status.submodulesummary'
> the submodule tree is scanned twice, once for "git status" and then
> again for "git submodule summary". With this patch the second run is
> gone, which is a big gain for users of 'status.submodulesummary' with
> large submodules.
>
> The second patch teaches "git status" the same "--ignore-submodules"
> option that "git diff" recently learned. Ignoring all changes also
> suppresses the output of "git submodule summary" when
> 'status.submodulesummary' is set.
>
> After this series I am planning to add a config option 'ignore' to
> .gitmodules, which can be set for each submodule to either "all",
> "dirty", "untracked" or "none" (the default). "git diff" and "git
> status" will use that config value for each submodule. Using
> "--ignore-submodule" overrides this default (and the new parameter
> "none" will be added there to able to override the config settings).
> And to avoid having to do "git submdule sync" every time that option
> changes, I would like to search for it in .git/config first. If it
> is not found there, it will be taken from .gitmodules, if present.
> So users can override the setting but if they don't, upstream can
> change it easily (e.g. when a submodules .gitignore has been updated
> so that "ignore=untracked" is no longer necessary anymore it can be
> removed). Also switching branches will have an effect instantly if
> the 'ignore' entry in .gitmodules is different between branches.
>
> Opinions?

I think both patches make sense.  It would be reassuring to hear from
people who are heavier submodule users than me, though...

Thanks.
