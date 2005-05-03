From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 10:13:56 -0400
Message-ID: <200505031013.57476.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org> <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:11:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSy7K-0001RT-Va
	for gcvg-git@gmane.org; Tue, 03 May 2005 16:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVECOQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 10:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVECOPi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 10:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36510 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261585AbVECOOC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 10:14:02 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 118AB9C23;
	Tue,  3 May 2005 16:14:01 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 0BF57150825; Tue,  3 May 2005 16:14:00 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 03 May 2005 04:06, Nicolas Pitre wrote:
> On Mon, 2 May 2005, Linus Torvalds wrote:
> > If you do something like this, you want such a delta-blob to be named by
> > the sha1 of the result, so that things that refer to it can transparently
> > see either the original blob _or_ the "deltified" one, and will never
> > care.
>
> Yep, that's what I've done last weekend (and just made it actually
> work since people are getting interested).

Hmmm, something is strange here, am I using this wrong?

coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
*** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***
Aborted

Valgrind output:

==9634== Invalid read of size 1
==9634==    at 0x1B9036F0: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1B90906F is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid write of size 1
==9634==    at 0x1B9036F3: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1BA3A08D is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid read of size 1
==9634==    at 0x1B9036F6: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1B90906E is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid write of size 1
==9634==    at 0x1B9036F9: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1BA3A08C is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid read of size 1
==9634==    at 0x1B9036FC: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1B90906D is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid write of size 1
==9634==    at 0x1B9036FF: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1BA3A08B is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid read of size 1
==9634==    at 0x1B903702: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1B90906C is not stack'd, malloc'd or (recently) free'd
==9634==
==9634== Invalid write of size 1
==9634==    at 0x1B903708: memcpy (in /usr/lib/valgrind/vgpreload_memcheck.so)
==9634==    by 0x8049142: patch_delta (patch-delta.c:59)
==9634==    by 0x80487CB: main (test-delta.c:65)
==9634==  Address 0x1BA3A08A is not stack'd, malloc'd or (recently) free'd
delta operation failed (returned NULL)
==9634==
==9634== ERROR SUMMARY: 206 errors from 13 contexts (suppressed: 0 from 0)
==9634== malloc/free: in use at exit: 0 bytes in 0 blocks.
==9634== malloc/free: 1 allocs, 1 frees, 5 bytes allocated.
==9634== For a detailed leak analysis,  rerun with: --leak-check=yes
==9634== For counts of detected errors, rerun with: -v

-chris
