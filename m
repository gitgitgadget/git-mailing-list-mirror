From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 21:05:29 +0200
Message-ID: <20070528190529.GA10656@fiberbit.xs4all.nl>
References: <87bqg724gp.fsf@rho.meyering.net> <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org> <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org> <87sl9hw0o0.fsf@rho.meyering.net> <20070528154630.GA9176@fiberbit.xs4all.nl> <87646cx13d.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon May 28 21:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HskXG-0003uW-EQ
	for gcvg-git@gmane.org; Mon, 28 May 2007 21:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbXE1TFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXE1TFb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 15:05:31 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:41766 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbXE1TFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 15:05:30 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1HskX3-0002nn-6x; Mon, 28 May 2007 21:05:29 +0200
Content-Disposition: inline
In-Reply-To: <87646cx13d.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48635>

On monday May 28th 2007 at 20:19 Jim Meyering wrote:

> ...
> 
> Also, to be consistent, don't ignore EPIPE write failures.

In practice I agree with someone else on this thread that EPIPE _is_
different. In a way the responsibility doesn't lie with the writer but
with the reader.

But just out of curiosity is there an easy way to test the EPIPE
behaviour? I cite a piece of the "changelog.Debian" file from the
Debian version of the bash shell. In Debian, as earlier in many other
distributions, the annoying EPIPE error was "fixed" in version 2.0.3-3
from 19 dec 1999.

========================================================================
* Define DONT_REPORT_SIGPIPE: We don't want to see `Broken pipe' messages
  when a job like `cat jobs.c | exit 1' is executed. Fixes part of #7047,
  #10259, #10433 and #10494. Comment from the upstream author: "The default
  bash behavior with respect to the exit status of a pipeline will not
  change.  Changing it as suggested in the discussion of #10494 would render
  bash incompatible with every other shell out there.". Closed these reports.

  -- Matthias Klose <doko@debian.org>  Sun, 19 Dec 1999 15:58:43 +0100
========================================================================

The mentioned "test-case" as used in "git log -n1 | exit 1" doesn't
produce an error in my Debian 'sid' bash, either with or without your
patch, so it doesn't seem to have any effect there? Whereas probably in
a "default" bash (don't know if upstream has changed it's mind already!)
with your patch (i.e. the EPIPE special casing removal) it will again
probably introduce these annoying (for interactive use) errors.

Thanks for your patch anyway, the "fcntl" diagnosis is a really useful
technique to know, and IMVHO also useful for git; although perhaps not
very portable for all platforms.
-- 
Marco Roeland
