From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Calculating tree nodes
Date: Wed, 05 Sep 2007 22:21:13 -0700
Message-ID: <7vhcm8e5di.fsf@gitster.siamese.dyndns.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	<20070904025153.GS18160@spearce.org>
	<9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	<20070904062629.GZ18160@spearce.org>
	<7vbqcinxdb.fsf@gitster.siamese.dyndns.org>
	<20070906032026.GO18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:21:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9o1-0001nA-5z
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXIFFVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbXIFFVX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:21:23 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbXIFFVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 01:21:22 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F409E12D537;
	Thu,  6 Sep 2007 01:21:37 -0400 (EDT)
In-Reply-To: <20070906032026.GO18160@spearce.org> (Shawn O. Pearce's message
	of "Wed, 5 Sep 2007 23:20:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57821>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The latter (build and test log) would generally be very large.
> We would *not* want to cluster them.  But we might want to store
> next to the commit a very small pointer to the note itself.  Such
> as the note's SHA-1.  Or its offset within the packfile's index.
> This would make locating those notes very cheap, while not having
> a huge impact on the common case of commit traversal.
>
> Likewise we might want to pack a tag's SHA-1 alongside of the commit
> it points at, as parsing the commit would immediately give us all
> annotated tags that refer to that commit.  Tags are (usually) few
> and far between.  But tools like git-describe are commonly used and
> would benefit from not needing to build the commit->tag hashtable.

I am not so sure.

It is a good idea to have an internal API that takes an object
and gives back a set of objects (be they notes to commit or tags
point at object) related to it, but you need to always deal with
loose objects and v2 packs, so you will have to traverse all the
tags and find what they point at _anyway_ to implement the API.
Having a specialized table in v4 does not mean you can look at
that table and nothing else, so I do not immediately see a gain.
