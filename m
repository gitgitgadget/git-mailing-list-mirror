From: gitml.jexpert@recursor.net
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout
 message 3 of 20)
Date: Thu, 08 Aug 2013 15:12:34 +0200
Message-ID: <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 15:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Q1R-0002s4-FV
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 15:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917Ab3HHNMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 09:12:53 -0400
Received: from gourmet7.spamgourmet.com ([216.75.62.102]:55267 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964909Ab3HHNMw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 09:12:52 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7Q1M-0002Rv-5s
	for git@vger.kernel.org; Thu, 08 Aug 2013 13:12:52 +0000
Received: from mail.exxcellent.de ([217.6.238.198])
	by gourmet7.spamgourmet.com with esmtp (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7Q1L-0002Qj-Dv; Thu, 08 Aug 2013 13:12:51 +0000
In-Reply-To: <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231880>

Great! Thank you all guys for your extensive instructions!

@Thomas: I only had to add libexpat1-dev to the list.

I checked out Git v1.8.3.4 as this was my used verion and built as
instructed. The error is still reproducible using the "CFLAGS = -O0 -g"
build.

So - now the puzzling thing: With valgrind it seems to work! 
If I run it plain, it doesn't:

/tmp/project.git $ valgrind --track-origins=yes  ~/projects/git.git/git-fsck
==3431== Memcheck, a memory error detector
==3431== Copyright (C) 2002-2011, and GNU GPL'd, by Julian Seward et al.
==3431== Using Valgrind-3.7.0 and LibVEX; rerun with -h for copyright info
==3431== Command: /home/ben/projects/git.git/git-fsck
==3431== 
==3431== Warning: set address range perms: large range [0x70b5000, 0x2b0ff000) (defined)
Checking object directories: 100% (256/256), done.
==3431== Warning: set address range perms: large range [0x3959d000, 0x49d53000) (defined)
Checking objects: 100% (63588/63588), done.
Checking connectivity: 68696, done.
==3431== 
==3431== HEAP SUMMARY:
==3431==     in use at exit: 7,574,911 bytes in 15,428 blocks
==3431==   total heap usage: 422,498 allocs, 407,070 frees, 4,396,939,465 bytes allocated
==3431== 
==3431== LEAK SUMMARY:
==3431==    definitely lost: 0 bytes in 0 blocks
==3431==    indirectly lost: 0 bytes in 0 blocks
==3431==      possibly lost: 0 bytes in 0 blocks
==3431==    still reachable: 7,574,911 bytes in 15,428 blocks
==3431==         suppressed: 0 bytes in 0 blocks
==3431== Rerun with --leak-check=full to see details of leaked memory
==3431== 
==3431== For counts of detected and suppressed errors, rerun with: -v
==3431== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 2 from 2)
/tmp/project.git $ ~/projects/git.git/git-fsck
Checking object directories: 100% (256/256), done.
error: packed 49cdd0b21a351f3366008615d2cf8d03ca943978 from .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack is corrupt
*** glibc detected *** <unknown>: free(): invalid pointer: 0x00007f8576682010 ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7f85ad765b96]
[0x4e727c]


I'm using a i5-3340M on Linux Mint 14 with a offical Linux 3.9.9
gcc (Ubuntu/Linaro 4.7.2-2ubuntu1) 4.7.2

Any further hints?


> Try something like
>
>   # The package names might be wrong and/or you may need additional -dev
>   # packages, I don't know the specifics for ubuntu
>   apt-get install gcc make valgrind libcurl-dev zlib-dev
>   cd
>   git clone git://git.kernel.org/pub/scm/git/git.git
>   cd git
>   echo 'CFLAGS = -O0 -g' >>config.mak
>   make
>   cd /path/to/repo
>   valgrind --track-origins=yes ~/git/git-fsck
>
> It'll be very slow, at least 20x the normal runtime, so don't be
> surprised if it doesn't seem to get anywhere at first.
>
