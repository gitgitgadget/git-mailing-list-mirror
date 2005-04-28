From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 18:27:54 -0400
Message-ID: <200504281827.54553.mason@suse.com>
References: <200504271251.00635.mason@suse.com> <200504281658.39300.mason@suse.com> <1114723987.4212.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHQe-0001zb-Bi
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVD1W2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVD1W2M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:28:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14529 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262298AbVD1W15 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:27:57 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 31B3C98A6;
	Fri, 29 Apr 2005 00:27:57 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id D63D714ED3C; Fri, 29 Apr 2005 00:27:56 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
User-Agent: KMail/1.8
In-Reply-To: <1114723987.4212.51.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 28 April 2005 17:33, Kay Sievers wrote:
> Sure. But file-changes lists the commit:
>   c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
>
> when asked for:
>   "drivers/usb/core/usb.c"
>
> and that file isn't touched there. Actually it lists merge-commits which
> are not related to the file.

Ok, this is what Daniel and David were talking about.  When we've got commit 
with multiple parents, we'll find the file at least one more time than it was 
really changed.  Looking at the results on git web, it's easy it ignore the 
merge sets as noise, but it would be nice if we only printed the merge set 
when it made some change to the file the original cset being merged did not.

I had misread your first mail, thinking that you had developed this 
independently and solved these issues ;)  The problem is that if we do a true 
depth first search, it seems like we'll have to keep a potentially unbounded 
amount of data in order to find the first changeset that happened to create a 
given sha1.  I'd really rather print the mergeset and let the user figure it 
out.

But, we're not really printing a merge set so much as we're printing the 
complete diff of what was merged.  Is there some way to see what changes had 
to be done in order to resolve conflicts during a merge?

-chris
