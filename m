From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 11:14:12 -0600
Message-ID: <1190654052.6078.14.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 19:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZrU3-0006FX-Q8
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 19:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbXIXRMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 13:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbXIXRMX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 13:12:23 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:4198 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760948AbXIXRMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 13:12:22 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Mon, 24 Sep 2007 11:12:09 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8OHC8Pt026388;
 Mon, 24 Sep 2007 11:12:08 -0600
In-Reply-To: <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.24.95354
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_NOT_1 0, __CT
 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070924171209; SEV=2.2.2; DFV=B2007092413;
 IFV=2.0.4,4.0-9; AIF=B2007092413; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230342E34364637454645382E303039443A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092413_5.02.0125_4.0-9
X-WSS-ID: 6AE930633HO3268549-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59065>

On Fri, 2007-09-21 at 17:15 -0700, Junio C Hamano wrote:
> "root" <root@sandia.gov> writes:
> 
> > +post-checkout
> > +-----------
> > +
> > +This hook is invoked when a `git-checkout` is run on a local repository.
> > +The hook is given two parameters: the ref of the previous HEAD, and the ref of 
> > +the new HEAD.  This hook cannot affect the outcome of `git-checkout`.
> > +
> > +This hook can be used to perform repository validity checks, auto-display
> > +differences from the previous HEAD, or set working dir metadata properties.
> > +
> 
> People may wonder why this is not run when they do "git checkout
> otherbranch path.c"; the second sentence from the above
> description implies why it shouldn't, but the first sentence
> probably should state it more clearly.
> 
> What's the _semantics_ you are trying to achieve?

I'd like to get a hook that runs whenever the working dir gets
updated.  The 'git-checkout otherbranch path.c' case should run it also, so I view that as a bug.

> Why does the hook run every time git-bisect suggests the next
> revision to try?
> Why does the hook run when rebase starts its work?

It may be inserted in a ad place or maybe it needs some intelligence in
there to know when *not* to run.

> When "git pull" or "git merge" results in a fast forward, the
> situation is no different from checking out a new revision.  Why
> doesn't the hook run in these cases?

This is actually what I'd like to do.  I submitted the post-merge patch
some time ago to serve that purpose.  Do you think they should both be
rolled into a single post-checkout hook?  It would seem to make sense to
me.
