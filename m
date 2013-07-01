From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: allow using --no-ff and --ff-only at the same time
Date: Mon, 01 Jul 2013 08:38:21 -0700
Message-ID: <7vmwq6i93m.fsf@alter.siamese.dyndns.org>
References: <20130701070143.GB17269@suse.cz> <51D197AD.1070502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@suse.cz>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 01 17:38:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtgBU-00027L-NL
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 17:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab3GAPi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 11:38:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab3GAPiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 11:38:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4D412D4BA;
	Mon,  1 Jul 2013 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KZ3dhQiKxPbAeBMIEavtHTDh5VI=; b=bbNp+N
	V/B7qz6Eo+WmyxqpgocFphN0zgcx/iTpTjFH5nS4Yj2gNhO5ZcepBuNRAeebfmJK
	u54iyyT0geQ8PN2UQYv+sl7p/OflNC0uwm4a5hCPMOlAbqe9SgRqGpVpig61Lxjb
	Tae6u+OKbZKWSUXe0EYJzhbbSZtM3Mh0sfud4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IupwGuqWKakYD6qoR8FtasNq48ZogTC6
	DXp0LbGDBU/rL7/uKVkMcpwCrK7+3VxL5L10M0iIKZAdYV32Y0LVd5UY5Aq6D3ic
	P9EZ8cRppJ2b4yEoT6XoIZDmeZnFYQUC4/58C26l10xEBajD/xFD6rdJaY77AXgw
	7G79zNDGA4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90942D4B9;
	Mon,  1 Jul 2013 15:38:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F01D2D4B6;
	Mon,  1 Jul 2013 15:38:23 +0000 (UTC)
In-Reply-To: <51D197AD.1070502@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 01 Jul 2013 16:52:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4386AB50-E264-11E2-B0A0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229302>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So I think that command invocations with more than one of {"--ff",
> "--no-ff", "--ff-only"} should respect the last option listed rather
> than complaining about "cannot combine options".
>
> If I find the time (unlikely) I might submit a patch to implement these
> expectations.

And I wouldn't reject it on the basis of the design --- I agree
fully with your analysis above.  Thanks for digging and spelling out
how they should be fixed.

As to "--no-ff" vs "--ff-only", "--ff-only" has always meant "only
fast-forward updates are allowed.  We do not want to create a merge
commit with this operation."  I do agree with you that the proposed
patch changes the established semantis and may be too disruptive a
thing to do at this point.

> In my opinion, your use case shouldn't be supported by the command
> because (1) it is confusing, (2) it is not very common, and (3) it is
> easy to work around:
> ...

If one were designing Git merge from scratch today, however, I could
see one may have designed these as two orthogonal switches.

 - Precondition on the shape of histories being merged ("fail unless
   fast forward" does not have to be the only criteria);

 - How the update is done ("fast forward to the other head", "always
   create a merge", "fast forward if possible, otherwise merge" do
   not have to be the only three choices).

I do not fundamentally oppose to such a new feature, but they have
to interact sanely with the current "--ff={only,only,never}".
