From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 13:52:15 -0700
Message-ID: <7vd2tvqzy8.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com>
 <20130415184347.GA21170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, marcnarc@xiplink.com,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:52:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URqO2-00033t-J0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab3DOUwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:52:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab3DOUwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:52:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C68A15CC6;
	Mon, 15 Apr 2013 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjY8wzwaR4ECeys6Ch0LpxGK7KY=; b=MgJE6E
	3OhBMxxOhxiIZ2Ke0EBKU1GK4d8Wfo38ytNfUy+89npj+8UjGvPNW570QaDtH8DZ
	DClWlSI0KkMB9/P9uJ9Y2/2xxK/t/Zrk01r8E627Map2SwvSPd5btHEsSEG6gwww
	VQ18BlZmEPNXwDWF4l1DptLeGmvUKcUKkd7Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pmvPPKaiGa+WbMwWANZV76q7KGara1ct
	I9yE/bqBuOqbXLMBwbYZx2Gwm+9DBnKgG3ml2WN/IvcMRoqPm/3NqDp9mnOJpFn6
	r1KZguaNRgC3tF0XL4jmdTGltZ1+WH+fOAFODUPy0Ft2jcEgLojTHNmCRRRF8HB8
	M6qj4xRZjlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12F7F15CC5;
	Mon, 15 Apr 2013 20:52:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70A0815CC2; Mon, 15 Apr
 2013 20:52:20 +0000 (UTC)
In-Reply-To: <20130415184347.GA21170@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Apr 2013 14:43:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D9A919C-A60E-11E2-9D8D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221314>

Jeff King <peff@peff.net> writes:

> And by the way, I am actually not sure that such a shared-object setup
> is a good idea, but only that _if_ you are going to do it with
> submodules, you might as well do it for all repos. In theory, it is not
> that hard to have a big per-user object-only repository (either for all
> repos, or for related ones). But we can do that already with "git clone
> -s", and people do not generally bother, because the maintenance is very
> tricky (especially dealing with reachability and pruning).
>
> I am open to the argument that solving it in a specific case
> (submodules) lets us make assumptions that simplify the problem from the
> general case, but I do not offhand see how it would be any easier in
> this case.

Nicely put.

Making it easier to manage such a shared object store by limiting
use cases is somewhat an intriguing idea, but those I can think of
offhand all have to involve a use case without any rewound history,
so being a submodules repository would not help.
