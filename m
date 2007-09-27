From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 27 Sep 2007 15:46:03 +0200
Message-ID: <868x6sgr1g.fsf@lola.quinscape.zz>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <854phgfxn7.fsf@lola.goethe.zz> <20070927133056.GA29674@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 16:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iau9g-000277-5u
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 16:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbXI0OPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 10:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbXI0OPo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 10:15:44 -0400
Received: from main.gmane.org ([80.91.229.2]:37843 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755633AbXI0OPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 10:15:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iatw6-0004jp-8P
	for git@vger.kernel.org; Thu, 27 Sep 2007 14:01:50 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 14:01:50 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 14:01:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:XOQMjdqIx9RL28/O9HLim2uQXz8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59301>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 27, 2007 at 08:08:44AM +0200, David Kastrup wrote:
>
>> In itself, it does not look like there is all too much room for
>> optimization.  One can remove the temporary pointer "optimization" and
>> see whether this makes strength reduction possible for the compiler.
>> Making this an endless loop wrapped around a loop on bucket might also
>> help the compiler in that effect.
>
> I am considering reworking the data structure to be a hash table
> whose buckets never overflow. However, Junio indicated that he tried
> something similar at one point and was not successful. So we will
> see. I haven't had time to play with it yet, but I will post numbers
> when I do.

Linear probing is pretty efficient with regard to keeping memory
access locality.  With a reasonable table filling ratio (not more than
something like 75%, for which it is necessary to know the maximum
number of hashable entries in advance), there is no gain to be
expected in either speed or even memory usage (the waste of 25% is
offset by not needing space for link pointers) with escape lists.
Linear probing hashes are quite hard to resize: if the maximum member
count is _not_ to be guessed in advance, things might look different.

I don't have the time to look at the code right now, so I don't know
whether resizing or unknown maximum size is a relevant factor.

-- 
David Kastrup
