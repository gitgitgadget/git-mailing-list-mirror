From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 11:58:00 -0600
Message-ID: <1190656680.6078.26.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 19:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZsAM-0005oM-2D
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 19:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758774AbXIXR4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 13:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758773AbXIXR4I
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 13:56:08 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:3830 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758715AbXIXR4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 13:56:07 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Mon, 24 Sep 2007 11:55:57 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8OHtugZ001511;
 Mon, 24 Sep 2007 11:55:56 -0600
In-Reply-To: <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.24.103528
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_NOT_1 0, __CT
 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070924175600; SEV=2.2.2; DFV=B2007092413;
 IFV=2.0.4,4.0-9; AIF=B2007092413; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364637464132452E303045363A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092413_5.02.0125_4.0-9
X-WSS-ID: 6AE925A62E03279285-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59067>

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
> 
> Why does the hook run every time git-bisect suggests the next
> revision to try?

Its being run since git-bisect calls git-checkout internally, but since
the 'git-checkout $branch' could potentially update the working tree it
may be desirable to have the hook run.  Since one stated purpose of the
hook is maintain repository validity or update metadata, running the
hook at this time may be the right thing to do.

> Why does the hook run when rebase starts its work?

I think this case is actually desirable.  If the rebase changes some
aspects of the working dir that the hook cares about (eg: metadata),
then the hook will be able handle the situation correctly.  Not running
the hook for a rebase operation could result in the working dir being
left in an inconsistent state.

-JE
