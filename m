From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 19:12:17 +0000
Message-ID: <20140319191217.GC11018@serenity.lan>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
 <1395226935-53044-1-git-send-email-modocache@gmail.com>
 <xmqqob123wjm.fsf@gitster.dls.corp.google.com>
 <20140319180213.GB11018@serenity.lan>
 <xmqqsiqe2es6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLul-00013m-2O
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbaCSTMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:12:31 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57718 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaCSTMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:12:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id AE96B24E37;
	Wed, 19 Mar 2014 19:12:29 +0000 (GMT)
X-Quarantine-ID: <8dZNK28DDo8G>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dZNK28DDo8G; Wed, 19 Mar 2014 19:12:29 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id EA36124E4F;
	Wed, 19 Mar 2014 19:12:28 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 389ED161E53E;
	Wed, 19 Mar 2014 19:12:27 +0000 (GMT)
X-Quarantine-ID: <OlEJQ0AuIgBu>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OlEJQ0AuIgBu; Wed, 19 Mar 2014 19:12:26 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id AA09E161E3A7;
	Wed, 19 Mar 2014 19:12:19 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqsiqe2es6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244479>

On Wed, Mar 19, 2014 at 12:02:01PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Wed, Mar 19, 2014 at 10:53:01AM -0700, Junio C Hamano wrote:
> >>    "rebase -" with your change still says something like this:
> >> 
> >>         First, rewinding head to replay your work on top of it...
> >>         Fast-forwarded HEAD to @{-1}.
> >> 
> >>    instead of "Fast-forwarded HEAD to -".  Somebody may later want
> >>    to "fix" this, making these two eye-candy output to be different
> >>    from each other, and what your test expects will no longer hold
> >>    (not that I think it is better to say "-" instead of @{-1}
> >>    there).
> >
> > I don't think either of these is correct.  When using "-" with the
> > commands that already support it, I have occasionally found that "-"
> > isn't what I thought it was.
> >
> > Can we use `git name-rev` to put the actual name here, so that people
> > who have not done what they intended can hopefully notice sooner?
> 
> That sounds like a right thing to do.  It however is totally
> orthogonal to the change we are discussing, and should be done as a
> separate patch.

Is it not part of adding support for "-"?

I'm not arguing for a change to any existing functionality, just to the
behaviour introduced by this patch, which is basically a change from
"@{-1}" to "$(git name-rev --name-only @{-1})" in the patch.  (The error
handling of name-rev appears not to be very useful here when the
previous branch has been deleted, so I don't think it's quite that
simple, but that's the principle.)
