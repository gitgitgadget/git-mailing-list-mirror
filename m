From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's database structure
Date: Thu, 06 Sep 2007 02:09:58 -0700
Message-ID: <7vsl5sb1nd.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	<7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	<9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	<20070904212507.GA24434@thunk.org>
	<9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
	<46DE5861.4050201@op5.se>
	<9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
	<46DEC26E.7030809@op5.se>
	<9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
	<Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
	<9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
	<46DFBF13.9040109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDNO-0007z9-JG
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbXIFJKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbXIFJKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:10:09 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbXIFJKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:10:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4746B12F553;
	Thu,  6 Sep 2007 05:10:24 -0400 (EDT)
In-Reply-To: <46DFBF13.9040109@op5.se> (Andreas Ericsson's message of "Thu, 06
	Sep 2007 10:49:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57845>

Andreas Ericsson <ae@op5.se> writes:

> Estimated daily uses of git-blame, world-wide: few
> Estimated daily uses of git-{merge,diff}, worldwide: lots

Which makes the author of git-blame weep X-<.

The real issue is that embedding pathname in blob does _not_
help "git blame" but would actively hurt it.  A file with the
identical contents moved between the parent to child commit
shares the same blob object and same object name in the real
git.  Jon's modified system that hashes pathname together with
the contents would have them as two completely unrelated objects
with different object names, which only means that even 100%
similarity rename case becomes as expensive to find as renames
of lower similarity, which needs to expand and look into blob
contents.
