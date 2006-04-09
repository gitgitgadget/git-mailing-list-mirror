From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 9 Apr 2006 12:02:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 21:02:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSfBX-0007np-7o
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 21:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWDITCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 15:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWDITCw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 15:02:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbWDITCw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 15:02:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k39J2jtH014502
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 9 Apr 2006 12:02:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k39J2i0m010814;
	Sun, 9 Apr 2006 12:02:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18560>



On Sun, 9 Apr 2006, Junio C Hamano wrote:
> 
> Also, I might have to rethink --max-count logic -- I think it is
> reasonable to skip the commit when doing limiting by diff like
> "whatchanged" does, but one thing I find suboptimal with the
> current whatchanged is that it does not count commits that are
> actually shown (it counts what the upstream rev-list feeds
> diff-tree).  With the "git log --diff" based whatchanged, it
> becomes trivial to skip the revs->max_count limiting and have
> the caller count the commits it actually does something
> user-visible to, instead of counting the commits it pulled out
> of get_revision().

Well, on the other hand, the new "git log --diff" should get the revision 
counting right even if it's _not_ done by the caller.

Really, the only reason "git-whatchanged" exists at all is that it used to 
be originally impossible, and later on too expensive to do the commit- 
limiting by pathname. With the new incremental path-limiting, the reason 
for "git-whatchanged" simply goes away.

So I'd suggest:
 - drop git-whatchanged entirely
 - keep it - for historical reasons - as a internal shorthand, and just 
   turn it into "git log --diff -cc"

and everybody will be happy (yeah, it will show a few merge commits 
without diffs, because the diffs end up being uninteresting, but that's 
_fine_, even if it's not 100% the same thing git-whatchanged used to do)

			Linus
