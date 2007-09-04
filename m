From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 10:21:41 -0700
Message-ID: <7vy7fmny6y.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	<46DD7FE4.1060908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISc66-0007Rv-F6
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXIDRVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbXIDRVt
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:21:49 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbXIDRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:21:49 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C91D712D1F6;
	Tue,  4 Sep 2007 13:22:04 -0400 (EDT)
In-Reply-To: <46DD7FE4.1060908@op5.se> (Andreas Ericsson's message of "Tue, 04
	Sep 2007 17:55:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57620>

Andreas Ericsson <ae@op5.se> writes:

> Each root tree can only ever belong to a single commit, unless you
> intentionally force git to make completely empty commits. git
> won't complain about this, so long as you don't make two in the
> same second, because it relies more heavily on the DAG than on
> developer sanity.

This actually can happen without even using 'ours' strategy.

If two people independently applied the same patch on their
branches and later their results were merged.  And "the same
second" requirement is not even there and not interesting.
There are other things like developer identity, log message, and
their ancestry that would make the resulting commit object
distinct.

> Each root tree can point to multiple sub-trees. The sub-trees can be
> linked to any number of root-trees.
>
> Blobs can be linked to any number of tree objects, or even multiple
> times to the same tree object. This wouldn't be possible if the
> blob objects had their own pathnames stored inside them, so to speak.

More importantly, in git, filenames and modes are not considered
part of "contents", which git tracks.  Although it is an
entirely possible and valid alternate design to move that as
part of "blob" to build a system that is different from git,
which Jon seems to be aiming at, the benefit of such a design is
unclear to me, both from theoretical point of view (now blobs
are not about pure contents anymore) nor performance point of
view (Linus's done flat tree object in an early stage of git,
and it was not nice) as other people explained.
