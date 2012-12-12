From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 09:49:09 -0800
Message-ID: <7vpq2f5ffu.fsf@alter.siamese.dyndns.org>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <20121212063208.GA18322@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:49:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiqR1-0000Im-1s
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab2LLRtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:49:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab2LLRtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:49:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1ED29F17;
	Wed, 12 Dec 2012 12:49:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrF+bfzk5TzzRt7EXOOMpN6U3GU=; b=ETIoWy
	Mj9fzA6YorFngO7iexfOKn8pst5zQDa/1vAYVG4xiLLm1khT+II0rUGp3Wi8BD6c
	b11MVkUJgq7xGUoX5BSl+nFoXgTM2b/aQGFdtd+wO/DcR/iZ9D03/BaTv74ilBP/
	J2cWHCv7WHC6FS5EW1r8m/shvNB47wVDRpDoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vtbKH9e2drDkVxhSC90rkLECczrPmDra
	sJIEgrznv/GdvPR6gNlIe2HGXS/HBmS326r068WnCAdxvFjZHY5cMh0/8gV+e/hw
	s/i9HAXl1GOQeCdP2hwtZ8t8Q9mVLmq5oRKE1EQw0vZda9tO/E+IG2iGeEScuTWG
	+XeMZE8WtmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A8C29F15;
	Wed, 12 Dec 2012 12:49:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A682F9F13; Wed, 12 Dec 2012
 12:49:11 -0500 (EST)
In-Reply-To: <20121212063208.GA18322@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Dec 2012 01:32:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C941E96-4484-11E2-BA12-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211372>

Jeff King <peff@peff.net> writes:

> I think there are really two separate use cases to consider:
>
>   1. Providing snippets of script to Git to get Turing-complete behavior
>      for existing Git features. For example, selecting commits during a
>      traversal (e.g., a better "log --grep"), formatting output (e.g., a
>      better "log --format" or "for-each-ref --format").
>
>   2. Writing whole new git commands in a language that is quicker or
>      easier to develop in than C.
>
> I think (1) is a good match for lua....
>
> But for (2), you are going to care a lot more about the language and its
> ecosystem (because you'll be interacting more with the world outside of
> git), and about having bindings to lots of different parts of git
> (because you'll want to do more interesting things than just examine a
> few data structures).

Good summary.  We also need to realize that adding a native
subcommand written in C has become much easier over time as our
internal API has evolved and matured.  These days, we still do a
whole new command in scripts (and we have whole commands still in
scripts) not because "quicker or easier to develop" (that is still
true for throw-away experiments) but primarily because that is
easier to modify and experiment over time until we find a solid
design.

Among the more important subcommands that are still scripts, I think
"add -i", "repack", "pull", "stash" and possibly "rebase" have
interfaces facing to both the end users and to the core part
solidified enough that they can now be ported to C.  Others either
are not important enough or still have rooms to improve the
interfaces in either direction that it would still be better to
leave them in scripts (e.g. "bisect" with "<used-to-be, now-is> vs
<good, bad>" issue unsettled, "submodule" with "floating" issue
unsettled, etc.).
