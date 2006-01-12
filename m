From: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 18:15:08 +0800
Message-ID: <2cd57c900601120215pdb5da27l@mail.gmail.com>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>
	 <43C558FB.3030102@op5.se>
	 <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 13:56:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex20L-0004ft-Nw
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 13:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWALM4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 07:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWALM4e
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 07:56:34 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:39037 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964920AbWALM4e convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 07:56:34 -0500
Received: by nproxy.gmail.com with SMTP id o25so245878nfa
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 04:55:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=npnCj++SU2uP1rX3LWDXiGpc1cuCZ13iq6U+Balq5k9keNi3AdQAyU79IaS7BajfA4E3zcDYwUX+Khk1Ztfkg3/lu7KriRE7dByyn9s1EWzizASaPu3YV2fD+p/HwbD4+DAEvmkoiACUfm6TuasiTV3fL0qfryExHZR/QTUnf4Q=
Received: by 10.49.27.6 with SMTP id e6mr121762nfj;
        Thu, 12 Jan 2006 02:15:08 -0800 (PST)
Received: by 10.48.42.2 with HTTP; Thu, 12 Jan 2006 02:15:08 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14560>

2006/1/12, Linus Torvalds <torvalds@osdl.org>:
>
>
> On Wed, 11 Jan 2006, Andreas Ericsson wrote:
> >
> > strip:
> >       strip $(PROGRAMS)
> >
> > install: strip
>
> Well, that ends up shaving some more from the binaries, but at a much
> bigger cost than just removing "-g".
>
> With stripped binaries, you can't really do _anything_. You get a
> core-file, and you're screwed.

Are you sure?

gemini:~> file `which mke2fs`
/sbin/mke2fs: ELF 32-bit LSB executable, Intel 80386, version 1
(SYSV), for GNU/Linux 2.2.0, dynamically linked (uses shared libs),
stripped

gemini:~> file /lib/libext2fs.so.2
/lib/libext2fs.so.2: symbolic link to `libext2fs.so.2.4'

gemini:~> file /lib/libext2fs.so.2.4
/lib/libext2fs.so.2.4: ELF 32-bit LSB shared object, Intel 80386,
version 1 (SYSV), stripped


In gdb:

No symbol table is loaded.  Use the "file" command.
(gdb) bt
#0  0xb7f16445 in ext2fs_mark_generic_bitmap () from /lib/libext2fs.so.2
#1  0xb7f110ed in ext2fs_reserve_super_and_bgd () from /lib/libext2fs.so.2
#2  0xb7f18353 in ext2fs_initialize () from /lib/libext2fs.so.2
#3  0x0804b461 in ?? ()
#4  0xbf84b9ad in ?? ()
#5  0x00000000 in ?? ()

So with stripped binary, I still get the backtrace to locate the buggy
function. IMO, Debian packages are build with -g.

So I suggest to let git go with `-g and striped' like all other packages do.

And if we use gnu autoconf, which provides site config ability, we
could easily get (1) "-g, striped" for distros, (2) "not striped" for
Linus and (3) "-g3, -O0, no striped" for some git developers.

To make git not tight to Linux, but cross platform, consider autoconf.

>
> With non-stripped binaries you can at least see the function the SIGSEGV
> happened in, and you usually even get a half-way decent backtrace etc.
>

False, see above.

>                 Linus

If I missed something in Debian, correct me.

--
Coywolf Qi Hunt
