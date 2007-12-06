From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 17:08:03 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712061645120.555@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <1196918132.10408.85.camel@brick>  <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com>  <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>  <20071206071503.GA19504@coredump.intra.peff.net>  <alpine.LFD.0.99999.0712060915590.555@xanadu.home>  <20071206173946.GA10845@sigill.intra.peff.net>  <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>  <9e4733910712061055p353775d8wd0321bc9c81297b7@mail.gmail.com>  <alpine.LFD.0.99999.0712061403000.555@xanadu.home>  <9e4733910712061339n3aef023r22e5b73aac120c8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff King <peff@peff.net>,  Daniel Berlin <dberlin@dberlin.org>,  Harvey Harrison <harvey.harrison@gmail.com>,  David Miller <davem@davemloft.net>, ismail@pardus.org.tr, gcc@gcc.gnu.org,  git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142773-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 23:08:42 2007
Return-path: <gcc-return-142773-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0OtV-00051w-Lw
	for gcc@gmane.org; Thu, 06 Dec 2007 23:08:34 +0100
Received: (qmail 6607 invoked by alias); 6 Dec 2007 22:08:15 -0000
Received: (qmail 6594 invoked by uid 22791); 6 Dec 2007 22:08:14 -0000
X-Spam-Check-By: sourceware.org
Received: from relais.videotron.ca (HELO relais.videotron.ca) (24.201.245.36)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 22:08:06 +0000
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca  (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))  with ESMTP id <0JSN002DQETGP380@VL-MO-MR004.ip.videotron.ca> for  gcc@gcc.gnu.org; Thu, 06 Dec 2007 17:08:04 -0500 (EST)
In-reply-to: <9e4733910712061339n3aef023r22e5b73aac120c8a@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67344>

On Thu, 6 Dec 2007, Jon Smirl wrote:

> On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > > When I lasted looked at the code, the problem was in evenly dividing
> > > the work. I was using a four core machine and most of the time one
> > > core would end up with 3-5x the work of the lightest loaded core.
> > > Setting pack.threads up to 20 fixed the problem. With a high number of
> > > threads I was able to get a 4hr pack to finished in something like
> > > 1:15.
> >
> > But as far as I know you didn't try my latest incarnation which has been
> > available in Git's master branch for a few months already.
> 
> I've deleted all my giant packs. Using the kernel pack:
> 4GB Q6600
> 
> Using the current thread pack code I get these results.
> 
> The interesting case is the last one. I set it to 15 threads and
> monitored with 'top'.
> For 0-60% compression I was at 300% CPU, 60-74% was 200% CPU and
> 74-100% was 100% CPU. It never used all for cores. The only other
> things running were top and my desktop. This is the same load
> balancing problem I observed earlier.

Well, that's possible with a window 25 times larger than the default.

The load balancing is solved with a master thread serving relatively 
small object list segments to any work thread that finished with its 
previous segment.  But the size for those segments is currently fixed to 
window * 1000 which is way too large when window == 250.

I have to find a way to auto-tune that segment size somehow.

But with the default window size there should not be any such noticeable 
load balancing problem.

Note that threading only happens in the compression phase.  The count 
and write phase are hardly paralleled.


Nicolas
