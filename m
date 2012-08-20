From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sun, 19 Aug 2012 17:26:09 -0700
Message-ID: <7vobm6o1cu.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
 <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com>
 <7vehn3rbom.fsf@alter.siamese.dyndns.org>
 <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com>
 <7v1uj2pysd.fsf@alter.siamese.dyndns.org>
 <9E4BBC27-5B26-4048-93D4-FE02C550F4E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 02:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3FpZ-0003R0-18
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 02:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2HTA0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 20:26:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab2HTA0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 20:26:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9B790DF;
	Sun, 19 Aug 2012 20:26:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j30O5NzYbgzewS0g54SReNuboHk=; b=PhyW3F
	Vt1k1wFt0/fZ9zS8jLtiFCNpJoNLImyE5BgaRZhSBqdFLZkhJGPf40oWex8TX+oN
	JsyjBs6BSr0UPrNod/fIFt69D2/xjrJ7HiWpbHVrUe0fFGvOQ6ALB1X9ff+WhTHc
	br3hld9b3U3qVOL1reWo/kjqu5cxA7bFHWDHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RSe0ACE/WQZchEfzoBZ2uokXlK0m1wYX
	qfROZPvPDac5txW3d2rOybXuZyMvYLMzZRRokCHYSi/1y62ZYHlOVFWprLs3tSGq
	WNUbUBS+Z6DDrBwG7x9WqRm1VJ5bJO6DnxVY9ckvbyhd567yM88Xs6jqmhArgwHS
	D6XHNaEB/L0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54FF290DE;
	Sun, 19 Aug 2012 20:26:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0BD790DD; Sun, 19 Aug 2012
 20:26:11 -0400 (EDT)
In-Reply-To: <9E4BBC27-5B26-4048-93D4-FE02C550F4E2@gmail.com> (Alexey
 Muranov's message of "Mon, 20 Aug 2012 00:09:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4DDC0BE-EA5D-11E1-B9A7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203744>

Alexey Muranov <alexey.muranov@gmail.com> writes:

> I only suggested how to resolve conflicts between dead reflogs in
> graveyard if "next" and "next/foo" cannot coexist.

But Jeff's patch series already has the support for a case where you
delete next (graveyard gets 'next'), create next/foo and then delete
that (graveyard gets 'next/foo', too) anyway (check the list archive
before posting).  It is a solved problem.

> It is possible to collect the information for "git log -g
> next/foo" by looking through all "timestamp" subdirectories in
> graveyard.

It is possible if you wrote a new file every time you add one entry
to reflog, or if you created a directory with timestamp in its name
and wrote a new file there, too.

We are not particularly interested in "it is possible" when many
implementations can all trivially allow it to be "possible"; the
question is what a sensible solution is among them, and I didn't
find "a directory with timestamp in its name" a particularly
sensible way to go.

Either Jeff's "refname $name's log goes to logs/graveyard/$name~" or
Michael's "append ~d to each directory component, append ~f to the
leaf component" that are already proposed will keep "one file per
name" property to allow us to open once and efficiently read the
file through.  Why would we want to see an inferiour alternative
added to the discussion?
