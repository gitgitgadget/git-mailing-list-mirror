From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 12:44:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161225470.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 21:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZYOU-0002SR-1K
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 21:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422871AbWJPTo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 15:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWJPTo4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 15:44:56 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:23779 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422871AbWJPToz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 15:44:55 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F531F> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 12:44:53 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28986>

On Mon, 16 Oct 2006, Linus Torvalds wrote:

> 
> Junio, I think this is worthy to go in before a 1.4.3 release. Possibly 
> even back-ported to earlier trees. Anything that causes an almost two 
> orders of magnitude slowdown (even if it's just on 64-bit architectures 
> and most people won't necessarily compile git that way) is worth fixing 
> pronto.

I ended up using this one:

#define XDL_HASHLONG(v, b) ((((unsigned long) (v) >> ((CHAR_BIT * sizeof(unsigned long)) - (b))) + \
                            (unsigned long) (v)) & ((1UL << (b)) - 1))

The GR_PRIME selection does not make me feel good, and the 'static inline' 
is puked-over by certain C compilers. It'd be probably fine to just use a 
simple function, though the above should work just fine.

real    0m0.665s
user    0m0.655s
sys     0m0.010s

(Opteron 252)



- Davide
