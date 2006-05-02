From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 2 May 2006 16:07:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605021603050.4086@g5.osdl.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org>
 <7vhd4as00i.fsf@assigned-by-dhcp.cox.net> <e34cb4$is1$1@sea.gmane.org>
 <44571967.7080807@op5.se> <7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net>
 <e378fs$lpc$1@sea.gmane.org> <7v1wvcmejr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605021422200.4086@g5.osdl.org> <7vbqugks8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 01:08:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb3yK-0006S0-B7
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWEBXHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEBXHv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:07:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21961 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965037AbWEBXHu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 19:07:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k42N7ktH004970
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 2 May 2006 16:07:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k42N7kH4018349;
	Tue, 2 May 2006 16:07:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqugks8j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19436>



On Tue, 2 May 2006, Junio C Hamano wrote:
> 
> On a related tangent, ever since I started using the built-in
> grep with ls-files like wildcard, I find myself typing something
> like this by mistake (this is from my day-job work project that
> has src/mx.js and src/mxstyle.css among other things):
> 
> 	git diff 268a94 -- 'src/mx*'
> 
> I am tempted to suggest switching pathspecs used by diff and log
> family to do the same wildcarding, perhaps after tightening the
> wildcard vs directory prefix logic used in the builtin-grep of
> the current "next" tip, which is a bit looser than necessary.

Yeah, the wildcarding is nice. You need to be very careful about it, 
though, to make sure that you take full advantage of the path 
component optimizations _before_ the wildcards, so that when you do 
something like the above ('src/mx*'), you do the "src/" part with the 
tree-level optimizations, and only the latter part with the pattern 
matching (because you do _not_ want to expand the whole tree when you 
don't want to).

That "ls-files.c" thing already does part of this (that whole "prefix_len" 
thing for the "longest common prefix").

		Linus
