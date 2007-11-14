From: Bill Lear <rael@zopyra.com>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Tue, 13 Nov 2007 18:11:30 -0600
Message-ID: <18234.15666.711624.443184@lisa.zopyra.com>
References: <18228.32091.865519.312011@lisa.zopyra.com>
	<20071109232106.GA3435@steel.home>
	<18232.29603.856766.275854@lisa.zopyra.com>
	<20071112233309.GI2918@steel.home>
	<18233.47472.890658.729250@lisa.zopyra.com>
	<20071113214802.GH3268@steel.home>
	<18234.14781.55429.671459@lisa.zopyra.com>
	<20071114000218.GL3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5rd-0004co-PP
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308AbXKNALn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759408AbXKNALn
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:11:43 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60230 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759357AbXKNALm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:11:42 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lAE0Beb11379;
	Tue, 13 Nov 2007 18:11:40 -0600
In-Reply-To: <20071114000218.GL3268@steel.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64925>

On Wednesday, November 14, 2007 at 01:02:18 (+0100) Alex Riesen writes:
>Bill Lear, Wed, Nov 14, 2007 00:56:45 +0100:
>> On Tuesday, November 13, 2007 at 22:48:02 (+0100) Alex Riesen writes:
>> >...
>> >> >I extend the part you quoted. The file is opened here:
>> >> >...
>> >> >This is strange. The current git should not produce anything like
>> >> >this (and does not, here). ...
>> >> 
>> >> You are absolutely correct.  My comrade ran this with 1.5.0.1 by
>> >> mistake.  He reran the strace with 1.5.3.5, and I have replaced
>> >> the tarball on my server:
>> >> 
>> >>     http://www.zopyra.com/~rael/git/git-trace.tar.bz2
>> >
>> >Still looks like v1.5.0.1:
>> >
>> >    write(2, "fatal: ", 7)                  = 7
>> >    write(2, "cannot pread pack file: No such "..., 49) = 49
>> 
>> Well, I just grepped for the above string in git-1.5.3.5:
>> 
>> % grep 'cannot pread pack file' *.c
>> index-pack.c:                   die("cannot pread pack file: %s", strerror(errno));
>
>oh, you should be looking for usage.c, the function report (it is
>called by default die handler). The old code used to fputs("fatal:"),
>the new just vfprintf's everything, so the write should look like:
>
>    write(2, "fatal: cannot pread pack file: No such "...

Are you sure?

% ls -l git-1.5.3.5.tar.bz2
-rw-r--r-- 1 blear software 1351433 2007-10-31 15:04 git-1.5.3.5.tar.bz2
% bunzip2 -c !$ | tar xf -
% cd git-1.5.3.5
% grep -A 5 'void report' usage.c
static void report(const char *prefix, const char *err, va_list params)
{
        fputs(prefix, stderr);
        vfprintf(stderr, err, params);
        fputs("\n", stderr);
}


Bill
