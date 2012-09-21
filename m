From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 16:51:23 -0700
Message-ID: <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
References: <505C7C80.3000700@workspacewhiz.com>
 <7vy5k370n7.fsf@alter.siamese.dyndns.org>
 <505CB21E.4040607@workspacewhiz.com>
 <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
 <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org>
 <505CD7D0.2000505@workspacewhiz.com>
 <20120921233723.GA29433@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 01:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFD0R-0005Te-Kw
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 01:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab2IUXv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 19:51:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab2IUXv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 19:51:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF5096B0;
	Fri, 21 Sep 2012 19:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XxINvLuYpwSZI3EjD8l1VLTWdGU=; b=HzqMz7
	6Wq1QyJwFP05Macz6WA2VJEBss+iU1Gtgn+pAmCKfEFeUrJQE1MjMXFznUDvr3wn
	RF+JPHQAGcUZ88Pt9OCdt8p26WWuMjpIm/LRIQ4JcqFqgosccpQsRTMJSg9agyIN
	vNsSFHJnq5MNeOWmD0RkS2zA0KaI902XFGq1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MV7tELY17H72UA0vjVOFO+rlpj0pFfCa
	5XIULFdbWWk9Hw+qyzGxpuGE8WwMvB9FLqVnqwSgsMy8BruFbHg3QnKHiWREx/c5
	NIg6wxv6g8uyOiF1tJjYGAAFBB3QF9AshsToqsIzF+4HDigM+jYJXEfLRZs8D88w
	dDV5WD0lEDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CA9E96AF;
	Fri, 21 Sep 2012 19:51:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68B8D96AE; Fri, 21 Sep 2012
 19:51:24 -0400 (EDT)
In-Reply-To: <20120921233723.GA29433@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 21 Sep 2012 19:37:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4069660C-0447-11E2-9EE8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206179>

Jeff King <peff@peff.net> writes:

> I think people have provided sane techniques for doing this with a
> pipeline. But there is really no reason not to have --grep-notes, just
> as we have --grep.  It's simply that nobody has implemented it yet (and
> nobody is working on it as far as I know). It would actually be a fairly
> simple feature to add if somebody wanted to get their feet wet with git.

I agree that the implementation will be simple once you figure out
what the sensible semantics and external interfaces are. The latter
is not that simple and certainly not something for newbies to solve
on their own.  That is why I didn't mention it.

But now you brought it up, here are a few thinking-points as a
starter:

 - Wouldn't it be more intuitive to just let the normal "--grep" to
   also hit what "--show-notes" would add to the output?  Does it
   really add value to the end user experience to add a separate
   "--grep-notes=P4[0-9]*" option, even though it would give you
   more flexibility?

   Not having thought things through thorouly, I still answer this
   question both ways myself and what the right user experience
   should look like.

 - Do we want to be limited to one notes tree?  Would it make sense
   to show notes from the usual commit notes but use different notes
   tree for the sole purpose of restricting visibility?  If we
   wanted to allow that for people who want flexibility, but still
   want to use only one and the same by default, what should the
   command line options look like?

 - Would it be common to say "I want commits with _any_ notes from
   this notes tree"?  Having to say "--grep-notes=." for such a
   simple task, if it is common, feels a bit clunky.
