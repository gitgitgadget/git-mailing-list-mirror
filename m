From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Mon, 13 Aug 2012 13:52:52 -0700
Message-ID: <7vlihicy57.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
 <CAOeW2eENsnrPqBL795FcwMgHURS6YsPBW6FYvb=DwD-UtgPZ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 22:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11dF-0001vP-BF
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 22:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab2HMUw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 16:52:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816Ab2HMUwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 16:52:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 307D18577;
	Mon, 13 Aug 2012 16:52:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dqeuFFIp/lUQa9kUI4rt38SI6xA=; b=TWWg5s
	yj2rbaz216XMEKXSEuoMCJP6KNwQ0quIKhU8316s+x/SgKFAi6zRBg0qBPzp+1JP
	CjeAgzWl5cvZWajXqb6bX9tpHurPWrZTbfy/irbzl/y+/BZrvJSJILle5Tt5KDh2
	jVpwzIffJHz+lGv9O6CGE8KrmZsOscok8P0AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N2oQfoNyh375w6m9FL/wm3cirDfSSFMw
	uwtwdZkFE0MTnmSuEFah1qlHO84kWGAoQpKwAF2GGvlb2VvYXf8vi/iZvgp/Tkdq
	egNpkJWF6SLRJx9fqAHJcZiMthlLl1/MqnczLkHmLMM7syl6UfLO1/ksjiYAcWI+
	uQbwEaYRl4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5B48576;
	Mon, 13 Aug 2012 16:52:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E8288575; Mon, 13 Aug 2012
 16:52:54 -0400 (EDT)
In-Reply-To: <CAOeW2eENsnrPqBL795FcwMgHURS6YsPBW6FYvb=DwD-UtgPZ5g@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 13 Aug 2012 13:10:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAB259E0-E588-11E1-A613-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203362>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> By the way, I can see the usefulness of --reverse when giving a range,
> but I think it's a little confusing when not giving a range.

"git rev-list --reverse --root v1.0.0" is a way to say "give me a
list of commits to be replayed in sequence" without having a bottom,
no?

Ah, you mean when we do _not_ walk.

Yeah, that is why I said that when we do not walk, we should not
even call into prepare_revision_walk() in the first place in my
earlier message.  We should take the commits as given from the
revs->pending.objects list instead.

With your "no_walk = NO_WALK_UNSORTED", calling prepare_revision_walk()
would amont to the same thing, as you would not sort the commits and
use them as given by the user.

> So "git cherry-pick A B" will apply B first, then A.

I am confused a bit.  Are you describing a buggy behaviour in the
current codebase, or are you saying we should fix it to behave that
way?
