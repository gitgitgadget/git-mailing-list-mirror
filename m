From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 16:18:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511081614140.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511090017370.28256@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 01:20:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZdge-00048s-I2
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 01:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbVKIATc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 19:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKIATc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 19:19:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030461AbVKIATa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 19:19:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA90JDnO002216
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Nov 2005 16:19:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA90Iq8C029406;
	Tue, 8 Nov 2005 16:19:02 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511090017370.28256@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11371>



On Wed, 9 Nov 2005, Johannes Schindelin wrote:
> 
> On Tue, 8 Nov 2005, Linus Torvalds wrote:
> 
> > Junio, that points out that "git-merge-base" is another program that could 
> > just be removed, since it's really supreceded by git-show-branch. Or did I 
> > miss something?
> 
> IIRC, git-show-branch has a limit on the number of refs it can take.

Well, git-merge-base does too. git-merge-base only takes two refs ;)

In general, you need to keep track of one bit per ref, and since we have 
a 32-bit "flags" word and need a couple of bits for other maintenance 
info, pretty much anything that figures out common heads will be limited 
some way. 

This is only a limit for the "and" logic - the "or" logic (if we implement 
it) will just share the same status bit for all the refs that are "ored 
together" and thus has no limits. 

Oh, and the "and" logic can be extended by running the program multiple 
times, so it's not a "hard" limit, it's just an issue of convenience.

That said, anybody who ever does an octopus of more than just a few heads 
deserves to be shot, so I don't think the limit should matter. The 
recursive strategy should only add the "or" kind of refs, and it 
shouldn't be a problem (apart from just how to describe them).

		Linus
