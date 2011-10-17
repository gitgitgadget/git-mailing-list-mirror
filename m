From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2011, #05; Fri, 14)
Date: Sun, 16 Oct 2011 23:37:06 -0400
Message-ID: <20111017033706.GA26326@sigill.intra.peff.net>
References: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
 <20111016165329.GA14226@sigill.intra.peff.net>
 <7vvcrorh49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 05:41:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFe5M-0002Bc-T3
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 05:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab1JQDhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 23:37:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33634
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487Ab1JQDhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 23:37:09 -0400
Received: (qmail 3292 invoked by uid 107); 17 Oct 2011 03:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 16 Oct 2011 23:37:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2011 23:37:06 -0400
Content-Disposition: inline
In-Reply-To: <7vvcrorh49.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183761>

On Sun, Oct 16, 2011 at 10:17:10AM -0700, Junio C Hamano wrote:

> >> * jk/daemon-msgs (2011-10-14) 1 commit
> >>  - daemon: give friendlier error messages to clients
> >> 
> >> Will merge to 'next'.
> >
> > I'm happy to tweak the "access denied" message if other people want. I
> > kind of hoped it wouldn't matter, and that most sites would use
> > --informative-errors.
> 
> I've already updated it with the "not exported" bit from Sitaram.

What you queued in d5570f4 looks sane, but the merge into next is
curious. It's an evil merge that turns on informative errors by default:

  $ git show 415cf53
  commit 415cf53e710b2ff44d485e253bb35a1ca5dff636
  Merge: fbc2ee6 d5570f4
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Sat Oct 15 21:25:41 2011 -0700

      Merge branch 'jk/daemon-msgs' into next

      * jk/daemon-msgs:
        daemon: give friendlier error messages to clients

      Conflicts:
          daemon.c

  diff --cc daemon.c
  index 91c4d9b,72fb53a..95b7df5
  --- a/daemon.c
  +++ b/daemon.c
  @@@ -20,6 -20,7 +20,7 @@@
    static int log_syslog;
    static int verbose;
    static int reuseaddr;
   -static int informative_errors;
  ++static int informative_errors = 1;

    static const char daemon_usage[] =
    "git daemon [--verbose] [--syslog] [--export-all]\n"


The conflicts come from merging with Duy's version, which was already in
next. But the introduced line comes from my second patch, which was
rightly dropped, and should not be there. Was this intentional, or did
you do something clever with "git am" and my original series during
resolution and accidentally pull in that change?

-Peff
