From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 07:24:56 -0400
Message-ID: <200505030724.57827.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org> <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 13:19:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSvQb-0000bC-7h
	for gcvg-git@gmane.org; Tue, 03 May 2005 13:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVECLZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 07:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVECLZL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 07:25:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:32696 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261468AbVECLZG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 07:25:06 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B05C7160E711;
	Tue,  3 May 2005 13:25:05 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 03 May 2005 04:06, Nicolas Pitre wrote:
> On Mon, 2 May 2005, Linus Torvalds wrote:
> > If you do something like this, you want such a delta-blob to be named by
> > the sha1 of the result, so that things that refer to it can transparently
> > see either the original blob _or_ the "deltified" one, and will never
> > care.
>
> Yep, that's what I've done last weekend (and just made it actually
> work since people are getting interested).
>
This looks much nicer than using zdelta, I'll try switching my packed item to 
your delta generator later this week.  Some quick and dirty space numbers to 
show why we need to pack the files together:

On the full import of all the bk->cvs changesets, the average file size 
in .git is 4074 bytes.  73% of the files are 4096 bytes or smaller.

This means that of the 2.5GB the .git directory consumes, about 1GB is taken 
up by files under 4k where deltas won't save space.  If the remaining files 
could be delta compressed down to less than 4k, they would still take up 
around 400MB on disk.

-chris

