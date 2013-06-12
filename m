From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from builtin/notes.c to notes-utils.c
Date: Wed, 12 Jun 2013 13:02:15 -0700
Message-ID: <7v7ghz2j3s.fsf@alter.siamese.dyndns.org>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 22:02:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmrFQ-00068O-CG
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 22:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab3FLUCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 16:02:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756138Ab3FLUCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 16:02:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF5C2791D;
	Wed, 12 Jun 2013 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0+WzgjtMRgrpJP0F8DNa4dMuR1M=; b=ZHwIF3zwkJlP2HDOoLdr
	My0Mb9nH0L9V5mj53aKYvx8j9uhiOHwcsmrWyK+zqAbuUqUxEcZ8WuBwSH4T3jUI
	PrGXwQ9HoSiTV/rqBQyyMjrLEnrsGjHIxyipOwwaYnkjj4tqgA0T1LuMwd8jZBsF
	0zq51IKkiXq23SufFaTgXEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fj4yOYuXT+blowexJVhEs6MJrLm/0iyObWS2bKrleT3lb3
	7wRo8gPuRJIrFsB+fy+Wmq6fHAXcPtj0ADhgggn8p7bGf39gqrtl9XlVHU3NMqIq
	9q2l31FjbaRdeG771XClGKw/tSNQsRMIvQZXzaP8Z7VApg0Q8lmHYqfpq/7WA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF022791B;
	Wed, 12 Jun 2013 20:02:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E6BF27917;
	Wed, 12 Jun 2013 20:02:16 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB337586-D39A-11E2-8C60-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227671>

Johan Herland <johan@herland.net> writes:

> This is a pure code movement of the machinery for copying notes to
> rewritten objects. This code was located in builtin/notes.c for
> historical reasons. In order to make it available to builtin/commit.c
> it was declared in builtin.h. This was more of an accident of history
> than a concious design, and we now want to make this machinery more
> widely available.
>
> Hence, this patch moves the code into the new notes-utils.[hc] files
> which are included into libgit.a. Except for adjusting #includes
> accordingly, this patch merely moves the relevant functions verbatim
> into the new files.
>
> Cc: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  Makefile         |   2 +
>  builtin.h        |  16 -------
>  builtin/commit.c |   1 +
>  builtin/notes.c  | 131 +-----------------------------------------------------
>  notes-utils.c    | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  notes-utils.h    |  23 ++++++++++
>  6 files changed, 159 insertions(+), 146 deletions(-)
>  create mode 100644 notes-utils.c
>  create mode 100644 notes-utils.h

Output from "git show -C1 --stat" after applying this patch shows
mostly removals (i.e. builtin/notes.c loses what was lifted from it,
notes-utils.c starts its life as a copy of the former and the patch
shows removal of what should not move to notes-utils.c).  After
inspecting "added" lines to these two files, I did not spot anything
suspicious, except for one C++/C99 comment (will locally touch-up).

Thanks.
