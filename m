From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Mon, 5 May 2008 09:28:18 +1000
Message-ID: <18462.18066.769759.585596@cargo.ozlabs.ibm.com>
References: <20080430172136.GA22601@sigill.intra.peff.net>
	<20080430172553.GC23747@sigill.intra.peff.net>
	<481CA227.1000801@ramsay1.demon.co.uk>
	<20080504192332.GB13029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 05 01:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsngs-0000Dq-4C
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 01:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYEDXbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 19:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYEDXbZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 19:31:25 -0400
Received: from ozlabs.org ([203.10.76.45]:44417 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbYEDXbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 19:31:24 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BCB35DDE06; Mon,  5 May 2008 09:31:22 +1000 (EST)
In-Reply-To: <20080504192332.GB13029@sigill.intra.peff.net>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81211>

Jeff King writes:

> Hrm. Is gitk on cygwin somehow squishing stderr and stdout together? Or
> does gitk in general look at what happens on stderr?
> 
> Because while I am happy that removing this message fixes your problem,
> it is a little disconcerting to think that we can break gitk just by
> issuing a warning diagnostic on stderr.

It's a more general Tcl thing - if you are reading from a process, and
the process writes to stderr, and the script hasn't explicitly
redirected stderr, the Tcl infrastructure assumes that the process is
signalling an error, even if the exit status is 0.  Gitk does redirect
stderr (to stdout) when it does a git reset, but not for other
commands.

At the moment I don't think there is a good way in Tcl to get hold of
the stderr output if a subcommand returns a non-zero exit status, but
ignore it if the exit status is 0, other than by redirecting stderr to
a temporary file, which has its own problems.  Tcl can bundle stderr
in with stdout, or ignore it, or take it as an error indication, or
send it to a file.

So if git commands can avoid writing non-error messages to stderr,
that will make my life easier...

Paul.
