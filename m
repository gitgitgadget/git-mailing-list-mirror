From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 09:23:47 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
References: <20071206.193121.40404287.davem@davemloft.net> <20071207063848.GA13101@coredump.intra.peff.net> <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com> <20071207.045329.204650714.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jonsmirl@gmail.com, peff@peff.net, nico@cam.org, dberlin@dberlin.org,         harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,         git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: gcc-return-142810-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 18:25:15 2007
Return-path: <gcc-return-142810-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0gwq-00035h-6b
	for gcc@gmane.org; Fri, 07 Dec 2007 18:25:12 +0100
Received: (qmail 15044 invoked by alias); 7 Dec 2007 17:24:53 -0000
Received: (qmail 15035 invoked by uid 22791); 7 Dec 2007 17:24:52 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 17:24:08 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB7HNn1o031890 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Fri, 7 Dec 2007 09:23:50 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB7HNlmN027780; 	Fri, 7 Dec 2007 09:23:48 -0800
In-Reply-To: <20071207.045329.204650714.davem@davemloft.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67437>



On Fri, 7 Dec 2007, David Miller wrote:
> 
> Also I could end up being performance limited by SHA, it's not very
> well tuned on Sparc.  It's been on my TODO list to code up the crypto
> unit support for Niagara-2 in the kernel, then work with Herbert Xu on
> the userland interfaces to take advantage of that in things like
> libssl.  Even a better C/asm version would probably improve GIT
> performance a bit.

I doubt yu can use the hardware support. Kernel-only hw support is 
inherently broken for any sane user-space usage, the setup costs are just 
way way too high. To be useful, crypto engines need to support direct user 
space access (ie a regular instruction, with all state being held in 
normal registers that get saved/restored by the kernel).

> Is SHA a significant portion of the compute during these repacks?
> I should run oprofile...

SHA1 is almost totally insignificant on x86. It hardly shows up. But we 
have a good optimized version there.

zlib tends to be a lot more noticeable (especially the uncompression: it 
may be faster than compression, but it's done _so_ much more that it 
totally dominates).

			Linus
