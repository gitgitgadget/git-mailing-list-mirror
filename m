From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Valgrind updates
Date: Tue, 27 Jan 2009 03:50:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302>
References: <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 03:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRe40-0005pU-Mi
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 03:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbZA0CvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 21:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZA0CvI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 21:51:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:55018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752365AbZA0CvH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 21:51:07 -0500
Received: (qmail invoked by alias); 27 Jan 2009 02:51:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp060) with SMTP; 27 Jan 2009 03:51:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/fEYsouQ/5H5lx52P4qAQPxWvnrg7KGNXBS97aU
	s7tWJ1lkGNFngI
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107300>

Hi,

it is real late now, so I am uncomfortable sending off a new patch series 
(I _know_ that I'll just introduce a stupid bug or forget to write a 
commit message or whatever).  In case you are interested in the current 
progress, you know where my branches are.

The changes I made:

- added t/valgrind/templates to t/.gitignore, too,

- split out the valgrind-unrelated parts that Peff complained about,

- added some more suppressions I needed,

- added a mode whereby the tests' results are written to test-results/,

- provided a Makefile target for further convenience,

- added a script to coalesce the valgrind results by backtrace,

- split out a patch that lets --valgrind imply --verbose, and

- ran the scripts several times, which is a PITA because one run takes 5.5 
  hours (and the first time I forgot to redirect stderr, ouch, thus the 
  test-results/ patch).

I have an output from a previous full run, albeit it was done with an 
earlier version of the valgrind patch series I was not comfortable with, 
so I will not send it here.  Besides, it is 300K (bzip2 -9 reduces that to 
20K), and I am sure you don't want to have it.

Just that much, most of the backtraces are pretty repetitive.  In fact, I 
think most if not all of them touch xwrite.c (I got other errors from my 
patches, as I expected).

==valgrind== Syscall param write(buf) points to uninitialised byte(s)
==valgrind==    at 0x5609E40: __write_nocancel (in /lib/libpthread-2.6.1.so)
==valgrind==    by 0x4D0380: xwrite (wrapper.c:129)
==valgrind==    by 0x4D046E: write_in_full (wrapper.c:159)
==valgrind==    by 0x4C0697: write_buffer (sha1_file.c:2275)
==valgrind==    by 0x4C0B1C: write_loose_object (sha1_file.c:2387)
==valgrind==    by 0x4C0C4F: write_sha1_file (sha1_file.c:2418)
==valgrind==    by 0x46DBB8: update_one (cache-tree.c:348)
==valgrind==    by 0x46D8CF: update_one (cache-tree.c:282)
==valgrind==    by 0x46DCCA: cache_tree_update (cache-tree.c:373)
==valgrind==    by 0x46E2B5: write_cache_as_tree (cache-tree.c:562)
==valgrind==    by 0x4662D4: cmd_write_tree (builtin-write-tree.c:36)
==valgrind==    by 0x404F37: run_command (git.c:243)
==valgrind==  Address 0x713dc23 is 51 bytes inside a block of size 195 alloc'd
==valgrind==    at 0x4C2273B: malloc (in /usr/local/lib/valgrind/amd64-linux/vgpreload_memcheck.so)
==valgrind==    by 0x4CFFCC: xmalloc (wrapper.c:20)
==valgrind==    by 0x4C0A33: write_loose_object (sha1_file.c:2362)
==valgrind==    by 0x4C0C4F: write_sha1_file (sha1_file.c:2418)
==valgrind==    by 0x46DBB8: update_one (cache-tree.c:348)
==valgrind==    by 0x46D8CF: update_one (cache-tree.c:282)
==valgrind==    by 0x46DCCA: cache_tree_update (cache-tree.c:373)
==valgrind==    by 0x46E2B5: write_cache_as_tree (cache-tree.c:562)
==valgrind==    by 0x4662D4: cmd_write_tree (builtin-write-tree.c:36)
==valgrind==    by 0x404F37: run_command (git.c:243)
==valgrind==    by 0x4050E4: handle_internal_command (git.c:387)
==valgrind==    by 0x4051CA: run_argv (git.c:425)

which can be reproduced by running t0000-basic.out in valgrind mode.

Good night, Vietnam,
Dscho
