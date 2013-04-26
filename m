From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Itches with the current rev spec
Date: Fri, 26 Apr 2013 14:13:25 -0700
Message-ID: <7v8v45vvuy.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<20130426101946.433f2d12@chalon.bertin.fr>
	<517A3E47.6010606@viscovery.net>
	<7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 23:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpxa-0006et-Bm
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab3DZVN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:13:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36303 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab3DZVN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:13:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 940E5171E8;
	Fri, 26 Apr 2013 21:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EfDdNt6qY3pocd+oALisEBzPYsc=; b=H5Y1ic
	znIfXzVRS1Nmu4PAZnUxSSx0agq6+UKiEgVUVrZqV+TFOHWovdqrHOdY+sK5kYxa
	PZjU1sKEzHqXMFYxq3ygxoPRRZNg3bORfioxTs1u1aIoisW4UV3UnUoqRb4+0i14
	4ImCrvGyUloJS8YeJzenzzslTjDfexVt2g5ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WISDM/M00+adSXFZn/QWxSOG3PTns13l
	uxGLyo21fTLeBZjg9+vHNCsjTs8Lr1NlFJ5d6Hf8mL/DENh0VO0Cp9IoBNoJ3K+h
	vKurCCrfRLssSMGifhlsIj5hL5qzhr134K4ulhnE6ulPn6buhWZdeToPGWQt1PUE
	o/QuvTXbIys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A2A171E7;
	Fri, 26 Apr 2013 21:13:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 062E9171E4;
	Fri, 26 Apr 2013 21:13:26 +0000 (UTC)
In-Reply-To: <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 14:48:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 231470F0-AEB6-11E2-BF90-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222581>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I don't know what 'git rebase master' does, but I would expect 'git
> rebase --onto=master' to do the same thing. Then, if 'git rebase
> --onto=next master..topic' makes sense, so should 'git rebase next
> master..topic'.
>
> Moreover, it often annoys me that 'git rebase master' does exactly
> what I want, but 'git rebase --onto=master previous' doesn't find the
> commits that are already into 'master'. One would expect the more
> defined version to work better, but it doesn't =/

That all stems from the fact that rebase (not -i variant) predates
these nice A..B, A...B, and $(merge-base A B) concepts have been
ingrained in the user's mindset as the primary UI language of Git.

 - The UI language of "rebase origin" comes more from the "workflow"
   school.  "I have built on 'origin'; I want to catch up with its
   current state".  To support that workflow, 'origin' is the only
   thing you need to say, and "rebase origin" matches that nicely.
   If you then add "By the way, that statement expresses my wish for
   the 'topic' branch, not my current one", you get "rebase origin
   topic".

 - If the UI language for "rebase" were designed following the
   "composition using common elements like ranges and revisions"
   school, it would have started from "rebase --onto=X A..B".

Back then, we did not know which principle to design the UI language
would prevail, but we needed something that works to support the end
users.  So "git log" spoke "A..B" but "git rebase" took "origin".

Over time, the "composition" school prevailed and these days we see
many commands accept and act on revision ranges or discrete
revisions.

The same thing happened to format-patch, whose original syntax was

    format-patch origin

which is still accepted, but we have adjusted it to understand the
more prevalent

    format-patch origin..

because it is far more understandable if you know other commands
that are based on "composition" UI language.  That adjustment
started making sense after it has become clear that "composition"
school of UI language is the way forward.

It's just that "rebase" is waiting for the same kind of adjustment.

Hint, hint.
