From: Richard Curnow <rc@rc0.org.uk>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 14:39:39 +0000 (UTC)
Message-ID: <loom.20060907T163036-849@post.gmane.org>
References: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com> <20060907133456.24226.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 16:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLL3Y-00089w-69
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 16:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWIGOkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 10:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWIGOkg
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 10:40:36 -0400
Received: from main.gmane.org ([80.91.229.2]:62628 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751774AbWIGOkf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 10:40:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLL3A-00083t-9S
	for git@vger.kernel.org; Thu, 07 Sep 2006 16:40:16 +0200
Received: from 164.129.1.39 ([164.129.1.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 16:40:16 +0200
Received: from rc by 164.129.1.39 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 16:40:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 164.129.1.39 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060728 Firefox/1.5.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26642>

 <linux <at> horizon.com> writes:

> 
> For regular packs, such objects wouldn't even be present, because
> all base objects are in the pack itself.
> 

It would actually be useful if this restriction were lifted.

Granted, for working repositories there's not much point, because 'git repack -a
-d' can be run regularly these days.

But for repositories served by the dumb http:// transport it makes some sense. 
You don't want to run 'repack -a -d' on those, because anybody tracking them
ends up having to download the entire history again every time they pull.  But
if you pack too often, you incur the cost of the packs containing lots of base
objects - it's as though the delta chain lengths can only ever be about 1 or 2.

If the packs were thin, regular pullers would already have the base objects, and
occasional pullers would just have to download more of the intervening (thin)
packs to get the missing deltas in the middle of the chains.  (I think everyone
has to download all the .idx files in any case.)
