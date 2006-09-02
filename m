From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 11:56:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609021151280.27779@g5.osdl.org>
References: <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
 <20060902011950.GB24234@spearce.org> <7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
 <20060902043931.GA25146@spearce.org> <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
 <9e4733910609020720w3633aa0cq5016fb1e223fc4cb@mail.gmail.com>
 <20060902173922.GA27826@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 20:58:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJagm-0006b3-Au
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 20:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWIBS5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 14:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIBS5J
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 14:57:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751286AbWIBS5G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 14:57:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k82IuxnW009419
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Sep 2006 11:57:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k82IuwVS031924;
	Sat, 2 Sep 2006 11:56:59 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902173922.GA27826@spearce.org>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26351>



On Sat, 2 Sep 2006, Shawn Pearce wrote:

> Jon Smirl <jonsmirl@gmail.com> wrote:
> > If you're going to redo the pack formats another big win for the
> > Mozilla pack is to convert pack internal sha1 references into file
> > offsets.within the pack. Doing that will take around 30MB off from the
> > Mozilla pack size. sha1's are not compressible so this is a direct
> > savings.
> 
> Right now Junio's working on the index to break the 4 GiB barrier.
> I think Junio and Nico have already agreed to change the base SHA1
> to be an offset instead; though this is an issue for the current
> way the base gets written out behind the delta as you need to know
> exactly how many bytes the delta is going to be so you can correctly
> compute the offset.

I think moving the delta to after the base object is fine, and solves that 
problem.

However, the "--thin" pack problem is potentially worse, since the object 
you delta against doesn't even _exist_, and as such you'd then end up 
having two totally different formats (or perhaps we'd add a new object 
type for use in thin packs: a "dummy object" that says "my type is 
<so-and-so> and my SHA1 is <so-and-so>, you'd better have me already".

I'm not actually personally convinced that we need to solve the 4GB 
pack-file problem right now. Does anybody have that problem yet? The 
"partial mapping" issue is a much bigger one, I suspect, even if the tree 
delta stuff seems to have fixed it largely (yes?) for the mozilla 
fast-import pack-file.

So in many ways, I'd think that the 4GB problem is one where we are 
perfectly happy to _know_ that a solution exists, rather than have to 
actually solve it today. 

Of course, if we change the pack/index-file format for other reasons, then 
we should obviously fix the 4G issue at the same time, but were there 
actually any real other reasons at this point?

			Linus

-- 
VGER BF report: U 0.500001
