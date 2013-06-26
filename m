From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Wed, 26 Jun 2013 14:03:08 -0700
Message-ID: <7vli5wvb3n.fsf@alter.siamese.dyndns.org>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
	<20130624224925.GC32270@paksenarrion.iveqy.com>
	<20130625221132.GB4161@sandbox-ub>
	<20130626160219.GC9141@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 23:03:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urws0-0000FW-B7
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 23:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3FZVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 17:03:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab3FZVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 17:03:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9872BE0D;
	Wed, 26 Jun 2013 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQ/g+eGLevwGdiF/thmOwpovOAk=; b=pUKpnA
	TcacAoWYEOU31Jwu7sq9cSBdLrWBnMpXciU2i7P6TcIVaV+5HSuyfXZM56+yFmCk
	VsnzIPEm7CDqIlFw7EKLdQbqC+H8kYNnw79dFmk1EE4hvMLA2f6/wp2exytsZNpu
	s6e5CyXt1nn6gOcXniCizSU4aKhz5m9CCLFcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvlNEk+phJkH9239cCdecNZTuDV4/ERs
	B3b8Ag+eP7gVgZpHTe9KuMbAjYvpOQ9gfMnkwEL+HcExx9RFZinw8Wk+j8jgjN0P
	I07NZhhaU6FoFUK+aAU8bU/Zf+JIKiqQUILBptn0HO+idR0lJ4glk3M0Jlc63MqX
	9pS2qjfYR2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C07722BE0C;
	Wed, 26 Jun 2013 21:03:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EC002BE0B;
	Wed, 26 Jun 2013 21:03:10 +0000 (UTC)
In-Reply-To: <20130626160219.GC9141@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Wed, 26 Jun 2013 18:02:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEA792F4-DEA3-11E2-B2C9-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229060>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Wed, Jun 26, 2013 at 12:11:32AM +0200, Heiko Voigt wrote:
>> On Tue, Jun 25, 2013 at 12:49:25AM +0200, Fredrik Gustafsson wrote:
>> > Used only when a clone is initialized. This is useful when the submodule(s)
>> > are huge and you're not really interested in anything but the latest commit.
>> > 
>> > Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
>> 
>> I this is a valid use case. But this option only makes sense when a
>> submodule is newly cloned so I am not sure whether submodule update is
>> the correct place. Let me think about this a little more. Since we do
>> not have any extra command that initiates the clone this is probably the
>> only place we can put this option. But at the moment it does not feel
>> completely right.
>> 
>> Apart from that the code looks good. If the user does a checkout of a
>> revision that was not fetched submodule update will error out the same
>> way as if someone forgot to push his submodule changes. So that should
>> not be a problem.
>
> I agree and would love to say that I've a more beautiful solution, but
> I haven't.
>
> The only other solution I can think about is to add a git
> submodule clone that will do only clones of non-cloned submodules.

The "update" subcommand already has "--init" to do "init && update",
and it would not complain if a given submodule is what you already
have shown interest in, so in that sense, I do not think what the
posted patch does is too bad---if it is already cloned, it just
ignores the depth altogether and makes sure the repository is there.
A separate "submodule clone" would only make it more cumbersome to
use, I suspect.

So let's queue the patch posted as-is for now; we can replace it
when/if somebody smarter than those who have spoken so far comes up
a more elegant approach.

The patch seems to lack any test on its own, by the way.
