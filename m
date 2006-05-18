From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 09:35:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605180929450.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
 <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
 <7v64k3698l.fsf@assigned-by-dhcp.cox.net> <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605180807060.10823@g5.osdl.org> <Pine.LNX.4.64.0605180917060.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 18:36:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FglU3-0002yx-Uo
	for gcvg-git@gmane.org; Thu, 18 May 2006 18:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWERQgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 12:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWERQgM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 12:36:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751373AbWERQgK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 12:36:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IGZxtH019766
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 09:35:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IGZwYR025269;
	Thu, 18 May 2006 09:35:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605180917060.10823@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20291>



On Thu, 18 May 2006, Linus Torvalds wrote:
> > 
> > But if people are ok with changing it from a "print a warning and ignore" 
> > into an _error_, we could just move it into "add_cache_entry()".
> 
> This is the incremental patch to do that instead, if you prefer it.

Thinking some more about it, I think I personally much prefer this.

Especially as a quick look-through seems to say that there's actually a 
path through git-update-index too that allows a unverified filename to get 
into the index (the new "--unresolve" thing also misses the need to verify 
the path).

Making it a fatal error makes it more obvious that the user did something 
fundamentally wrong. And the safety in doing it in add_cache_entry() just 
makes be happier, particularly in light of the above problem with 
--unresolve.

That still leaves the question of whether we should also drop all the 
"verify_path()" calls in update-index.c, and make it fatal there too. I 
think we probably should.

(At that point we could turn verify_path() back into a static function, 
this time local entirely to read-cache.c, rather than update-index.c)

			Linus
