From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git and GCC
Date: Fri, 07 Dec 2007 14:36:12 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712071419390.555@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>  <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>  <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>  <1196995353.22471.20.camel@brick>  <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org>  <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>  <alpine.LFD.0.9999.0712062120100.13796@woody.linux-foundation.org>  <9e4733910712062308t22258c6anb685b18a663e0a31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Harvey Harrison <harvey.harrison@gmail.com>,  Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,  ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142822-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 20:36:40 2007
Return-path: <gcc-return-142822-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0j03-0006Hz-38
	for gcc@gmane.org; Fri, 07 Dec 2007 20:36:39 +0100
Received: (qmail 7570 invoked by alias); 7 Dec 2007 19:36:20 -0000
Received: (qmail 7561 invoked by uid 22791); 7 Dec 2007 19:36:20 -0000
X-Spam-Check-By: sourceware.org
Received: from relais.videotron.ca (HELO relais.videotron.ca) (24.201.245.36)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 19:36:14 +0000
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca  (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))  with ESMTP id <0JSP005K12GC6J70@VL-MO-MR002.ip.videotron.ca> for  gcc@gcc.gnu.org; Fri, 07 Dec 2007 14:36:12 -0500 (EST)
In-reply-to: <9e4733910712062308t22258c6anb685b18a663e0a31@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67447>

On Fri, 7 Dec 2007, Jon Smirl wrote:

> On 12/7/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Thu, 6 Dec 2007, Jon Smirl wrote:
> > > >
> > > >         time git blame -C gcc/regclass.c > /dev/null
> > >
> > > jonsmirl@terra:/video/gcc$ time git blame -C gcc/regclass.c > /dev/null
> > >
> > > real    1m21.967s
> > > user    1m21.329s
> >
> > Well, I was also hoping for a "compared to not-so-aggressive packing"
> > number on the same machine.. IOW, what I was wondering is whether there is
> > a visible performance downside to the deeper delta chains in the 300MB
> > pack vs the (less aggressive) 500MB pack.
> 
> Same machine with a default pack
> 
> jonsmirl@terra:/video/gcc/.git/objects/pack$ ls -l
> total 2145716
> -r--r--r-- 1 jonsmirl jonsmirl   23667932 2007-12-07 02:03
> pack-bd163555ea9240a7fdd07d2708a293872665f48b.idx
> -r--r--r-- 1 jonsmirl jonsmirl 2171385413 2007-12-07 02:03
> pack-bd163555ea9240a7fdd07d2708a293872665f48b.pack
> jonsmirl@terra:/video/gcc/.git/objects/pack$
> 
> Delta lengths have virtually no impact. 

I can confirm this.

I just did a repack keeping the default depth of 50 but with window=100 
instead of the default of 10, and the pack shrunk from 2171385413 bytes 
down to 410607140 bytes.

So our default window size is definitely not adequate for the gcc repo.

OTOH, I recall tytso mentioning something about not having much return 
on  a bigger window size in his tests when he proposed to increase the 
default delta depth to 50.  So there is definitely some kind of threshold 
at which point the increased window size stops being advantageous wrt 
the number of cycles involved, and we should find a way to correlate it 
to the data set to have a better default window size than the current 
fixed default.


Nicolas
