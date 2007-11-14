From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Wed, 14 Nov 2007 20:54:06 +0100
Message-ID: <20071114195406.GB3973@steel.home>
References: <18228.32091.865519.312011@lisa.zopyra.com> <20071109232106.GA3435@steel.home> <18232.29603.856766.275854@lisa.zopyra.com> <20071112233309.GI2918@steel.home> <18233.47472.890658.729250@lisa.zopyra.com> <20071113214802.GH3268@steel.home> <18234.14781.55429.671459@lisa.zopyra.com> <20071114000218.GL3268@steel.home> <18234.15666.711624.443184@lisa.zopyra.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:54:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOJn-0005ED-3t
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 20:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764038AbXKNTyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 14:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764007AbXKNTyM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 14:54:12 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:51808 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763945AbXKNTyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 14:54:11 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (fruni mo63) (RZmta 14.0)
	with ESMTP id 20225ajAEJUw5x ; Wed, 14 Nov 2007 20:54:07 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 16F5D277AE;
	Wed, 14 Nov 2007 20:54:07 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id EFD3256D22; Wed, 14 Nov 2007 20:54:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18234.15666.711624.443184@lisa.zopyra.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65003>

Bill Lear, Wed, Nov 14, 2007 01:11:30 +0100:
> >oh, you should be looking for usage.c, the function report (it is
> >called by default die handler). The old code used to fputs("fatal:"),
> >the new just vfprintf's everything, so the write should look like:
> >
> >    write(2, "fatal: cannot pread pack file: No such "...
> 
> Are you sure?
> 
> % ls -l git-1.5.3.5.tar.bz2
> -rw-r--r-- 1 blear software 1351433 2007-10-31 15:04 git-1.5.3.5.tar.bz2
> % bunzip2 -c !$ | tar xf -
> % cd git-1.5.3.5
> % grep -A 5 'void report' usage.c
> static void report(const char *prefix, const char *err, va_list params)
> {
>         fputs(prefix, stderr);
>         vfprintf(stderr, err, params);
>         fputs("\n", stderr);

Ach, right. I just checked Junio's master. BTW, maybe you could check
that as well? There were 64bit fixes lately, and had an impression you
were using git compiled for 64bit (mmap2 return address from your
first strace was shown 64bit).
