From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Mon, 25 Jan 2016 12:21:21 -0800
Message-ID: <xmqqmvrtfm0u.fsf@gitster.mtv.corp.google.com>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
	<20160124071234.GA24084@sigill.intra.peff.net>
	<20160124071815.GB24084@sigill.intra.peff.net>
	<xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
	<20160124222736.GA29115@sigill.intra.peff.net>
	<xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com>
	<20160125100141.GC24452@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:21:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNndi-0000Im-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 21:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbcAYUV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 15:21:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932246AbcAYUVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 15:21:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D0303EA46;
	Mon, 25 Jan 2016 15:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Od+3DxWK+RxuB5rD1UqfGEoDCw=; b=AGlQ1f
	uH7pCCkiX3ok+Qc+VyTMspU18eKdVAMPbBbfyVKR04B09J+AqAqTP3mjjjeVd27f
	XcJS/lRObgxVOPFQfQdu0UU3d001aLI2v1+Qsy63XygCQpggN85Wn8sPanq+f2id
	9Wfw2pvGf+P6VTVCxqSprFYhYK3uvI+YXAOTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mL1cR0Zzab8ud8AHutdJ4sCGnfCWBiX/
	ebQeO1aeX3r2yGBez4XFcnIhmLl0CKgpj84Q63DBtklL4W1HvlFr5yeLg0ytxQ47
	b2Dn5YNt1oXX1Wjil2Tvxs1FYeguvtvys3JeGHVUPvbtLcEYSBRnki3DmOKZwk/P
	eaamZGh3Lmo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 442D03EA45;
	Mon, 25 Jan 2016 15:21:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE76F3EA44;
	Mon, 25 Jan 2016 15:21:22 -0500 (EST)
In-Reply-To: <20160125100141.GC24452@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 25 Jan 2016 05:01:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 339FB922-C3A1-11E5-8D27-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284755>

Jeff King <peff@peff.net> writes:

> I'm not sure "remove-standard-prefix" doesn't open its own questions.
> Like "what are the standard prefixes?".

It is easy to define, no?  This is invented for the internal use of
the listing modes of "tag" and "branch", so the users are welcome to
use it if they see fit, but how the prefixes are stripped is defined
by the convenience of these commands--the behaviour might even change
when these commands are enhanced.

> If we are going to go with "remove a prefix", I really don't think
> "remove if present" is too complicated a set of semantics (as opposed to
> "error out" you mentioned above).
>
> I do like "strip=<n>" for its simplicity (it's easy to explain), and the
> fact that it will probably handle the git-branch case for us. The only
> open question is what to do if there are fewer components, but I really
> think any of the 4 behaviors I gave earlier would be fine.
>
> Eric' globbing suggestion is simpler for the error case (as a prefix, it
> can be "remove if present"), but I think introducing globbing in general
> opens up too many corner cases (e.g., does "*" match "/", is "**"
> supported, etc).

Yeah, I really do not like any of the "do not error out but assume
that the user would not care about the ambiguities" solutions for
something we primarily intend to use for internal purposes.

I agree that "strip=<n>", "remove-prefix=<glob>", and the friends
are good for end-user scripting, but they can come later, outside of
the scope of this regression fix, and that is the proper time to
debate and decide if it is really ok to assume that the user does
not care about ambiguity, or it is prudent to error out.  A separate
"remove-standard-prefix" that is meant for internal use would allow
us to push the fix out without having to decide now.
