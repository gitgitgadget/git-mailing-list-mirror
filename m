From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 09:17:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180845040.18388@alien.or.mcafeemobile.com>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home> <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610180752500.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 18:18:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaE6y-0002qK-97
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 18:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWJRQRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 12:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWJRQRO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 12:17:14 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:62081 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422634AbWJRQRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 12:17:13 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F5BD9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 18 Oct 2006 09:17:10 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610180752500.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29243>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> On Tue, 17 Oct 2006, Davide Libenzi wrote:
> > 
> > Ehm, I think there's a little bit of confusion. The incorrect golden ratio 
> > prime selection for 64 bits machines was coalescing hash indexes into a 
> > very limited number of buckets, hence creating very bad performance on diff 
> > operations. The result of the diff would have been exacly the same, just 
> > coming out after the time for a cup of coffee and a croissant ;)
> 
> But my point is, you would have been better off _without_ an algorithm 
> that cared about the word-size at all, or with just using "uint32_t".

Yes. At the time I picked Knuth's hash function because it was simple and 
fast enough. But it needed special handling for different word sizes, 
exactly like kernel's hash_long() does.



> A diff algorithm that gives different answers on a 32-bit LE architecture 
> than on a 64-bit BE architecture is BROKEN. If I run on x86-64, I want the 
> same answers I got on x86-32, and the same ones I get on ppc32. Anything 
> else is SIMPLY NOT ACCEPTABLE!

Speaking in general, seen at the hash function level, of course an interface 
should not give different result for different word sizes or word endianess. 
Considering the diff algorithm as interface, as I said, the output was 
unaffected by the 64 bits word size. It was just very slow.



- Davide
