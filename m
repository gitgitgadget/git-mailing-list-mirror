From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 16:15:36 -0500
Message-ID: <20080223211536.GA13280@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <7v63wf2yzt.fsf@gitster.siamese.dyndns.org> <200802232209.41428.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1jC-0007vP-Oa
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbYBWVPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759101AbYBWVPj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:15:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756297AbYBWVPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 16:15:38 -0500
Received: (qmail 10729 invoked by uid 111); 23 Feb 2008 21:15:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 16:15:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 16:15:36 -0500
Content-Disposition: inline
In-Reply-To: <200802232209.41428.johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74854>

On Sat, Feb 23, 2008 at 10:09:41PM +0100, Johannes Sixt wrote:

> On Saturday 23 February 2008 21:34, Junio C Hamano wrote:
> > -echo "#!$SHELL" >fake-editor
> > +echo "#!$SHELL_PATH" >fake-editor.sh
> 
> Hm, when we run the test outside make, like
> 
>    $ sh t3404-rebase-interactive.sh
> 
> then the fake-editor.sh script begins with this line:
> 
>    #!
> 
> Isn't this a trap similar to what Jeff wanted to avoid?

Well, the trap I wanted to avoid is that "/bin/sh" specifically is
broken. But yes, I think losing the ability to run the tests from the
commandline is bad.

Ideally we figured out a sane shell for our shell scripts in the main
build process, and we want to always use that here.  I think "git
rev-parse --sane-shell-path" is probably overkill. Maybe test-lib.sh can
source a file of build-time options? The "diff -u" vs "cmp" thing could
go there, as well.

-Peff
