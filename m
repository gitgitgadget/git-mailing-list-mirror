From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Something is broken in repack. Why not with fork and pipes?
Date: Wed, 12 Dec 2007 19:47:14 +0100
Message-ID: <998d0e4a0712121047m3cb09f37qc3157b96e5d171e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Miller" <davem@davemloft.net>, "Nicolas Pitre" <nico@cam.org>,  	jonsmirl@gmail.com, "Junio C Hamano" <gitster@pobox.com>,  	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>,  	"Andreas Ericsson" <ae@op5.se>
X-From: gcc-return-142944-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 19:47:59 2007
Return-path: <gcc-return-142944-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2WcY-0003Bh-50
	for gcc@gmane.org; Wed, 12 Dec 2007 19:47:50 +0100
Received: (qmail 20492 invoked by alias); 12 Dec 2007 18:47:30 -0000
Received: (qmail 20480 invoked by uid 22791); 12 Dec 2007 18:47:30 -0000
X-Spam-Check-By: sourceware.org
Received: from an-out-0708.google.com (HELO an-out-0708.google.com) (209.85.132.241)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 18:47:17 +0000
Received: by an-out-0708.google.com with SMTP id c3so93155ana.104         for <gcc@gcc.gnu.org>; Wed, 12 Dec 2007 10:47:14 -0800 (PST)
Received: by 10.70.44.1 with SMTP id r1mr1624015wxr.61.1197485234136;         Wed, 12 Dec 2007 10:47:14 -0800 (PST)
Received: by 10.70.26.9 with HTTP; Wed, 12 Dec 2007 10:47:14 -0800 (PST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68086>

At http://gcc.gnu.org/ml/gcc/2007-12/msg00360.html, Andreas Ericsson
<ae@op5.se> wrote:
> If it's still an issue next week, we'll have a 16 core (8 dual-core cpu's)
> machine with some 32gb of ram in that'll be free for about two days.
> You'll have to remind me about it though, as I've got a lot on my mind
> these days.
>
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231

It's good idea if it's for 24/365.25 that it does
 autorepack-compute-again-again-again-those-unexplored-deltas of
 git repositories in realtime. :D

Some body can do "git clone" that it could give smaller that one hour ago :D

-----------------------------------------------------------------

To Linus, Why don't you forget the threaded implementation of your repo-pack?

To imagine a "buggy bloated threading implementation originated to try it to
work only in HyperThreading Intel CPUs and 8 cores x 8 threads/core
Niagara Sparcs"

IMHO, in multicored machine, multiprocessed implementation of repo-pack perfomes
better than multithreaded implementation, although i've not their results.

It has not issue, not problem, etc. with memory allocation of threads,
so monothreaded memory allocation is simple and fast!

You can see "Why not with fork and pipes like in linux?" at
http://gcc.gnu.org/ml/gcc/2007-12/msg00203.html
http://gcc.gnu.org/ml/gcc/2007-12/msg00209.html

For easy implementation, don't use threads due to complicated condition races
 between threads of multithreaded processes.

To use only condition races between monothreaded processes with select/epoll
 only in the parent process. It's due to the KISS principle works.

The children processes share almost readed-only memory due to COW
 (Copy On Write), so, before forking, the parent must to have a large
 plain data structures in C for children. The children use pipes to
 realize a complex intercommunication that the parent updates the
 results computated by the children almost of the time.

Another implementation is that the children can realize a locked
 load-and-store to/from unique filesystem's database if big memory to
 store data is a big problem.

Another implementation is to consider children processes as intensive-CPU
slaves and parent process as the master that manipulates the big database.

If you want to measure the performance between multiprocessed vs multithreaded
implementation of repo-pack then you have to remember that

   For same data input size and same data output size, to get the
   seconds of your wall-clock or watch-clock as a measure of the benchmark
   of this repo-pack.

The numeric data posted to mailing list about the timings dependently of # of
 threads are bad measured because they don't say how is small the result repo.
 and don't say if the results are the same independently of # of threads.

For good measures, we need "to plot the curves", e.g. based in
( # of threads, elapsed time of wall-clock, data input size, data output size )
and we can observe the intersection between above curves.

   J.C.Pizarro
