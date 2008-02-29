From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when
	not running verbosely
Date: Fri, 29 Feb 2008 18:01:56 -0500
Message-ID: <20080229230156.GA8742@coredump.intra.peff.net>
References: <1204323805-23185-1-git-send-email-mh@glandium.org> <20080229225331.GA8440@coredump.intra.peff.net> <20080229225816.GA24892@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVEFQ-0001jt-95
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbYB2XB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbYB2XB7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:01:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4518 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994AbYB2XB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:01:59 -0500
Received: (qmail 9490 invoked by uid 111); 29 Feb 2008 23:01:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 29 Feb 2008 18:01:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 18:01:56 -0500
Content-Disposition: inline
In-Reply-To: <20080229225816.GA24892@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75587>

On Fri, Feb 29, 2008 at 11:58:16PM +0100, Mike Hommey wrote:

> > > -git reset --hard
> > > +git reset --hard >&3 2>&4
> > >  test_expect_success 'refuse to merge binary files' '
> > >  	printf "\0" > binary-file &&
> > >  	git add binary-file &&
> > 
> > Should this perhaps just be:
> > 
> >   test_expect_success 'reset state' 'git reset --hard'
> 
> Is it really about testing git reset ?

No, of course not. Nor is t0003 about testing 'setup'. But it is a
convention[1] in git tests to do everything inside a test_expect_success
wrapper, which is beneficial because:

  - you get your output handled properly automagically :)
  - if the setup step fails, we notice. Which means:
     - it cannot silently cause a later test to succeed (e.g., setup
       changes a file, then the real test reverts it)
     - it is easier to debug failing tests, because you are notified
       of the _first_ failure

-Peff

[1] By convention, I don't necessarily mean that there is a written
rule, nor that we always do it that way, but only that in my experience
we usually do. Somebody like Junio could say more definitely what is
preferred.

