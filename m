From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Mon, 21 Jun 2010 08:22:40 -0700
Message-ID: <7vlja8if5r.fsf@alter.siamese.dyndns.org>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006210106.07758.johan@herland.net>
 <7vk4pttfo3.fsf@alter.siamese.dyndns.org>
 <201006211219.02911.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 21 17:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQipv-00031G-P8
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 17:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab0FUPWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 11:22:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725Ab0FUPWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 11:22:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63013BDA80;
	Mon, 21 Jun 2010 11:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hWqE6IAjXC+EsqqqXnYjcXv9/SM=; b=wR7apZ
	w9UzVzS/y+8L6y0p7QJqoT/S+F0uBN0nAhZOn/F/XuPag0TMfNWOztbKpbUBZn+M
	EUrxEO2TVGhJWebDE1ab5LAFmf1YD705ok9z3MXvNX3RS20tO5KLo19kt2+OhITH
	vNR5Ge6zJRnAW4TCzLE1nvUAIynpCdZHl4nVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PgLLo8h+wKGTKOP0vsb7pz7/AwOR6oui
	YZWb7Za320rvrX8u9WxT9SpUDggA4SXQFZMwhCFx0pYis1rytuS5N5bHWRtTkn2n
	fhF8yFbN81KtnLI2gJrMKgjrIDGTyTgCJzmRuedtaCBS484Sn0hvTsBGzwgyMRrN
	jpI+JydNFes=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5BC6BDA7C;
	Mon, 21 Jun 2010 11:22:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D15A8BDA7B; Mon, 21 Jun
 2010 11:22:42 -0400 (EDT)
In-Reply-To: <201006211219.02911.johan@herland.net> (Johan Herland's message
 of "Mon\, 21 Jun 2010 12\:19\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D90546CA-7D48-11DF-ACC0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149417>

Johan Herland <johan@herland.net> writes:

> I still don't like this, as IMHO it's too subtle, and possibly conflicts 
> with explicitly tracking submodule branches (which, to me, is a more 
> important feature).

If you mean, by "explicitly tracking", to say "I don't care which commit
from the submodule appears at this path, as long as it is at the tip of
this branch", I still don't think it makes much sense, but what I outlined
is not _incompatible_ with such a scheme.  In fact I think it would rather
fit naturally as a sanity/safety measure.

I presume that in your "explicitly tracked" world, if the user tries to
commit at the superproject level with a submodule commit that is
inconsistent with that "explicitly tracked" branch (e.g. the commit is not
reachable from the tip of that branch), you would issue a warning of some
sort, using that knowledge.  What I outlined uses the exact same knowledge
of which branch in the submodule the superproject branch is tied to to
reject irrelevant existing merges as resolution candidates.

Of course, this ".gitmodule in superproject can tell you which branch of
submodule it follows" is optional; the user needs to take responsibility
of picking the right one among I, E and G, of course, if the information
does not exist or is not available.
