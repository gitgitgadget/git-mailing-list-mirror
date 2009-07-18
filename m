From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [test failure] Re: t4114 binary file becomes symlink
Date: Sat, 18 Jul 2009 16:16:58 +0200
Message-ID: <20090718141658.GE16708@vidovic>
References: <20090718134551.GC16708@vidovic> <20090718135649.GA6759@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 16:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSAiw-0001MN-1J
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 16:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZGRORF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 10:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbZGRORF
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 10:17:05 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:65111 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbZGRORE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 10:17:04 -0400
Received: by ewy26 with SMTP id 26so1443222ewy.37
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=w4OHr5zjjYMxMMN/N+UIdTjM4a3BNbx2zTGZcWDm3pY=;
        b=x+MTxyuntlnx4LmSEWcu2b4BkEvZ9uTS6hLWR8EHgcVg7AbDHAE1iEV6DqXbq/pKiR
         Iaop2qgpy6X+oLnQso0crdxeMZtQoAeeZz7IBXMtjxYuzhI4VENh4NVD5TAZ7FRcUBI7
         Ndnu4thoHEANepOz7gf6YaMWkyfP+1VcnDXSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hEq5DTkJrxESd15SuEDYPEhDiNeKxcPYqHMGZXSAp17/l+vWuoEeiwz9rSfg2AXXh9
         0G+T1BpgDqX9FQQDw8TTZArGZGNxbl8Tj+Pb1z2CbjwAq3lQret5NBbqLekJAr3iP3at
         h/Nyk3xIYMHLseXyo3dvUaQu+XTO0nlU658Ew=
Received: by 10.210.78.16 with SMTP id a16mr2756246ebb.73.1247926622193;
        Sat, 18 Jul 2009 07:17:02 -0700 (PDT)
Received: from @ (91-164-151-27.rev.libertysurf.net [91.164.151.27])
        by mx.google.com with ESMTPS id 10sm998929eyd.9.2009.07.18.07.17.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Jul 2009 07:17:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090718135649.GA6759@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123522>

The 18/07/09, Jeff King wrote:
> On Sat, Jul 18, 2009 at 03:45:51PM +0200, Nicolas Sebrecht wrote:
> 
> > Running 'sh t4114-apply-typechange.sh --verbose --debug' fails since its
> > introduction by b67b9612e1a90ae093445abeaeff930e9f4cf936 with this
> > output:
> > 
> > 
> >    * expecting success: 
> >    	git checkout -f foo-becomes-binary &&
> >    	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
> >    	git apply --index < patch
> >    	
> >    ./test-lib.sh: line 234: 26816 Segmentation fault      git checkout -f
> >    foo-becomes-binary
> 
> Sorry, I can't reproduce here (I tried v1.6.3 and the current
> 'next'). The tests pass just fine with --debug (which, IIRC, doesn't
> actually do much). What is the exact commit you're seeing it fail on?

It fails on:
  - next
  - v1.6.3
  - b67b9612e1a90ae093445abeaeff930e9f4cf936
  - (other I don't remember, but does it really matter?)

> Can you try running it under gdb to get a stack trace? If you have
> valgrind installed, can you run the test script with --valgrind?

$ sh t4114-apply-typechange.sh --valgrind

<snip>

* expecting success: 
	git checkout -f foo-becomes-binary &&
	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
	git apply --index < patch
	
==10807== Invalid read of size 1
==10807==    at 0x4C22349: strlen (in /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so)
==10807==    by 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)
==10807==    by 0x412AA0: cmd_checkout (builtin-checkout.c:364)
==10807==    by 0x404222: handle_internal_command (git.c:243)
==10807==    by 0x404466: main (git.c:483)
==10807==  Address 0x1 is not stack'd, malloc'd or (recently) free'd
{
   <insert a suppression name here>
   Memcheck:Addr1
   fun:strlen
   fun:vfprintf
   fun:vsnprintf
   fun:git_vsnprintf
   fun:strbuf_addf
   fun:cmd_checkout
   fun:handle_internal_command
   fun:main
}
==10807== 
==10807== Process terminating with default action of signal 11 (SIGSEGV)
==10807==  Access not within mapped region at address 0x1
==10807==    at 0x4C22349: strlen (in /usr/lib64/valgrind/amd64-linux/vgpreload_memcheck.so)
==10807==    by 0x5616ED6: vfprintf (in /lib64/libc-2.8.so)
==10807==    by 0x563C159: vsnprintf (in /lib64/libc-2.8.so)
==10807==    by 0x495E90: git_vsnprintf (snprintf.c:38)
==10807==    by 0x48917B: strbuf_addf (strbuf.c:203)
==10807==    by 0x412AA0: cmd_checkout (builtin-checkout.c:364)
==10807==    by 0x404222: handle_internal_command (git.c:243)
==10807==    by 0x404466: main (git.c:483)
==10807==  If you believe this happened as a result of a stack overflow in your
==10807==  program's main thread (unlikely but possible), you can try to increase
==10807==  the size of the main thread stack using the --main-stacksize= flag.
==10807==  The main thread stack size used in this run was 8388608.
* FAIL 8: binary file becomes symlink

<snip>

$

-- 
Nicolas Sebrecht
