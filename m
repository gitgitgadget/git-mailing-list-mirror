From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 7/9] git-hash-object: Add --stdin-paths option
Date: Tue, 23 Oct 2007 23:11:23 -0700
Message-ID: <20071024061123.GA10916@soma>
References: <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com> <1193118397-4696-8-git-send-email-aroben@apple.com> <20071023055331.GF14735@spearce.org> <471D8D34.4050104@apple.com> <20071023061022.GG14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 08:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkZSs-00085d-JS
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 08:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbXJXGL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 02:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbXJXGL0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 02:11:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53121 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbXJXGL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 02:11:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2565A7DC0FE;
	Tue, 23 Oct 2007 23:11:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071023061022.GG14735@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62195>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Adam Roben <aroben@apple.com> wrote:
> > Shawn O. Pearce wrote:
> > >Adam Roben <aroben@apple.com> wrote:
> > >  
> > >>This allows multiple paths to be specified on stdin.
> > >
> > >git-fast-import wasn't suited to the task?
> > 
> > I actually considered using fast-import for the whole shebang, but 
> > decided that I don't yet understand the workings and structure of 
> > git-svn well enough to make such a big change.
> > 
> > git-svn uses git-hash-object to both determine a file's hash and insert 
> > it into the index in one go -- can fast-import do this? Or will it just 
> > put it in the index and not give you the hash back? The latter was my 
> > impression.
> 
> It doesn't currently give you the hash back.  You can sort of get
> to it by marking the blob then using the 'checkpoint' command to
> dump the marks to a file, which you can read in.  Not good.
> 
> It probably wouldn't be very difficult to give fast-import a way
> to dump marks back on stdout as they are assigned.  So long as the
> frontend either locksteps with fast-import or is willing to monitor
> it with a select/poll type of arrangement and read from stdout as
> soon as its ready.
> 
> Probably a 5 line code change to fast-import.  Like this.  Only Git
> won't recognize that object SHA-1 as its in a packfile that has
> no index.  You'd need to 'checkpoint' to flush the object out, or
> just use all of fast-import for the processing.  So yea, I guess
> I can see now how its not suited to this.

Shawn, thanks for clearing that up.  I was previously considering
fast-import for git-svn, but never had time[1] to really look at it.

I guess Adam is on the right track with his patches.

[1] - Sorry to all on the list, but I've really been slacking on git-svn
      work.  I was going to get some stuff done this weekend but decided
      to attempt to fight my nasty caffeine addiction instead :x

-- 
Eric Wong
