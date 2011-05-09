From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Mon, 09 May 2011 16:25:27 -0700
Message-ID: <7v1v07o3rs.fsf@alter.siamese.dyndns.org>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
 <20110509225307.GG22908@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:25:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZph-0004CS-Cl
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab1EIXZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:25:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1EIXZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:25:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D63315023;
	Mon,  9 May 2011 19:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=43n3/7LSuHDU++SJajKnr/ni6DQ=; b=ho95NF
	gFFyYsbwX/phRju9JJZDGpCIFGY3YVD5CjQGXdUJ61TQ7LvIhBRMRCqiuzwaVjcS
	FDW85c3PptoBlXxV3YRUzpAP90p5Y2WVHc11nRLmvJCSN8F62Phr3HnF579SeP0d
	5M2AELm+XHhA5E8cCFxGlw9i8IC7FoCUX1qQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sUdwzYM4dCIx/joG5TJzRWJXd+HUUC9r
	4t9Ahq57ECJ07DeMe0dLlG+OrTs4nCsW8x0EjJBYQ+K1qK2IA61wBGxQFq/rJmf6
	b+2D1WPJJC99yuj4vXJvzpLrOCuVz3wxlGLchSpsrCqYk+AodOo4+Bt2USPeF6KY
	ktT+XglGWqU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94E885021;
	Mon,  9 May 2011 19:27:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 42ECC5020; Mon,  9 May 2011
 19:27:35 -0400 (EDT)
In-Reply-To: <20110509225307.GG22908@elie> (Jonathan Nieder's message of
 "Mon, 9 May 2011 17:53:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEBDA202-7A93-11E0-85EF-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173287>

Jonathan Nieder <jrnieder@gmail.com> writes:

> An alternative possibility if we need this fixed in the v1.7.5.x
> series (do we?) would be cherry-picking the fix from
> sg/completion-updates on top of maint.

As contrib/ material, I personally don't think we would care strongly
enough to bother.

> To clarify the trade-offs:
>
>  - in terms of lines of code, the fix itself in sg/completion-updates
>    and this fix are about the same size.  But the sg/completion-updates
>    version relies on a code cleanup.
>
>  - the fix in sg/completion-updates is less likely to be broken by
>    future changes in the bashcompinit library.
>
>  - this fix is conceptually simpler.  In a way, the fix in
>    sg/completion-updates only works by accident.

Hmm, zsh does not want to see "word" getting localized by the user because
it has a special semantics associated with it.  Szeder avoids localizing
it.  Felipe sidesteps the issue by stripping the funny special semantics
from the variable.  I guess both have a similar degree of conceptual
simplicity.

One big thing going for this patch is that this is the blessed solution
zsh folks themselves like to use, no? The repeated mention "zsh bashinit
bug" in the code seems to suggest that it is the case.

I do not mind reverting sg/completion-updates from 'next' (please remind
me that I need to resurrect your "private shopt shim" separately if we go
this route) and applying a cleaned-up version of this one.

Thanks.
