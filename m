From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Wed, 14 Nov 2012 09:32:40 -0800
Message-ID: <7vmwykay4n.fsf@alter.siamese.dyndns.org>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
 <7v4nktdwtp.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
 <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
 <7v390ccoak.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git <git@vger.kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYgpd-0007ME-PD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017Ab2KNRco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:32:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932978Ab2KNRcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:32:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D21A9F14;
	Wed, 14 Nov 2012 12:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LNTQGZWLN3T6nl9rqSuKH+PxdZ0=; b=BwMaP8
	udJX5bTGULkcJoaNQclMEWVYAp+Py07IKZ0UeDgK/4kE5Ibb52VfU44mWGsAuhIW
	ZtAJbsRDFwDg7ZN+tfgfJrgdz7/Z3Ex1nGmSsSuy0ySuP8GZo37sshKVfAkR8KGF
	MBvjDV85BumP2rw6BuKnjv9yrmv7u/K9RRnhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aTdG5Y7mCwYWReoI38pUWN+0SSbWh1j2
	SUHNrBsv0lCQ/l8uB326HCUs3r4odQS1surwIbf7gmQakTH7EGBTBNkbgETBREGU
	1FCVkCyMMCAyTiqoSof+AqToWTJIunP7e1xNQJ6zsi2yspqxIIfxoh+TtlZVopPH
	oGyXs0amUUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A1FD9F13;
	Wed, 14 Nov 2012 12:32:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D92BE9F0D; Wed, 14 Nov 2012
 12:32:41 -0500 (EST)
In-Reply-To: <CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com> (Angelo
 Borsotti's message of "Wed, 14 Nov 2012 15:58:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B0B5CFA-2E81-11E2-B729-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209732>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> actually, I proposed to add a key in config files, e.g.
> pushTagsNoChange to be set in the remote repo do disallow changes to
> tags, similar to pushNonFastForward that disallows non-fastforward
> changes to branches. I still have the impression that this is simple
> and clear, and allows the owner of the remote repository to enforce
> the policy s/he wants on her/his repository.

That is an independent issue of deciding to accept or reject
receiving a push from outside, no?  You can implement any such
policy in the pre-receive hook on the receiving end with a simple
and clear manner, instead of adding specific logic to enforce a
single hardcoded policy to the code that is flipped on with a
configuration variable.

In any case, I thought this series was about users who run "push"
voluntarily stopping themselves from pushing updates to tags that
may happen to fast-forward, so if we were to go with the
configuration route, the suggestion would be more like

    [push]
	updateNeedsForce = refs/tags/:refs/frotz/

or perhaps

    [remote "origin"]
	updateNeedsForce = refs/tags/:refs/frotz/

if we want to configure it per-remote, to specify that you would
need to say "--force" to update the refs in the listed hierarchies.

Then your patch series could become just the matter of declaring
that the value of push.updateNeedsForce, when unspecified, defaults
to "refs/tags/".
