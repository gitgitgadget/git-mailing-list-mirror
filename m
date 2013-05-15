From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 17:43:14 +0100
Message-ID: <20130515164314.GW2299@serenity.lan>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
 <1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vy5bgckr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 18:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucena-00051T-46
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 18:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536Ab3EOQnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 12:43:24 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53070 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758319Ab3EOQnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 12:43:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0E616CDA608;
	Wed, 15 May 2013 17:43:23 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0qMrwLA34zA; Wed, 15 May 2013 17:43:21 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C296BCDA57C;
	Wed, 15 May 2013 17:43:16 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vy5bgckr4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224422>

On Wed, May 15, 2013 at 08:42:39AM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
> > Many tutorials tell the users to set color.ui=auto as a very first step.
> > These tutorials would benefit from skiping this step and starting the
> > real Git manipualtions earlier. Other beginners do not know about
> > color.ui=auto, and may not discover it by themselves, hence live with
> > black&white outputs while they may have prefered colors.
> >
> > A few people (e.g. color-blind) prefer having no colors, but they can
> > easily set color.ui=never for this (and googling "disable colors in git"
> > already tells them how to do so).
> 
> The above two paragraphs do not make a good justification [*1*].
> The former can just as easily websearch for "enable colours in git"
> as the latter would for "disable" in order to avoid having to live
> with distraction while they may have preferred monochrome.
> 
> The train of thought that is a sufficient justification for this
> change is "Our document and third-party tutorials often start with
> setting color.ui=auto configuration." leading to "Our recommendation
> is to enable colour on terminals." which in turn leading to "Why is
> our default monochrome, against our own recommendation?".  Saying
> anything more, like who are the majority or how easily the default
> can be overridden, is unnecessary, I think [*2*].
> 
> As this is purely a UI thing, and since daa0c3d97176 (color: delay
> auto-color decision until point of use, 2011-08-17), the logic to
> decide when "auto colouring" is triggered is centrary controlled
> (hence it is much less likely than before that color.ui=auto could
> misfire when it shouldn't), I agree that this does not even deserve
> a warning. You could even sell it as a pure bugfix ("we recommend
> users to use auto colouring but we did not set it up for users").
> 
> > The default value is changed, and the documentation is reworded to
> > mention "color.ui=false" first, since the primary use of color.ui after
> > this change is to disable colors, not to enable it.
> 
> Good.
> 
> > I'm starting to wonder why we didn't do this earlier ;-).
> >
> >  Documentation/config.txt | 11 ++++++-----
> >  color.c                  |  2 +-
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 1009bfc..97550be 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -913,11 +913,12 @@ color.ui::
> >  	as `color.diff` and `color.grep` that control the use of color
> >  	per command family. Its scope will expand as more commands learn
> >  	configuration to set a default for the `--color` option.  Set it
> > +	to `false` or `never` if you prefer Git commands not to use
> > +	color unless enabled explicitly with some other configuration
> > +	or the `--color` option. Set it to `always` if you want all
> > +	output not intended for machine consumption to use color, to
> > +	`true` or `auto` (this is the default since Git 2.0) if you
> > +	want such output to use color when written to the terminal.
> 
> OK, so this is planned for 2.0?

I would vote for just considering this a bugfix as you say above and
therefore not worthy of any special treatment, so it should end up in
whatever the next release is after it hits master.

The changes that are being held back for 2.0 change how commands operate
and we don't provide any overrides for those; this is just a cosmetic
change to the default output format.
