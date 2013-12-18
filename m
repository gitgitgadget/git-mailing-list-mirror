From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: "git fsck" fails on malloc of 80 G
Date: Tue, 17 Dec 2013 22:06:20 -0500
Message-ID: <201312180306.rBI36KCm016209@hobgoblin.ariadne.com>
References: <201312161605.rBGG5Wm5027739@hobgoblin.ariadne.com> <20131216191500.GD29324@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 04:12:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt7Yw-0004da-CR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 04:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab3LRDMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 22:12:30 -0500
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:45183
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752386Ab3LRDM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 22:12:28 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2013 22:12:28 EST
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id 2oaV1n00N0mv7h051r6Nyd; Wed, 18 Dec 2013 03:06:22 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id 2r6N1n00K1KKtkw3Xr6N8r; Wed, 18 Dec 2013 03:06:22 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id rBI36Ldk016211;
	Tue, 17 Dec 2013 22:06:21 -0500
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id rBI36KCm016209;
	Tue, 17 Dec 2013 22:06:20 -0500
In-reply-to: <20131216191500.GD29324@sigill.intra.peff.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1387335982;
	bh=Ol9nWH8Wnb+5JE7k67uJTwRhTx+CFYstfHbyxUEAcvc=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=otVvle/LfSyax6V9zVYMX8JpfQ5gQiAgtVWj/wq8Uo8jCuLwLVD79nmAc8Iq6zhQy
	 MNHi1EWk/t7A4qQVG1Dal+6i3V3LKq567xGIhsMOaIuySDynEWP6a9ocpdP4GUFhY8
	 DOZ6+doaMt1yKq0vwphD1bqIGh6ctSvtOslIH/cp9Ylac9pMORLsAc8SAVjhXByhTC
	 ogcYCcSi4OneLrfJImlpu/Z9XMhRy1McaeUJIjfLPURowX13tVh0KT/sBsVTlR2rHM
	 /DZ203meVjjFgYg87dIr+HznUMIg97sYuM9IOhvHSfEArvK0vWESM5M9n8Fp41OOTI
	 Rff44WMrEDKQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239420>

> From: Jeff King <peff@peff.net>
> 
> On Mon, Dec 16, 2013 at 11:05:32AM -0500, Dale R. Worley wrote:
> 
> > # git fsck
> > Checking object directories: 100% (256/256), done.
> > fatal: Out of memory, malloc failed (tried to allocate 80530636801 bytes)
> > #
> 
> Can you give you give us a backtrace from the die() call? It would help
> to know what it was trying to allocate 80G for.

Further information:

    # git --version
    git version 1.8.3.1
    #

Here's the basic backtrace information, and the values of the "size"
variables, which seem to be the immediate culprits:

    # gdb
    GNU gdb (GDB) Fedora 7.6.1-46.fc19
    Copyright (C) 2013 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
    and "show warranty" for details.
    This GDB was configured as "x86_64-redhat-linux-gnu".
    For bug reporting instructions, please see:
    <http://www.gnu.org/software/gdb/bugs/>.
    (gdb) file /usr/bin/git
    Reading symbols from /usr/bin/git...Reading symbols from /usr/lib/debug/usr/bin/git.debug...done.
    done.
    (gdb) break wrapper.c:59
    Breakpoint 1 at 0x4f35ef: file wrapper.c, line 59.
    (gdb) break die_child
    Breakpoint 2 at 0x4d0ca0: file run-command.c, line 211.
    (gdb) break die_async
    Breakpoint 3 at 0x4d1020: file run-command.c, line 604.
    (gdb) run fsck
    Starting program: /usr/bin/git fsck
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib64/libthread_db.so.1".
    Checking object directories: 100% (256/256), done.
    Checking objects:   0% (0/526211)   
    Breakpoint 1, xmalloc (size=size@entry=80530636801) at wrapper.c:59
    59				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
    (gdb) bt
    #0  xmalloc (size=size@entry=80530636801) at wrapper.c:59
    #1  0x00000000004f3633 in xmallocz (size=size@entry=80530636800)
	at wrapper.c:73
    #2  0x00000000004d922f in unpack_compressed_entry (p=p@entry=0x7e4020, 
	w_curs=w_curs@entry=0x7fffffffc9f0, curpos=654214694, size=80530636800)
	at sha1_file.c:1797
    #3  0x00000000004db4cb in unpack_entry (p=p@entry=0x7e4020, 
	obj_offset=654214688, final_type=final_type@entry=0x7fffffffd088, 
	final_size=final_size@entry=0x7fffffffd098) at sha1_file.c:2072
    #4  0x00000000004b1e3f in verify_packfile (base_count=0, progress=0x9bdd80, 
	fn=0x42fc00 <fsck_obj_buffer>, w_curs=0x7fffffffd090, p=0x7e4020)
	at pack-check.c:119
    #5  verify_pack (p=p@entry=0x7e4020, fn=fn@entry=0x42fc00 <fsck_obj_buffer>, 
	progress=0x9bdd80, base_count=base_count@entry=0) at pack-check.c:177
    #6  0x0000000000430724 in cmd_fsck (argc=0, argv=0x7fffffffe400, 
	prefix=<optimized out>) at builtin/fsck.c:678
    #7  0x0000000000405cfd in run_builtin (argv=0x7fffffffe400, argc=1, 
	p=0x75fa68 <commands.23748+840>) at git.c:284
    #8  handle_internal_command (argc=1, argv=0x7fffffffe400) at git.c:446
    #9  0x000000000040511f in run_argv (argv=0x7fffffffe2a0, argcp=0x7fffffffe2ac)
	at git.c:492
    #10 main (argc=1, argv=0x7fffffffe400) at git.c:567
    (gdb) frame 2
    #2  0x00000000004d922f in unpack_compressed_entry (p=p@entry=0x7e4020, 
	w_curs=w_curs@entry=0x7fffffffc9f0, curpos=654214694, size=80530636800)
	at sha1_file.c:1797
    1797		buffer = xmallocz(size);
    (gdb) p size
    $29 = 80530636800
    (gdb) p/x size
    $30 = 0x12c0000000
    (gdb) frame 3
    #3  0x00000000004db4cb in unpack_entry (p=p@entry=0x7e4020, 
	obj_offset=654214688, final_type=final_type@entry=0x7fffffffd088, 
	final_size=final_size@entry=0x7fffffffd098) at sha1_file.c:2072
    2072				data = unpack_compressed_entry(p, &w_curs, curpos, size);
    (gdb) p size
    $31 = 80530636800
    (gdb) p/x size
    $32 = 0x12c0000000
    (gdb) 

I did a further test to see where the value of "size" came from:

    (gdb) break sha1_file.c:2023
    Breakpoint 4 at 0x4db073: file sha1_file.c, line 2023.
    (gdb) cond 4 size == 0x12c0000000
    (gdb) break sha1_file.c:2029
    Breakpoint 5 at 0x4daee7: file sha1_file.c, line 2029.
    (gdb) cond 5 size == 0x12c0000000
    (gdb) break sha1_file.c:2072
    Breakpoint 6 at 0x4db4b4: file sha1_file.c, line 2072.
    (gdb) cond 6 size == 0x12c0000000
    (gdb) break unpack_object_header_buffer
    Breakpoint 7 at 0x4d9ea0: file sha1_file.c, line 1399.
    (gdb) comm 7
    Type commands for breakpoint(s) 7, one per line.
    End with a line saying just "end".
    >continue
    >end
    (gdb) run
    The program being debugged has been started already.
    Start it from the beginning? (y or n) y
    Starting program: /usr/bin/git fsck
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib64/libthread_db.so.1".
    Checking object directories: 100% (256/256), done.

    Breakpoint 7, unpack_object_header_buffer (
	buf=0x7fffc4d3e00c "\265\334\352\277\023x\234", len=733530087, 
	type=type@entry=0x7fffffffc984, sizep=sizep@entry=0x7fffffffca00)
	at sha1_file.c:1399
    1399	{
    Checking objects:   0% (0/526211)   
    Breakpoint 7, unpack_object_header_buffer (
	buf=0x7fffebd26620 "\260\200\200\200\340\022x\234\354\301\001\001", 
	len=79315411, type=type@entry=0x7fffffffc984, 
	sizep=sizep@entry=0x7fffffffca00) at sha1_file.c:1399
    1399	{

    Breakpoint 5, unpack_entry (p=p@entry=0x7e4020, obj_offset=654214688, 
	final_type=final_type@entry=0x7fffffffd088, 
	final_size=final_size@entry=0x7fffffffd098) at sha1_file.c:2029
    2029			if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
    (gdb) 

If I understand the code correctly, the object header buffer
\260\200\200\200\340\022x\234\354\301\001\001
really does encode the size value 0x12c0000000.

I will see if I can experiment with the new version you mention.

Dale
