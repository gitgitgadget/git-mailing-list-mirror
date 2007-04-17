From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 08:28:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170816390.5473@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <vpqejmjjrdp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdpby-0006Jn-0V
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbXDQP2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754468AbXDQP2v
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:28:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52132 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbXDQP2u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:28:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HFSNTW006180
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 08:28:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HFSNe6032161;
	Tue, 17 Apr 2007 08:28:23 -0700
In-Reply-To: <vpqejmjjrdp.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-0.465 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44779>



On Tue, 17 Apr 2007, Matthieu Moy wrote:
> 
> * Perhaps your boss will be interested in the "data integrity" (i.e.
>   git fsck) problem too.

The data integrity thing is a lot more than just fsck.

I care a lot about my data, and it's an area where a *lot* of systems fall 
down. CVS is just about the worst (basically no checksums or sanity 
checking anywhere), and you can pretty much have total data corruption 
without ever even _realizing_, until you try to get some old version.

Even more interesting with CVS is that you can have total data corruption 
and you'll not realize it *even*as* you use the data. Lots of people and 
projects have been known to happily move *,v files around and edit the 
CVS repo files by hand to make things look right, which means that not 
only did you do a "rename" in CVS, you actually renamed *retroactively* 
too - you made history look wrong!

So with CVS, you actually have no guarantees what-so-ever that when you 
check out something old, you'll get what you actually used to have. You 
can tag things as much as you want - if people end up editing the CVS 
files (and people *do* that), you'll never have any indication that the 
history you checked out isn't the "real" history. So you can check out 
some old version that you made a release to a customer off, and may be 
totally unable to recreate the customer problem, because the release you 
checked out doesn't even compile any more!

You can actually do the same with most other SCM's. It may need somebody 
who is actually malicious, but even that isn't necessarily the case. Lots 
of SCM's don't have any checksums *at*all* on their data - the only way 
you'd ever know that something bad happened and you had disk corruption, 
is when you check something out and it just looks corrupted!

In other words, in a lot of SCM's, you're actually *lucky* if the 
corruption is so serious that it's not just a subtle "data is wrong" 
thing, it's so pervasive that you actually get an error from the SCM.

In git, every *single* piece of data is not just checksummed, it's 
CHECKSUMMED. Yeah, we use CRC's and Adler32 for some things, but even 
those are actually *also* protected at a higher level by real 
cryptographic hashes. You simply *cannot* corrupt data by mistake and not 
know about it. You can lose it, you can corrupt it, but it *will* be 
noticed.

If that doesn't make you feel good about your data, I don't know what 
will. Git will not replace backups in any way, shape, or form (although 
you can obviously use git itself to _do_ those backups - the joy of 
distributed SCMS), but it will tell you when you *need* those backups. 

Guaranteed.

And I can tell you that that is actually very rare. I doubt *any* 
commercial SCM will come even close. They might have checksums, but 
nothing really strong. It might be a CRC or even weaker. Or it might be 
nothing at all (and sadly, that's the *common* case).

				Linus
