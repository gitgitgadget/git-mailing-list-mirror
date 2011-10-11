From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 14:31:48 -0700
Message-ID: <7vpqi3dxkr.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011203903.GA23069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 23:32:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDjvi-0001Nh-Fl
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 23:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017Ab1JKVbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 17:31:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab1JKVbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 17:31:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4938A542B;
	Tue, 11 Oct 2011 17:31:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qifk6qc59aJysd4MefmVV9GrjPI=; b=Ufqo+v
	pFFnnfZqpgNjQ9+BF8xEq/rUtYImNg2BQqtlq6xm4ZXBBIJ6HZg61zBCgxg0jnNA
	6Ev1pSIqnbe3wEV1oPEnguIvQEdaPtfSqLXVaOI2rpi2wMNjIbco6CaFQeS6d+Lr
	DAAwfEcgc8oIcZR/AOcnf2hARq+86G9Pgzzrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DLb4HQDbz9YWaXiWgL4RmLr6YSIMjRGX
	iVvjaC4o79juoqr+gg5u+gEbJtCX0arEUM7AaMcWtPlkgi3FVXADvI6s0YilJzWx
	qVVwB7VsiWUIwyu64NxXwsmVJEY0TQoUKHyuLD1I4GifS2NRiYSgb1JHfNFF41uW
	s5CVoKcs8s0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40F4D5429;
	Tue, 11 Oct 2011 17:31:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87F065421; Tue, 11 Oct 2011
 17:31:49 -0400 (EDT)
In-Reply-To: <20111011203903.GA23069@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 11 Oct 2011 16:39:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DB0AE98-F450-11E0-AEAA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183329>

Jeff King <peff@peff.net> writes:

> But in the code, it is spelled RENAMED-REF (with a dash). And as far as
> I can tell, does not actually create a reflog. And it's not documented
> anywhere, so I suspect nobody is using it. Maybe it is worth switching
> that name.

Or even better get rid of it?

>>  - dwim_ref() can be fed "refs/heads/master" and is expected to dwim it to
>>    the master branch.
>
> It looks like your code will allow any subdirectory. I had thought to
> limit it to "refs/". Otherwise, my "config" example could be
> "objects/pack", or "lost-found/commits", "remotes/foo", or something.
> Obviously the longer the name, the smaller the possibility of an
> accidental collision.  But I couldn't think of any other subdirectory
> into which refs should go.

I wanted to start as loose as possible to avoid negatively impacting
existing users, later to tighten.  As fsck and friends never look outside
of refs/, I think the prefix refs/ is a reasonable restriction that is
safe.
