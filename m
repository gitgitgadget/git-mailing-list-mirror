From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 10:35:22 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <20071205.202047.58135920.davem@davemloft.net> <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net>  <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <1196918132.10408.85.camel@brick> <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> <20071206071503.GA19504@coredump.intra.peff.net>  <alpine.LFD.0.99999.0712060915590.555@xanadu.home> <20071206173946.GA10845@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,         Daniel Berlin <dberlin@dberlin.org>,         Harvey Harrison <harvey.harrison@gmail.com>,         David Miller <davem@davemloft.net>, ismail@pardus.org.tr,         gcc@gcc.gnu.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: gcc-return-142757-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 19:36:30 2007
Return-path: <gcc-return-142757-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0La7-00076o-TE
	for gcc@gmane.org; Thu, 06 Dec 2007 19:36:20 +0100
Received: (qmail 30735 invoked by alias); 6 Dec 2007 18:36:01 -0000
Received: (qmail 30720 invoked by uid 22791); 6 Dec 2007 18:36:01 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 18:35:54 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6IZO9u022958 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Thu, 6 Dec 2007 10:35:25 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6IZMv2005873; 	Thu, 6 Dec 2007 10:35:23 -0800
In-Reply-To: <20071206173946.GA10845@sigill.intra.peff.net>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67315>



On Thu, 6 Dec 2007, Jeff King wrote:
> 
> What is really disappointing is that we saved only about 20% of the 
> time. I didn't sit around watching the stages, but my guess is that we 
> spent a long time in the single threaded "writing objects" stage with a 
> thrashing delta cache.

I don't think you spent all that much time writing the objects. That part 
isn't very intensive, it's mostly about the IO.

I suspect you may simply be dominated by memory-throughput issues. The 
delta matching doesn't cache all that well, and using two or more cores 
isn't going to help all that much if they are largely waiting for memory 
(and quite possibly also perhaps fighting each other for a shared cache? 
Is this a Core 2 with the shared L2?)

			Linus
