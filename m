From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 11:52:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505171130460.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505170826061.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 17 17:56:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY4QI-0002X1-OX
	for gcvg-git@gmane.org; Tue, 17 May 2005 17:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVEQPzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 11:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVEQPyn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 11:54:43 -0400
Received: from iabervon.org ([66.92.72.58]:16902 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261806AbVEQPwt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 11:52:49 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DY4Mj-0003zx-00; Tue, 17 May 2005 11:52:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505170826061.18337@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 17 May 2005, Daniel Barkalow wrote:
> >
> > This adds contents and size fields to struct object. If unpack_object is
> > called on an object, it will fill in the contents field with the complete
> > raw contents of the object. If free_object_contents is called on an
> > object, the contents will be freed. If contents is filled when an object
> > is parsed, it is not unpacked an extra time, but the contents are not
> > retained if they were not unpacked before parsing.
> 
> I really hate magic interfaces like that. It's just a bug waiting to 
> happen.

I think I described it with too many cases above. parse_*() doesn't change
whether the contents are unpacked. The obvious optimization is performed 
if possible.

I'm already going to add a per-type global to have the parse functions
also unpack the object contents user-visibly, for the case that Junio
pointed out. (Making it: parse_* doesn't change whether the contents are
unpacked, unless you tell it to unpack objects.)

I think the only likely bug would be unpacking objects after parsing
them, instead of before, which is correct but inefficient. It should be
clear to a user whether the raw contents are available at any point in the
user code.

	-Daniel
*This .sig left intentionally blank*

