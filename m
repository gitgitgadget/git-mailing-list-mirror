From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: allow using --no-ff and --ff-only at the same time
Date: Mon, 01 Jul 2013 09:43:13 -0700
Message-ID: <7va9m6i63i.fsf@alter.siamese.dyndns.org>
References: <20130701070143.GB17269@suse.cz> <51D197AD.1070502@alum.mit.edu>
	<7vmwq6i93m.fsf@alter.siamese.dyndns.org>
	<20130701161009.GI17269@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:43:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthCM-0003bm-DU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab3GAQnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:43:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab3GAQnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:43:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58AAB2D2FE;
	Mon,  1 Jul 2013 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2yXSujGH57Qtgp6jneiXI6J1zqk=; b=BRRHA8
	r0a1ET8bzlPrk/5TvUKNCtuYxtXg5ZtqltjjCbuut5OKbydG+pmajjYwGFoMMoTx
	tEqKug3Q/ufqmXHNQhPYrj++I/SwWUVqssmTs9Zzn8XObzDLicOqlmiMLVmsvDmY
	QuWPoLWyQYc2TbUjypfxDywhPCzCBLRh5xE7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nf0a/YyY4vWPn2tgGNwxfMrFaxeR07W6
	qIFdyUHyR9IK594fxpgTAm/U9akpVOqA+FGSDQ2N64DXqeY8U2VcQUIdmk6HsFWA
	j+11Ggomdi9XDz2AaBhkwHKkL/sKETZQUo3augxbn6wOXZuSIHvB+hHacVzcpoPh
	/RFBvb1NGyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C65C2D2FD;
	Mon,  1 Jul 2013 16:43:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F8ED2D2FB;
	Mon,  1 Jul 2013 16:43:14 +0000 (UTC)
In-Reply-To: <20130701161009.GI17269@suse.cz> (Miklos Vajna's message of "Mon,
	1 Jul 2013 18:10:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52FBDEEE-E26D-11E2-A79E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229309>

Miklos Vajna <vmiklos@suse.cz> writes:

> OK, so if I get it right, the problem is that users got used to
> that the --ff-only not only means a precondition for the merge,
> but also means "either don't create a merge commit or fail", while
> my patch would change this second behaviour.

It is not just "users got used to".  "We do not want to create a
merge commit with this operation." is what "--ff-only" means from
the day one [*1*].

For a merge not to create an extra merge commit, the other history
has to be a proper descendant, but that "precondition" is a mere
logical consequence of the ultimate goal of the mode.

> I could imagine then new switches, like 'git merge --pre=ff
> --update=no-ff" could provide these, though I'm not sure if it makes
> sense to add such generic switches till the only user is "ff".

Yes, that is why I said "if one were designing it from scratch, I
could see..." in a very weak form.


[Footnote]

*1* 13474835 (Teach 'git merge' and 'git pull' the option --ff-only,
2009-10-29) and also $gmane/107768 whose documentation part says:

  "Refuse to merge unless the merge is resolved as a fast-forward."
