From: Jeff King <peff@peff.net>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 02:31:09 -0500
Message-ID: <20071207073109.GA13638@coredump.intra.peff.net>
References: <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <1196918132.10408.85.camel@brick> <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> <20071206071503.GA19504@coredump.intra.peff.net> <alpine.LFD.0.99999.0712060915590.555@xanadu.home> <20071206173946.GA10845@sigill.intra.peff.net> <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>, 	Daniel Berlin <dberlin@dberlin.org>, 	Harvey Harrison <harvey.harrison@gmail.com>, 	David Miller <davem@davemloft.net>, ismail@pardus.org.tr, 	gcc@gcc.gnu.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: gcc-return-142794-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 08:31:37 2007
Return-path: <gcc-return-142794-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0XgN-0002nC-La
	for gcc@gmane.org; Fri, 07 Dec 2007 08:31:36 +0100
Received: (qmail 29490 invoked by alias); 7 Dec 2007 07:31:17 -0000
Received: (qmail 29480 invoked by uid 22791); 7 Dec 2007 07:31:16 -0000
X-Spam-Check-By: sourceware.org
Received: from 66-23-211-5.clients.speedfactory.net (HELO peff.net) (66.23.211.5)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 07:31:12 +0000
Received: (qmail 3377 invoked by uid 111); 7 Dec 2007 07:31:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)     by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 02:31:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 02:31:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67393>

On Thu, Dec 06, 2007 at 10:35:22AM -0800, Linus Torvalds wrote:

> > What is really disappointing is that we saved only about 20% of the 
> > time. I didn't sit around watching the stages, but my guess is that we 
> > spent a long time in the single threaded "writing objects" stage with a 
> > thrashing delta cache.
> 
> I don't think you spent all that much time writing the objects. That part 
> isn't very intensive, it's mostly about the IO.

It can get nasty with super-long deltas thrashing the cache, I think.
But in this case, I think it ended up being just a poor division of
labor caused by the chunk_size parameter using the quite large window
size (see elsewhere in the thread for discussion).

> I suspect you may simply be dominated by memory-throughput issues. The 
> delta matching doesn't cache all that well, and using two or more cores 
> isn't going to help all that much if they are largely waiting for memory 
> (and quite possibly also perhaps fighting each other for a shared cache? 
> Is this a Core 2 with the shared L2?)

I think the chunk_size more or less explains it. I have had reasonable
success keeping both CPUs busy on similar tasks in the past (but with
smaller window sizes).

For reference, it was a Core 2 Duo; do they all share L2, or is there
something I can look for in /proc/cpuinfo?

-Peff
