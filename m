From: Junio C Hamano <gitster@pobox.com>
Subject: Re: History over-simplification
Date: Tue, 25 Sep 2007 15:42:54 -0700
Message-ID: <7v4phi4b9t.fsf@gitster.siamese.dyndns.org>
References: <20070923044628.GA3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJ7Y-0001wn-T9
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbXIYWnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbXIYWnD
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:43:03 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbXIYWnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:43:02 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E683913C061;
	Tue, 25 Sep 2007 18:43:17 -0400 (EDT)
In-Reply-To: <20070923044628.GA3099@spearce.org> (Shawn O. Pearce's message of
	"Sun, 23 Sep 2007 00:46:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59184>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I don't really like the patch to revision.c because it winds up
> showing trivial merges too.  What I really want is to have the
> "--full-history" option include a merge if either of the following
> is true:
>
>  a) The resulting path does not match _any_ of the parents.  We
>     already handle this case correctly in revision.c and correctly
>     show the "evil" merge.
>
>  b) The resulting path matches one of the parents but not one of
>     the others.  In such a case the merge should still be output if
>     a 3-way read-tree would not have chosen this result by default.

I am not sure (b) is useful in general.  Merging two branches
that fix the same issue but in different ways (think: 'maint'
and 'master' have different infrastructure and a fix initially
made on 'master' was backported to 'maint', and then later
'maint' needed to be merged to 'master' to carry forward other
fixes) is a norm, and in such cases taking the version from the
merged-to branch is almost always what happens.

Also it sounds to me by "if read-tree would not have chosen this
result by default" you mean this feature would not just need to
run merge-base but also recursive merge-base synthesis, and also
recreate the structural merge (aka "rename detection") there as
well.  Even if (b) is useful, it sounds like a very expensive
option, and the current merge-recursive code is structured in
such a way to be easily reused for this purpose.
