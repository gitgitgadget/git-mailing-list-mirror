From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Reroll of rr/triangular-push-fix
Date: Mon, 24 Jun 2013 01:12:17 -0700
Message-ID: <7vli60c4gu.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<CALkWK0kDwMq-ADRPShOdCy2Vh+zj9J9A0A4CFv21aKZFeiMs+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:12:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1t0-0001uD-Op
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab3FXIM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:12:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab3FXIMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:12:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE0727D83;
	Mon, 24 Jun 2013 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJ4ZWwKNTZY/AK0r/How13s0IC4=; b=YRcAAc
	cU3bvU9KCRQWilcILADNgU76pQ8Uw8hk0yV1Zn+iqgRIM4A7nJMPcIhJ6pNB56vQ
	5BUZ5uwvoyIrUIxU0H5Gep4vxIt7lTfAVmuzi5AXxjvKl6nRJkydIrvANzyX6Poh
	+YgnX0rM/2bPqK98SdGQoMeaALV2wXHE6XFDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D8Dq0EaUfRqnkKFvdubvEpmtZjuYT/fR
	8s5KLJuD8Y5GZpcq1GI/GB+vvJCf7ulDqgkJguRlSsr1JsT+KM9HBfNCN3IVV6DA
	8a+ovp7znp4W3SaXQJUhywEXbinHj6khZrVlm8z01tsZfEFY5FEAYVxzZ0EZPXUa
	Qzwz1og7Gxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2299027D80;
	Mon, 24 Jun 2013 08:12:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D43827D78;
	Mon, 24 Jun 2013 08:12:22 +0000 (UTC)
In-Reply-To: <CALkWK0kDwMq-ADRPShOdCy2Vh+zj9J9A0A4CFv21aKZFeiMs+w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 12:51:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBE8C074-DCA5-11E2-84F0-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228792>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I hope (perhaps foolishly) to persuade you nevertheless. I fear that
> if this series solidifies before I get there, we'll be stuck with this
> stupid erroring-out behavior forever.

I do not think it is "stupid" at all.

'simple' is supposed to be an easy and safe default to help new
people.  Your original patch to change its semantics for the central
workflow from the current 'make sure upstream is set and set to the
same name' to 'anything goes' is making the mode more dangerous than
the corresponding 'upstream'.  Such a mode may have its place, but
labelling such a mode with rough edges as 'simple' and forcing it on
new people _is_ stupid, IMHO.

In any case, the good news is, if you start strict, and if it turns
out to be stricter than necessary, it is easier to loosen it later,
because nobody would be relying on an operation to _fail_.

If you start too loose without safety, however, it is a lot harder
to tighten it later when it turns out that safety helps new people.

Since the beginning of this series, our working assumption for
triangular-simple' has been that it can just turn into a straight
'current'.  But given that 'simple' is supposed to be an easy and
safe default for new people, I suspect that it should be a bit more
strict.

For example, if you are on a random topic branch and say "git push",
always pushing it out may not be a very sensible thing to do, and it
might be safer if we restrict 'triangular-simple' to push out the
current branch to the branch of the same name, but only when such a
branch already exists at the remote end, or something.
