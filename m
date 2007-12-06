From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Git and GCC. Why not with fork, exec and pipes like in linux?
Date: Thu, 6 Dec 2007 20:25:28 +0100
Message-ID: <998d0e4a0712061125h3d44139ctb7f5600bc8467292@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,  	"Daniel Berlin" <dberlin@dberlin.org>,  	"Harvey Harrison" <harvey.harrison@gmail.com>,  	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,  	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>,  	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: gcc-return-142763-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 20:26:04 2007
Return-path: <gcc-return-142763-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0MMC-00031a-Tw
	for gcc@gmane.org; Thu, 06 Dec 2007 20:26:01 +0100
Received: (qmail 7073 invoked by alias); 6 Dec 2007 19:25:39 -0000
Received: (qmail 6980 invoked by uid 22791); 6 Dec 2007 19:25:37 -0000
X-Spam-Check-By: sourceware.org
Received: from nz-out-0506.google.com (HELO nz-out-0506.google.com) (64.233.162.234)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 19:25:31 +0000
Received: by nz-out-0506.google.com with SMTP id i11so171605nzh         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 11:25:29 -0800 (PST)
Received: by 10.143.161.3 with SMTP id n3mr1868199wfo.1196969128879;         Thu, 06 Dec 2007 11:25:28 -0800 (PST)
Received: by 10.70.54.17 with HTTP; Thu, 6 Dec 2007 11:25:28 -0800 (PST)
Content-Disposition: inline
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67328>

On 2007/12/06, "Jon Smirl" <jonsmirl@gmail.com> wrote:
> On 12/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Thu, 6 Dec 2007, Jeff King wrote:
> > >
> > > What is really disappointing is that we saved only about 20% of the
> > > time. I didn't sit around watching the stages, but my guess is that we
> > > spent a long time in the single threaded "writing objects" stage with a
> > > thrashing delta cache.
> >
> > I don't think you spent all that much time writing the objects. That part
> > isn't very intensive, it's mostly about the IO.
> >
> > I suspect you may simply be dominated by memory-throughput issues. The
> > delta matching doesn't cache all that well, and using two or more cores
> > isn't going to help all that much if they are largely waiting for memory
> > (and quite possibly also perhaps fighting each other for a shared cache?
> > Is this a Core 2 with the shared L2?)
>
> When I lasted looked at the code, the problem was in evenly dividing
> the work. I was using a four core machine and most of the time one
> core would end up with 3-5x the work of the lightest loaded core.
> Setting pack.threads up to 20 fixed the problem. With a high number of
> threads I was able to get a 4hr pack to finished in something like
> 1:15.
>
> A scheme where each core could work a minute without communicating to
> the other cores would be best. It would also be more efficient if the
> cores could avoid having sync points between them.
>
> --
> Jon Smirl
> jonsmirl@gmail.com

For multicores CPUs, don't divide the work in threads.
To divide the work in processes!

Tips, tricks and hacks: to use fork, exec, pipes and another IPC mechanisms like
mutexes, shared memory's IPC, file locks, pipes, semaphores, RPCs, sockets, etc.
to access concurrently and parallely to the filelocked database.

For Intel Quad Core e.g., x4 cores, it need a parent process and 4
child processes
linked to the parent with pipes.

The parent process can be
* no-threaded using select/epoll/libevent
* threaded using Pth (GNU Portable Threads), NPTL (from RedHat) or whatever.

   J.C.Pizarro
