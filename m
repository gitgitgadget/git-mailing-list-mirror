From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 2 Sep 2006 11:43:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609021138500.27779@g5.osdl.org>
References: <20060829165811.GB21729@spearce.org>
 <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
 <20060829175819.GE21729@spearce.org> <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
 <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
 <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
 <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
 <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
 <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 20:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJaSb-00048l-H2
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 20:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWIBSnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWIBSnO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 14:43:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbWIBSnO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 14:43:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k82Ih8nW008915
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Sep 2006 11:43:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k82Ih8Yc031649;
	Sat, 2 Sep 2006 11:43:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.466 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26350>



On Fri, 1 Sep 2006, Junio C Hamano wrote:
> 
> But "git repack -a -d", which you now consider almost being
> free, in the recent kernel repository counts 300k objects, and
> reuses 298k objects or so.  That means we expand and recompress
> that many objects, totalling 120MB.

Sure. Do we have data for how expensive that is (ie did you apply the 
patch and time it)?

I'd rather be really safe by default, and then if somebody knows to trust 
their archive, maybe add a "--fast" flag (or even a "core.reliablepack" 
config option) to disable it for people who have backups and think their 
machines are infallible - or have slow CPU's..

For me, performance has always been one of the primary goals, but being 
able to trust the end result has been even _more_ primary. A lot of the 
design has centered around not doing things that are unsafe (eg the whole 
"never ever re-write an object" thing was obviously a big part of the 
design, and a lot of it is about being able to do things quickly _without_ 
having to do slow things like fsync).

			Linus

-- 
VGER BF report: U 0.5
