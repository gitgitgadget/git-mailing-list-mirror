From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Better value for chunk_size when threaded
Date: Thu, 6 Dec 2007 20:37:07 -0500
Message-ID: <9e4733910712061737o50a9a5f1ldccdf943bb19319f@mail.gmail.com>
References: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
	 <alpine.LFD.0.99999.0712062014060.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 02:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0S9t-0007lz-N8
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 02:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbXLGBhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 20:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbXLGBhL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 20:37:11 -0500
Received: from ro-out-1112.google.com ([72.14.202.180]:22462 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbXLGBhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 20:37:09 -0500
Received: by ro-out-1112.google.com with SMTP id p4so6908119roc
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 17:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cwNJKMGGdS9bod9gP3wvgGDhUtXNLwoAIpSvj2kiCDo=;
        b=fpD+H5x8d3ZivYsQ/dlt1dpbW08kX1BU4qf7oFhK6RKuxDeqSz/NNT7klIJkQNBLimREihTeuLKw9g/x1TM4wxkWFFrxZlHWjYU/CzFwSddFfYIEp/ZEq4v2BsK2GzhGEj9XtzojZCX4iWpxiWqvhcJV5EGPndiK1LhWV8qCWcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQqmmrLq28nys7Z3WxjRRNKSGC/GdCx1xpg3RaqsGgGZzQLx/sMcxREA/D4j80LHSyo2EhWXtjlkCoXZb4R4f+jLtkTW9ezH9fMwqZndFxOXJlVi6CSLjHpyKsOy1WIBqoAx0JRqmCbQjlgN8GUPCLpNavMF96Zy0YTh9LDq2LY=
Received: by 10.114.168.1 with SMTP id q1mr2730825wae.1196991427989;
        Thu, 06 Dec 2007 17:37:07 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 17:37:07 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712062014060.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67365>

On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 6 Dec 2007, Jon Smirl wrote:
>
> > I tried some various ideas out for chunk_size and the best strategy I
> > found was to simply set it to a constant. How does 20,000 work on
> > other CPUs?
>
> That depends on the object size.  If you have a repo with big objects
> but only 1000 of them for example, then the constant doesn't work.

How about defaulting it to 20,000 and allowing an override? It's not
fatal if we guess wrong, we just want to most common cases to work out
of the box. 20,000 is definitely better than the current window *
1000.

> Ideally I'd opt for a value that tend towards around 5 seconds worth of
> work per segment, or something like that.  Maybe using the actual
> objects size could be another way.
>
> > I'd turn on default threaded support with this change. With threads=1
> > versus non-threaded there is no appreciable difference in the time.
>
> Would need a way to determine pthreads availability from Makefile.

configure knows if pthreads is there.

> > Is there an API to ask how many CPUs are in the system? It would be
> > nice to default the number of threads equal to the number of CPUs and
> > only use pack.threads=X to override.
>
> If there is one besides futzing with /proc/cpuinfo I'd like to know
> about it.  Bonus points if it is portable.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
