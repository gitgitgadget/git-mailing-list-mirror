From: Theodore Tso <tytso@mit.edu>
Subject: Re: basics... when reading docs doesn't help
Date: Thu, 29 Mar 2007 22:43:27 -0400
Message-ID: <20070330024327.GC3198@thunk.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange> <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net> <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 13:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXFlS-0006BM-Kc
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 13:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618AbXC3L7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 07:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933620AbXC3L7T
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 07:59:19 -0400
Received: from thunk.org ([69.25.196.29]:34760 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933618AbXC3L7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 07:59:17 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HXFrA-0001t1-Nh; Fri, 30 Mar 2007 08:05:25 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HX75L-00064c-RF; Thu, 29 Mar 2007 22:43:27 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2007 at 12:13:02AM +0200, Guennadi Liakhovetski wrote:
> On Thu, 29 Mar 2007, J. Bruce Fields wrote:
> > Though actually on a second look, clone -l -s produces something that's
> > only 377M.  I hadn't realized how much space the build output takes up.
> > So judging from du the 1.5G Guennadi Liakhovetski mentions above seems
> > to break down into something like:
> > 
> > 	330M .git
> > 	380M working tree
> > 	750M build output

Hmm.... That doesn't look right.  My packed .git directory is 156 megs
(using post git 1.5 and repack.usedeltabaseoffset=true and
core.legacyheaders=false).

My working tree is 287M, and my build output (size of build tree minus
sources) is 1055M.   (This will vary based on .config options, obviously).

The point though is the size of the .git tree is in the noise compared
to the size of the object files.  I do share the .git repository
between trees; in fact I have a standard "base" repository which is
just a mirror of Linus's tree, and my other kernel repositories have
an .git/objects/info/alternates file which points at the base
repository for maximal sharing.

I could try to share the sources where the source files are identical,
but quite frankly, it's just never been worth the effort.  After all,
when you have a 100gig laptop drive, 287 megs isn't that much, and
it's noise compared to the size of my object files.

> Strange. Is my git 1.4.0 criminally broken? I have a clone of Linus' tree 
> on a USB disk on ext3 without any objects, which I just cloned at some 
> point and then did a couple of pulls from the same source. 

You really, really, *REALLY* want to upgrade to at least git 1.5.0.
It's is *so* much better than git 1.5.0, and it's a lot easier to make
sure your repository is kept packed, using "git gc".  

						- Ted
