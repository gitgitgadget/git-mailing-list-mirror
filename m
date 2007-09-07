From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout and rm
Date: Fri, 07 Sep 2007 15:00:02 -0700
Message-ID: <7v4pi62l25.fsf@gitster.siamese.dyndns.org>
References: <4F2CF06E-CCC6-4597-A1BF-663BC36B9A94@ShopWiki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Jenkins <Jeff@ShopWiki.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:00:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITlsA-0004Pu-UV
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbXIGWAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758335AbXIGWAL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:00:11 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253AbXIGWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:00:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D44221304AD;
	Fri,  7 Sep 2007 18:00:27 -0400 (EDT)
In-Reply-To: <4F2CF06E-CCC6-4597-A1BF-663BC36B9A94@ShopWiki.com> (Jeff
	Jenkins's message of "Thu, 6 Sep 2007 22:59:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58081>

Jeff Jenkins <Jeff@ShopWiki.com> writes:

> With stash in 1.5.3 the only reason I
> can think of to allow working directory changes to propagate is gone

This reasoning is utterly wrong.

We often begin exploring a solution while on one branch (perhaps
'master'), starting with small changes in the work tree, and
then realize that it needs to be worked on in a separate branch:

	$ edit some work tree files
	$ git branch new-topic
        $ git checkout new-topic

Or maybe we would realize that the fix we started to work on
while on 'master' also applies to 'maint', and do the checkout
without creating a new branch:

	$ edit some work tree files
	$ git checkout maint

In either case, it is a _good_ thing that you can take your
local changes with you when you switch branches, without extra
stash/unstash sequence, and I do not think this is going to
change.

About the "lost remove", I think it is related to the fact that
we try to be usable in a sparsely checked out work tree, and
during a two-way merge (aka "switching branches") we consider a
missing file equivalent to an unmodified file and this might be
a bug in the logic to implement it there.  I haven't checked
this conjecture and won't have time now to do the digging myself
(you're welcome to do the digging yourself in the meantime).  It
may turn out to be a trivial change, but I dunno at this moment.
