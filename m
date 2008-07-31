From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 00:36:59 -0700
Message-ID: <7v8wvi33ok.fsf@gitster.siamese.dyndns.org>
References: <20080730093903.GA14330@cuci.nl>
 <20080730150123.GB9758@atjola.homenet>
 <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com>
 <20080731064814.GA32431@sigill.intra.peff.net>
 <7vfxpq3559.fsf@gitster.siamese.dyndns.org>
 <20080731072149.GA2304@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:38:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSjp-0007GQ-9E
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbYGaHhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYGaHhL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:37:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYGaHhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:37:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A021449B8;
	Thu, 31 Jul 2008 03:37:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AD13B449B7; Thu, 31 Jul 2008 03:37:01 -0400 (EDT)
In-Reply-To: <20080731072149.GA2304@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 Jul 2008 03:21:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AB0BB80-5ED3-11DD-9FB2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90908>

Jeff King <peff@peff.net> writes:

> I took a look at implementing a "don't parse the diff options" flag, but
> it is much larger than that. The revision parser understands a lot of
> options that don't really make sense for blame (or shortlog), like
> "--full-diff". So perhaps it is best to just fix this one (which we have
> actually had a bug report about) and not worry about the rest.

That reminds me of an issue with shortlog.

I often wish to do this:

	git shortlog --since=3.day --all | sort | uniq -c

This is to catch a stupid mistake of (1) applying a few patches to
'master', (2) forking a new topic from 'master' and applying a few patches
there, (3) realizing a few commits on 'master' that haven't been pushed
out was faulty and rewrite the 'master' history.  Such a new topic made in
step (2) must be rebased on the updated 'master' built in step (3);
otherwise merging the topic to 'next' will contaminate it with the old
version of patches that have been rewritten on 'master'.

Alas, shortlog does not take --all.  Yes, I know

	git log --since=3.day --all | git shortlog | sort | uniq -c

is an obvious workaround, but it is mildly irritating.
