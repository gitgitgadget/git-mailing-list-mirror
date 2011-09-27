From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Mon, 26 Sep 2011 17:04:24 -0700
Message-ID: <7vd3emzw8n.fsf@alter.siamese.dyndns.org>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
 <20110925094822.GA1702@myhost>
 <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
 <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
 <7voby6zwxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 02:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8LA0-0006hN-I5
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 02:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab1I0AE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 20:04:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab1I0AE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 20:04:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D24C5CCB;
	Mon, 26 Sep 2011 20:04:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4M5cmfTnUbMw4+22LyuZ695LEM=; b=s7xHx2
	JkEbg7/zpEEj6+orG+j/4YeXotpYFPomiU70tjVX4/uhCA5HfD+dOJxq5uFYaPkq
	2pmZnttgpHB/r06jnou4ZZKpqHBIjVNjSO0hEwJNRPPKRzNnG/FRLf59o7+s99Fj
	s2SVzRDNrL9cFWg/HXZjA/T/sPIn5dmFH+sr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=smcYGrm/nIEaDqEjEdWpQQxRecqRZ2y4
	M3IJqlgs2baiV3rPWLW02hJ747TVz/V6+mlbI/Qfpe8DGlv86GS/rnneycNIP059
	0iN/n71vCZjVWGfZUU9+ILD9PXQXM7fEkVCkzQpY6uu8Se0cqrqVnt11S6E1V3y1
	wRTUEhFZEwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4413D5CCA;
	Mon, 26 Sep 2011 20:04:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6D945CC9; Mon, 26 Sep 2011
 20:04:25 -0400 (EDT)
In-Reply-To: <7voby6zwxg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 26 Sep 2011 16:49:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 430840D0-E89C-11E0-A154-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182195>

Junio C Hamano <gitster@pobox.com> writes:

> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>> In that case (if "non-existent-ref" was indeed non-existent, and not just
>>> pointing at a dangling commit), I would say the post anything hook should
>>> not be called for that ref. These hooks of course need to run if there
>>> are _other_ refs that were updated, though, to handle these _other_ refs,
>>> but I do not think they should be told about the no-op.
>>
>> Question is what happens if none of them existed.  It's a difference
>> between not calling the hook at all, versus calling it with no
>> arguments/empty stdin (as the case may be) -- which would you do?
>
> In case it was unclear, I was trying to say the hooks should not run with
> empty input.

If the purpose of "post-update" (or "post-receive") hooks were to trigger
every time anybody attempted to push into the repository, then it would
make perfect sense for them to trigger when "push origin :no-such-branch"
were attempted. But if that were the purpose of these hooks, they should
also trigger when "push origin master" is run and "master" is already at
the right commit, as that is the same kind of no-op -- the pushed into
repository was already up-to-date with respect to the wish of the pusher.

I do not mind, and I do prefer, these hooks to run when somebody deleted
an existing ref that points at a corrupt or non-existent object, as that
is _not_ a no-op but is a meaningful event that has an effect that is
observable from the outside world (e.g. ls-remote).
