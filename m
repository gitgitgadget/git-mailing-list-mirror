From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Make "git gc" pack all refs by default
Date: Thu, 24 May 2007 19:20:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705241911200.26602@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0705241132400.26602@woody.linux-foundation.org>
 <7vy7jdu08k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 04:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPQQ-0003Uo-1B
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbXEYCU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbXEYCU6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:20:58 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:45006 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751843AbXEYCU5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2007 22:20:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4P2Ks9k030202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2007 19:20:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4P2KmS4009143;
	Thu, 24 May 2007 19:20:49 -0700
In-Reply-To: <7vy7jdu08k.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.262 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48334>



On Thu, 24 May 2007, Junio C Hamano wrote:
> 
> Boy, you are a lot more aggressive than me.

Heh. 

I don't like the http interfaces, so I have a much easier time saying 
"they were broken, deal with it" ;)

I also think that we mis-calculated earlier in assuming that prople don't 
have lots of branches, and that packing branches was thus much less 
important than packing tags.

It's true that in sane git-only environment, you don't have lots of 
branches (fifty isn't "lots"). But when importing things from other 
environments, I seem to recall people talking about thousands of branches 
(since they cannot be merged and they are project-wide rather than some 
local entity, they cannot disappear).

So I think it's better to just pack branches aggressively too, and in 
fact, once you do that, and http-fetch knows about it, then that also 
means that info/refs becomes pointless, because afaik, it doesn't actually 
contain anything more than what a modern "packed-refs" file contains.

So in order to take that _next_ step, we need to encourage people to pack 
branches, and then at some point we can hopefully just make http-fetch 
start ignoring info/refs..

So yeah, I think being aggressive here is a good idea. I really also 
wanted to make update-server-info do the pack-refs thing, but to do it 
properly we'd need to make the whole pack-refs thing have a nice library 
interface, so it was a much bigger (although probably fairly 
straightforward) thing.

		Linus
