From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 16:52:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161651010.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org> <7vy7rfub36.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610161604360.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 01:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcFm-0005Ev-Pt
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWJPXwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWJPXwF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:52:05 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:30947 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750820AbWJPXwC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 19:52:02 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F53CA> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 16:52:00 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161604360.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28999>

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> That said, it unnecessarily calculates "BITS_IN_LONG - (b)" to shift with, 
> because it really shouldn't matter _which_ high bits you use for hashing, 
> so you might as well just use the "next" b bits, and have
> 
> 	#define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
> 	#define XDL_MASKBITS(b)		((1UL << (b)) - 1)
> 	#define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MASKBITS(b))

Ok, I'm fine with this. And my Opteron agrees too:

real    0m0.283s
user    0m0.267s
sys     0m0.016s



- Davide
