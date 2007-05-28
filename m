From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 22:23:20 +0200
Message-ID: <87veecvgsn.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<20070528154630.GA9176@fiberbit.xs4all.nl>
	<87646cx13d.fsf@rho.meyering.net>
	<20070528190529.GA10656@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 28 22:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HslkX-00025p-Mm
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbXE1UXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXE1UXW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:23:22 -0400
Received: from mx.meyering.net ([82.230.74.64]:35540 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbXE1UXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:23:22 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id F3B6C32CF1; Mon, 28 May 2007 22:23:20 +0200 (CEST)
In-Reply-To: <20070528190529.GA10656@fiberbit.xs4all.nl> (Marco Roeland's message of "Mon\, 28 May 2007 21\:05\:29 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48637>

Marco Roeland <marco.roeland@xs4all.nl> wrote:
> On monday May 28th 2007 at 20:19 Jim Meyering wrote:
>> Also, to be consistent, don't ignore EPIPE write failures.
>
> In practice I agree with someone else on this thread that EPIPE _is_
> different. In a way the responsibility doesn't lie with the writer but
> with the reader.

Do you think it's ok for git-rev-list _not_ to diagnose an erroneous
command like this (i.e., to exit(0)):

    git-rev-list HEAD | sync

where "sync" could be any command that exits successfully
without reading any input?

Is it ok that it is currently *impossible* to diagnose that
failure by looking at exit codes?

> But just out of curiosity is there an easy way to test the EPIPE
> behaviour? I cite a piece of the "changelog.Debian" file from the

There are some examples here:
http://thread.gmane.org/gmane.comp.version-control.git/48469/focus=48617

...
> The mentioned "test-case" as used in "git log -n1 | exit 1" doesn't
> produce an error in my Debian 'sid' bash, either with or without your
> patch, so it doesn't seem to have any effect there? Whereas probably in
> a "default" bash (don't know if upstream has changed it's mind already!)
> with your patch (i.e. the EPIPE special casing removal) it will again
> probably introduce these annoying (for interactive use) errors.

As I just said in reply to Linus, the EPIPE handling difference
is independent of what version of bash you use.

> Thanks for your patch anyway, the "fcntl" diagnosis is a really useful
> technique to know, and IMVHO also useful for git; although perhaps not
> very portable for all platforms.

It appears to be portable enough.  fcntl/F_GETFD support is required
by POSIX, and has been around for ages.  FWIW, it's also used in git's
daemon.c and sha1_file.c.
